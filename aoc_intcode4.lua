require('_test_prelude')
local inspect = require('inspect')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')
require('fun')()

local tap = require('tap').new {name='Intcode4'}

local function setIfNil (tbl, key, defaultVal)
  if tbl[key] == nil then
    tbl[key] = defaultVal
  end
end

--- @param program - A table of integers, that is the program and memory.
--- @param options - A table specifying the options.
function computer (program, options)
  local api = {}
  local memory = totable(iter(program))
  setIfNil(options, 'name', 'Anon')
  setIfNil(options, 'verbosity', 0)
  setIfNil(options, 'debug', 0)

  local zeroPtr = 0
  local relOffset = 0

  local function expandMemory (minSize)
    fmt.printf('[%s]: Expanding memory to: %d', options.name, minSize)
    for i = #memory + 1, minSize do
      memory[i] = memory[i] or 0
    end
  end

  local function getArgValue (offset, modes)
    local mode = modes[offset] or 0
    assert(mode ~= nil, 'mode cannot be nil')

    local arg = memory[zeroPtr + 1 + offset]
    assert(arg ~= nil, 'arg cannot be nil')

    if mode == 0 then -- position mode
      if (arg + 1) > #memory then
        expandMemory(arg + 1)
      end
      return memory[arg + 1], string.format('@%s(%s)', arg + 1, memory[arg + 1])
    elseif mode == 1 then -- immediate mode
      return arg, tostring(arg)
    elseif mode == 2 then -- relative mode
      local addr = relOffset + 1 + arg
      if addr > #memory then
        expandMemory(addr)
      end
      return memory[addr], string.format(
        '#[rbo(%s) + 1 + arg(%s) = %s](%s)', relOffset, arg, addr, memory[relOffset + 1 + arg])
    else
      error('Unknown mode')
    end
  end

  local instructions = {
    ['1'] = {
      name = 'add';
      parameterCount = 3;
      compute = function (modes)
        local arg1, arg1Meta = getArgValue(1, modes)
        local arg2, arg2Meta = getArgValue(2, modes)
        local resultAddr = memory[zeroPtr + 1 + 3]

        if options.verbosity > 1 then
          fmt.printf(
            '[%s].(add): [%d] = %s + %s',
            options.name, resultAddr + 1, arg1Meta, arg2Meta)
        end

        memory[resultAddr + 1] = arg1 + arg2
        zeroPtr = zeroPtr + 4
      end;
    };

    ['2'] = {
      name = 'mul';
      parameterCount = 3;
      compute = function (modes)
        local arg1, arg1Meta = getArgValue(1, modes)
        local arg2, arg2Meta = getArgValue(2, modes)
        local resultAddr = memory[zeroPtr + 1 + 3]

        if options.verbosity > 1 then
          fmt.printf(
            '[%s].(mul): [%d] = %s * %s',
            options.name, resultAddr + 1, arg1Meta, arg2Meta)
        end

        memory[resultAddr + 1] = arg1 * arg2
        zeroPtr = zeroPtr + 4
      end;
    };

    ['3'] = {
      name = 'input';
      parameterCount = 1;
      compute = function (modes)
        local result1Addr
        if (modes[1] == nil) or (modes[1] == 0) then
          result1Addr = memory[zeroPtr + 1 + 1]
        elseif modes[1] == 2 then
          result1Addr = memory[relOffset + 1 + memory[zeroPtr + 2]]
        end

        zeroPtr = zeroPtr + 2

        if options.verbosity > 1 then
          fmt.printf('[%s] BLOCKING FOR INPUT', options.name)
        end

        return function (value)
          if value == nil then
            error('Nil value from input')
          end

          if options.verbosity > 1 then
            fmt.printf('[%s].(input): @%s=%s', options.name, result1Addr, value)
          end

          memory[result1Addr + 1] = tonumber(value)
        end
      end;
    };

    ['4'] = {
      name = 'output';
      parameterCount = 1;
      compute = function (modes)
        local arg1, arg1Meta = getArgValue(1, modes)

        zeroPtr = zeroPtr + 2

        if options.verbosity > 1 then
          fmt.printf('[%s].(output): %s', options.name, arg1Meta)
        end

        options.out(arg1)
      end;
    };

    ['5'] = {
      name = 'jump-if-true';
      parameterCount = 2;
      compute = function (modes)
        local arg1, arg1Meta = getArgValue(1, modes)
        if arg1 == 0 then
          if options.verbosity > 1 then
            fmt.printf('[%s].(jump-if-true): %s', options.name, arg1Meta)
          end
          zeroPtr = zeroPtr + 3
        else
          local resultAddr, resultMeta = getArgValue(2, modes)

          if options.verbosity > 1 then
            fmt.printf('[%s].(jump-if-true): %s? @%s(%s)',
                       options.name, arg1Meta, resultAddr, memory[resultAddr + 1])
          end

          zeroPtr = resultAddr
        end
      end;
    };

    ['6'] = {
      name = 'jump-if-false';
      parameterCount = 2;
      compute = function (modes)
        local arg1, arg1Meta = getArgValue(1, modes)
        if arg1 ~= 0 then
          if options.verbosity > 2 then
            local resultAddr, resultMeta = getArgValue(2, modes)
            fmt.printf('[%s].(jump-if-false): 0', options.name)
          end
          zeroPtr = zeroPtr + 3
        else
          local resultAddr, resultMeta = getArgValue(2, modes)

          if options.verbosity > 1 then
            fmt.printf('[%s].(jump-if-false): %s? @%s(%s)',
                       options.name, arg1Meta, resultAddr, memory[resultAddr + 1])
          end

          zeroPtr = resultAddr
        end
      end;
    };

    ['7'] = {
      name = 'less-than';
      parameterCount = 3;
      compute = function (modes)
        local arg1, arg1Meta = getArgValue(1, modes)
        local arg2, arg2Meta = getArgValue(2, modes)
        local resultAddr = memory[zeroPtr + 1 + 3]

        if options.verbosity > 1 then
          fmt.printf(
            '[%s].(less-than): [%d] = %s < %s',
            options.name, resultAddr + 1, arg1Meta, arg2Meta)
        end

        if arg1 < arg2 then
          memory[resultAddr + 1] = 1
        else
          memory[resultAddr + 1] = 0
        end

        zeroPtr = zeroPtr + 4
      end;
    };

    ['8'] = {
      name = 'equal';
      parameterCount = 3;
      compute = function (modes)
        local arg1, arg1Meta = getArgValue(1, modes)
        local arg2, arg2Meta = getArgValue(2, modes)
        local resultAddr = memory[zeroPtr + 1 + 3]

        if options.verbosity > 1 then
          fmt.printf(
            '[%s].(equal): [%d] = %s == %s',
            options.name, resultAddr + 1, arg1Meta, arg2Meta)
        end

        if arg1 == arg2 then
          memory[resultAddr + 1] = 1
        else
          memory[resultAddr + 1] = 0
        end

        zeroPtr = zeroPtr + 4
      end;
    };

    ['9'] = {
      name = 'adjust-relative-base';
      parameterCount = 1;
      compute = function (modes)
        local arg1, arg1Meta = getArgValue(1, modes)

        local relOffsetBefore = relOffset
        relOffset = relOffset + arg1

        if options.verbosity > 1 then
          fmt.printf(
            '[%s].(adjust-relative-base): +%s (%d -> %d)',
            options.name, arg1Meta, relOffsetBefore, relOffset)
        end

        zeroPtr = zeroPtr + 2
      end;
    };
  }

  local function parseOpcodeAndModes (opcodeAndModes)
    local opcodeMask = 100
    local opcode = opcodeAndModes % opcodeMask
    local modes = math.floor(opcodeAndModes / opcodeMask)
    local acc = {}
    for i, c in strings.iter(tostring(modes)) do
      table.insert(acc, tonumber(c))
    end
    return opcode, tables.reverse(acc)
  end

  local function cycleImpl ()
    while true do
      local opcode, modes = parseOpcodeAndModes(memory[zeroPtr + 1])

      if options.verbosity > 2 then
        fmt.dump {zeroPtr=zeroPtr, opcode=opcode, modes=modes}
      end

      if opcode == 99 then
        if options.verbosity > 0 then
          fmt.printf('[%s].(halt)', options.name)
        end
        return memory[1], memory
      else
        local instr = instructions[tostring(opcode)]
        if options.verbosity > 2 then
          fmt.printf('[%s]: Instruction (%s)', options.name, instr.name)
        end

        local lastZeroPtr = zeroPtr
        coroutine.yield(instr.compute(modes), memory)

        if options.verbosity > 1 then
          fmt.printf('[%s].zeroPtr(%d -> %d)', options.name, lastZeroPtr, zeroPtr)
        end
      end
    end
  end
  api.cycle = coroutine.create(cycleImpl)

  function api.run ()
    local ok, result, memory = false, nil, nil
    while coroutine.status(api.cycle) ~= 'dead' do
      ok, result = coroutine.resume(api.cycle)
      if not ok then
        fmt.dump(result)
        error('Cycle failed')
      elseif type(result) == 'function' then
        return result
      end
    end

    return result
  end

  function api.reset ()
    if options.verbosity > 1 then
      fmt.printf('[%s]: RESET', options.name)
    end
    memory = totable(iter(program))
    zeroPtr = 0
    relOffset = 0
    api.cycle = coroutine.create(cycleImpl)
  end

  function api.getMemory ()
    return totable(iter(memory))
  end

  return api
