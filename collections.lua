local inspect = require('inspect')
local dbg = require('debugger')

local prototype = require('prototype')

--[[
  Collections

  See https://ece.uwaterloo.ca/~dwharder/aads/Abstract_data_types/

  Queue
  A Queue contains elements of same type arranged in sequential order. Operations takes place at both ends, insertion is done at end and deletion is done at front. Following operations can be performed:
  enqueue() – Insert an element at the end of the queue.
  dequeue() – Remove and return the first element of queue, if the queue is not empty.
  peek() – Return the element of the queue without removing it, if the queue is not empty.
  size() – Return the number of elements in the queue.
  isEmpty() – Return true if the queue is empty, otherwise return false.
  isFull() – Return true if the queue is full, otherwise return false.

  Stack
  A Stack contains elements of same type arranged in sequential order. All operations takes place at a single end that is top of the stack and following operations can be performed:
  push() – Insert an element at one end of the stack called top.
  pop() – Remove and return the element at the top of the stack, if it is not empty.
  peek() – Return the element at the top of the stack without removing it, if the stack is not empty.
  size() – Return the number of elements in the stack.
  isEmpty() – Return true if the stack is empty, otherwise return false.
  isFull() – Return true if the stack is full, otherwise return false.

  Heap (priority queue <= sorted list)

  RedBlackTree

  Set
]]

--[[
  Metatable events

  http://lua-users.org/wiki/MetatableEvents

  __concat = function (self, other) end;
  __add = function (self, object) end;
  __len = function (self) end;
  __sub - Subtraction. Invoked similar to addition, using the '-' operator.
  __mul - Multiplication. Invoked similar to addition, using the '*' operator.
  __div - Division. Invoked similar to addition, using the '/' operator.
  __idiv - (Lua 5.3) Floor division (division with rounding down to nearest integer). '//' operator.
  __mod - Modulo. Invoked similar to addition, using the '%' operator.
  __pow - Involution. Invoked similar to addition, using the '^' operator.
  __concat - Concatenation. Invoked similar to addition, using the '..' operator.

]]

