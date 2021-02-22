--[[

  Initially copy of:
  https://github.com/Wiladams/lj2win32
  tests/stopwatch.lua

  A simple stopwatch.
  This stopwatch is independent of wall clock time.  It sets a relative
  start position whenever you call 'reset()'.

  The only function it serves is to tell you the number of seconds since
  the reset() method was called.

--]]

local ffi = require('ffi')
local C = ffi.C
local prototype = require('prototype')

local function winimpl ()
  -- local profileapi = require('lj2win32.win32.profileapi')

  local function GetPerformanceFrequency (anum)
    anum = anum or ffi.new('int64_t[1]')
    local success = ffi.C.QueryPerformanceFrequency(anum)
    if success == 0 then
      return false --, errorhandling.GetLastError()
    end

    return tonumber(anum[0])
  end

  local function GetPerformanceCounter (anum)
    anum = anum or ffi.new('int64_t[1]')
    local success = ffi.C.QueryPerformanceCounter(anum)
    if success == 0 then
      return false --, errorhandling.GetLastError()
    end

    return tonumber(anum[0])
  end

  local function GetCurrentTickTime ()
    local frequency = 1 / GetPerformanceFrequency()
    local currentCount = GetPerformanceCounter()
    local seconds = currentCount * frequency

    return seconds
  end


  local StopWatch = {}

  local StopWatch_mt = {
    __index = StopWatch
  }

  function StopWatch.init (_, obj)
    obj = obj or
      {
        starttime = 0
      }

    setmetatable(obj, StopWatch_mt)
    obj:reset()

    return obj
  end

  function StopWatch.new ()
    return StopWatch.init({})
  end

  function StopWatch.ticks ()
    return GetPerformanceCounter()
  end

  function StopWatch.seconds (self)
    local currentTime = GetCurrentTickTime()
    return currentTime - self.starttime
  end

  function StopWatch.millis (self)
    return self:seconds() * 1000
  end

  function StopWatch.reset (self)
    self.starttime = GetCurrentTickTime()
  end


  return StopWatch
end

-- only Linux as of now. See https://github.com/luapower/time
local function posiximpl ()

  ffi.cdef[[
    typedef struct {
      long s;
      long ns;
    } time_timespec;

    int time_nanosleep(time_timespec*, time_timespec *) asm("nanosleep");
  ]]

  local EINTR = 4

  local t = ffi.new('time_timespec')

  local function sleep (s)
    local int, frac = math.modf(s)
    t.s = int
    t.ns = frac * 1e9
    local ret = C.time_nanosleep(t, t)
    while ret == -1 and ffi.errno() == EINTR do --interrupted
      ret = C.time_nanosleep(t, t)
    end
    assert(ret == 0)
  end

  ffi.cdef [[
    int time_clock_gettime(int clock_id, time_timespec *tp) asm("clock_gettime");
  ]]

  local CLOCK_REALTIME = 0
  local CLOCK_MONOTONIC = 1

  local clock_gettime = ffi.load('rt').time_clock_gettime

  local function tos(tm)
    return tonumber(tm.s) + tonumber(tm.ns) / 1e9
  end

  local function time()
    assert(clock_gettime(CLOCK_REALTIME, t) == 0)
    return tos(t)
  end

  local function clock()
    assert(clock_gettime(CLOCK_MONOTONIC, t) == 0)
    return tos(t)
  end
  -- not implemented
  local StopWatch = prototype {}

  function StopWatch.new ()
    return StopWatch {
      starttime = clock()
    }
  end

  function StopWatch.ticks (self)
    return (clock() - self.starttime) * 1e9
  end

  function StopWatch.seconds (self)
    return clock() - self.starttime
  end

  function StopWatch.millis (self)
    return self:seconds() * 1000
  end

  function StopWatch.reset (self)
    self.starttime = clock()
  end

  function StopWatch.sleep (_, seconds)
    sleep(seconds)
  end

  function StopWatch.time ()
    return time()
  end


  return StopWatch
end

if ffi.os == 'Windows' then
  return winimpl()
else
  return posiximpl()
end
