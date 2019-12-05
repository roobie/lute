
require('_test_prelude')
local inspect = require('inspect')
local prototype = require('prototype')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')
local StopWatch = require('stopwatch')
local linalg = require('linalg')
local vec2i = linalg.vec2i

local intcode = require('aoc_intcode')

local inputFile = io.open('aoc5-input.txt')
local inputText = inputFile:read('*l')
inputFile:close()

local input = strings.split(inputText, ',')

intcode.compute(input, 0)
