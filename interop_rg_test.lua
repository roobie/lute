
local inspect = require('inspect')
local fmt = require('lute.fmt')
local tap = require('tap').new {name = 'interop_rg.lua'}

local ffi = require('ffi')
local delimiter = '/'
local newline = '\n'
local exesuffix = ''
if ffi.os == 'Windows' then
  delimiter = '\\'
  newline = '\r\n'
  exesuffix = '.exe'
end

tap:addTest(
  'rg',
  function (test)
    local exename = string.format('rg%s', exesuffix)
    local PATH = os.getenv('PATH')
    local searchvalue = 'addTest'
    local fd = io.popen(string.format('%s %s ./', exename, searchvalue))
    for line in fd:lines() do
      print(line)
    end
    fd:close()
end)

return tap
