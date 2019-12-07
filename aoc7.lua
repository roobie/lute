
require('_test_prelude')
local inspect = require('inspect')
local prototype = require('prototype')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')

local utils = require('aoc_utils')
local tap = require('tap').new {name = 'AoC 7'}

require('fun')()

local intcode = require('aoc_intcode')


local function getInput()
  local inputText = utils.getInputText('aoc7.input.txt')
  return tables.map(
    strings.split(inputText, ','),
    function (a)
      return tonumber(a)
  end)
end

local VERBOSE = true
local amps = {'A', 'B', 'C', 'D', 'E', }

--- @param phaseSettings {[ampName] = setting}
local function ampPipeline (program, phaseSettings)
  intcode.enableMockIO()
  local yield = coroutine.yield
  local lastOutput
  intcode.setOnMockOutput(function (v)
      if VERBOSE then
        fmt.printf('Output: %d', v)
      end
      lastOutput = v
  end)
  for i, amp in ipairs(amps) do
    intcode.setOnMockInput(
      coroutine.wrap(
        function ()
          if amp == 'A' then
            yield(phaseSettings[amp])
            yield(0)
          elseif amp == 'B' then
            yield(phaseSettings[amp])
            yield(lastOutput)
          elseif amp == 'C' then
            yield(phaseSettings[amp])
            yield(lastOutput)
          elseif amp == 'D' then
            yield(phaseSettings[amp])
            yield(lastOutput)
          elseif amp == 'E' then
            yield(phaseSettings[amp])
            yield(lastOutput)
          end
        end
      )
    )
    local output = intcode.compute(program)
    if VERBOSE then
      fmt.printf('Compute result: %d', output)
    end
  end
  return lastOutput
end

tap:addTest(
  'ampPipeline: 1',
  function (test)
    local thrusterSignal = ampPipeline(
      {3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0},
      {
        A = 4;
        B = 3;
        C = 2;
        D = 1;
        E = 0;
    })

    test:equal(thrusterSignal, 43210)
end)

tap:addTest(
  'ampPipeline: 2',
  function (test)
    local thrusterSignal = ampPipeline(
      {3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0},
      {
        A = 0;
        B = 1;
        C = 2;
        D = 3;
        E = 4;
    })

    test:equal(thrusterSignal, 54321)
end)

-- an attempt at implementing the python itertools.permutations func
-- https://docs.python.org/3/library/itertools.html#itertools.permutations
local function computePermutations (set)
  local yield = coroutine.yield
  return coroutine.wrap(function ()
      local pool = tables.take(set, #set)
      local indices = totable(range(1, #set))
      local cycles = totable(range(#set, 1, -1))

      yield(totable(iter(set)))
      while true do
        for _, i in range(#set, 1, -1) do
          fmt.dump {
            i = i;
            cycles = cycles;
            indices = indices;
          }
          cycles[i] = cycles[i] - 1
          if cycles[i] == 0 then
            local b = totable(indices)
            for a = i, #indices do
              if a == 4 then
                require('debugger')()
              end
              if b[a+1] ~= nil then
                indices[a] = b[a+1]
              else
                indices[a] = b[i]
              end
            end
            cycles[i] = #pool - i
          else
            local j = cycles[i]
            indices[i], indices[#indices-j] = indices[#indices-j], indices[i]
            yield(totable(map(function (x) return pool[x] end, iter(indices))))
          end
        end
        yield(nil)
      end
  end)
end

tap:addTest(
  'Permutations',
  function (test)
    local perms = require('aoc7_permutations')
    test:equal(#perms, 120)
end)

local perms = require('aoc7_permutations')
tap:addTest(
  'A',
  function (test)

    local function getPhaseSettings (amps)
      local acc = {}
      for i, a in ipairs(amps) do
        acc[a] = i - 1
      end
      return acc
    end

    local highestThrusterSignal = 0
    local highestPhaseSettings = nil
    if false then
    for _, amps in iter(perms) do
      local phaseSettings = getPhaseSettings(amps)
      local thrusterSignal = ampPipeline(
        getInput(),
        phaseSettings)
      if thrusterSignal > highestThrusterSignal then
        highestThrusterSignal = thrusterSignal
        highestPhaseSettings = phaseSettings
      end
    end
    end

    fmt.printf('Answer A: %d', highestThrusterSignal)
end)

local computer = require('aoc_intcode2')
--- @param phaseSettings {[ampName] = setting}
local function ampPipelineFeedback (getProgram, phaseSettings)
  local amplifiers = {}
  for _, a in iter(amps) do
    amplifiers[a] = getProgram()
  end
  local lastVal
  for _, a in iter(amps) do
    amplifiers[a] = computer(
      getProgram(),
      function (a)
        if VERBOSE then
          fmt.printf('Output: %s', a)
        end
        lastVal = a
      end,
      a)
  end
  local send = amplifiers.A.compute()
  send(phaseSettings.A)
  send = amplifiers.A.compute()
  send(0)
  send = amplifiers.B.compute()
  send(phaseSettings.B)
  amplifiers.B.send = amplifiers.B.compute()
  send = amplifiers.C.compute()
  send(phaseSettings.C)
  amplifiers.C.send = amplifiers.C.compute()
  send = amplifiers.D.compute()
  send(phaseSettings.D)
  amplifiers.D.send = amplifiers.D.compute()
  send = amplifiers.E.compute()
  send(phaseSettings.E)
  amplifiers.E.send = amplifiers.E.compute()

  while true do
    for _, a in iter(amps) do
      if type(amplifiers[a].send) == 'function' then
        amplifiers[a].send(lastVal)
        amplifiers[a].send = nil
      end
      local result, memory, halted = amplifiers[a].compute()
      amplifiers[a].halted = halted
      if not halted then
        if type(result) == 'function' then
          amplifiers[a].send = result
        end
      end
    end

    local done = true
    for _, a in iter(amps) do
      done = done and amplifiers[a].halted
    end
    if done then
      return lastVal
    end
  end
end

tap:addTest(
  'B',
  function (test)
    local function getPhaseSettings (amps)
      local acc = {}
      for i, a in ipairs(amps) do
        acc[a] = i + 4
      end
      return acc
    end

    -- intcode.setVerbose(true)

    local highestThrusterSignal = 0
    for _, amps in iter(perms) do
      local phaseSettings = getPhaseSettings(amps)
      local thrusterSignal = ampPipelineFeedback(
        getInput,
        -- function ()
        --   return {
        --     3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,
        --     27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5
        --   }
        -- end,
        phaseSettings)
      if thrusterSignal > highestThrusterSignal then
        highestThrusterSignal = thrusterSignal
      end
    end

    fmt.printf('Answer B: %d', highestThrusterSignal)
end)

tap:run()
