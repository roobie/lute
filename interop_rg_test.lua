
local inspect = require('inspect')
local fmt = require('fmt')
local tap = require('tap').new {name = 'interop_rg.lua'}
local interop = require('interop')
local ffi = require('ffi')
local Program = interop.Program

tap:addTest(
  'ls/dir',
  function (test)
    local ls = 'ls'
    if ffi.os == 'Windows' then
      ls = 'dir'
    end
    local prog = Program.new(ls)
    local results = {}
    prog:run(nil, function (file)
        for line in file:lines() do
          table.insert(results, line)
        end
    end)
    test:isTrue(#results > 0)
end)

return tap
