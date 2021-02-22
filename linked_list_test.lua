local List = require('linked_list')

local Tap = require('tap')

local tap = Tap.new { name = 'linked_list.lua' }

tap:addTest(
  'List.__tostring',
  function (test)
    local l = List.new {1, 2, 3}
    test:equal(tostring(l), 'List(1, 2, 3)')
end)

tap:addTest(
  'List.insertAfterNode',
  function (test)
    local l = List.new {1, 2, 3}
    l:insertAfterNode(l._head, List.Node.new(9))
    test:equal(tostring(l), 'List(1, 9, 2, 3)')
end)

tap:addTest(
  'List.prependNode',
  function (test)
    local l = List.new {1, 2, 3}
    l:prependNode(List.Node.new(9))
    test:equal(tostring(l), 'List(9, 1, 2, 3)')
end)

tap:addTest(
  'List.prepend',
  function (test)
    local l = List.new {1, 2, 3}
    l:prepend(9)
    test:equal(tostring(l), 'List(9, 1, 2, 3)')
end)

tap:addTest(
  'List.removeAfterNode',
  function (test)
    local l = List.new {1, 2, 3}
    l:removeAfterNode(l._head)
    test:equal(tostring(l), 'List(1, 3)')
end)

tap:addTest(
  'List.removeFirstNode',
  function (test)
    local l = List.new {1, 2, 3}
    l:removeFirstNode()
    test:equal(tostring(l), 'List(2, 3)')
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
    l2._head._element = 9
    l2._head._next._element = 8
    test:equal(tostring(l2), 'List(9, 8, 4)')
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
    l1._head._element = 9
    test:equal(tostring(l1), 'List(9, 3)')
    test:equal(tostring(l2), 'List(1, 2, 3)')
    l2:removeFirstNode()
    l2:removeFirstNode()
    test:equal(tostring(l1), 'List(9, 3)')
    test:equal(tostring(l2), 'List(3)')
end)

return tap
