local collections = require('collections')
local List = collections.List
local MinHeap = collections.MinHeap
local Tap = require('tap')
local inspect = require('inspect')
local fmt = require('fmt')
local printf = fmt.printf

local tap = Tap.new()

tap:run()
