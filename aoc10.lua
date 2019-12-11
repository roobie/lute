require('_test_prelude')
require('fun')()

local inspect = require('inspect')
local prototype = require('prototype')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')
local numerics = require('numerics')

local tap = require('tap').new {name = 'AoC 10'}

local mapData = [[
#...##.####.#.......#.##..##.#.
#.##.#..#..#...##..##.##.#.....
#..#####.#......#..#....#.###.#
...#.#.#...#..#.....#..#..#.#..
.#.....##..#...#..#.#...##.....
##.....#..........##..#......##
.##..##.#.#....##..##.......#..
#.##.##....###..#...##...##....
##.#.#............##..#...##..#
###..##.###.....#.##...####....
...##..#...##...##..#.#..#...#.
..#.#.##.#.#.#####.#....####.#.
#......###.##....#...#...#...##
.....#...#.#.#.#....#...#......
#..#.#.#..#....#..#...#..#..##.
#.....#..##.....#...###..#..#.#
.....####.#..#...##..#..#..#..#
..#.....#.#........#.#.##..####
.#.....##..#.##.....#...###....
###.###....#..#..#.....#####...
#..##.##..##.#.#....#.#......#.
.#....#.##..#.#.#.......##.....
##.##...#...#....###.#....#....
.....#.######.#.#..#..#.#.....#
.#..#.##.#....#.##..#.#...##..#
.##.###..#..#..#.###...#####.#.
#...#...........#.....#.......#
#....##.#.#..##...#..####...#..
#.####......#####.....#.##..#..
.#...#....#...##..##.#.#......#
#..###.....##.#.......#.##...##]]

local function parse (dat)
  local out = {}
  local currLine = {}
  out[#out+1] = currLine
  for i, c in strings.iter(dat) do
    if c == '\n' then
      currLine = {}
      out[#out+1] = currLine
    else
      currLine[#currLine+1] = c
    end
  end
  return out
end

local algorithmicTemplate = [[
#.........
...A......
...B..a...
.EDCG....a
..F.c.b...
.....c....
..efd.c.gb
.......c..
....f...c.
...e..d..c
]]

local function traceLine (x1, y1, x2, y2, callback)
  local dx, dy = x2 - x1, y2 - y1
  print(dx, dy)
end

local function frameOf (map)
  local acc = {}
  for y=1,#map do
    table.insert(acc, {1, y})
    table.insert(acc, {#map[1], y})
  end
  for x=2,#map[1]-1 do
    table.insert(acc, {x, 1})
    table.insert(acc, {x, #map})
  end
  return acc
end

local function getFrame (x1, y1, x2, y2)
  local acc = {}
  for y=y1,y2 do
    table.insert(acc, {x1, y})
    table.insert(acc, {x2, y})
  end
  for x=x1+1,x2-1 do
    table.insert(acc, {x, y1})
    table.insert(acc, {x, y2})
  end
  return acc
end

tap:addTest(
  'One',
  function (test)
--     local mapData = [[
-- .#..#
-- .....
-- #####
-- ....#
-- ...##]]
    local map = parse(mapData)
    -- local map = parse(algorithmicTemplate)

    local withinBounds = func.memoize2(function (x, y)
        return (0 < x)
          and (x <= #map[1])
          and (0 < y)
          and (y <= #map)
    end)

    -- local c = 1
    local function spiralFromBox (nwcx, nwcy, secx, secy, center, acc, callbackIfBlocked)
      if (not withinBounds(nwcx, nwcy)) and (not withinBounds(secx, secy)) then
        return acc
      end
      local frame = getFrame(nwcx-1, nwcy-1, secx+1, secy+1)
      local p, x, y, dx, dy, q
      local cx, cy = center[1], center[2]
      for i = 1,#frame do
        p = frame[i]
        x, y = p[1], p[2]
        dx, dy = cx-x,cy-y
        q = math.atan2(dy,dx)
        if acc.index[q] == nil then
          if withinBounds(x, y) and callbackIfBlocked(p[1], p[2]) then
            acc.index[q]=true
            acc[#acc+1]={x,y}
          end
        end
      end
      return spiralFromBox(nwcx-1, nwcy-1, secx+1, secy+1, center, acc, callbackIfBlocked)
    end

    local max, bx, by = 0, 0, 0
    for y=1,#map do
      for x=1,#map[1] do
        local v = spiralFromBox(x, y, x, y, {x,y}, {index={}}, function (x, y)
                                  local res = map[y][x] == '#'
                                  -- if res then
                                  --   map[y][x] = 'S'
                                  -- end
                                  return res
                               end)
        if #v > max then
          max = #v
          bx, by = x, y
        end
      end
    end
    print(max, bx, by)

    for _,row in ipairs(map) do
      print(table.concat(row, ''))
    end
end)

tap:run()
