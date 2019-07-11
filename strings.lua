
local strings = {}

local EMPTYSTRING = ''

--[[

  @parameter str <string> - The string to split

  @parameter [separator] <string/regex> - What to split by. Defaults to %s
  (whitespace).

]]
function strings.split (str, separator)
  separator = separator or '%s'
  local t = {}

  if str == EMPTYSTRING or separator == EMPTYSTRING then
    return t
  end

  local pattern = string.format('([^%s]*)(%s?)', separator, separator)
  for field, s in string.gmatch(str, pattern) do
    table.insert(t, field)
    if s == EMPTYSTRING then
      return t
    end
  end
end

--[[

  strings.iter

  Allows for iterating through a string for each character.

  @parameter str <string>

  @returns an iterator<index, character>

  @example
  local str = 'a bc d'
  local acc = {}
  for i, c in strings.iter(str) do
    acc[i] = c
  end

]]
function strings.iter (str)
  local len = #str
  local i = 0
  return function ()
    i = i + 1
    if i <= len then
      return i, str:sub(i, i)
    end
  end
end

function strings.join (tbl, separator)
  return table.concat(tbl, separator)
end

return strings
