
local Pubsub = require('pubsub')
local Tap = require('tap')

local tap = Tap.new {name='pubsub.lua'}

tap:addTest(
  'publish',
  function (test)
    local event = Pubsub.new()
    event('data')
end)

return tap
