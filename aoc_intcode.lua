
require('_test_prelude')
local inspect = require('inspect')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')

local tap = require('tap').new {name='Intcode'}

local DEBUG = true
local VERBOSE = false
local MOCK = false
-- local MOCK = true
-- mockIO is used if MOCK is true. Index 1 is input and index 2 is output
local mockIO = {}
local onMockOutput = function (...)
  print(...)
end
local function setOnMockOutput (fn)
  onMockOutput = fn
end

-- Maybe TODO: onMockInput

local function enableMockIO ()
  MOCK = true
end

local function disableMockIO ()
  MOCK = false
end

local function setMockInput (v)
  mockIO[1] = v
end

local function readMockOutput (v)
  return mockIO[2]
end

local function getValue (memory, arg, mode)
  if mode == 0 then -- position mode
    return memory[arg + 1]
  elseif mode == 1 then -- immediate mode
    return arg
  else
    error('Unknown mode')
  end
end

local function getArgValue (memory, instructionPointer, offset, modes)
  local mode = modes[offset]
  assert(mode ~= nil, 'mode cannot be nil')

  local arg = memory[instructionPointer + offset]
  assert(arg ~= nil, 'arg cannot be nil')

  return getValue(memory, arg, mode)
end

local instructions = {
  ['1'] = {
    name = 'add';
    parameterCount = 3;
    compute = function (memory, instructionPointer, modes)
      local arg1 = getArgValue(memory, instructionPointer, 1, modes)
      local arg2 = getArgValue(memory, instructionPointer, 2, modes)
      local resultAddr = memory[instructionPointer+3]

      memory[resultAddr + 1] = arg1 + arg2

      if VERBOSE then
        fmt.printf('Add: %s', inspect {
                     instructionPointer = instructionPointer,
                     arg1 = arg1,
                     arg2 = arg2,
                     resultAddr = resultAddr,
                     valueAtResultAddr = memory[resultAddr + 1],
                     newInstructionPointer = instructionPointer + 4
        })
      end

      return instructionPointer + 4
    end;
  };

  ['2'] = {
    name = 'mul';
    parameterCount = 3;
    compute = function (memory, instructionPointer, modes)
      local resultAddr = memory[instructionPointer+3]

      memory[resultAddr + 1] =
        getArgValue(memory, instructionPointer, 1, modes)
        *
        getArgValue(memory, instructionPointer, 2, modes)

      return instructionPointer + 4
    end;
  };

  ['3'] = {
    name = 'input';
    parameterCount = 1;
    compute = function (memory, instructionPointer, modes)
      local result1Addr = memory[instructionPointer+1]
      local value
      if MOCK then
        value = mockIO[1]
      else
        value = io.read()
      end

      memory[result1Addr + 1] = tonumber(value)
      return instructionPointer + 2
    end
  };

  ['4'] = {
    name = 'output';
    parameterCount = 1;
    compute = function (memory, instructionPointer, modes)
      local val = getArgValue(memory, instructionPointer, 1, modes)
      if MOCK then
        mockIO[2] = val
        if type(onMockOutput) == 'function' then
          onMockOutput(val)
        end
      else
        io.write(val, '\n')
      end
      return instructionPointer + 2
    end
  };

  ['5'] = {
    name = 'jump-if-true';
    parameterCount = 2;
    compute = function (memory, instructionPointer, modes)
      local arg1 = getArgValue(memory, instructionPointer, 1, modes)
      if arg1 == 0 then
        return instructionPointer + 3
      else
        local resultAddr = getArgValue(memory, instructionPointer, 2, modes)

        if VERBOSE then
          fmt.printf('JumpIfTrue: %s', inspect {
                       instructionPointer = instructionPointer,
                       arg1 = arg1,
                       resultAddr = resultAddr,
                       valueAtResultAddr = memory[resultAddr + 1],
          })
        end

        return resultAddr + 1
      end
    end
  };

  ['6'] = {
    name = 'jump-if-false';
    parameterCount = 2;
    compute = function (memory, instructionPointer, modes)
      local val = getArgValue(memory, instructionPointer, 1, modes)
      if val ~= 0 then
        return instructionPointer + 3
      else
        local addr = getArgValue(memory, instructionPointer, 2, modes)
        return addr + 1
      end
    end
  };

  ['7'] = {
    name = 'less-than';
    parameterCount = 3;
    compute = function (memory, instructionPointer, modes)
      local arg1 = getArgValue(memory, instructionPointer, 1, modes)
      local arg2 = getArgValue(memory, instructionPointer, 2, modes)
      local resultAddr = memory[instructionPointer+3]
      if arg1 < arg2 then
        memory[resultAddr + 1] = 1
      else
        memory[resultAddr + 1] = 0
      end
      return instructionPointer + 4
    end
  };

  ['8'] = {
    name = 'equal';
    parameterCount = 3;
    compute = function (memory, instructionPointer, modes)
      local arg1 = getArgValue(memory, instructionPointer, 1, modes)
      local arg2 = getArgValue(memory, instructionPointer, 2, modes)
      local resultAddr = memory[instructionPointer+3]
      if arg1 == arg2 then
        memory[resultAddr + 1] = 1
      else
        memory[resultAddr + 1] = 0
      end

      if VERBOSE then
        fmt.printf('Equal: %s', inspect {
                     instructionPointer = instructionPointer,
                     arg1 = arg1,
                     arg2 = arg2,
                     resultAddr = resultAddr,
                     valueAtResultAddr = memory[resultAddr + 1],
        })
      end
      return instructionPointer + 4
    end
  };

  ['99'] = {
    name = 'halt';
    parameterCount = 0;
    compute = function ()
      error('Halt')
    end;
  };
}

