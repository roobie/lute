local prototype = require('prototype')

local tables = prototype {}

function tables.partition (tbl, partsize)
  local result = {}
  for i = 1, #tbl, partsize do
    local part = {}
    for j = 1, partsize do
      part[j] = tbl[i+j-1]
    end
    result[#result + 1] = part
  end

  return result
end

function tables.imap (tbl, transform)
  local result = {}
  for i, e in ipairs(tbl) do
    result[#result + 1] = transform(e, i)
  end

  return result
end

return tables
