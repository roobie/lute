
local _module = {}

local EMPTY_STRING = ''

--[[

  @parameter _string <string> - The string to split
  @parameter [_separator] <string/regex> - What to split by. Defaults to %s (whitespace)
]]
function _module.split (_string, _separator)
  _separator = _separator or '%s'
  local t = {}
  if _string == EMPTY_STRING then
    return t
  end
  local pattern = string.format('([^%s]*)(%s?)', _separator, _separator)
  for field,s in string.gmatch(_string, pattern) do
    table.insert(t, field)
    if s=="" then
      return t
    end
  end
end

return _module
