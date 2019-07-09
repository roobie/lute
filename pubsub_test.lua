
local Pubsub = require('pubsub')
local Tap = require('tap')

local tap = Tap.new {name='pubsub.lua'}

tap:addTest(
  'publish',
  function (test)
    local event = Pubsub.new()
    local c = 0
    event:subscribe(function (v)
      c = c + 1
    end)
    event('data')
    test:equal(c, 1)
end)

return tap
