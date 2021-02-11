
local inspect = require('inspect')
local fmt = require('fmt')
local tap = require('tap').new {name = 'interop_rg.lua'}
local interop = require('interop')
local Program = interop.Program

tap:addTest(
  'rg',
  function (test)
    local rg = Program.new('rg')
    local searchvalue = [['local Program = interop.Program']]
    local results = {}
    rg:run({searchvalue, './'}, function (file)
        for line in file:lines() do
          table.insert(results, line)
        end
    end)
    test:isTrue(#results > 0)
end)

return tap
