--[[
  A light weight implementation allowing creation of so called "prototypes"
  which can be used to easily create "objects" with certain methods.

  The value passed in to this function is mutated, so it is not recommended
  to store a separate reference to this value.

  @example
  local MyProto = prototype({doStuff = ...})
  function MyProto.new (arg1)
    local instance = {_value = arg1}
    ...
    return MyProto(instance)
  end
  local myobj = MyProto.new('some value')
  myobj:doStuff()
]]
local function prototype (definition)
  local mmt = {
    __call = function (self, obj)
      return setmetatable(obj, self)
    end
  }
  local proto = definition or {}
  proto.__index = proto
  return setmetatable(proto, mmt)
end

return prototype
