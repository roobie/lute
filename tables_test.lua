local tables = require('tables')
local Atable = require('augmented_table')
local Tap = require('tap')
local inspect = require('inspect')

local tap = Tap.new {name = 'tables.lua'}

tap:addTest(
  'tables.partition [even]',
  function (test)
    local t = {1, 2, 3, 4}
    local p = tables.partition(t, 2)
    test:equal(table.concat(p[1], ','), '1,2')
    test:equal(table.concat(p[2], ','), '3,4')
end)

tap:addTest(
  'tables.partition [one]',
  function (test)
    local t = {1, 2, 3}
    local p = tables.partition(t, 1)
    test:equal(table.concat(p[1], ','), '1')
    test:equal(table.concat(p[2], ','), '2')
    test:equal(table.concat(p[3], ','), '3')
end)

tap:addTest(
  'tables.partition [odd]',
  function (test)
    local t = {1, 2, 3, 4, 5, 6, 7}
    local p = tables.partition(t, 3)
    test:equal(table.concat(p[1], ','), '1,2,3')
    test:equal(table.concat(p[2], ','), '4,5,6')
    test:equal(table.concat(p[3], ','), '7')
end)

tap:addTest(
  'tables.imap',
  function (test)
    local at = tables {1, 2}
    local r = at:imap(function (n)
        return n + 1
    end)
    test:equal(table.concat(r, ','), '2,3')
end)

tap:addTest(
  'tables.skip',
  function (test)
    local t1 = tables {1,2,3,4}
    test:equal(table.concat(t1:skip(0), ','), '1,2,3,4')
    test:equal(table.concat(t1:skip(1), ','), '2,3,4')
    test:equal(table.concat(t1:skip(2), ','), '3,4')
    test:equal(table.concat(t1:skip(3), ','), '4')
    test:equal(table.concat(t1:skip(4), ','), '')
end)

tap:addTest(
  'tables.concat',
  function (test)
    local at = tables {1, 2}
    local r = at:concat {3, 4}
    test:equal(table.concat(at, ','), '1,2')
    test:equal(table.concat(r, ','), '1,2,3,4')
end)

tap:addTest(
  'tables.reduce',
  function (test)
    local t = {1,2,3}
    local s = tables.reduce(t, function (a, b) return a + b end, 0)
    test:equal(s, 6)
end)

tap:addTest(
  'tables.merge',
  function (test)
    local t = Atable {a=1}
    local a = {a=2}
    local b = {b=3}
    local c = {c=4}
    test:equal(t.a, 1)
    test:equal(t:merge(a).a, 2)
    test:equal(t:merge(a).b, nil)
    test:equal(t:merge(a, b).a, 2)
    test:equal(t:merge(a, b).b, 3)
    test:equal(t:merge(a, b, c).b, 3)

    local merged = t:merge(a, b, c):map(function (e, k) return {k, e} end)
    merged:qsort(function (a, b) return a[1] < b[1] end)
    test:isTrue(type(merged) == 'table')
    test:isTrue(merged:isa(Atable))
    -- local str = tables.reduce(merged,
    local function reducer (s, e, k)
      return s..tostring(e[1])..':'..tostring(e[2])..','
    end
    local str = tables.reduce(merged, reducer, '')
    test:equal(str, 'a:2,b:3,c:4,')
end)

tap:addTest(
  'Atable.imap',
  function (test)
    local t = Atable {1,2,3}
    local m = t:imap(function (v) return v + 1 end)
    for i, v in ipairs(m) do
      test:equal(i + 1, v)
    end
end)

tap:addTest(
  'tables.get',
  function (test)
    local data = {
      atable = { 123, 234, 345 }
    }
    local v = tables.get(data, 'atable.1', 'NOTFOUND')
    test:equal(v, 123)
    local v = tables.get(data, 'atable.2', 'NOTFOUND')
    test:equal(v, 234)
    local v = tables.get(data, 'atable.3', 'NOTFOUND')
    test:equal(v, 345)
    local v = tables.get(data, 'atable.4', 'NOTFOUND')
    test:equal(v, 'NOTFOUND')
end)

tap:run()
