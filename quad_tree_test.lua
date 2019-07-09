
local QTree = require('quad_tree')
local fmt = require('fmt')
local Tap = require('tap')
local tap = Tap.new {name = 'quad_tree.lua'}
local r = require('randy').new()

tap:addTest(
  'QTree.insert',
  function (test)
    local q = QTree.new {
        center = {x=50; y=50};
        halfDimension = 50;
    }

    -- for i = 1, 40 do
    --   q:insert {x = r:integer(100); y = r:integer(100)}
    -- end
    for x = 1, 5 do
      for y = 1, 5 do
        q:insert {x = x; y = y}
      end
    end

    -- fmt.printf('%s', tostring(q))
    local range = q:queryRange {
        center = {x=3; y=3};
        halfDimension = 1;
    }
    test:isTrue(range ~= nil)
    test:isTrue(#range == 9)
    local s = ''
    for _, p in ipairs(range) do
      s = s..tostring(p)..', '
    end
    fmt.printf('# %s', s)
end)

return tap
