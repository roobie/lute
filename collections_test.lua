local collections = require('collections')
local prototype = require('prototype')
local Tap = require('tap')
local inspect = require('inspect')
local fmt = require('fmt')
local printf = fmt.printf

local tap = Tap.new {name='collections.lua'}

function void () end

tap:addTest(
  'meta events',
  function (test)
    local T = prototype {}
    function T.__mod (self, fn)
      for i, e in ipairs(self) do
        fn(e, i)
      end
    end

    local t = T {1, 2, 3}
    void(t % print)
end)

return tap
