
local hash = ''
local strings = require('strings')
local tables = require('tables')
local interop = require('interop')
local git = interop.Program.new('git')
local commit = git:run({'log -1'}, function (gitLog)
  local lines = tables.collect(gitLog:lines())
  local commitLine = lines[1]
  hash = strings.split(commitLine, ' ')[2]
  print('Commit hash:', hash)
end)

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

local output = strings.template.interpolate([[
---! Built from commit hash: %[hash]

local export = {
--- The license defined here might be overridden in each underlying module.
--- Please refer to each module to see whether that is the case.
%[initContents]
}

--- internal require, to accomodate interdependencies even when concat'd
local function require (name)
  if export[name] then
    return export[name]
  else
    return _G.require(name)
  end
end

]], {
  hash = hash;
  initContents = initContents;
})

local moduleTemplate = strings.template.compile [[

--- BEGIN %[module].lua
export.%[module] = (function ()
%[sourceCode]
end)()
--- END %[module].lua

]]

for _, modname in ipairs(modules) do
  local f = io.open(modname..'.lua')
  local code = f:read('*a')
  f:close()
  code = moduleTemplate {
    module = modname;
    sourceCode = code;
  }
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

-- check that the concat'd file is `load`/`require`able
local ok, lute = pcall(require, 'lute')
if not ok then
  error(string.format('lute not functioning, %s', lute))
else
  print(lute)
end
