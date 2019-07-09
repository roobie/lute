local collections = require('collections')
local List = collections.List
local MinHeap = collections.MinHeap
local Tap = require('tap')
local inspect = require('inspect')
local fmt = require('fmt')
local printf = fmt.printf

local tap = Tap.new()

tap:addTest(function (test)
    local heapData = {
      {20, 'b'};
      {30, 'c'};
      {10, 'a'};
      {15, 'd'};
    }
    printf('# %s', MinHeap.empty)
    test:equal(tostring(MinHeap.empty), 'MinHeap(Empty)')
    local minh = MinHeap.from(heapData)
    test:equal(
      tostring(minh),
      'MinHeap(a| MinHeap(d), MinHeap(b| MinHeap(c)))')
    local e, minh = minh:pop()
    test:equal(e, 'a')
    test:equal(
      tostring(minh),
      'MinHeap(d| MinHeap(b| MinHeap(c)))')

    local e, minh = minh:pop()
    test:equal(e, 'd')
    local e, minh = minh:pop()
    test:equal(e, 'b')

end)

tap:run()
