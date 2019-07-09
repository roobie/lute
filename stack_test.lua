
local Stack = require('stack')
local tap = require('tap').new {name='stack.lua'}

tap:addTest(
  'basic',
  function (test)
    local s = Stack.new()
    s:push(1)
    s:push(2)
    s:push(3)
    test:equal(s:peek(), 3)
    test:equal(s:pop(), 3)
    test:equal(s:pop(), 2)
    test:equal(s:pop(), 1)
    test:equal(s:peek(), nil)
end)

return tap
