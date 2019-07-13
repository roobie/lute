
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

function strings.padr (str, length, char)
  str = tostring(str)
  local diff = length - #str
  if diff > 0 then
    return str..string.rep(char, diff)
  end

  return str
end

function strings.padl (str, length, char)
  str = tostring(str)
  local diff = length - #str
  if diff > 0 then
    return string.rep(char, diff)..str
  end

  return str
end

return strings
