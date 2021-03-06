local prototype = require('prototype')
local strings = require('strings')

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

function tables.map (tbl, transform)
  local result = {}
  if #tbl == 0 then
    for k, e in pairs(tbl) do
      result[k] = transform(e, k)
    end
  else
    for i, e in ipairs(tbl) do
      result[#result + 1] = transform(e, i)
    end
  end
  return result
end

function tables.reduce (tbl, reducer, init)
  if #tbl == 0 then
    for k, e in pairs(tbl) do
      init = reducer(init, e, k)
    end
  else
    for i, e in ipairs(tbl) do
      init = reducer(init, e, i)
    end
  end

  return init
end

function tables.filter (tbl, predicate)
  local result = {}
  if #tbl == 0 then
    for k, e in pairs(tbl) do
      if predicate(e, k) then
        result[k] = e
      end
    end
  else
    for i, e in ipairs(tbl) do
      if predicate(e, i) then
        result[#result + 1] = e
      end
    end
  end

  return result
end

--[[

  Concatenate two or more tables into a new table.

]]
function tables.concat (tbl, ...)
  local result = {}
  for _, e in ipairs(tbl) do
    result[#result + 1] = e
  end

  for i = 1, select('#', ...) do
    local other = select(i, ...)
    for _, e in ipairs(other) do
      result[#result + 1] = e
    end
  end

  return result
end

function tables.merge (tbl, ...)
  local result = {}
  for k, e in pairs(tbl) do
    result[k] = e
  end

  for i = 1, select('#', ...) do
    local other = select(i, ...)
    for k, e in pairs(other) do
      result[k] = e
    end
  end

  return result
end

function tables.skip (tbl, count)
  local result = {}
  for i = count+1, #tbl do
    result[#result + 1] = tbl[i]
  end

  return result
end

function tables.take (tbl, count)
  local result = {}
  for i = 1, math.min(#tbl, count) do
    result[#result + 1] = tbl[i]
  end

  return result
end

function tables.get (tbl, path, default)
  -- todo numbers
  if type(path) ~= 'table' then
    path = strings.split(path, '%.')
  end
  if #path == 0 then
    return tbl or default
  end
  local key = path[1]
  local asnum = tonumber(key)
  if asnum ~= nil then
    key = asnum
  end
  local value = tbl[key]
  local nextPath = tables.skip(path, 1)
  --require('debugger')()
  return tables.get(value, nextPath, default)
end

function tables.swap (tbl, i1, i2)
  local temp = tbl[i1]
  tbl[i1] = tbl[i2]
  tbl[i2] = temp
  -- return tbl[i1], tbl[i2], tbl
end

function tables.collect (iterable)
  local result = {}
  for v in iterable do
    result[#result + 1] = v
  end
  return result
end

function tables.reverse (tbl)
  local acc = {}
  for i = #tbl, 1, -1 do
    acc[#acc+1] = tbl[i]
  end
  return acc
end

function tables.padEnd (tbl, minLength, value)
  if #tbl < minLength then
    for i = #tbl + 1, minLength do
      tbl[i] = value
    end
  end

  return tbl
end

function tables.createIndex (tbl)
  local index = {}
  for i, v in ipairs(tbl) do
    index[v] = i
  end

  return index
end

return tables
