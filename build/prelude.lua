local hash = ''
local strings = require('strings')
local tables = require('tables')
local interop = require('interop')
local git = interop.Program.new('git')
local commit = git:run({'log -1'}, function (gitLog)
    local lines = tables.collect(gitLog:lines())
    local commitLine = lines[1]
    hash = strings.split(commitLine, ' ')[2]
end)

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

print(output)
