
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


function Randy.sample (self, tbl, count)
  local pool = {}
  local result = {}

  for i, v in ipairs(tbl) do
    pool[i] = v
  end

  for i = 1, count do
    local n = self:integer(1, #pool)
    result[#result + 1] = pool[n]
    table.remove(pool, n)
  end

  return result
end


return Randy
