
local prototype = require('prototype')
local func = require('func')

local ffi = require('ffi')
local delimiter = '/'
local newline = '\n'
local executableSuffix = ''
if ffi.os == 'Windows' then
  delimiter = '\\'
  newline = '\r\n'
  executableSuffix = '.exe'
end

local bind = func.bind

local Program = prototype {}

function Program.new (name)
	return Program {
    name = name;
  }
end

function Program.executableName (self)
  return string.format('%s%s', self.name, executableSuffix)
end

function Program.run (self, args, pipeFn)
  local invocation = string.format(
    '%s %s',
    self:executableName(),
    table.concat(args or {}, ' ')
  )
  local file = io.popen(invocation, 'r')
  xpcall(
    bind(pipeFn, file),
    function (err)
      file:close()
      error(err)
    end
  )
  file:close()
end

return {
  Program = Program
}
