local inspect = require('inspect')
local prototype = require('prototype')

local List = require('linked_list')

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

  List
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
        List.cons(heap2, self._subheaps)
      )
    else
      return MinHeap.new(
        heap2._priority,
        heap2._element,
        List.cons(self, heap2._subheaps)
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
    _subheaps = subheaps or List.new();
  }

  return instance
end

MinHeap.empty = MinHeap {
  _priority = 0;
  _isEmpty = true;
  _subheaps = List.new()
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
  List = List;
  MinHeap = MinHeap;
}
