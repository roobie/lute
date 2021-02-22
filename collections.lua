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
  __len = function (self) end;

  __add = function (self, object) end;
  __sub - Subtraction. Invoked similar to addition, using the '-' operator.
  __mul - Multiplication. Invoked similar to addition, using the '*' operator.
  __div - Division. Invoked similar to addition, using the '/' operator.
  __idiv - (Lua 5.3) Floor division (division with rounding down to nearest integer). '//' operator.
  __mod - Modulo. Invoked similar to addition, using the '%' operator.
  __pow - Involution. Invoked similar to addition, using the '^' operator.

  __index
  __newindex

]]


--[[
  Terminology:
  static method
  - A method not designed to be invoked as a meta method

  generic method
  - A method designed to be invoked as a meta method, but can be invoked on any
    object that satisfies the interface.
]]

local interfaces = {}


interfaces.List = {}

return interfaces
