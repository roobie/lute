--[[

  TBD

  @example

  local stream = rx.stream(0)
  -------------------------^ initial value. May be nil,
  -- in which case the stream has no initial value.

  print(stream()) -- prints 0 (the initial value)

  rx.map(print, stream)

  stream(1) -- prints 1
  stream(2) -- prints 2

  print(stream()) -- prints 2 (the last value)

]]

local unpack = rawget(table, 'unpack') or unpack
local prototype = require('lute.prototype')

local rx = {}

local function createDependentStream (sources, fn)
end

local function createStream (...)
  local value = {...}

  local function impl (...)
    if select('#', ...) == 0 then
      return unpack(value)
    else
      value = {...}
    end
  end

  return impl
end

return rx
