
local Tree = require('avl_tree')
local List = require('table_list')
local prototype = require('prototype')
local strings = require('strings')
local fmt = require('fmt')
local Tap = require('tap')

local tap = Tap.new {name='avl_tree.lua'}

local function dump (node, depth)
  if not node then return end
  depth = depth or 0
  if node._right then dump(node._right, depth + 1) end
  print(string.rep('\t',depth)
        ..tostring(node._key)..':'
        ..tostring(node._value)..' ('..strings.padl(node._balance, 2, ' ')..')')
  if node._left then dump(node._left, depth + 1) end
end

tap:addTest(
  'insert',
  function (test)
    local t = Tree.new()
    t:insert(14)
    t:insert(4)
    t:insert(44)
    t:insert(33)
    t:insert(55)
    t:insert(5)
    t:insert(15)
    t:insert(12)
    t:insert(18)
    t:insert(1)
    test:isTrue(#t:enumerate() == 10)
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

    t:insert(Kvp.new('b', List.new()))
    t:insert(Kvp.new('d', List.new()))
    t:insert(Kvp.new('g', List.new()))
    t:insert(Kvp.new('a', List.new()))
    t:insert(Kvp.new('e', List.new()))
    t:insert(Kvp.new('f', List.new()))
    t:insert(Kvp.new('c', List.new()))

    -- dump(t._root)
    local correctOrder = {'a', 'b', 'c', 'd', 'e', 'f', 'g'}
    for i, v in t:iter() do
      -- print(i, v)
      test:equal(v.key, correctOrder[i], string.format('It should be ordered: %s', v))
    end
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
    for i = 1, 9 do
      t:insert(10 + i, 'c')
    end
    dump(t._root)

    test:isTrue(t:has(10))
    test:equal(t:find(10), 'a')
    test:equal(t:find(20), 'b')
end)

tap:addTest(
  'cannot',
  function (test)
    local t = Tree.new()
    local ok, err = pcall(function ()
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
