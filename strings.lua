local F = require('func')

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

local TEMPLATE_BEGIN_TAG, TEMPLATE_END_TAG = '%[', ']'
local TEMPLATE_BEGIN_BRACKET, TEMPLATE_END_BRACKET = '[', ']'

--- Creates a function based on the supplied template string. This function
--- accepts a table to be used as the data when rendering the template.
--- TODO error handling
---
--- Signature: string -> tbl -> string
---
--- Template DSL: Lua code may be included within the square brackets following
--- a percent sign: %[]. An example of this would be: 'This is static text, but
--- the following is code: %[akey]'. Calling metamethods are allowed, e.g.:
--- 'Calling a metamethod: %[stringVal:upper()]'
---
--- Compiling a template means that the template string is parsed and
--- transformed into Lua code consisting of one table, which is returned by a
--- dynamically created function using `load`. This table is then
--- `table.concat`ted to finally yield the result.
---
--- Full example of usage: TODO
function template.compile (tmpl)
  if type(tmpl) ~= 'string' then
    error('argument #1 must be a string')
  end

  local code = {}
  local len = #tmpl

  local function makeTransform (i)
    local accumulator = ''
    local depth = 0
    while i <= len do
      local c = charAt(tmpl, i)
      if c == TEMPLATE_BEGIN_BRACKET then
        depth = depth + 1
      elseif c == TEMPLATE_END_BRACKET then
        if depth == 0 then
          break
        end
        depth = depth - 1
      end
      accumulator = accumulator..c
      i = i + 1
    end

    return accumulator, i + #TEMPLATE_END_TAG -- skip end tag
  end

  local function makeValue (i)
    local accumulator = ''
    while i <= len and string.sub(tmpl, i, i + 1) ~= TEMPLATE_BEGIN_TAG do
      accumulator = accumulator..charAt(tmpl, i)
      i = i + 1
    end

    return accumulator, i
  end

  local function escape (str)
    local gsub = string.gsub
    return gsub(gsub(str, '"', '\\"'), '\n', '\\n')
  end

  local i = 1
  while i <= len do
    local value
    if string.sub(tmpl, i, i + 1) == TEMPLATE_BEGIN_TAG then
      value, i = makeTransform(i + #TEMPLATE_BEGIN_TAG) -- skip begin tag
      code[#code + 1] = '('..value..')'
    else
      value, i = makeValue(i)
      code[#code + 1] = '"'..escape(value)..'"'
    end
  end


  -- table.insert(code, 1, 'return {')
  -- code[#code + 1] = '}'
  code = table.concat(code, ',')
  code = string.format('return {%s}', code)
  print(code)
  local renderer = load(code)
  if renderer == nil then
    error('Invalid template definition')
  end

  return function (data)
    -- local env = {}
    -- env.__index = _G
    -- return setfenv(renderer, setmetatable(data, env))()
    return table.concat(setfenv(renderer, data)())
  end
end

function template.interpolate (tmpl, data)
  return template.compile(tmpl)(data)
end

do
  ok, lpeg = pcall(function ()
      return require('lpeg')
  end)
  if ok then
    --- This function sets an fenv on the supplied function so that LPeg and a
    --- couple of helper functions are available unqualified.
    ---
    --- @example:
    --- local result = withLpeg(function ()
    ---   return (P'123'):match('x123x')
    --- end)
    function strings.withLpeg (fn)
      local envObj = {
        --- match pat1 XOR pat2 one or more times
        either = function (pat1, pat2)
          return (pat1 + pat2) ^ 1
        end;
        --- match `pat` 0 or 1 times
        maybe = function (pat)
          return pat ^ -1
        end;
      }
      local mt = {}
      mt.__index = function (self, key)
        if lpeg[key] then
          return lpeg[key]
        elseif envObj[key] then
          return envObj[key]
        elseif _G[key] then
          return _G[key]
        end

        return nil
      end

      local env = setmetatable(envObj, mt)

      return setfenv(fn, env)()
    end
  end
end

return strings
