
require('_test_prelude')
local inspect = require('inspect')
local prototype = require('prototype')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')
local StopWatch = require('stopwatch')
local linalg = require('linalg')
local vec2i = linalg.vec2i

local sw = StopWatch.new()

local function vec2iFromString (str)
  local x, y = unpack(strings.split(str, ';'))
  return vec2i(tonumber(x), tonumber(y))
end

-- local inputFile = io.open('aoc3-input.test.txt')
local inputFile = io.open('aoc3-input.txt')
local wires = {}

local function parseWireData (str)
  local instructions = strings.split(str, ',')
  local parsed = {}
  for i, instr in ipairs(instructions) do
    local dir, amount = string.match(instr, '(.)(%d*)')
    parsed[#parsed+1] = {dir, amount}
  end

  return parsed
end

for line in inputFile:lines() do
  local wire = parseWireData(line)
  table.insert(wires, wire)
end
inputFile:close()

local function trace (id, wire, index, fromPoint, accumulator, accumulatorKeyed)
  if wire[index] == nil then
    return accumulator
  end

  local dir, amount = unpack(wire[index])

  if index == 1 then
    accumulator[#accumulator+1] = fromPoint
    accumulatorKeyed[tostring(fromPoint)] = {}
  end
  local p
  for v = 1,amount do
    if dir == 'U' then
      p = fromPoint + vec2i(0, v)
    elseif dir == 'D' then
      p = fromPoint + vec2i(0, -v)
    elseif dir == 'L' then
      p = fromPoint + vec2i(-v, 0)
    elseif dir == 'R' then
      p = fromPoint + vec2i(v, 0)
    else
      error('wut')
    end
    accumulator[#accumulator+1] = p
    -- if p.x == 146 and p.y == 11 then
    --   print('asdfasdf', p, fromPoint)
    -- end
    local tbl = accumulatorKeyed[tostring(p)] or {}
    tbl[id] = true
    accumulatorKeyed[tostring(p)] = tbl
  end

  -- print(p)
  return trace(id, wire, index+1, p, accumulator, accumulatorKeyed)
end

sw:reset()
local origin = vec2i(0, 0)
local traces = {}
local keyedPoints = {}
for id, wire in ipairs(wires) do
  local points = trace(id, wire, 1, origin, {}, keyedPoints)
  table.insert(traces, points)
  -- print(inspect(keyedPoints))
end

-- print(inspect(traces[1]))
-- print(inspect(traces[2]))
-- for _, v in ipairs(traces[2]) do
--   print(v)
-- end
do -- find intersections
  local intersections = {}
  for k, v in pairs(keyedPoints) do
    -- if type(v) == 'number' then
    --   print(k, v)
    -- end
    if v[1] and v[2] then
      local p = vec2iFromString(k)
      -- if p ~= origin then
      if not p:equal(origin) then
        table.insert(intersections, p)
      end
    end
  end
  -- for i, trace in ipairs(traces) do
  --   for j = i+1,#traces do
  --     for _, p1 in ipairs(trace) do
  --       io.write('.')
  --       for _, p2 in ipairs(traces[j]) do
  --         if p1:equal(p2) and (not p1:equal(origin)) then
  --           -- print('Intersection', p1, p2)
  --           table.insert(intersections, p1)
  --         end
  --       end
  --     end
  --   end
  --   print('Big loop is done')
  -- end

  local closest = intersections[1]
  for _, p in ipairs(intersections) do
    if p:manhattanDistance(origin) < closest:manhattanDistance(origin) then
      closest = p
    end
  end
  print('Closest intersection =', closest)
  fmt.printf('# Time elapsed: %f ms', sw:millis())


  sw:reset()
  function stepsToIntersection (intersection, trace)
    for i = 1,#trace do
      if linalg.vec2eq(trace[i], intersection) then
        return i - 1
      end
    end
  end

  local leastSteps = nil
  for _, intersection in ipairs(intersections) do
    local totalSteps = 0
    for _, trace in ipairs(traces) do
      -- print(inspect(trace))
      local steps = stepsToIntersection(intersection, trace)
      totalSteps = totalSteps + steps
    end
    -- print(intersection, totalSteps)
    if leastSteps == nil then
      leastSteps = totalSteps
    elseif totalSteps < leastSteps then
      leastSteps = totalSteps
    end
  end
  print('Intersection closest path: ', leastSteps)
  fmt.printf('# Time elapsed: %f ms', sw:millis())
end