local Queue = prototype {
    __len = function (self)
      return #self._data
    end;
    push = function (self, element)
      table.insert(self._data, element)
    end;
    peek = function (self)
      return self._data[#self]
    end;
    pop = function (self)
    end;
}

local Set = prototype {
  add = function (self, element)
  end;
  remove = function (self, element)
  end;
  union = function (self, other)
  end;
  difference = function (self, other)
  end;
  elements = function (self)
  end;
}

function Set.new (elements)
  local instance = Set({})
  for _, v in ipairs(elements) do
    instance:add(v)
  end
  return instance
end


--[[

  The LinkedList implements the List abstract data type. It is a doubly linked
  list, so appending and prepending are O(1) operations. The length of the list
  is eagerly computed, so reading that state is also O(1). However, removing and
  inserting items are linear in time complexity: O(n).

  It is implemented with "external" structures (node elements), so the elements
  that are stored in it are _not_ mutated by the data structure. This is worse
  for space complexity, but better for safety. Also makes it possible to store
  the same object in different list instances.

]]

local LinkedListNode = {}
function LinkedListNode.new (element)
  return {
      _element = element;
      _prevNode = nil;
      _nextNode = nil;
  }
end

-- forward declaration, so that it can be used inside methods
local LinkedList
LinkedList = prototype {
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
        if index <= self._length then
          local result = currentNode
          currentNode = currentNode._nextNode
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
      local newList = LinkedList.new()
      for _, v1 in self:iter() do
        newList:add(v1)
      end
      for _, v2 in other:iter() do
        newList:add(v2)
      end
      return newList
    end;

    append = function (self, element)
      if self._head == nil then
        self._head = LinkedListNode.new(element)
      else
        local newNode = LinkedListNode.new(element)
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
      if self._iterating then
        error('Cannot mutate while iterating.')
      end
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
        self._head = LinkedListNode.new(element)
        self._length = 1
        return
      end
      local currentNode = self:findAt(index)
      if currentNode == nil then
        return
      end
      local newNode = LinkedListNode.new(element)
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
      elseif self._head._prevNode ~= nil then
        return self._head._prevNode._element
      else
        return self._head._element
      end
    end;

    skip = function (self, count)
      local result = LinkedList.new()
      for i, e in self:iter() do
        if i > count then
          result:add(e)
        end
      end
      return result
    end;

    map = function (self, transform)
      local result = {}
      for i, e in self:iter() do
        result[#result + 1] = transform(e, i)
      end
      return result
    end;

    --[[
      TODO:
      addRange

      pop
      popLast

      insertBefore
      insertAfter
      __newindex => insertAt

      removeAt <= l[n] = nil?

      replace

      last

      sort -- in place?

      filter
      map
      reduce
    ]]
}

-- allow indexing the list by list[x]
LinkedList.__index = function (self, key)
  if type(key) == 'number' then
    return self:get(key)
  else
    return LinkedList[key]
  end
end

function LinkedList.new (elements)
  local list = LinkedList {
      _length = 0;
      _head = nil;
      _iterating = false;
  }
  for _, element in ipairs(elements or {}) do
    list:add(element)
  end
  return list
end

function LinkedList.cons (element, list)
  local t = {element}
  for _, e in list:iter() do
    t[#t + 1] = e
  end
  return LinkedList.new(t)
end

--[[
  Pairing heap
]]
local MinHeap
MinHeap = prototype {
  __tostring = function (self)
    if self:isEmpty() then
      return 'MinHeap(Empty)'
    elseif self._subheaps:isEmpty() then
      return string.format(
        'MinHeap(%s)',
        self._element)
    else
      local subheaps = self._subheaps:map(tostring)
      local rest = ''
      for i, h in ipairs(subheaps) do
        rest = rest..h
        if i < #subheaps then
          rest = rest..', '
        end
      end
      return string.format(
        'MinHeap(%s| %s)',
        self._element,
        rest)
    end
  end;
  isEmpty = function (self)
    return self._isEmpty
  end;
  pop = function (self)
    if self:isEmpty() then
      error('This heap is empty, so cannot pop an element.')
    else
      return self._element, MinHeap.mergePairs(self._subheaps)
    end
  end;
  peek = function (self)
    if self:isEmpty() then
      error('This heap is empty, so cannot pop an element.')
    else
      return self._element
    end
  end;
  length = function (self)
  end;
  meld = function (self, heap2)
    if self:isEmpty() then
      return heap2
    elseif heap2:isEmpty() then
      return self
    elseif MinHeap.compare(self, heap2) then
      return MinHeap.new(
        self._priority,
        self._element,
        LinkedList.cons(heap2, self._subheaps)
      )
    else
      return MinHeap.new(
        heap2._priority,
        heap2._element,
        LinkedList.cons(self, heap2._subheaps)
      )
    end
  end;
  insert = function (self, priority, element)
    return self:meld(MinHeap.new(priority, element))
  end;
}

--[[
]]
function MinHeap.new (priority, element, subheaps)
  local instance = MinHeap {
    _isEmpty = isEmpty;
    _priority = priority;
    _element = element;
    _subheaps = subheaps or LinkedList.new();
  }

  return instance
end

MinHeap.empty = MinHeap {
  _priority = 0;
  _isEmpty = true;
  _subheaps = LinkedList.new()
}

function MinHeap.compare (heap1, heap2)
  return heap1._priority < heap2._priority
end

function MinHeap.mergePairs (heaps)
  if heaps:isEmpty() then
    return MinHeap.empty
  elseif heaps:length() == 1 then
    return heaps:first()
  else
    local h1, h2 = heaps[1], heaps[2]
    return h1:meld(h2):meld(MinHeap.mergePairs(heaps:skip(2)))
  end
end

function MinHeap.from (tuples)
  local result = MinHeap.empty
  for _, tuple in ipairs(tuples) do
    result = result:insert(tuple[1], tuple[2])
  end
  return result
end


return {
  List = LinkedList;
  MinHeap = MinHeap;
}
