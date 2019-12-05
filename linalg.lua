local ffi = require('ffi')

ffi.cdef[[

typedef struct { double x, y; } vec2_t;

typedef struct { long x, y; } vec2i_t;
]]

local function vec2eq (a, b)
  return a.x == b.x and a.y == b.y
end

local function parseVec2 (ctor, str)
  local xStr, yStr = str:match('([^;]*);([^;]*)')
  return ctor(tonumber(xStr), tonumber(yStr))
end

local vec2
local vec2_mt = {
  __add = function (a, b) return vec2(a.x + b.x, a.y + b.y) end;
  __len = function (a) return math.sqrt(a.x * a.x + a.y * a.y) end;
  __eq = vec2eq;
  __tostring = function (a) return string.format('%d;%d', a.x, a.y) end;
  __index = {
    equal = function (a, b)
      return a.x == b.x and a.y == b.y
    end;
  };
}

vec2 = ffi.metatype('vec2_t', vec2_mt)


local vec2i
local vec2i_mt = {
  __add = function (a, b) return vec2i(a.x + b.x, a.y + b.y) end;
  __len = function (a) return math.sqrt(a.x * a.x + a.y * a.y) end;
  __eq = vec2eq;
  __tostring = function (a) return string.format('%d;%d', a.x, a.y) end;
  __index = {
    equal = function (a, b)
      return a.x == b.x and a.y == b.y
    end;
    manhattanDistance = function (a, b)
      if b == nil then
        b = vec2i(0, 0)
      end
      return math.abs(a.x - b.x) + math.abs(a.y - b.y)
    end;
  };
}

vec2i = ffi.metatype('vec2i_t', vec2i_mt)

return {
  vec2 = vec2;
  vec2i = vec2i;
  vec2eq = vec2eq;
  parseVec2 = parseVec2;
}
