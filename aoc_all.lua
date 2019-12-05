local fmt = require('fmt')
require('_test_prelude')
local StopWatch = require('stopwatch')

local sw = StopWatch.new()

sw:reset()
for i = 1,25 do
  local mod = 'aoc'..tostring(i)
  print(mod)
  ok = pcall(require, mod)
  if not ok then
    print('Does not exist')
  end
end
fmt.printf('All AOC took: %f ms', sw:millis())

