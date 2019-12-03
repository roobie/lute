local ffi = require('ffi')

ffi.cdef[[
typedef struct { double x, y; } vec2_t;
typedef struct { long x, y; } vec2i_t;
]]

local vec2
local vec2_mt = {
  __add = function (a, b) return vec2(a.x + b.x, a.y + b.y) end;
  __len = function (a) return math.sqrt(a.x * a.x + a.y * a.y) end;
  -- __eq = function (a, b) return a.x == b.x and a.y == b.y end;
  __tostring = function (a) return string.format('%d;%d', a.x, a.y) end;
  __index = {
    area = function (a) return a.x * a.x + a.y * a.y end;
  };
}

vec2 = ffi.metatype('vec2_t', vec2_mt)


local vec2i
local vec2i_mt = {
  __add = function (a, b) return vec2(a.x + b.x, a.y + b.y) end;
  __len = function (a) return math.sqrt(a.x * a.x + a.y * a.y) end;
  -- __eq = function (a, b) return a.x == b.x and a.y == b.y end;
  __tostring = function (a) return string.format('%d;%d', a.x, a.y) end;
  __index = {
    equal = function (a, b)
      return a.x == b.x and a.y == b.y
    end;
    area = function (a) return a.x * a.x + a.y * a.y end;
    manhattanDistance = function (a, b)
      return math.abs(a.x - b.x) + math.abs(a.y - b.y)
    end;
  };
}

vec2i = ffi.metatype('vec2i_t', vec2i_mt)

require('_test_prelude')
local tap = require('tap').new {name='linalg.lua'}
tap:addTest(
  'basic',
  function (test)
    local a = vec2(3, 4)
    test:equal(a.x, 3)
    test:equal(a.y, 4)
    test:equal(#a, 5)
    test:equal(a:area(), 25)
    local b = a + vec2(0.5, 8)
    test:equal(#b, 12.5)

    test:isTrue(vec2i(3, 4):equal(vec2i(3, 4)))
    test:equal(tostring(vec2i(3, 4)), '3;4')
end)
tap:run()
-- return tap

return {
  vec2 = vec2;
  vec2i = vec2i;
  vec2eq = function (a, b)
    return a.x == b.x and a.y == b.y
  end;
}
