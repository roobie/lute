require('_test_prelude')
require('fun')()

local inspect = require('inspect')
local prototype = require('prototype')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')

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

local function bresenham(x1, y1, x2, y2, callback)
  local delta_x = x2 - x1
  local ix = delta_x > 0 and 1 or -1
  local delta_x = 2 * math.abs(delta_x)

  local delta_y = y2 - y1
  local iy = delta_y > 0 and 1 or -1
  local delta_y = 2 * math.abs(delta_y)

  callback(x1, y1)

  if delta_x >= delta_y then
    local err = delta_y - delta_x / 2

    while x1 ~= x2 do
      if (err > 0) or ((err == 0) and (ix > 0)) then
        err = err - delta_x
        y1 = y1 + iy
      end

      err = err + delta_y
      x1 = x1 + ix

      if callback(x1, y1) then
        break
      end
    end
  else
    local err = delta_x - delta_y / 2

    while y1 ~= y2 do
      if (err > 0) or ((err == 0) and (iy > 0)) then
        err = err - delta_y
        x1 = x1 + ix
      end

      err = err + delta_x
      y1 = y1 + iy

      if callback(x1, y1) then
        break
      end
    end
  end
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

tap:addTest(
  'One',
  function (test)
    local mapData = [[
.#..#
.....
#####
....#
...##]]
    local map = parse(mapData)
    traceLine(4, 5, 5, 1, function (x, y)
                fmt.dump {x=x; y=y}
    end)
end)

tap:run()
