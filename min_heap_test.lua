
local MinHeap = require('min_heap')
local Tap = require('tap')

local tap = Tap.new {name='min_heap.lua'}

tap:addTest(
  'basic operations',
  function (test)
    local heapData = {
      {20, 'b'};
      {30, 'c'};
      {10, 'a'};
      {15, 'd'};
    }

    test:equal(tostring(MinHeap.empty), 'MinHeap(Empty)')

    local minh = MinHeap.from(heapData)
    test:equal(
      tostring(minh),
      'MinHeap(a| MinHeap(d), MinHeap(b| MinHeap(c)))')
    local e
    e, minh = minh:pop()
    test:equal(e, 'a')
    test:equal(
      tostring(minh),
      'MinHeap(d| MinHeap(b| MinHeap(c)))')

    e, minh = minh:pop()
    test:equal(e, 'd')
    e = minh:pop()
    test:equal(e, 'b')

end)

return tap
