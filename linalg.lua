local ffi = require('ffi')

ffi.cdef[[
typedef struct { double x, y; } vec2_t;
]]

local vec2
local mt = {
  __add = function (a, b) return vec2(a.x + b.x, a.y + b.y) end;
  __len = function (a) return math.sqrt(a.x * a.x + a.y * a.y) end;
  __index = {
    area = function (a) return a.x * a.x + a.y * a.y end;
  };
}

vec2 = ffi.metatype('vec2_t', mt)


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
end)

return tap
