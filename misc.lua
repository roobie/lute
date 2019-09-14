
local misc = {}

--[[

  @example

  local a = {b = {longName = {}}}
  local sameAsLongName = mutate(a.b.longName, function (o)
    o.value = 1
    return o
  end)
]]
function misc.mutate (object, mutator)
  return mutator(object)
end

return misc
