local prototype = require('prototype')

-- for sortInPlace
local quickSort = require('quick_sort_generic')
-- for sort
local quickSortTable = require('quick_sort')

--[[

  This is an implementation of the List abstract data type. It is a circular
  doubly linked list, so appending and prepending are O(1) operations. The
  length of the list is cached, so reading that state is also O(1). However,
  removing and inserting items are linear in time complexity: O(n) because of a
  linear search to find the element to insert after or remove. Reverse
  operations are supported and have the same time complexity as forward
  operations.

  It is implemented with "external" structures (node elements), so the elements
  that are stored in it are _not_ mutated by the data structure. This is worse
  for space complexity, but better for sanity. Also makes it possible to store
  the same object in different list instances.

  Reasons for using this would be to allow for efficient appending or prepending
  of items, when random access is not as important. Because it is circular, it
  can be thought of as a "ring" that supports moving the head efficiently both
  forwards and backwards. Also works nicely if reverse iteration is needed.

  This data structure would fit nicely when implementing a Queue or a Stack.

  If random access is more important, try using a `table_list` instead.

  TODO:
  addRange

  insertBefore
  insertAfter

  replace

  last

  sort -- in place?

  filter
  reduce

]]

-- Internal data structure. Represents a single node in the list.
-- Instances of this prototype havea link to the previous and next nodes
local Node = {}
function Node.new (element)
  local node = {
      _element = element;
      _prevNode = nil;
      _nextNode = nil;
  }
  node._prevNode = node
  node._nextNode = node
  return node
end

-- This is the actual module.
local List = prototype {}

-- Stringifies the list by enumerating the elements in the list starting with
-- the head and continues forward concatenating a comma separated string
function List.__tostring (self)
  local str = ''
  for i, v in self:iter() do
    str = str..tostring(v)
    if i < self._length then
      str = str..', '
    end
  end
  return string.format('List(%s)', str)
end

-- Moves the head by `diff` steps in an efficient manner. `diff` may be
-- negative, and in which case the head moves backwards.
function List.moveHead (self, diff)
  if diff == 0 or self:isEmpty() then
    return
  elseif diff < 0 then
    while diff < 0 do
      diff = diff + 1
      self._head = self._head._prevNode
    end
  elseif diff > 0 then
    while diff > 0 do
      diff = diff - 1
      self._head = self._head._nextNode
    end
  end
end;

-- returns the pre-computed length of the list. Cheap operation.
function List.length (self)
  return self._length
end

-- Lua 5.2+, support for the #-operator.
function List.__len (self)
  return self:length()
end

-- Returns a generator which will yield [i, e], where `i` is the index (1-based)
-- and `e` is the element at index `i`.
function List.iter (self)
  local currentNode = self._head
  local index = 0
  return function ()
    index = index + 1
    if index <= self:length() then
      local result = currentNode
      currentNode = currentNode._nextNode
      return index, result._element
    end
  end
end

-- Like `iter` only it walks backwards instead of forwards.
function List.iterReverse (self)
  if self:isEmpty() then
    return function ()
    end
  end

  local currentNode = self._head --._prevNode
  local index = self:length()
  return function ()
    if index >= 1 then
      index = index - 1
      local result = currentNode
      currentNode = currentNode._prevNode
      return index, result._element
    end
  end
end

-- Enumerate the list and constructs a table representing the list.
function List.enumerate (self)
  local collect = {}
  for _, e in self:iter() do
    table.insert(collect, e)
  end
  return collect
end

-- Allows for using `ipairs` with an instance of the list. Works the same as if
-- you would use :iter() directly
function List.__ipairs (self)
  return self:iter()
end

-- Allows for using `..` to concatenate two `List`s. As in `list3 = list1..list2`
function List.__concat (self, other)
  local newList = List.new()
  for _, v1 in self:iter() do
    newList:add(v1)
  end
  for _, v2 in other:iter() do
    newList:add(v2)
  end
  return newList
end

-- Appends an element to the end of the list.
function List.append (self, element)
  local newNode = Node.new(element)
  if self._head == nil then
    self._head = newNode
  else
    local endNode = self._head._prevNode
    endNode._nextNode = newNode
    self._head._prevNode = newNode
    newNode._prevNode = endNode
    newNode._nextNode = self._head
  end

  self._length = self._length + 1
end

-- Alias for `append`
function List.add (self, element)
  return self:append(element)
end

-- Finds the first node in the list whose element is equal to `element`
function List.find (self, element)
  local found = false
  local reference = nil
  local currentNode = self._head
  local count = 0
  while count < self._length and not found do
    count = count + 1
    if currentNode._element == element then
      found = true
      reference = currentNode
    else
      currentNode = currentNode._nextNode
    end
  end

  return reference
end

-- Tests whether a node exists in the list whose element is equal to `element`
function List.contains (self, element)
  return self:find(element) ~= nil
end

-- Finds a node in the list based on the index
function List.findAt (self, index)
  -- local found = false
  -- local reference = nil
  local currentNode = self._head

  local count = 1
  -- FIXME: if index is greater than half of length, we should iterate
  -- backwards. Still linear, but hey.
  while count < index and count <= self._length do
    currentNode = currentNode._nextNode
    count = count + 1
  end

  return currentNode
end

