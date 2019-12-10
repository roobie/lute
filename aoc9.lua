
require('_test_prelude')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')

local computer = require('aoc_intcode4')

local tap = require('tap').new {name='Intcode4'}

local getProgram = require('aoc9_input')

tap:addTest(
  'A',
  function (test)
    local lastVal = nil
    local c = computer(getProgram(), {
                         name = 'A',
                         verbosity = 0,
                         out = function (v)
                           lastVal = v
                         end
    })
    local send = c.run()
    send(1)
    local result = c.run()
    fmt.printf('Answer: %s', lastVal)
end)

tap:addTest(
  'B',
  function (test)
    local lastVal = nil
    local c = computer(getProgram(), {
                         name = 'B',
                         verbosity = 0,
                         out = function (v)
                           lastVal = v
                         end
    })
    local send = c.run()
    send(2)
    local result = c.run()
    fmt.printf('Answer: %s', lastVal)
end)

tap:run()