-- opcodeAndModes is the 10- and 1- digit
local function parseOpcode (opcodeAndModes)
  local opcodeMask = 100
  local opcode = opcodeAndModes % opcodeMask
  local modes = math.floor(opcodeAndModes / opcodeMask)
  local acc = {}
  for i, c in strings.iter(tostring(modes)) do
    table.insert(acc, tonumber(c))
  end
  return opcode, tables.reverse(acc)
end

local function compute (memory, zeroBasedInstructionPointer)
  if VERBOSE then
    assert(type(memory[1]) == 'number', 'Memory must be numbers')
  end
  if zeroBasedInstructionPointer == nil then
    zeroBasedInstructionPointer = 0
  end

  local oneBasedInstructionPointer = zeroBasedInstructionPointer + 1
  local opcodeAndModes = memory[oneBasedInstructionPointer]

  local opcode, modes = parseOpcode(opcodeAndModes)

  if opcode == 99 then -- halt
    return memory[1], memory
  end

  local instruction = instructions[tostring(opcode)]
  assert(
    instruction ~= nil,
    string.format(
      'instruction is nil! %s', inspect {
        opcodeAndModes = opcodeAndModes,
        opcode = opcode,
        modes = modes,
        memory = memory,
        oneBasedInstructionPointer = oneBasedInstructionPointer,
        zeroBasedInstructionPointer = zeroBasedInstructionPointer,
  }))
  if VERBOSE then
    fmt.printf('Operation: %s', inspect {
                 opcode = opcode,
                 instruction = instruction.name,
                 modes = modes,
                 memory = memory,
                 oneBasedInstructionPointer = oneBasedInstructionPointer,
    })
  end
  local newOneBasedInstructionPointer = instruction.compute(
    memory,
    oneBasedInstructionPointer,
    tables.padEnd(modes, instruction.parameterCount, 0)
  )

  return compute(memory, newOneBasedInstructionPointer - 1)
end

tap:addTest(
  'Basics',
  function (test)
    local res1 = compute({1,9,10,3,2,3,11,0,99,30,40,50}, 0)
    test:equal(res1, 3500,
           fmt.printf('Expected(%d) : Actual(%d)', 3500, res1))

  local res2, res22 = compute({1,1,1,4,99,5,6,0,99}, 0)
  test:equal(strings.join(res22, ','), '30,1,1,4,2,5,6,0,99')

  local opcode, modes = parseOpcode(10002)
  test:equal(opcode, 2)
  test:equal(modes[1], 0)
  test:equal(modes[2], 0)
  test:equal(modes[3], 1)
end)

tap:addTest(
  'jump-if-true',
  function (test)
    local res, mem = compute {
      1105, 1, 4,    -- jump-if-true (1, 4)
      99,            -- HALT (this one should not happen)
      1001, 2, 5, 0, -- add(@2, 5) => 0
      99,            -- HALT
    }
    test:equal(res, 9)
    test:equal(mem[1], 9)
end)

tap:addTest(
  'jump-if-false',
  function (test)
    local res, mem = compute {
        1106, 0, 4,    -- jump-if-true (1, 4)
        99,            -- HALT (this one should not happen)
        1001, 2, 5, 0, -- add(@2, 5) => 0
        99,            -- HALT
      }
    test:equal(res, 9)
    test:equal(mem[1], 9)
end)

tap:addTest(
  'less-than',
  function (test)
    local res, mem = compute {
      1107, 80, 90, 0, -- [0] = lessThan(80, 90)
      99,              -- HALT
    }
    test:equal(res, 1)
    test:equal(mem[1], 1)
end)

tap:addTest(
  'equal',
  function (test)
    local res, mem = compute {
      1108, 80, 80, 0, -- [0] = equal(80, 80)
      99,              -- HALT
    }
    test:equal(res, 1)
    test:equal(mem[1], 1)
end)

enableMockIO()
if MOCK then
  tap:addTest(
    'IO',
    function (test)
      mockIO[1] = 123
      mockIO[2] = 0
      local res1 = compute({3, 1, 4, 1, 99}, 0)
      test:equal(mockIO[2], 123)
  end)

  tap:addTest(
    'IO2',
    function (test)
      mockIO[1] = 5
      mockIO[2] = 0
      compute {
        3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99
      }
      test:equal(mockIO[2], 999)

      mockIO[1] = 8
      mockIO[2] = 0
      compute {
        3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99
      }
      test:equal(mockIO[2], 1000)

      mockIO[1] = 9
      mockIO[2] = 0
      compute {
        3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99
      }
      test:equal(mockIO[2], 1001)
  end)
end

tap:run()
disableMockIO()

return {
  compute = compute;
  enableMockIO = enableMockIO;
  disableMockIO = disableMockIO;
  setMockInput = setMockInput;
  readMockOutput = readMockOutput;
  setVerbose = function (b)
    VERBOSE = b
  end;
  setOnMockOutput = setOnMockOutput;
}
