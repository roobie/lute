require('_test_prelude')
local inspect = require('inspect')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')

local tap = require('tap').new {name='Intcode2'}

local DEBUG = true
local VERBOSE = false

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

local function computer (program, onoutput, name)
  local zeroBasedInstructionPointer = 0
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

        return instructionPointer + 2,
        function (value)
          if value == nil then
            error('Value is nil')
          end
          if VERBOSE then
            print('Input: ', value)
          end
          memory[result1Addr + 1] = tonumber(value)
        end
      end
    };

    ['4'] = {
      name = 'output';
      parameterCount = 1;
      compute = function (memory, instructionPointer, modes)
        local val = getArgValue(memory, instructionPointer, 1, modes)
        onoutput(val)
        return instructionPointer + 2, val
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

  local function compute (memory)
    if VERBOSE then
      assert(type(memory[1]) == 'number', 'Memory must be numbers')
    end

    local oneBasedInstructionPointer = zeroBasedInstructionPointer + 1
    local opcodeAndModes = memory[oneBasedInstructionPointer]

    local opcode, modes = parseOpcode(opcodeAndModes)

    if opcode == 99 then -- halt
      if VERBOSE then
        fmt.printf('[%s] halted', name)
      end
      return memory[1], memory, true
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
      fmt.printf('Operation [%s]: %s', name, inspect {
                   opcode = opcode,
                   instruction = instruction.name,
                   modes = modes,
                   -- memory = memory,
                   oneBasedInstructionPointer = oneBasedInstructionPointer,
      })
    end
    local newOneBasedInstructionPointer, extra = instruction.compute(
      memory,
      oneBasedInstructionPointer,
      tables.padEnd(modes, instruction.parameterCount, 0)
    )

    zeroBasedInstructionPointer = newOneBasedInstructionPointer - 1

    if type(extra) == 'function' then
      return extra, memory
    end

    return compute(memory)
  end

  return {
    compute = function ()
      return compute(program)
    end;
  }
end

return computer
