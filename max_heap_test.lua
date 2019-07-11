
local MaxHeap = require('max_heap')
local Tap = require('tap')
local fmt = require('fmt')

local tap = Tap.new {name='max_heap.lua'}

tap:addTest(
  '__tostring',
  function (test)
    test:equal(tostring(MaxHeap.new()), 'MaxHeap()')

    local h = MaxHeap.new()
    h:insert(10, 'a')
    test:equal(tostring(h), 'MaxHeap(a)')
    h:insert(20, 'b')
    test:equal(tostring(h), 'MaxHeap(b...)')
end)

tap:addTest(
  'insert/pop',
  function (test)
    local h = MaxHeap.new()
    h:insert(10, 'a')
    h:insert(30, 'c')
    h:insert(50, 'e')
    h:insert(40, 'd')
    h:insert(60, 'f')
    h:insert(20, 'b')

    test:equal(h:pop(), 'f')
    test:equal(h:pop(), 'e')
    test:equal(h:pop(), 'd')
    test:equal(h:pop(), 'c')
    test:equal(h:pop(), 'b')
    test:equal(h:pop(), 'a')
    local ok, err = pcall(function ()
        h:pop()
    end)
    test:isTrue(not ok)
end)

tap:addTest(
  'from',
  function (test)
    local h = MaxHeap.from {
      {10, 'a'};
      {20, 'b'};
    }
    test:equal(h:pop(), 'b')
    test:equal(h:pop(), 'a')
end)

tap:addTest(
  'same priority stable?',
  function (test)
    local h = MaxHeap.from {
      {10, 'a'};
      {10, 'b'};
      {10, 'c'};
    }
    test:equal(h:pop(), 'c')
    test:equal(h:pop(), 'b')
    test:equal(h:pop(), 'a')
end)

tap:addTest(
  'random (with floats)',
  function (test)
    local h = MaxHeap.new()
    for i = 1, 10 do
      local p = math.random()
      h:insert(p, p)
    end

    local acc = {}

    repeat acc[#acc + 1] = h:pop()
    until h:isEmpty()

    for i, v in ipairs(acc) do
      if i < #acc then
        test:isGte(v, acc[i+1])
      end
    end
end)

tap:run()
