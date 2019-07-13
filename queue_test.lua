
local Queue = require('queue')
local tap = require('tap').new {name='queue.lua'}

tap:addTest(
  'basic',
  function (test)
    local q = Queue.new()
    q:push(1)
    q:push(2)
    q:push(3)
    test:equal(q:peek(), 1)
    test:equal(q:pop(), 1)
    test:equal(q:pop(), 2)
    test:equal(q:pop(), 3)
    test:equal(q:peek(), nil)
end)

return tap
