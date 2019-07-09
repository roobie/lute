local F = require('func')
local Tap = require('tap')
local inspect = require('inspect')
local fmt = require('fmt')
local printf = fmt.printf
local unpack = rawget(table, 'unpack') or unpack

local tap = Tap.new { name = 'func.lua' }

tap:addTest(
  'identity',
  function (test)
    local a = {}
    test:equal(F.identity(a), a)
end)

tap:addTest(
  'compose',
  function (test)
    local a = 1
    local f = F.compose(F.inc, F.double)
    test:equal(f(2), 5)

    local gt = F.compose(F.lt, F.transpose)
    test:isTrue(gt(2, 1))
    local gte = F.compose(F.bnot, F.lt)
    test:isTrue(gte(1, 1))
    test:isTrue(gte(2, 1))
end)

tap:addTest(
  'pipe',
  function (test)
    local a = 1
    local f = F.pipe {
      F.inc,
      F.double,
      F.inc,
    }
    test:equal(f(2), 7)

    local f2 = F.pipe {
      function (v)
        local a, b = unpack(v)
        test:equal(a, 1)
        test:equal(b, 2)
        return {a+1, b+1}
      end;
    }
    local a, b, c = unpack(f2{1, 2})
    test:equal(a, 2)
    test:equal(b, 3)
    test:isNil(c)
end)

tap:addTest(
  'func.collect1/2',
  function (test)
    local c = 0
    local iter = function ()
      c = c + 1
      if c < 4 then
        return c, c + 1
      end
    end
    local t = F.collect1(iter)
    test:equal(table.concat(t, ':'), '1:2:3')

    c = 0
    test:equal(table.concat(F.collect2(iter), ':'), '2:3:4')
end)

tap:addTest(
  'func.bind',
  function (test)
    local function add (...)
      local a = 0
      for i=1,select('#', ...) do
        a = a + select(i, ...)
      end

      return a
    end

    local f = F.bind(add, 1, 1)
    test:equal(f(2, 3), 7)
end)

return tap
