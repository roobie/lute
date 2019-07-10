local prototype = require('prototype')

local quickSort = require('quick_sort_generic')

--[[

  This is an implementation of the List abstract data type. It is a circular
  doubly linked list, so appending and prepending are O(1) operations. The
  length of the list is eagerly computed, so reading that state is also O(1).
  However, removing and inserting items are linear in time complexity: O(n)
  because of a linear search to find the element to insert after or remove.
  Reverse operations are supported.

  It is implemented with "external" structures (node elements), so the elements
  that are stored in it are _not_ mutated by the data structure. This is worse
  for space complexity, but better for sanity. Also makes it possible to store
  the same object in different list instances.

  Reasons for using this would be to allow for efficient appending or prepending
  of items, when random access is not as important. Because it is circular, it
  can be thought of as a "ring" that supports moving the head efficiently. Also
  works nicely if reverse iteration is needed.

]]

local Node = prototype {
  __tostring = function (self)
    return string.format('N(%s)', self._element)
  end
}

function Node.new (element)
  local node = Node {
      _element = element;
      _prevNode = nil;
      _nextNode = nil;
  }
  node._prevNode = node
  node._nextNode = node
  return node
end

-- forward declaration, so that it can be used inside methods
local List
List = prototype {
    __tostring = function (self)
      local str = ''
      for i, v in self:iter() do
        str = str..tostring(v)
        if i < self._length then
          str = str..', '
        end
      end
      return string.format('List(%s)', str)
    end;

    moveHead = function (self, diff)
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

    length = function (self)
      return self._length
    end;

    __len = function (self)
      return self:length()
    end;

    iter = function (self)
      self._iterating = true
      local currentNode = self._head
      local index = 0
      return function ()
        index = index + 1
        if index <= self:length() then
          local result = currentNode
          currentNode = currentNode._nextNode
          return index, result._element
        else
          self._iterating = false
        end
      end
    end;

    iterReverse = function (self)
      if self:isEmpty() then
        return function ()
        end
      end
      local currentNode = self._head._prevNode
      if currentNode == nil then
        return function ()
        end
      end

      local index = self:length()
      self._iterating = true
      return function ()
        if index >= 1 then
          index = index - 1
          local result = currentNode
          currentNode = currentNode._prevNode
          return index, result._element
        else
          self._iterating = false
        end
      end
    end;

    elements = function (self)
      local collect = {}
      for _, e in self:iter() do
        table.insert(collect, e)
      end
      return collect
    end;

    __ipairs = function (self)
      return self:iter()
    end;

    __concat = function (self, other)
      local newList = List.new()
      for _, v1 in self:iter() do
        newList:add(v1)
      end
      for _, v2 in other:iter() do
        newList:add(v2)
      end
      return newList
    end;

    append = function (self, element)
      if self._iterating then
        error('Cannot mutate while iterating.')
      end

      if self._head == nil then
        self._head = Node.new(element)
      else
        local newNode = Node.new(element)
        if self._head._prevNode == nil then
          self._head._nextNode = newNode
          self._head._prevNode = newNode
          newNode._prevNode = self._head
          newNode._nextNode = self._head
        else
          local endNode = self._head._prevNode
          endNode._nextNode = newNode
          self._head._prevNode = newNode
          newNode._prevNode = endNode
          newNode._nextNode = self._head
        end
      end

      self._length = self._length + 1
    end;

    add = function (self, element)
      return self:append(element)
    end;

    find = function (self, element)
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
    end;

    findAt = function (self, index)
      local found = false
      local reference = nil
      local currentNode = self._head
      local count = 1
      while count < index and count <= self._length do
        currentNode = currentNode._nextNode
        count = count + 1
      end

      return currentNode
    end;

    remove = function (self, element)
      if self._iterating then
        error('Cannot mutate while iterating.')
      end

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

        self._length = self._length - 1
        return true
      else
        return false
      end
    end;

    removeAt = function (self, index)
      if self._iterating then
        error('Cannot mutate while iterating.')
      end

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

        self._length = self._length - 1
        return true
      else
        return false
      end
    end;

    get = function (self, index)
      for i, v in self:iter() do
        if i == index then
          return v
        end
      end
    end;

    insertAt = function (self, index, element)
      if self._iterating then
        error('Cannot mutate while iterating.')
      end

      if self._length == 0 and index == 1 then
        self._head = Node.new(element)
        self._length = 1
        return
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
    end;

    __newindex = function (self, index, element)
      if type(index) == 'number' then
        return self:insertAt(index, element)
      else
        rawset(self, index, element)
      end
    end;

    prepend = function (self, element)
      self:insertAt(1, element)
    end;

    isEmpty = function (self)
      return self._head == nil
    end;

    first = function (self)
      return self._head._element
    end;

    last = function (self)
      if self:isEmpty() then
        return nil
      elseif self._head._prevNode ~= nil and self._head._prevNode ~= self._head then
        return self._head._prevNode._element
      else
        return nil -- self._head._element
      end
    end;

    skip = function (self, count)
      local result = List.new()
      for i, e in self:iter() do
        if i > count then
          result:add(e)
        end
      end
      return result
    end;

    map = function (self, transform)
      local result = List.new()
      for i, e in self:iter() do
        result:append(transform(e, i))
      end
      return result
    end;

    swap = function (self, i1, i2)
      local node1 = self:findAt(i1)
      local node2 = self:findAt(i2)
      local temp = node1._element
      node1._element = node2._element
      node2._element = temp
    end;

    sortInPlace = function (self, comparator)
      quickSort(self, comparator)
    end;

    sort = function (self, comparator)
      local result = List.new()
      for _, e in self:iter() do
        result:append(e)
      end
      result:sortInPlace(comparator)
      return result
    end;


    --[[
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
}

--[[

  Allows indexing the list by list[x], but still be able to look up metatable
  methods.

]]
List.__index = function (self, key)
  if type(key) == 'number' then
    return self:get(key)
  else
    return List[key]
  end
end


--[[

  `new` creates a new List. The first and only argument is optional, and if it
is a table, all (ipairs) elements of the table will be appended in order to the
new list

]]
function List.new (elements) local list = List {
_length = 0; _head = nil; _iterating = false; }

  if type(elements) == 'table' then
    for _, element in ipairs(elements) do
      list:add(element)
    end
  end

  return list
end


--[[

  `cons` constructs a new List by prepending the `element` to the `list`

  @example
  local l1 = List.new()
  local l2 = List.cons(1, l1)
  assert(l1:length() == 0 and l2:length() == 1 and l1 ~= l2, 'A new list was created')

]]
function List.cons (element, list)
  local result = List.new()
  result:append(element)

  for _, e in list:iter() do
    result:append(e)
  end

  return result
end

return List
