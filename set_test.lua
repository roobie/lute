
local Set = require('set')

local Tap = require('tap')
local fmt = require('fmt')
local printf = fmt.printf

local tap = Tap.new {name = 'set.lua'}

tap:addTest(
  'basic operations',
  function (test)
    local set = Set.new()
    local a, b, c = {}, {}, {}
    test:equal(set:size(), 0)
    set:add(a)
    test:equal(set:size(), 1)
    test:equal(set:has(a), true)
    set:add(b)
    test:equal(set:size(), 2)
    test:equal(set:has(a), true)
    test:equal(set:has(b), true)
    set:add(c)
    test:equal(set:size(), 3)
    test:equal(set:has(c), true)
    set:remove(b)
    test:equal(set:size(), 2)
    test:equal(set:has(b), false)
end)

tap:addTest(
  'union',
  function (test)
    local s1, s2 = Set.new(), Set.new()
    local distinctItemsCount = 4
    local a, b, c, d = 1, 2, 3, 4
    s1:add(a):add(b)
    s2:add(c):add(d)

    test:equal(s1:size(), 2)
    test:isTrue(s1:size() == s2:size(), 'The sets should be of equal size')
    local s3 = s1:union(s2)
    test:equal(
      s3:size(),
      distinctItemsCount,
      'The union\'s size should be the sum of distinct items')
end)

tap:addTest(
  'difference',
  function (test)
    local s1, s2 = Set.new(), Set.new()
    local distinctItemsCount = 3
    local a, b, c = 1, 2, 3
    -- item `b` is in both sets
    s1:add(a):add(b)
    s2:add(b):add(c)

    test:equal(s1:size(), 2)
    test:isTrue(s1:size() == s2:size(), 'The sets should be of equal size')
    local s3 = s1:difference(s2)
    test:equal(
      s3:size(),
      distinctItemsCount,
      'The difference\'s size should be the sum of distinct items')
end)

tap:addTest(
  'intersect',
  function (test)
    local s1, s2 = Set.new(), Set.new()
    local distinctItemsCount = 3
    local a, b, c = 1, 2, 3
    -- item `b` is in both sets
    s1:add(a):add(b)
    s2:add(b):add(c)

    test:equal(s1:size(), 2)
    test:isTrue(s1:size() == s2:size(), 'The sets should be of equal size')
    local s3 = s1:intersect(s2)
    test:equal(
      tostring(s3),
      'Set(2)',
      'The difference\'s size should be the sum of distinct items')
end)

return tap
