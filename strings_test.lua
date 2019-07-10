local strings = require('strings')
local Tap = require('tap')
local inspect = require('inspect')

local function dump (what)
  print(inspect(what))
end

local tap = Tap.new {name = 'strings.lua'}

tap:addTest(
  'strings.split', function (test)
    local r = strings.split('')
    test:equal(#r, 0, 'Splitting an empty string should yield no results')


    test:comment('Even though splitting strings are so mundane, we test it more.')

    r = strings.split('a,b,c', ',')
    test:equal(#r, 3, 'We expect "a,b,c" split by "," should be 3 elements long')
    test:equal(r[1]..r[2]..r[3], 'abc')
end)

tap:addTest(
  'strings.iter',
  function (test)
    local str = 'a bc d'
    local acc = {}
    for i, c in strings.iter(str) do
      acc[i] = c
    end
    test:equal(acc[1], 'a')
    test:equal(acc[2], ' ')
    test:equal(acc[3], 'b')
    test:equal(acc[4], 'c')
    test:equal(acc[5], ' ')
    test:equal(acc[6], 'd')
end)

tap:run()
