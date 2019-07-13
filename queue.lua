--[[

  This is an implementation of a simple queue data structure (first in, first out).

]]

local prototype = require('lute.prototype')
local List = require('lute.doubly_linked_list')

local Queue = prototype {}

function Queue.new ()
  return Queue { _data = List.new() }
end

function Queue.length (self)
  return self._data:length()
end

function Queue.__len (self)
  return self:length()
end

function Queue.isEmpty ()
  return self._data:isEmpty()
end

function Queue.push (self, element)
  return self._data:append(element)
end

function Queue.peek (self)
  return self._data:get(1)
end

function Queue.pop (self)
  return self._data:pop()
end

return Queue