end

tap:addTest(
  'Example 1: Basics',
  function (test)
    local computer1 = computer({1,9,10,3,1,3,11,0,99,30,40,50}, {name='Test1', verbosity=0})
    local compute1 = computer1.cycle
    local ok, result1 = false, nil
    while coroutine.status(compute1) ~= 'dead' do
      ok, result1 = coroutine.resume(compute1)
    end

    test:equal(result1, 120)
end)

tap:addTest(
  'Example 2: Add',
  function (test)
    local computer1 = computer({1,9,10,3,1,3,11,0,99,30,40,50}, {name='Test2', verbosity=0})
    local result1 = computer1.run()
    test:equal(result1, 120)
end)

tap:addTest(
  'Example 3: Mul',
  function (test)
    local computer1 = computer({1,9,10,3,2,3,11,0,99,30,40,50}, {name='Test3', verbosity=0})
    local result1 = computer1.run()
    test:equal(result1, 3500)
end)

tap:addTest(
  'Example 4: IO',
  function (test)
    local testVal = 88
    local outval
    local computer1 = computer({3,0,4,0,99}, {
        name='Test4',
        verbosity=0,
        out = function (v)
          outval = v
        end;
    })
    local result1 = computer1.run()
    result1(testVal)
    local result1 = computer1.run()
    test:equal(outval, testVal)
end)

