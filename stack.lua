--[[

  This is an implementation of a simple stack data structure (last in, first out).

]]

local prototype = require('prototype')
local List = require('doubly_linked_list')

local Stack = prototype {}

function Stack.new ()
  return Stack { _data = List.new() }
end

function Stack.length (self)
  return self._data:length()
end

function Stack.__len (self)
  return self:length()
end

function Stack.isEmpty (self)
  return self._data:isEmpty()
end

function Stack.push (self, element)
  return self._data:prepend(element)
end

function Stack.peek (self)
  return self._data:get(1)
end

function Stack.pop (self)
  return self._data:pop()
end

return Stack
