--[[
  A light weight implementation allowing creation of so called "prototypes"
  which can be used to easily create "objects" with certain methods.

  The value passed in to this function is mutated, so it is not recommended
  to store a separate reference to this value.

  @example
  local MyProto = prototype {doStuff = ...}
  function MyProto.new (arg1)
    local instance = {_value = arg1}
    ...
    return MyProto(instance)
  end
  local myobj = MyProto.new('some value')
  myobj:doStuff()
  myobj:isa(MyProto)

  local MyDerivedProto = prototype {
    MyProto; -- derive from MyProto
    {
      extraMethod = function () ... end
    }
  }
  local myobj2 = MyDerivedProto {}
  myobj2:isa(MyProto)
  myobj2:isa(MyDerivedProto)
]]

local function simplePrototype (definition)
  local mmt = {
    __call = function (self, obj)
      return setmetatable(obj, self)
    end
  }
  local proto = definition or {}
  proto.__index = proto
  function proto.isa (self, protoref)
    return getmetatable(self) == protoref
  end

  return setmetatable(proto, mmt)
end

local function inheritPrototype (super, definition)
  local mmt = setmetatable({
    __call = function (self, obj)
      return setmetatable(obj, self)
    end
  }, super)
  mmt.__index = mmt

  local proto = definition or {}
  proto.__index = proto
  function proto.isa (self, protoref)
    local t = self
    repeat
      t = getmetatable(t)
      if t == protoref then
        return true
      end
    until type(t) ~= 'table'
  end

  return setmetatable(proto, mmt)
end

local function prototype (definition)
  if #definition == 2 then
    return inheritPrototype(definition[1], definition[2])
  end
  return simplePrototype(definition)
end

return prototype
