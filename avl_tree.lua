
local prototype = require('prototype')

local Node = {
  _balance = 0;
  _value = nil;
  _left = nil;
  _right = nil;
}

local Tree = prototype {
  _root = nil;
  _comparator = function (node1, node2)
    if node1 < node2 then return -1 end
    if node1 > node2 then return  1 end
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

function insert (tree, node, value)
  if node == nil then
    local newNode = {
      _balance = 0;
      _value = value;
      _left = nil;
      _right = nil;
    }
    return newNode, 1
  end

  local grow
  local comparison = tree._comparator(value, node._value)
  if comparison == 0 then
    return node, 0
  elseif comparison < 0 then
    node._left, grow = insert(tree, node._left, value)
    node._balance = node._balance - grow
  else
    node._right, grow = insert(tree, node._right, value)
    node._balance = node._balance + grow
  end
  node, rotated = rebalance(tree, node)
  return node, (rotated or node._balance == 0) and 0 or grow
end

function Tree.insert (self, value)
  self._root = insert(self, self._root, value)
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
    s = s..tostring(node._value)
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
  tbl[#tbl + 1] = node._value
  if node._right ~= nil then
    enumerate(node._right, tbl)
  end
  return tbl
end


function Tree.iter (self)
  local t = enumerate(self._root)
  return ipairs(t)
end

function Tree.new (comparator)
  local tree = Tree {
    _comparator = comparator
  }
  return tree
end

return Tree
