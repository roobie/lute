--[[
  Requires LuaJIT
]]

local ffi = require('ffi')

ffi.cdef [[
  void * memmove(void * dest, const void * src, size_t n);
]]

local slice = {}

local mt

local function totable(s)
  local t = {}
  for i = 1, s.len do
    t[i] = tostring(s.s[i - 1])
  end
  return t
end

-- raw make function
local function make(ct, len, cap)
  cap = cap or len or 0
  local atype = ffi.typeof("$ [?]", ct)
  local array = atype(cap)

  local instance = {
    len = len,
    cap = cap,
    s = array,
    array = array,
    type = ct,
    stride = ffi.sizeof(ct)
  }
  return setmetatable(instance, mt)
end

local function checkTypes(a, b)
  if a.type ~= b.type then
    error("cannot copy slices of different types")
  end
  -- if ffi.sizeof(a.type) ~= ffi.sizeof(b.type) then
  --   error("cannot copy slices of different types")
  -- end
end

mt = {
  -- only works in 5.2
  __len = function(s)
    return s.len
  end;
  __index = function(s, i)
    if type(i) == 'number' then
      return s.s[i % s.len]
    end

    return rawget(s, i) or rawget(mt, i)
  end;
  __newindex = function(s, i, v)
    if type(i) == 'number' then
      s.s[i % s.len] = v
    end
  end;
  __tostring = function(s)
    return "[" .. table.concat(totable(s), ", ") .. "]"
  end;
  __concat = function(a, b)
    checkTypes(a, b)
    local len = a.len + b.len
    if len > b.cap then
      local s = make(a.type, len)
      ffi.copy(s.s, a.s, ffi.sizeof(a.type) * a.len)
      ffi.copy(s.s + a.len, b.s, ffi.sizeof(a.type) * b.len)
      return s
    end
    ffi.C.memmove(a.s + a.len, b.s, ffi.sizeof(a.type) * b.len)
    return s
  end;

  --- Zero based iterator. Returns a function which
  --- yields [index], [value-at-index].
  iter = function (s)
    local i = 0
    return function ()
      if i < s.len then
        local index = i
        i = i + 1
        return index, s[index]
      end
    end
  end;

  slice = function (s, i, j)
    if not i then i = 0 end
    if not j then j = s.len end
    local len = j - i
    local instance = {
      len = len,
      cap = s.cap,
      s = s.s + i,
      array = s.array,
      type = s.type,
      stride = ffi.sizeof(s.type)
    }
    return setmetatable(instance, mt)
  end;
  toTable = function (s)
    return totable(s)
  end;
  copy = function (s)
    return s:slice()
  end;
  copyTo = function (s, destination)
    slice.copy(destination, s)
  end;
}

function slice.make(ct, len, cap) -- allows table initializer
  local t
  if type(len) == 'table' then
    t = len
    len = #t
  end
  local s = make(ct, len, cap)
  if t then
    for i = 1, len do
      s.s[i - 1] = ct(t[i])
    end
  end
  return s
end

function slice.copy(dest, src)
  checkTypes(dest, src)
  local len = math.min(dest.cap, src.len)
  ffi.C.memmove(dest.s, src.s, ffi.sizeof(dest.type) * len)
  dest.len = len
  return dest
end

--- End of implementation

return slice

