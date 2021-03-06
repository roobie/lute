
local quickSort = require('quick_sort')

local Tap = require('tap')

local tap = Tap.new {name = 'quick_sort.lua'}

tap:addTest(
  'sort with default comparator',
  function (test)
    local t = {3, 8, 2, 4, 1, 5, 7, 6}
    quickSort(t)
    local acc = ''
    for _, v in ipairs(t) do
      acc = acc..tostring(v)
    end
    test:equal(acc, '12345678', 'sorted')
end)

local function gt (a, b)
  return a > b
end

tap:addTest(
  'sort with specified comparator',
  function (test)
    local t = {3, 8, 2, 4, 1, 5, 7, 6}
    quickSort(t, gt)
    local acc = ''
    for _, v in ipairs(t) do
      acc = acc..tostring(v)
    end
    test:equal(acc, '87654321', 'sorted')
end)

return tap
