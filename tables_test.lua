local tables = require('tables')
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

tap:run()
