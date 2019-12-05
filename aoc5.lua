
require('_test_prelude')
local inspect = require('inspect')
local prototype = require('prototype')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')
local StopWatch = require('stopwatch')
local linalg = require('linalg')
local vec2i = linalg.vec2i

local intcode = require('aoc_intcode')

local function getInput ()
  local inputFile = io.open('aoc5-input.txt')
  local inputText = inputFile:read('*l')
  inputFile:close()

  local input = tables.map(
    strings.split(inputText, ','),
    function (a)
      return tonumber(a)
  end)

  return input
end

intcode.enableMockIO()
intcode.setOnMockOutput(function (...)
  print(...)
end)

intcode.setMockInput(1)
intcode.compute(getInput(), 0)
-- print('Result: ', intcode.readMockOutput())

intcode.setMockInput(5)
-- intcode.setVerbose(true)
intcode.compute(getInput(), 0)
-- print('Result: ', intcode.readMockOutput())
