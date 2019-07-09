
local quickSort = require('quick_sort')

local Tap = require('tap')
local fmt = require('fmt')
local printf = fmt.printf

local tap = Tap.new()

tap:addTest(
  'Quick sort 1',
  function (test)
    local t = {3, 8, 2, 4, 1, 5, 7, 6}
    quickSort(t)
    local acc = ''
    for i, v in ipairs(t) do
      acc = acc..tostring(v)
    end
    test:equal(acc, '12345678', 'sorted')
end)

local function gt (a, b)
  return a > b
end

tap:addTest(
  'Quick sort 2',
  function (test)
    local t = {3, 8, 2, 4, 1, 5, 7, 6}
    quickSort(t, gt)
    local acc = ''
    for i, v in ipairs(t) do
      acc = acc..tostring(v)
    end
    test:equal(acc, '87654321', 'sorted')
end)

tap:run()
