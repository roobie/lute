local strings = require('strings')
local Tap = require('tap')
local inspect = require('inspect')

local function dump (what)
  print(inspect(what))
end

local tap = Tap.new {name = 'strings.lua'}

tap:addTest(
  'Test string split', function (test)
    test:plan(3)

    local r = strings.split('')
    test:equal(#r, 0, 'Splitting an empty string should yield no results')

    test:comment('Even though splitting strings are so mundane, we test it more.')

    r = strings.split('a,b,c', ',')
    test:equal(#r, 3, 'We expect "a,b,c" split by "," should be 3 elements long')
    test:equal(r[1]..r[2]..r[3], 'abc')
end)

tap:run()
