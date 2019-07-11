
local Tree = require('avl_tree')
local fmt = require('fmt')
local Tap = require('tap')
local Randy = require('randy')
local r = Randy.new()

local tap = Tap.new {name='avl_tree.lua'}

local function dump (node, depth)
  if not node._value then return end
  depth = depth or 0
  if node._right then dump(node._right, depth + 1) end
  print(string.rep('\t',depth)..node._value..' ('..node._balance..')')
  if node._left then dump(node._left, depth + 1) end
end

tap:addTest(
  'insert',
  function (test)
    local t = Tree.new()
    for i = 1, 40 do
      t:insert(r:integer(100))
    end

    dump(t._root)

    -- for i, v in t:iter() do
    --   print(i, v)
    -- end
end)

tap:run()
