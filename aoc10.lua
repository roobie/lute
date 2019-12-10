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

local numerics = require('numerics')
-- print(numerics.gcd(4,4))
-- print(numerics.lcm(4,4))

local function fraction (v, err)
  err = err or 0.0001
  local f = v - math.floor(v)
  local lo = {0, 1}
  local hi = {1, 1}
  while true do
    -- mid = (lo + hi)/2
    -- if lo = a/b and hi = c/d, then mid = (ad+bc)/(2ad)
    local mid = {lo[1]*hi[2] + hi[1]*lo[2], 2*lo[2]*hi[2]}
    -- gcd to reduce fraction
    local k = numerics.gcd(mid[1], mid[2])
    mid = {mid[1]/k, mid[2]/k}

    local d = 1.*mid[1]/mid[2]
    fmt.dump {mid=mid,d=d,lo=lo,hi=hi,f=f,k=k}
    -- are we close enough?
    if math.abs(f - d) < err then
      break
    -- if we are above our goal, get high to middle
    elseif d > f then
      hi = mid
    -- if we are under our goal, get lower to middle
    else
      lo = mid
      -- Add integer part
      mid = {mid[1] + math.floor(v)*mid[2], mid[2]}
      -- Debug comparing to Fraction library solution.
      --print v, mid, Fraction('%s' % v)
    end
  end
  return mid
end
-- fmt.dump(fraction(0.8))

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
    local mapData = [[
.#..#
.....
#####
....#
...##]]
    local map = parse(mapData)
    -- local map = parse(algorithmicTemplate)
    -- print('AAA')
    -- traceLine(1, 1, 5, 5)
    -- print('BBB')
    -- traceLine(1, 1, 15, 18)
    -- local dump = function (x, y)
    --   fmt.dump {x=x; y=y}
    -- end
    -- traceLine(4, 5, 5, 1, dump)
    -- traceLine(4, 5, 1, 2, dump)

    -- for _,pair in ipairs(frameOf(map)) do
    --   map[pair[2]][pair[1]] = '!'
    -- end
    -- for _,row in ipairs(map) do
    --   print(table.concat(row, ''))
    -- end

    -- local acc = {a={};b={};c={};d={};e={};f={};g={}}
    -- local x, y = 1, 1
    -- for _, c in strings.iter(algorithmicTemplate) do
    --   if c == '\n' then
    --     y = y + 1
    --     x = 1
    --   else
    --     c = string.lower(c)
    --     if acc[c] then
    --       table.insert(acc[c], {x-1,y-1})
    --     end
    --     x = x + 1
    --   end
    -- end
    -- fmt.dump(acc)

    local function memoize2 (fn)
      local cache = {}
      return function (a, b)
        if cache[a] then
          if cache[a][b] then
            return cache[a][b]
          else
            cache[a][b] = fn(a, b)
          end
        else
          cache[a] = {}
          cache[a][b] = fn(a, b)
        end
        return cache[a][b]
      end
    end

    local withinBounds = memoize2(function (x, y)
        return (0 < x)
          and (x <= #map[1])
          and (0 < y)
          and (y <= #map)
    end)

    -- local c = 1
    local function spiralFromBox (nwcx, nwcy, secx, secy, sz, acc, callbackIfBlocked)
      if (not withinBounds(nwcx, nwcy)) and (not withinBounds(secx, secy)) then
        return acc
      end
      local frame = getFrame(nwcx-1, nwcy-1, secx+1, secy+1)
      -- for _,pair in ipairs(frame) do
      --   if withinBounds(pair[1], pair[2]) then
      --     map[pair[2]][pair[1]]=c
      --   else print(pair[1], pair[2])
      --   end
      -- end
      -- c=c+1
      local p, x, y
      for i = 1,#frame do
        p = frame[i]
        x, y = p[1], p[2]
        if callbackIfBlocked(p[1], p[2]) then
          acc.index.x[x] = acc.index.x[x] or {}
          table.insert(acc.index.x[x], y)

          acc.index.y[y] = acc.index.y[y] or {}
          table.insert(acc.index.y[y], x)
        end
      end
      return spiralFromBox(nwcx-1, nwcy-1, secx+1, secy+1, acc, callbackIfBlocked)
    end

    local v = spiralFromBox(3, 3, 3, 3, 1, {index={x={};y={}}}, function (x, y)
                              return map[y][x] == '#'
    end)

    for _,row in ipairs(map) do
      print(table.concat(row, ''))
    end
end)

tap:run()
