local strings = require('strings')
local tables = require('tables')

local moduleTemplate = strings.template.compile([[
--- BEGIN %[module]
export.%[module] = (function ()
%[sourceCode]
end)()
--- END %[module]
]]
)

local args = {...}
for i, modname in ipairs(args) do
  local f = assert(io.open(modname..'.lua'))
  local luaCode = f:read('*a')
  local output = moduleTemplate {
    module = modname;
    sourceCode = luaCode;
  }
  f:close()

  print(output)
end
