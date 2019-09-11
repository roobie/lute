--[[

  This is an attempt at implementing an AVL tree as described here:
  https://en.wikipedia.org/wiki/AVL_tree

  It could be used as a map or dictionary, as a mapping of keys to values. The
  keys must be orderable. This implementation supports user-defined comparator
  functions, so complex keys could be used, as long as they contain data that
  uniquely identifies and (absolute) orders them.

  @example

  -- use a complex key, where each key is a table with at least the field `key`
  -- that is orderable using < and >
  -- returning a zero indicates that the keys are the same (identity)
  local t = Tree.new(function (a, b)
    if a.key < b.key then return -1 end
    if a.key > b.key then return  1 end
    return  0
  end)

  t:insert({key = 1}, 'a value stored with the key')
  t:insert({key = 2}, 'another value')

  assert(t:has {key = 2})
  assert(t:find {key = 2} == 'another value')
  t:delete {key = 2}
  assert(not t:has {key = 2})
]]

local prototype = require('prototype')

local Node = {
  _balance = 0;
  _key = nil;
  _value = nil;
  _left = nil;
  _right = nil;
}

local Tree = prototype {
  _root = nil;
  _comparator = function (key1, key2)
    if key1 < key2 then return -1 end
    if key1 > key2 then return  1 end
    return  0
  end;
}

function rebalance (tree, node)
  local rotated = false
  if node._balance > 1 then
    if node._right._balance < 0 then
      -- turn the right node triplet clockwise
      -- R<-RL ; RL<-RLR ; RLR<-R
      node._right,
      node._right._left,
      node._right._left._right = node._right._left,
      node._right._left._right,
      node._right

      node._right._right._balance = node._right._balance > -1 and 0 or 1
      node._right._balance = node._right._balance > 0 and 2 or 1
    end
    -- turn this triplet counter-clockwise
    -- N<-NR ; NRL<-N ; NR<-NRL
    node, node._right._left, node._right = node._right, node, node._right._left
    node._left._balance = 1 - node._balance
    node._balance = node._balance == 0 and -1 or 0
    rotated = true
  elseif node._balance < -1 then
    if node._left._balance > 0 then
      -- rotate left triplet counter-clockwise
      -- L<-LR ; LRL<-L ; LR<-LRL
      node._left,
      node._left._right._left,
      node._left._right = node._left._right,
      node._left,
      node._left._right._left

      node._left._left._balance = node._left._balance < 1 and 0 or -1
    end
    node, node._left._right, node._left = node._left, node, node._left._right
    node._right._balance = -1 - node._balance
    node._balance = node._balance == 0 and 1 or 0
    rotated = true
  end
  return node, rotated
end

function insert (tree, node, key, value)
  if node == nil then
    local newNode = {
      _balance = 0;
      _key = key;
      _value = value;
      _left = nil;
      _right = nil;
    }
    return newNode, 1
  end

  local grow
  local comparison = tree._comparator(key, node._key)
  if comparison == 0 then
    return node, 0
  elseif comparison < 0 then
    node._left, grow = insert(tree, node._left, key, value)
    node._balance = node._balance - grow
  else -- comparison > 0
    node._right, grow = insert(tree, node._right, key, value)
    node._balance = node._balance + grow
  end
  node, rotated = rebalance(tree, node)
  return node, (rotated or node._balance == 0) and 0 or grow
end

local LEFT = '_left'
local RIGHT = '_right'
local oppositeDirection = {[LEFT] = RIGHT ; [RIGHT] = LEFT}

local function deleteMove (tree, node, direction, multiplier)
  if node[direction] then
    local rotated, key
    node[direction], rotated, key = deleteMove(tree, node[direction], direction, multiplier)
    node._balance = node._balance + rotated * multiplier
    node, rotated = rebalance(tree, node)
    return node, (rotated or node._balance == 0) and -1 or 0, key
  else
    return node[oppositeDirection[direction]], -1, node._key
  end
end

local function delete (tree, node, key)
  local grow = 0
  local comparison = tree._comparator(key, node._key)
  if comparison == 0 then
    local key
    -- FIXME why balance vs. nil-check
    if node._balance > 0 then
      node._right, grow, key = deleteMove(tree, node._right, LEFT, -1)
    elseif node._left then
      node._left, grow, key = deleteMove(tree, node._left, RIGHT, 1)
      grow = -grow
    else
      -- return not isSubTree and nil, -1
      return nil, -1
    end
    node._key = key
    node._balance = node._balance + grow
  elseif comparison < 0 then
    node._left, grow = delete(tree, node._left, key, true)
    node._balance = node._balance - grow
  else -- comparison > 0
    node._right, grow = delete(tree, node._right, key, true)
    node._balance = node._balance + grow
  end
  node, rotated = rebalance(tree, node)
  return node, grow ~= 0 and (rotated or node._balance == 0) and -1 or 0
end

function Tree.delete (self, key)
  self._root = delete(self, self._root, key, false)
  return self
end

function Tree.insert (self, key, value)
  assert( -- FIXME this raises an error instead of the assertion failing.
    type(self._comparator(key, key)) == 'number',
    "The tree's comparator function must be able to order the keys")
  self._root = insert(self, self._root, key, value)
  return self
end

local function find (tree, node, key)
  if node == nil then
    return nil
  end

  local comparison = tree._comparator(key, node._key)
  if comparison == 0 then
    return node
  elseif comparison < 0 then
    return find(tree, node._left, key)
  else -- comparison > 0
    return find(tree, node._right, key)
  end
end

function Tree.has (self, key)
  return find(self, self._root, key) ~= nil
end

function Tree.find (self, key)
  local node = find(self, self._root, key)
  if node then
    return node._value
  else
    error(string.format('The element for key=%s does not exist', tostring(key)))
  end
end

function Tree.insertMany (self, keys)
  for _, v in ipairs(keys) do
    if type(v) == 'table' then
      self:insert(v[1], v[2])
    else
      self:insert(v)
    end
  end
  return self
end

function Tree.__tostring (self)
  local function stringifyNode (node)
    local s = ''
    if node == nil then
      return s
    end

    if node._left then
      s = s..stringifyNode(node._left)..', '
    end
    s = s..tostring(node._key)
    if node._right then
      s = s..', '..stringifyNode(node._right)
    end
    return s
  end
  return string.format('Tree(%s)', stringifyNode(self._root))
end

local function enumerate (node, tbl)
  tbl = tbl or {}
  if node._left ~= nil then
    enumerate(node._left, tbl)
  end
  tbl[#tbl + 1] = node._key
  if node._right ~= nil then
    enumerate(node._right, tbl)
  end
  return tbl
end

function Tree.enumerate (self)
  return enumerate(self._root)
end

function Tree.iter (self)
  return ipairs(self:enumerate())
end

function Tree.new (comparator)
  local tree = Tree {
    _comparator = comparator
  }
  return tree
end

return Tree
