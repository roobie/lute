
local prototype = require('prototype')

local Randy = prototype {}

function Randy.new (source)
  return Randy {
    _source = source or math.random
  }
end

function Randy.integer (self, min, max)
  if max == nil then
    max = min
    min = 1
  end
  if min == max then
    -- not very random in this case, but whatever :|>
    return min
  end

  assert(min < max, '`min` must be less than `max`')
  local diff = max - min

  return min + math.floor(self._source() * (diff + 1))
end

function Randy.pickOne (self, tbl)
  if #tbl == 0 then
    -- TODO map
  end
  return tbl[self:integer(#tbl)]
end


return Randy
