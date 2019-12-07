
require('_test_prelude')
local inspect = require('inspect')
local prototype = require('prototype')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')

local utils = require('aoc_utils')
local tap = require('tap').new {name = 'AoC 6'}

local input = utils.getInputLines('aoc6.input.txt')

local function getOrbitData (input)
  local orbits = {}
  local orbitsInverse = {}
  for _, orbit in ipairs(input) do
    local parts = strings.split(orbit, '%)')
    local orbitedObject, orbitingObject = unpack(parts)
    local orbitingObjects = orbits[orbitedObject] or {}
    table.insert(orbitingObjects, orbitingObject)
    orbits[orbitedObject] = orbitingObjects
    orbitsInverse[orbitingObject] = orbitedObject
  end

  return {
    orbits = orbits;
    orbitsInverse = orbitsInverse;
  }
end

local function computeIndirect (obj, orbitsInverse)
  local count = 0
  local currentObj = orbitsInverse[obj]
  while currentObj ~= nil do
    count = count + 1
    currentObj = orbitsInverse[currentObj]
  end
  return count
end

local function computeChecksum (orbitData)
  -- local sumDirectOrbits = 0
  local sumIndirectOrbits = 0
  for centerObject, orbitingObjects in pairs(orbitData.orbits) do
    -- sumDirectOrbits = sumDirectOrbits + #orbitingObjects
    for _, obj in ipairs(orbitingObjects) do
      sumIndirectOrbits = sumIndirectOrbits +
        computeIndirect(obj, orbitData.orbitsInverse)
    end
  end

  return sumIndirectOrbits
end

tap:addTest(
  'Logic',
  function (test)
    local testInput = strings.split([[COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L]], '%\n')
    local data = getOrbitData(testInput)
    -- fmt.dump(data)
    test:equal(computeIndirect('L', data.orbitsInverse), 7)
    test:equal(computeChecksum(data), 42)
end)

tap:addTest(
  'A',
  function (test)
    local data = getOrbitData(input)
    fmt.printf('The checksum is: %d', computeChecksum(data))
end)

local function getPathToCom (obj, orbitsInverse)
  local acc = {}
  local currentObj = orbitsInverse[obj]
  while currentObj ~= nil do
    table.insert(acc, currentObj)
    currentObj = orbitsInverse[currentObj]
  end

  return acc
end

local function getClosestCommonObject (obj1, obj2, data)
  local path1 = getPathToCom(obj1, data.orbitsInverse)
  local path2 = getPathToCom(obj2, data.orbitsInverse)

  local path1Lookup = tables.createIndex(path1)
  local path2Lookup = tables.createIndex(path2)

  for _, v in ipairs(path1) do
    if path2Lookup[v] then
      return v,
      tables.take(path1, path1Lookup[v]),
      tables.take(path2, path2Lookup[v])
    end
  end

  error('Not found')
end

local function computeAmountOfJumps (path1, path2)
  return #path1 - 1 + #path2 - 1
end

tap:addTest(
  'Logic',
  function (test)
    local testInput = strings.split([[COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
I)SAN
K)YOU]], '%\n')
    local data = getOrbitData(testInput)
    -- fmt.dump(data)
    test:equal(computeIndirect('L', data.orbitsInverse), 7)
    local closestCommonObject, p1, p2 =
      getClosestCommonObject('SAN', 'YOU', data)
    local jumpCount = computeAmountOfJumps(p1, p2)
    test:equal(jumpCount, 4)
end)

tap:addTest(
  'B',
  function (test)
    local data = getOrbitData(input)
    local closestCommonObject, p1, p2 =
      getClosestCommonObject('SAN', 'YOU', data)
    local jumpCount = computeAmountOfJumps(p1, p2)
    fmt.printf('The minimal amount of jumps is: %d', jumpCount)
end)

tap:run()
