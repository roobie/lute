
local misc = {}

--[[

  @example

  local a = {b = {longName = {}}}
  local refTo_longName = mutate(a.b.longName, function (o)
    o.value = 1
  end)
]]
function misc.mutate (object, mutator)
  mutator(object)
  return object
end

return misc
