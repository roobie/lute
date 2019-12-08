--- NOT DONE! Consider coroutines

require('_test_prelude')
local inspect = require('inspect')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')

local tap = require('tap').new {name='Intcode2'}

local function getArgValue (memory, instructionPointer, offset, modes)
  local mode = modes[offset]
  assert(mode ~= nil, 'mode cannot be nil')

  local arg = memory[instructionPointer + offset]
  assert(arg ~= nil, 'arg cannot be nil')

  if mode == 0 then -- position mode
    return memory[arg + 1]
  elseif mode == 1 then -- immediate mode
    return arg
  else
    error('Unknown mode')
  end
end

local function computer (IO, options)
  local zeroBasedInstructionPointer = 0
  local memory = nil

  local instructions = {
    ['1'] = {
      name = 'add';
      parameterCount = 3;
      compute = function (modes)
        local ptr = zeroBasedInstructionPointer + 1
        local arg1 = getArgValue(memory, ptr, 1, modes)
        local arg2 = getArgValue(memory, ptr, 2, modes)
        local resultAddr = memory[ptr + 3]

        memory[resultAddr + 1] = arg1 + arg2
        zeroBasedInstructionPointer = ptr + 4 - 1
      end;
    };

    ['3'] = {
      name = 'input';
      parameterCount = 1;
      compute = function (modes)
        local ptr = zeroBasedInstructionPointer + 1
        local result1Addr = memory[ptr + 1]

        zeroBasedInstructionPointer = ptr + 2 - 1
        return function (value)
          if value == nil then
            error('Value is nil')
          end
          if options.verbose > 0 then
            print('Input: ', value)
          end
          memory[result1Addr + 1] = tonumber(value)
        end
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

  local cycle = coroutine.create(function ()
      local opcodeAndModes = memory[zeroBasedInstructionPointer + 1]
      local opcode, modes = parseOpcode(opcodeAndModes)
      local instruction = instructions[tostring(opcode)]
      assert(instruction ~= nil, 'Instruction is nil, so there is a bug')
      if opcode == 99 then -- halt
        return memory[1], true
      end
      local paddedModes = tables.padEnd(modes, instruction.parameterCount, 0)
      local result = instruction.compute(paddedModes)
      if instruction.name == 'input' then
        result(IO.read())
      elseif instruction.name == 'output' then
        IO.write(result)
      end
  end)

  local compute = coroutine.create(function ()
    if memory == nil then
      error('No program loaded.')
    end

    compute()
  end)

  local function loadProgram (program)
    memory = program
  end

  return {
    zeroBasedInstructionPointer = function (v)
      if v ~= nil then
        zeroBasedInstructionPointer = v
      else
        return zeroBasedInstructionPointer
      end
    end;
    loadProgram = loadProgram;
    compute = compute;
  }
end

return computer
