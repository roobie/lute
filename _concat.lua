
local modules = {
  'inspect';
  'fun';
  'func';
  'prototype';
  'fmt';
  'flags';
  'strings';
  'tables';
  'quick_sort';
  'quick_sort_generic';
  'table_list';
  'avl_tree';
  'linked_list';
  'doubly_linked_list';
  'max_heap';
  'min_heap';
  'quad_tree';
  'queue';
  'set';
  'stack';
  'curried';
  'pubsub';
  -- 'stopwatch';
  -- 'tap';
  'utf8';
}

local initContents = ''
for line in io.lines('init.lua') do
  if line:find('return') == 1 then
  elseif line:find('}') == 1 then
  else
    initContents = initContents..line..'\n'
  end
end

local output = [[

local export = {
--- The license defined here might be overridden in each underlying module.
--- Please refer to each module to see whether that is the case.
]]..initContents..[[
}

local function require (name)
  if export[name] then
    return export[name]
  else
    return _G.require(name)
  end
end

]]
for _, modname in ipairs(modules) do
  local f = io.open(modname..'.lua')
  local code = f:read('*a')
  f:close()
  code = string.format([[

--- BEGIN %s.lua
export.%s = (function ()
%s
end)()
--- END %s.lua
]], modname, modname, code, modname)
  output = output..code
end
output = output..
  '\n\n--[[\n  '..(table.concat(modules, '\n  '))..'\n]]'..
  '\nreturn export\n'
load(output)
print(output)

local distfile = io.open('lute.lua', 'w+')
distfile:write(output)
distfile:close()

local ok, lute = pcall(require, 'lute')
if not ok then
  error(string.format('lute not functioning, %s', lute))
else
  print(lute)
end