-- Removes the first node from the list whose element is equal to `element`
function List.remove (self, element)
  local reference = self:find(element)
  if reference ~= nil then
    local p, n = reference._prevNode, reference._nextNode
    if reference == self._head then
      if self._length == 1 then
        self._head = nil
      else
        self._head = n
      end
    end
    if p ~= nil then
      p._nextNode = n
    end
    if n ~= nil then
      n._prevNode = p
    end
    reference._prevNode = nil
    reference._nextNode = nil

    self._length = self._length - 1
    return true
  else
    return false
  end
end

-- Removes the node at `index`
function List.removeAt (self, index)
  local reference = self:findAt(index)
  if reference ~= nil then
    local p, n = reference._prevNode, reference._nextNode
    if reference == self._head then
      if self._length == 1 then
        self._head = nil
      else
        self._head = n
      end
    end
    if p ~= nil then
      p._nextNode = n
    end
    if n ~= nil then
      n._prevNode = p
    end
    reference._prevNode = nil
    reference._nextNode = nil

    self._length = self._length - 1
    return true
  else
    return false
  end
end

function List.pop (self)
  if self:isEmpty() then
    return nil
  end
  local element = self._head._element
  self:removeAt(1)
  return element
end

function List.popLast (self)
  if self:isEmpty() then
    return nil
  elseif self:length() == 1 then
    return self:pop()
  else
    local node = self._head._prevNode
    node._prevNode._nextNode = self._head
    self._head._prevNode = node._prevNode
    node._prevNode = nil
    node._nextNode = nil
    return node._element
  end
end

-- Gets the node's element at `index`
-- This is O(n) time complexity, because indices are not cached
function List.get (self, index)
  for i, v in self:iter() do
    if i == index then
      return v
    end
  end
end;

-- Inserts an element in a new node at `index`, if the index is in the interval
-- [1,#list+1]
function List.insertAt(self, index, element)
  if self._length == 0 then
    if index == 1 then
      self._head = Node.new(element)
      self._length = 1
      return
    else
      error('Out of bounds')
    end
  end
  local currentNode = self:findAt(index)
  if currentNode == nil then
    return
  end
  local newNode = Node.new(element)
  local prevNode = currentNode._prevNode
  prevNode._nextNode = newNode
  newNode._prevNode = prevNode
  newNode._nextNode = currentNode
  currentNode._prevNode = newNode
  if index == 1 then
    self._head = newNode
  end
  self._length = self._length + 1
end

-- Allows for assigning new elements using the `list[n] = v` syntax
function List.__newindex (self, index, element)
  if type(index) == 'number' then
    return self:insertAt(index, element)
  else
    rawset(self, index, element)
  end
end

-- Inserts an element in a new node at the start of the list.
-- Cheap operation.
function List.prepend (self, element)
  self:insertAt(1, element)
end

-- Indicates whether the list has any nodes at all or not.
function List.isEmpty (self)
  return self._head == nil
end

-- Gets the element of the first node in the list.
function List.first (self)
  if self:isEmpty() then
    return nil
  end
  return self._head._element
end

-- Gets the element of the last node in the list.
function List.last (self)
  if self:isEmpty() then
    return nil
  else
    return self._head._prevNode._element
  end
end

-- Returns a new list where the first `count` nodes are not in
function List.skip (self, count)
  local result = List.new()
  for i, e in self:iter() do
    if i > count then
      result:append(e)
    end
  end
  return result
end;

-- Applies a transform on each element in the list, building a new list and
-- returning that as the result
function List.map (self, transform)
  local result = List.new()
  for i, e in self:iter() do
    result:append(transform(e, i))
  end
  return result
end

-- Swaps the links to the elements stored in the nodes found at the indices `i1`
-- and `i2`. Linear search, so O(n), but the swap itself is cheap.
function List.swap (self, i1, i2)
  local node1 = self:findAt(i1)
  local node2 = self:findAt(i2)
  local temp = node1._element
  node1._element = node2._element
  node2._element = temp
end;

function List.sortInPlace (self, comparator)
  quickSort(self, comparator)
end

-- FIXME: insertion sort would be better perhaps. Or enumerating into an array,
-- and sorting that, because of bad performance on random access/linear search.
function List.sort (self, comparator)
  -- local result = List.new()
  -- for _, e in self:iter() do
  --   result:append(e)
  -- end
  -- result:sortInPlace(comparator)
  -- return result
  local t = self:enumerate()
  quickSortTable(t, comparator)
  return List.new(t)
end

-- Allows indexing the list by list[x], but still be able to look up metatable
-- methods.
List.__index = function (self, key)
  if type(key) == 'number' then
    return self:get(key)
  else
    return List[key]
  end
end


-- `new` creates a new List. The first and only argument is optional, and if it
-- is a table, all (ipairs) elements of the table will be appended in order to
-- the new list
function List.new (elements)
  local list = List {
    _length = 0;
    _head = nil;
  }

  if type(elements) == 'table' then
    for _, element in ipairs(elements) do
      list:append(element)
    end
  end

  return list
end


-- `cons` constructs a new List by prepending the `element` to the `list`
--
-- @example
-- local l1 = List.new()
-- local l2 = List.cons(1, l1)
-- assert(l1:length() == 0 and l2:length() == 1 and l1 ~= l2)
function List.cons (element, list)
  local result = List.new()
  result:append(element)

  for _, e in list:iter() do
    result:append(e)
  end

  return result
end

return List
