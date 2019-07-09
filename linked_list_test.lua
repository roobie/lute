local List = require('linked_list')

local Tap = require('tap')
local inspect = require('inspect')
local fmt = require('fmt')
local printf = fmt.printf

local tap = Tap.new { name = 'linked_list.lua' }
tap:addTest(
  'Test basic list operations',
  function (test)
    test:plan(12)
    local l1 = List.new()
    l1:add(1)
    test:equal(l1:length(), 1)
    l1:add(2)
    test:equal(l1:length(), 2)
    l1:add(3)
    test:equal(l1:length(), 3)

    printf('# %s', l1)

    local s = ''
    for i, v in l1:iter() do
      s = s..tostring(v)..','
    end
    test:equal(s, '1,2,3,')

    l1:add(4)
    l1:add(5)
    test:equal(l1:length(), 5)
    l1:remove(1)
    test:equal(l1:length(), 4)
    local s = ''
    for i, v in l1:iter() do
      s = s..tostring(v)..','
    end
    test:equal(s, '2,3,4,5,')

    l1:remove(4)
    test:equal(tostring(l1), 'List(2, 3, 5)')

    l1:remove(2)
    l1:remove(3)
    test:equal(l1:length(), 1)
    l1:remove(5)
    test:equal(l1:length(), 0)

    l1:add(1)
    l1:add(2)
    l1:add(3)
    l1:add(4)
    l1:add(5)
    test:equal(l1:length(), 5)
    local t = {}
    for i, v in l1:iter() do
      table.insert(t, v)
    end
    for _, v in ipairs(t) do
      l1:remove(v)
    end
    test:equal(l1:length(), 0)
end)

tap:addTest(
  'More basic list stuff',
  function (test)
    test:isTrue(List.new():isEmpty(), 'An empty list should be empty')
end)

tap:addTest(function (test)
    local l1, l2, l3
    l1 = List.new {1, 2}
    l2 = List.new {3, 4}
    l3 = l1..l2

    test:plan(6)
    test:equal(tostring(l1), 'List(1, 2)')
    test:equal(tostring(l2), 'List(3, 4)')
    test:equal(tostring(l3), 'List(1, 2, 3, 4)')

    test:equal(l3[1], 1)
    test:equal(l3[2], 2)
    test:equal(l3[3], 3)
end)

tap:addTest(
  'Test __index and __newindex',
  function (test)
    l0 = List.new()
    test:equal(tostring(l0), 'List()')
    l0:insertAt(1, 1)
    test:equal(tostring(l0), 'List(1)')
    l1 = List.new {1, 2}
    test:equal(tostring(l1), 'List(1, 2)')
    l1:insertAt(1, 0)
    test:equal(tostring(l1), 'List(0, 1, 2)')
    l1[4] = 3
    test:equal(tostring(l1), 'List(0, 1, 2, 3)')
    l1[4] = 9
    test:equal(tostring(l1), 'List(0, 1, 2, 9, 3)')
    test:equal(l1[4], 9)

    local l2 = List.new {
      l0, l1
    }
    printf('# %s', l2)
end)

tap:addTest(
  'sorting a list',
  function (test)
    local list = List.new { 6, 4, 2, 3, 1, 5 }
    list:sortInPlace()
    test:equal(tostring(list), 'List(1, 2, 3, 4, 5, 6)')
end)

tap:run()
