
--- Module constructor. Accepts a configuration that optionally specify which
--- separator to use and which char(s) to use for newline.
return function (configuration)
  cfg = configuration or {}
  -- character separated values
  local csv = {
    separator = cfg.separator or ',';
    newline = cfg.newline or '\n';
  }

  --- Constructs a new sequential table that contains the associative keys
  --- of the supplied table.
  function csv.keys (tbl)
    local result = {}
    for k, _ in pairs(tbl) do
      result[#result+1] = k
    end

    return result
  end


  --- Determines whether the index is the last index of the supplied sequential
  --- table.
  local function isLast (index, tbl)
    return index == #tbl
  end

  --- Encodes the headers using the current configuration.
  --- Destination is a file like object. It must support the `write` method.
  function csv.encodeHeaders (destination, headers)
    for i, header in ipairs(headers) do
      destination:write(header)
      if not isLast(i, headers) then
        destination:write(csv.separator)
      end
    end
    destination:write(csv.newline)
  end

  --- Encodes a single table using the supplied headers and using the current
  --- configuration.
  --- Destination is a file like object. It must support the `write` method.
  function csv.encodeTable (destination, headers, source)
    for i, header in ipairs(headers) do
      destination:write(source[header])
      if not isLast(i, headers) then
        destination:write(csv.separator)
      end
    end
  end

  --- Encodes all tables in the supplied sequence using the supplied headers and
  --- using the current configuration.
  --- Destination is a file like object. It must support the `write` method.
  function csv.encodeTables (destination, headers, sequence)
    for i, source in ipairs(sequence) do
      csv.encodeTable(destination, headers, source)
      if not isLast(i, sequence) then
        destination:write(csv.newline)
      end
    end
  end

  -- end of module
  return csv
end
