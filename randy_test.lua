
local Randy = require('randy')
local Tap = require('tap')
local tap = Tap.new {name='randy.lua'}

tap:addTest(
  'integer()',
  function (test)
    local r = Randy.new()
    local ones = 0
    local twos = 0
    for i = 1, 1000 do
      local result = r:integer(2)
      if result == 2 then
        twos = twos + 1
      elseif result == 1 then
        ones = ones + 1
      else
        error('Should not go here')
      end
    end
    test:isTrue(math.abs(ones - twos) < 30, string.format('ones=%d | twos=%d', ones, twos))
end)

tap:addTest(
  'pickOne',
  function (test)
    local r = Randy.new()
    test:equal(r:pickOne({1}), 1)

    local sum = 0
    for i = 1, 100 do
      local v = r:pickOne({1, 2})
      sum = sum + v
    end
    test:isTrue(math.abs(sum - 150) < 2, tostring(sum))
end)

tap:run()
