local prototype = require('prototype')

local Node = prototype {
  _element = nil;
  _next = nil;
}
function Node.new (element)
  return Node { _element = element; }
end

local List

List = prototype {
  Node = Node;
  _head = nil;
}

function List.__tostring (self)
  local s = 'List('
  for i, v in self:iter() do
    s = s..tostring(v)..', '
  end

  return s:sub(1, -3)..')'
end

function List.insertAfterNode (self, node, newNode)
  newNode._next = node._next
  node._next = newNode
end

function List.prependNode (self, newNode)
  newNode._next = self._head
  self._head = newNode
end

function List.prepend (self, element)
  return self:prependNode(Node.new(element))
end

function List.removeAfterNode (self, node)
  local obsoleteNode = node._next
  if node._next ~= nil then
    node._next = node._next._next
  end
end

function List.removeFirstNode (self)
  local obsoleteNode = self._head
  if self._head ~= nil then
    self._head = self._head._next
  end
end

function List.iter (self)
  local currentNode = self._head
  local count = 0
  return function ()
    count = count + 1
    local result = currentNode
    if result ~= nil then
      currentNode = currentNode._next
      return count, result._element
    end
  end
end

function List.length (self)
  local count = 0
  for _, _ in self:iter() do
    count = count + 1
  end

  return count
end

function List.isEmpty (self)
  return self._head == nil
end

function List.map (self, transform)
  if self:isEmpty() then
    return List.new()
  end

  local result = List.new()
  local currentNode = nil
  local lastNode = nil
  local firstNode = nil
  for i, e in self:iter() do
    currentNode = Node.new(transform(e, i))
    if firstNode == nil then
      firstNode = currentNode
    end
    if lastNode ~= nil then
      lastNode._next = currentNode
    end
    lastNode = currentNode
  end
  result._head = firstNode
  return result
end

function List.cons (element, list)
  if list == nil then
    return List.new { element }
  end
  local result = List.new()
  result._head = Node.new(element)
  -- result._head._next = list._head
  local currentNode = result._head
  for _, e in list:iter() do
    currentNode._next = Node.new(e)
    currentNode = currentNode._next
  end
  return result
end

function List.new (elements)
  local result = List {}
  if type(elements) == 'table' then
    for i = #elements, 1, -1 do
      result:prepend(elements[i])
    end
  end

  return result
end

return List
