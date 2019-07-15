local F = require('lute.func')

local strings = {}

local EMPTYSTRING = ''

--[[

  @parameter str <string> - The string to split

  @parameter [separator] <string/regex> - What to split by. Defaults to %s
  (whitespace).

  @returns a table with the elements from splitting the string.

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

function strings.isEmpty (str)
  return #str == 0
end

function strings.isBlank (str)
  if strings.isEmpty(str) then
    return true
  end

  local isWhitespaceOnly = (string.find(str, '[^%s]')) == nil
  return isWhitespaceOnly
end

function strings.trimStart (str)
  return string.gsub(str, '^%s', '')
end

function strings.trimEnd (str)
  return string.gsub(str, '%s$', '')
end

strings.trim = F.compose(strings.trimStart, strings.trimEnd)

-- Ported from https://github.com/gustf/js-levenshtein (MIT)
function strings.levenshteinDistance (a, b)
  local function _min (d0, d1, d2, bx, ay)
    if d0 < d1 or d2 < d1 then
      if d0 > d2 then
        return d2 + 1
      else
        return d0 + 1
      end
    else
      if bx == ay then
        return d1
      else
        return d1 + 1
      end
    end
  end

  local function distance (a, b)
    -- identical strings means 0 edit distance
    if a == b then
      return 0
    end

    -- make sure that a is the shortest string
    if string.len(a) > string.len(b) then
      local tmp = a
      a = b
      b = tmp
    end

    local la = string.len(a)
    local lb = string.len(b)

    -- check each char in the string from back to front and decrease the length
    -- if they are the same
    while la > 1 and (string.byte(a, la) == string.byte(b, lb)) do
      la = la - 1
      lb = lb - 1
    end

    -- check each char from front to back and increase the offset by one for
    -- each match
    local offset = 1
    while offset < la and (string.byte(a, offset) == string.byte(b, offset)) do
      offset = offset + 1
    end

    -- adjust the length according to the offset
    la = la - offset;
    lb = lb - offset;

    -- if the length of a is zero, we know that the length of b is the edit distance.
    if la == 0 or lb < 3 then
      return lb
    end

    local x = 0, y,
    d0, d1, d2, d3, dd, dy, ay,
    bx0, bx1, bx2, bx3

    local vector = {}

    for y = 1, la do
      table.insert(vector, y);
      table.insert(vector, string.byte(a, offset + y));
    end

    local len = #vector

    while x <= lb - 3 do
      d0 = x
      bx0 = string.byte(b, offset + d0)
      d1 = x + 1
      bx1 = string.byte(b, offset + d1)
      d2 = x + 2
      bx2 = string.byte(b, offset + d2)
      d3 = x + 3
      bx3 = string.byte(b, offset + d3)
      x = x + 4
      dd = x

      for y = 1, len, 2 do
        dy = vector[y];
        ay = vector[y + 1];
        d0 = _min(dy, d0, d1, bx0, ay);
        d1 = _min(d0, d1, d2, bx1, ay);
        d2 = _min(d1, d2, d3, bx2, ay);
        dd = _min(d2, d3, dd, bx3, ay);
        vector[y] = dd;
        d3 = d2;
        d2 = d1;
        d1 = d0;
        d0 = dy;
      end
    end

    while x <= lb do
      d0 = x
      bx0 = string.byte(b, offset + d0)
      x = x + 1
      dd = x
      for y = 1, len, 2 do
        dy = vector[y]
        dd = _min(dy, d0, dd, bx0, vector[y + 1])
        vector[y] = dd
        d0 = dy
      end
    end

    return dd
  end

  return distance(a, b)
end

function strings.startsWith (str, substr)
  return (string.find(str, string.format('^%s', substr)) ~= nil)
end

function strings.endsWith (str, substr)
  return (string.find(str, string.format('%s$', substr)) ~= nil)
end

function strings.compare (a, b)
  if     a < b then return -1
  elseif a > b then return  1
  else              return  0
  end
end

local function charAt (str, index)
  return string.sub(str, index, index)
end

local template = {}
strings.template = template

--- Creates a function based on the supplied template string. This function
--- accepts a table to be used as the data when rendering the template.
---
--- string -> tbl -> string
function template.compile (tmpl)
  if type(tmpl) ~= 'string' then
    error('argument #1 must be a string')
  end

  local values = {}
  local len = #tmpl

  --- TODO: nested access
  --- TODO: inline formatting
  local function makeTransform (i)
    local accumulator = ''
    while i <= len and charAt(tmpl, i) ~= ']' do
      accumulator = accumulator..charAt(tmpl, i)
      i = i + 1
    end

    local num = tonumber(accumulator)
    if type(num) == 'number' then
      accumulator = num
    end

    local transform = function (data)
      return data[accumulator]
    end

    return transform, i + 1 -- skip ']'
  end

  local function makeValue (i)
    local accumulator = ''
    while i <= len and string.sub(tmpl, i, i + 1) ~= '%[' do
      accumulator = accumulator..charAt(tmpl, i)
      i = i + 1
    end

    return accumulator, i
  end

  local i = 1
  while i <= len do
    local value
    if string.sub(tmpl, i, i + 1) == '%[' then
      value, i = makeTransform(i + 2) -- skip '%['
    else
      value, i = makeValue(i)
    end
    values[#values + 1] = value
  end

  return function (data)
    local accumulator = ''
    for _, v in ipairs(values) do
      if type(v) == 'function' then
        local item = v(data)
        if type(item) == 'function' then
          accumulator = accumulator..item()
        else
          accumulator = accumulator..tostring(item)
        end
      else
        accumulator = accumulator..v
      end
    end

    return accumulator
  end
end

function template.interpolate (tmpl, data)
  return template.compile(tmpl)(data)
end

return strings
