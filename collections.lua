local inspect = require('inspect')
local prototype = require('prototype')

local List = require('linked_list')
local MinHeap = require('min_heap')

--[[
  Collections

  See https://ece.uwaterloo.ca/~dwharder/aads/Abstract_data_types/

  Queue - FIFO
  Stack - LIFO

  (Min/Max) heap (priority queue <= sorted list)

  Balanced search tree

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
      local result = self._data[#self]
      self._data[#self] = nil
      return result
    end;
}

return {
  List = List;
  MinHeap = MinHeap;
}
