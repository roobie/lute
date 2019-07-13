
local Tree = require('avl_tree')
local List = require('table_list')
local prototype = require('prototype')
local inspect = require('inspect')
local strings = require('strings')
local fmt = require('fmt')
local Tap = require('tap')
local Randy = require('randy')
local r = Randy.new()

local tap = Tap.new {name='avl_tree.lua'}

local function dump (node, depth)
  if not node then return end
  depth = depth or 0
  if node._right then dump(node._right, depth + 1) end
  print(string.rep('\t',depth)..tostring(node._key)..':'..tostring(node._value)..' ('..strings.padl(node._balance, 2, ' ')..')')
  if node._left then dump(node._left, depth + 1) end
end

tap:addTest(
  'insert',
  function (test)
    local t = Tree.new()
    for i = 1, 40 do
      t:insert(r:integer(10, 99))
    end

    -- dump(t._root)
    test:isTrue(#t:enumerate() > 30)
end)

tap:addTest(
  'insert',
  function (test)
    local t = Tree.new(function (a, b)
        if a.key < b.key then return -1 end
        if a.key > b.key then return  1 end
        return  0
    end)

    local Kvp = prototype {}
    function Kvp.new (key, value)
      return Kvp {
        key = key;
        value = value;
      }
    end

    function Kvp.__tostring (self)
      return string.format('%s=>%s', self.key, self.value)
    end

    local function tstr (t)
      local s = ''
      for k,v in pairs(t) do
        s = s..tostring(k)..':'..tostring(v)
      end
      return s
    end
    t:insert(Kvp.new('a', List.new()))
    t:insert(Kvp.new('b', List.new()))
    t:insert(Kvp.new('c', List.new()))
    t:insert(Kvp.new('d', List.new()))
    t:insert(Kvp.new('e', List.new()))
    t:insert(Kvp.new('f', List.new()))
    t:insert(Kvp.new('g', List.new()))

    -- dump(t._root)
end)

tap:addTest(
  'delete',
  function (test)
    local t = Tree.new()
    t:insertMany({2,8,4,5,1,3,6,7})

    test:equal(table.concat(t:enumerate(), ','), '1,2,3,4,5,6,7,8')
    t:delete(4)
    test:equal(table.concat(t:enumerate(), ','), '1,2,3,5,6,7,8')
    t:delete(1):delete(8)
    test:equal(table.concat(t:enumerate(), ','), '2,3,5,6,7')
    print(table.concat(t:enumerate(), ','))
    t:insert(1)
    test:equal(table.concat(t:enumerate(), ','), '1,2,3,5,6,7')
    t:insert(4)
    test:equal(table.concat(t:enumerate(), ','), '1,2,3,4,5,6,7')
    t:insertMany({8,9,10,11,12,13,14,15,16,17,18,19})
    t:insertMany({20,21,22})
    test:equal(#t:enumerate(), 22)
end)

tap:addTest(
  'find',
  function (test)
    local t = Tree.new()
    t:insert(10, 'a')
    t:insert(20, 'b')
    dump(t._root)

    test:isTrue(t:has(10))
    test:equal(t:find(10), 'a')
    test:equal(t:find(20), 'b')
end)

tap:addTest(
  'cannot',
  function (test)
    local t = Tree.new()
    ok, err = pcall(function ()
        t:insert({})
    end)
    test:isFalse(ok)
    fmt.printf('# %s', err)
end)

tap:addTest(
  'example',
  function (test)
    local t = Tree.new(function (a, b)
        if a.key < b.key then return -1 end
        if a.key > b.key then return  1 end
        return  0
    end)

    t:insert({key = 1}, 'a value stored with the key')
    t:insert({key = 2}, 'another value')

    test:isTrue(t:has {key = 2})
    test:equal(t:find {key = 2}, 'another value')
    t:delete {key = 2}
    test:isFalse(t:has {key = 2})
end)

return tap
