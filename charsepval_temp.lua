local function reduce(iterator, tbl, initial_value, transform)
  local accumulator = initial_value
  for k, v in iterator(tbl) do
    transform(accumulator, v, k)
  end
  return accumulator
end
local function mutate(root, key, transform)
  local result = transform(root[key])
  root[key] = result
  return result
end
local function _0_(configuration)
  local cfg = (configuration or {})
  local csv = {newline = (cfg.newline or "\n"), separator = (cfg.separator or ",")}
  csv.keys = function(atable)
    local function _1_(a, _, k)
      return table.insert(a, k)
    end
    return reduce(pairs, atable, {}, _1_)
  end
  csv["string-sink"] = function()
    local function _1_(self, data)
      local function _2_(v)
        return (v .. data)
      end
      return mutate(self, "buffer", _2_)
    end
    return {buffer = "", write = _1_}
  end
  csv["stringSink"] = csv["string-sink"]
  local function is_last(index, itable)
    return (index == #itable)
  end
  csv["encode-headers"] = function(destination, headers)
    for i, header in ipairs(headers) do
      destination:write(header)
      if not is_last(i, headers) then
        destination:write(csv.separator)
      end
    end
    return destination:write(csv.newline)
  end
  csv["encodeHeaders"] = csv["encode-headers"]
  csv["encode-table"] = function(destination, headers, source)
    for i, header in ipairs(headers) do
      destination:write(source[header])
      if not is_last(i, headers) then
        destination:write(csv.separator)
      end
    end
    return nil
  end
  csv["encodeTable"] = csv["encode-table"]
  csv["encode-tables"] = function(destination, headers, sequence)
    for i, source in ipairs(sequence) do
      csv["encode-table"](destination, headers, source)
      if not is_last(i, sequence) then
        destination:write(csv.newline)
      end
    end
    return nil
  end
  csv["encodeTables"] = csv["encode-tables"]
  return csv
end
return _0_
