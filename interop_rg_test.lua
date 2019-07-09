
local inspect = require('inspect')
local fmt = require('fmt')
local tap = require('tap').new {name = 'interop_rg.lua'}
local interop = require('interop')
local Program = interop.Program

tap:addTest(
  'rg',
  function (test)
    local rg = Program.new('rg')
    local searchvalue = 'rx'
    rg:run({searchvalue, './'}, function (file)
        for line in file:lines() do
          print(line)
        end
    end)
end)

return tap
