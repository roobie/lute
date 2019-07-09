local strings = require('strings')
local Tap = require('tap')
local inspect = require('inspect')

local function dump (what)
  print(inspect(what))
end

local tap = Tap.new()

tap:addTest(function (test)
    test:name('Test string split')
    test:plan(1)

    local r = strings.split('')
    test:equal(#r, 0, 'Splitting an empty string should yield no results')
end)

tap:addTest(function (test)
    test:name('Test string split')
    test:plan(4)
    test:comment('This is a comment')

    local r = strings.split('a,b,c', ',')
    test:equal(#r, 3)
    test:equal(r[1], 'a')
    test:equal(r[2], 'b')
    test:equal(r[3], 'd', '# TODO correct')
end)

tap:run()
