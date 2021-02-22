--[[

  This is an implementation of a max heap. It is procedural/imperative, in that
  it is mutated when insert or pop are invoked so that the next element is the
  one with the highest (>) priority.

  The public API for creating an instance is:

  `MaxHeap.new()` creates a new, empty, instance

  `MaxHeap.from(tuples)` creates a new instance with the supplied elements.
  `tuples` is a linear table where each item is a tuple of {priority, element}.

  The public API for an instance of MaxHeap is:

  `heap:insert(priority, element)` inserts an element with the specified
  priority, updating the internal structure as necessary.

  `heap:pop()` pops the next element off of the heap (the element with the
  highest priority), updating the internal structure as necessary. An error is
  raised if this is invoked on a heap with no elements.

  `heap:isEmpty()` indicates whether this heap instance has elements or not.

]]

local prototype = require('prototype')

local MaxHeap = prototype {}

function MaxHeap.new ()
  return MaxHeap { _root = nil; }
end

function MaxHeap.isEmpty (self)
  return self._root == nil
end

local function compare (n1, n2)
  return n1.priority > n2.priority
end

local function meld (node1, node2)
  if node1 == nil then
    return node2
  elseif node2 == nil then
    return node1
  elseif compare(node1, node2) then
    local subnodes = node1.subnodes
    subnodes[#subnodes + 1] = node2
    return {
      priority=node1.priority,
      element=node1.element,
      subnodes=subnodes
    }
  else
    local subnodes = node2.subnodes
    subnodes[#subnodes + 1] = node1
    return {
      priority=node2.priority,
      element=node2.element,
      subnodes=subnodes
    }
  end
end

local function mergePairs (nodes)
  if #nodes == 0 then
    return nil
  elseif #nodes == 1 then
    return table.remove(nodes, 1)
  else
    local n1, n2 = table.remove(nodes, #nodes), table.remove(nodes, #nodes-1)
    return meld(meld(n1, n2), mergePairs(nodes))
  end
end

function MaxHeap.insert (self, priority, element)
  local newNode = {priority=priority, element=element, subnodes={}}
  self._root = meld(self._root, newNode)
end

function MaxHeap.pop (self)
  if self:isEmpty() then
    error('Cannot pop from an empty heap.')
  end
  local e = self._root.element
  self._root = mergePairs(self._root.subnodes)
  return e
end

function MaxHeap.from (tuples)
  local h = MaxHeap.new()
  for _, tuple in ipairs(tuples) do
    h:insert(tuple[1], tuple[2])
  end
  return h
end

function MaxHeap.__tostring (self)
  if self:isEmpty() then
    return 'MaxHeap()'
  end
  if #self._root.subnodes == 0 then
    return string.format(
      'MaxHeap(%s)', self._root.element)
  end
  return string.format(
    'MaxHeap(%s...)', self._root.element)
end

return MaxHeap
