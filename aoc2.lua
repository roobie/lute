
local inspect = require('inspect')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')

local opmap = {
  ['1'] = func.add;
  ['2'] = func.mul;
  ['99'] = 'halt';
}

local function compute (memory)
  local index = memory.index
  local opcode = memory.program[index]
  local operand1Index = memory.program[index+1]
  local operand2Index = memory.program[index+2]
  local resultIndex = memory.program[index+3]

  local op = opmap[tostring(opcode)]
  if op == 'halt' then
    return memory.program[1], memory.program
  end

  -- Program i zero-based index, whereas Lua is 1-based, so
  -- we adjust the indices here.
  memory.program[resultIndex+1] = op(
    memory.program[operand1Index+1],
    memory.program[operand2Index+1]
  )

  memory.index = index + 4
  return compute(memory)
end

do -- tests
  local res1 = compute {
    index = 1;
    program = {1,9,10,3,2,3,11,0,99,30,40,50}
  }
  assert(res1 == 3500, 'Compute shoud equal 3500')

  local res2, res22 = compute {
    index = 1;
    program = {1,1,1,4,99,5,6,0,99}
  }
  assert(strings.join(res22, ',') == '30,1,1,4,2,5,6,0,99')
end

do
  local input = {1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,10,1,19,1,19,5,23,1,23,9,27,2,27,6,31,1,31,6,35,2,35,9,39,1,6,39,43,2,10,43,47,1,47,9,51,1,51,6,55,1,55,6,59,2,59,10,63,1,6,63,67,2,6,67,71,1,71,5,75,2,13,75,79,1,10,79,83,1,5,83,87,2,87,10,91,1,5,91,95,2,95,6,99,1,99,6,103,2,103,6,107,2,107,9,111,1,111,5,115,1,115,6,119,2,6,119,123,1,5,123,127,1,127,13,131,1,2,131,135,1,135,10,0,99,2,14,0,0}

  local memory = {
    program = input;
    index = 1;
  }
  memory.program[2] = 12
  memory.program[3] = 2
  local result = compute(memory)
  print(result)
end

do
  local function getProgram (noun, verb)
    return {1,noun,verb,3,1,1,2,3,1,3,4,3,1,5,0,3,2,10,1,19,1,19,5,23,1,23,9,27,2,27,6,31,1,31,6,35,2,35,9,39,1,6,39,43,2,10,43,47,1,47,9,51,1,51,6,55,1,55,6,59,2,59,10,63,1,6,63,67,2,6,67,71,1,71,5,75,2,13,75,79,1,10,79,83,1,5,83,87,2,87,10,91,1,5,91,95,2,95,6,99,1,99,6,103,2,103,6,107,2,107,9,111,1,111,5,115,1,115,6,119,2,6,119,123,1,5,123,127,1,127,13,131,1,2,131,135,1,135,10,0,99,2,14,0,0}
  end
  local targetOutput = 19690720
  local verb = 0
  local noun = 0

  local found = false
  for noun = 0,99 do
    if found then
      break
    end
    for verb = 0,99 do
      print('Trying', 'noun:', noun, 'verb:', verb)
      local memory = {
        program = getProgram(noun, verb);
        index = 1;
      }
      local result = compute(memory)
      if result == targetOutput then
        found = true
        print(inspect {
                result = result,
                noun = noun,
                verb = verb,
                answer = 100 * noun + verb
        })
        break
      end
    end
  end
end
