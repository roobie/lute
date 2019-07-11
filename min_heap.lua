--[[
  Pairing (min) heap. Used https://en.wikipedia.org/wiki/Pairing_heap as reference.

  This heap has a "functional" interface in that it returns a new heap object on each "mutation".
  TODO: consider a less "functional" implementation and interface.
]]

local prototype = require('prototype')
local List = require('table_list')

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
      for i, h in subheaps:iter() do
        rest = rest..h
        if i < subheaps:length() then
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
      error('This heap is empty, so cannot peek.')
    else
      return self._element
    end
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

function MinHeap.new (priority, element, subheaps)
  local instance = MinHeap {
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

return MinHeap
