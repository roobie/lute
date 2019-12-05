
require('_test_prelude')
local inspect = require('inspect')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')

local tap = require('tap').new {name='Intcode'}

local DEBUG = true
-- local MOCK = false
local MOCK = true
-- mockIO is used if MOCK is true. Index 1 is input and index 2 is output
local mockIO = {}

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
    name = "add";
    parameterCount = 3;
    compute = function (memory, instructionPointer, modes)
      local resultAddr = memory[instructionPointer+3]

      memory[resultAddr + 1] =
        getArgValue(memory, instructionPointer, 1, modes)
        +
        getArgValue(memory, instructionPointer, 2, modes)

      return instructionPointer + 4
    end;
  };

  ['2'] = {
    name = "mul";
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
    name = "input";
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
    name = "output";
    parameterCount = 1;
    compute = function (memory, instructionPointer, modes)
      local arg1Addr = memory[instructionPointer+1]
      if MOCK then
        mockIO[2] = memory[arg1Addr+1]
      else
        io.write(memory[arg1Addr+1], '\n')
      end
      return instructionPointer + 2
    end
  };

  ['99'] = {
    name = "halt";
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
  local oneBasedInstructionPointer = zeroBasedInstructionPointer + 1
  local opcodeAndModes = memory[oneBasedInstructionPointer]

  local opcode, modes = parseOpcode(opcodeAndModes)

  if opcode == 99 then -- halt
    return memory[1], memory
  end

  local instruction = instructions[tostring(opcode)]
  assert(instruction ~= nil, string.format('instruction is nil, %s - %s', opcodeAndModes, opcode))
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
  'Intrisics',
  function (test)
    local t = {1}
    tables.padEnd(t, 3, 0)
    test:equal(#t, 3)
    test:equal(t[1], 1)
    test:equal(t[2], 0)
    test:equal(t[3], 0)
end)

if MOCK then
  tap:addTest(
    'IO',
    function (test)
      mockIO[1] = 123
      mockIO[2] = 0
      local res1 = compute({3, 1, 4, 1, 99}, 0)
      test:equal(mockIO[2], 123)
  end)
end

tap:run()
