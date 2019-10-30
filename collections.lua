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
local List = interfaces.List

--- Static method
--- Creates a new instance of `List`.
function List.new (initialElements) end

--- Static method
--- Constructs a new list from head (a value) and tail (a list)
function List.cons (head, tail) end

--- Generic method
--- Prepends to the list a new node containing the supplied element.
function List.prepend (self, element) end

--- Generic method
--- Appends to the list a new node containing the supplied element.
function List.append (self, element) end

function List.head (self) end
function List.remove (self, element) end
function List.removeAll (self, element) end
function List.sort (self) end
function List.sortInPlace (self) end

--- Generic method
--- Returns an iterator (index, element) that traverses the list in
--- order from beginning to end
function List.iter (self) end

--- Generic method
--- Results in the total length of the list. This may be computed or stored.
function List.length (self) end

return {}
