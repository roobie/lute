
local linalg = require('linalg')
local inspect = require('inspect')
local tap = require('tap').new {name='linalg.lua'}

local vec2 = linalg.vec2
local vec2i = linalg.vec2i

tap:addTest(
  'vec2, Basics',
  function (test)
    local a = vec2(3, 4)
    test:equal(a.x, 3)
    test:equal(a.y, 4)
    test:equal(#a, 5)
    local b = a + vec2(0.5, 8)
    test:equal(#b, 12.5)
    test:isTrue(vec2(3, 4):equal(vec2(3, 4)))
    test:isTrue(vec2(3, 4) == (vec2(3, 4)))
    test:equal(tostring(vec2(3, 4)), '3;4')
end)

tap:addTest(
  'vec2i, Basics',
  function (test)
    local a = vec2i(3, 4)
    test:equal(a.x, 3)
    test:equal(a.y, 4)
    test:equal(#a, 5)
    local b = a + vec2i(1, 3)
    test:equal(tostring(b), '4;7')

    test:isTrue(vec2i(3, 4):equal(vec2i(3, 4)))
    test:isTrue(vec2i(3, 4) == (vec2i(3, 4)))
    test:equal(tostring(vec2i(3, 4)), '3;4')
    test:equal(vec2i(3, 4):manhattanDistance(), 7)

    test:equal(inspect(vec2i(3, 4)), '3;4')
end)

tap:addTest(
  'parseVec2',
  function (test)
    test:equal(linalg.parseVec2(vec2i, '3;4'), vec2i(3, 4))
    test:equal(linalg.parseVec2(vec2, '3.1;4.1'), vec2(3.1, 4.1))
end)

return tap
