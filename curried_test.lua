local C = require('curried')
local Tap = require('tap')
local tap = Tap.new {name='curried.lua'}

tap:addTest(
  'curried.reduce',
  function (test)
    local sum = C.reduce(function (a, b) return a + b end)(0)
    local theSum = sum({1, 2, 3}, 0)
    test:equal(theSum, 6)
end)

tap:addTest(
  'curried.imap',
  function (test)
    local addOne = C.imap(function (n) return n + 1 end)
    local n = addOne {1, 2, 3}
    test:equal(n[1], 2)
    test:equal(n[2], 3)
    test:equal(n[3], 4)
end)

tap:addTest(
  'curried.imap',
  function (test)
    local onlyEvens = C.ifilter(function (n) return n % 2 == 0 end)
    local n = onlyEvens {1, 2, 3, 4}
    test:equal(n[1], 2)
    test:equal(n[2], 4)
end)

tap:run()
