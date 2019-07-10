local List = require('table_list')

local Tap = require('tap')
local inspect = require('inspect')
local fmt = require('fmt')
local printf = fmt.printf

local tap = Tap.new { name = 'table_list.lua' }

tap:addTest(
  'List.__tostring',
  function (test)
    local l = List.new {1, 2, 3}
    test:equal(tostring(l), 'List(1, 2, 3)')
end)

tap:addTest(
  'List.prepend',
  function (test)
    local l = List.new {1, 2, 3}
    l:prepend(9)
    test:equal(tostring(l), 'List(9, 1, 2, 3)')
end)

tap:addTest(
  'List.iter',
  function (test)
    local l = List.new {1, 2, 3}
    local s = ''
    for i, e in l:iter() do
      s = s..tostring(i)..':'..tostring(e)..'|'
    end
    test:equal(s, '1:1|2:2|3:3|')
end)

tap:addTest(
  'List.length',
  function (test)
    test:equal(List.new():length(), 0)
    test:equal(List.new({1}):length(), 1)
    test:equal(List.new({1, 2}):length(), 2)
end)

tap:addTest(
  'List.isEmpty',
  function (test)
    test:isTrue(List.new():isEmpty())
end)

tap:addTest(
  'List.map',
  function (test)
    local l = List.new {1, 2, 3}
    local l2 = l:map(function (n)
        return n + 1
    end)
    test:equal(tostring(l2), 'List(2, 3, 4)')
    test:equal(tostring(l), 'List(1, 2, 3)')
end)

tap:addTest(
  'List.cons',
  function (test)
    test:equal(tostring(List.cons(1)), 'List(1)')
    test:equal(tostring(List.cons(1, List.cons(2))), 'List(1, 2)')
    test:equal(tostring(List.cons(1, List.cons(2, List.cons(3)))), 'List(1, 2, 3)')

    local l1 = List.new {2, 3}
    local l2 = List.cons(1, l1)
    test:equal(tostring(l1), 'List(2, 3)')
    test:equal(tostring(l2), 'List(1, 2, 3)')
    test:equal(l2:shift(), 1)
    test:equal(l2:shift(), 2)
    test:equal(tostring(l1), 'List(2, 3)')
    test:equal(tostring(l2), 'List(3)')
    test:equal(l2:shift(), 3)
    test:equal(tostring(l2), 'List()')
    test:equal(tostring(l2), 'List()')
    test:equal(tostring(l2), 'List()')
end)

tap:addTest(
  'List: Random access',
  function (test)
    local l = List.new {1, 2, 3}
    test:equal(l:length(), 3)
    test:equal(l:first(), 1)
    test:equal(l:first(), l[1])
    test:equal(l[2], 2)
    test:equal(l[2], l:get(2))
    test:equal(l:skip(1)[1], 2)

    test:equal(List.cons(11, l):get(1), 11)
end)

tap:addTest(
  'List: sorting',
  function (test)
    local l = List.new {4, 1, 3, 5, 2}
    l:sortInPlace()
    test:equal(tostring(l), 'List(1, 2, 3, 4, 5)')
end)

tap:run()
