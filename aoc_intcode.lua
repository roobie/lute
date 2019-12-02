
local inspect = require('inspect')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')

local instructions = {
  ['1'] = { -- add
    parameterCount = 3;
    compute = function (memory, instructionPointer)
      -- these are zero based
      local arg1Addr = memory[instructionPointer+1]
      local arg2Addr = memory[instructionPointer+2]
      local resultAddr = memory[instructionPointer+3]

      memory[resultAddr + 1] =
        memory[arg1Addr + 1] + memory[arg2Addr + 1]

      return instructionPointer + 4
    end;
  };

  ['2'] = { -- mul
    parameterCount = 3;
    compute = function (memory, instructionPointer)
      local arg1Addr = memory[instructionPointer+1]
      local arg2Addr = memory[instructionPointer+2]
      local resultAddr = memory[instructionPointer+3]

      memory[resultAddr + 1] =
        memory[arg1Addr + 1] * memory[arg2Addr + 1]

      return instructionPointer + 4
    end;
  };

  ['99'] = { -- halt
    parameterCount = 0;
    compute = function ()
      error('Halt')
    end;
  };
}

local function compute (memory, zeroBasedInstructionPointer)
  local oneBasedInstructionPointer = zeroBasedInstructionPointer + 1
  local opcode = memory[oneBasedInstructionPointer]

  if opcode == 99 then -- halt
    return memory[1], memory
  end

  local instruction = instructions[tostring(opcode)]
  local newOneBasedInstructionPointer = instruction.compute(
    memory, oneBasedInstructionPointer)

  return compute(memory, newOneBasedInstructionPointer - 1)
end

do -- tests
  local res1 = compute({1,9,10,3,2,3,11,0,99,30,40,50}, 0)
  assert(res1 == 3500,
         fmt.printf('Expected(%d) : Actual(%d)', 3500, res1))

  -- local res2, res22 = compute({1,1,1,4,99,5,6,0,99}, 0)
  -- assert(strings.join(res22, ',') == '30,1,1,4,2,5,6,0,99')
end
