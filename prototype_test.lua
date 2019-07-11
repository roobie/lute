local prototype = require('prototype')

local Tap = require('tap')

local tap = Tap.new {name='prototype.lua'}

tap:addTest(
  'isa',
  function (test)
    local T1 = prototype {}
    local t1 = T1 {}
    test:isTrue(t1:isa(T1), 'isa should say yes')
end)

tap:run()
