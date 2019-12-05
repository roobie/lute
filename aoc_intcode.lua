
require('_test_prelude')
local inspect = require('inspect')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')

local tap = require('tap').new {name='Intcode'}

local DEBUG = true

local function getValue (memory, value, mode)
  if mode == 0 then -- addr mode
    return memory[value + 1]
  elseif mode == 1 then -- immediate mode
    return value
  else
    error('Unknown mode')
  end
end

local instructions = {
  ['1'] = { -- add
    parameterCount = 3;
    compute = function (memory, instructionPointer, modes)
      -- these are zero based
      local arg1 = memory[instructionPointer+1]
      local arg1Mode = modes[1]
      assert(arg1Mode ~= nil)

      local arg2 = memory[instructionPointer+2]
      local arg2Mode = modes[2]
      assert(arg2Mode ~= nil)

      local resultAddr = memory[instructionPointer+3]

      memory[resultAddr + 1] =
        -- memory[arg1Addr + 1] + memory[arg2Addr + 1]
        getValue(memory, arg1, arg1Mode) + getValue(memory, arg2, arg2Mode)

      return instructionPointer + 4
    end;
  };

  ['2'] = { -- mul
    parameterCount = 3;
    compute = function (memory, instructionPointer, modes)
      local arg1Addr = memory[instructionPointer+1]
      local arg2Addr = memory[instructionPointer+2]
      local resultAddr = memory[instructionPointer+3]

      memory[resultAddr + 1] =
        memory[arg1Addr + 1] * memory[arg2Addr + 1]

      return instructionPointer + 4
    end;
  };

  ['3'] = { -- input
    parameterCount = 1;
    compute = function (memory, instructionPointer, modes)
      local result1Addr = memory[instructionPointer+1]
      local value = io.read()

      memory[result1Addr+1] = tonumber(value)
      return instructionPointer + 1
    end
  };

  ['4'] = { -- output
    parameterCount = 1;
    compute = function (memory, instructionPointer, modes)
      local arg1Addr = memory[instructionPointer+1]
      io.write(memory[arg1Addr+1], '\n')
      return instructionPointer + 1
    end
  };

  ['99'] = { -- halt
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

tap:run()
