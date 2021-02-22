local collections = require('collections')
local prototype = require('prototype')
local Tap = require('tap')

local tap = Tap.new {name='collections.lua'}

local function void () end

tap:addTest(
  'meta events',
  function (test)
    local T = prototype {collections}
    test:isTrue(T ~= nil)
    function T.__mod (self, fn)
      for i, e in ipairs(self) do
        fn(e, i)
      end
    end

    local t = T {1, 2, 3}
    void(t % print)
end)

return tap