tap:addTest(
  'Example 5: jump-if-true',
  function (test)
    local computer1 = computer(
      {
        1105, 1, 6,    -- jump-if-true (1, 4)
        99,            -- HALT (this one should not happen)
        99,            -- HALT (this one should not happen)
        99,            -- HALT (this one should not happen)
        1001, 2, 3, 0, -- add(@2, 3) => 0
        99,            -- HALT
      }, {
        name='Test5',
        verbosity=0,
    })
    local result1 = computer1.run()
    test:equal(result1, 9)
    test:equal(computer1.getMemory()[1], 9)
end)

tap:addTest(
  'Example 6: IO',
  function (test)
    local outval
    local program = {
      3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
      1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
      999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99
    }
    local computer1 = computer(program, {
        name='Test6',
        verbosity=0,
        out = function (v)
          outval = v
        end;
    })
    local result1 = computer1.run()
    result1(7)
    local result1 = computer1.run()
    test:equal(outval, 999)

    computer1.reset()
    local result1 = computer1.run()
    result1(8)
    local result1 = computer1.run()
    test:equal(outval, 1000)

    computer1.reset()
    local result1 = computer1.run()
    result1(9)
    local result1 = computer1.run()
    test:equal(outval, 1001)
end)

tap:addTest(
  'Example 7: RelOffset',
  function (test)
    local program = {109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99}
    local acc = {}
    local computer1 = computer(
      program, {
        name='Test7',
        verbosity=0,
        out = function (v)
          acc[#acc+1] = v
        end
    })
    local result1 = computer1.run()
    test:equal(inspect(program), inspect(acc))
end)

tap:addTest(
  'Example 7: RelOffset',
  function (test)
    local program = {109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99}
    local acc = {}
    local computer1 = computer(
      program, {
        name='Test7',
        verbosity=0,
        out = function (v)
          acc[#acc+1] = v
        end
    })
    local result1 = computer1.run()
    test:equal(inspect(program), inspect(acc))
end)

tap:addTest(
  'Example 8: Large numbers',
  function (test)
    local program = {1102,34915192,34915192,7,4,7,99,0}
    local outVal = 0
    local computer1 = computer(
      program, {
        name='Test7',
        verbosity=0,
        out = function (v)
          outVal = v
        end
    })
    local result1 = computer1.run()
    test:equal(tostring(outVal), '1.2190706323969e+15')
end)

tap:addTest(
  'Example 8: Large numbers',
  function (test)
    local program = {104,1125899906842624,99}
    local outVal = 0
    local computer1 = computer(
      program, {
        name='Test7',
        verbosity=0,
        out = function (v)
          outVal = v
        end
    })
    local result1 = computer1.run()
    test:equal(tostring(outVal), '1.1258999068426e+15')
end)

tap:run()

return computer
