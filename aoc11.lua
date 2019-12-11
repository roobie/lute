require('_test_prelude')
-- require('fun')()

local inspect = require('inspect')
local prototype = require('prototype')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')

local tap = require('tap').new {name = 'AoC 11'}

local getProgram = require('aoc11_input')
local intcode = require('aoc_intcode4')


tap:addTest(
  'A',
  function (test)
    local px, py = 0, 0
    local map = {[0]={[0]=1}}
    local c = 0
    local left = {
      up = 'left';
      left = 'down';
      down = 'right';
      right = 'up';
    }
    local right = {
      up = 'right';
      right = 'down';
      down = 'left';
      left = 'up';
    }
    local move = {
      up = {0, -1};
      down = {0, 1};
      left = {-1, 0};
      right = {1, 0};
    }
    local dir = 'up'
    local bot = intcode(getProgram(), {
                          name = 'EHP',
                          verbosity = 0,
                          out = function (v)
                            -- fmt.printf('Output: %d', v)
                            if c == 0 then -- paint
                              map[py][px] = v
                              -- fmt.printf('Paint: [%d;%d] %d', px, py, v)
                            elseif c == 1 then -- turn
                              if v == 0 then -- left
                                dir = left[dir]
                              elseif v == 1 then -- right
                                dir = right[dir]
                              end
                              -- move
                              local vec = move[dir]
                              px = vec[1] + px
                              py = vec[2] + py
                              if map[py] == nil then
                                map[py] = {}
                              end
                              if map[py][px] == nil then
                                map[py][px] = 0
                              end
                            end
                            c = (c+1)%2
                          end
    })
    local input
    local s = 1
    local ss = {'/','-','\\','|'}
    local cc = 0
    while true do
      input = bot.run()
      if type(input) == 'function' then
        input(map[py][px])
      else
        fmt.dump(input)
        break
      end
      io.write('\r'..ss[s])
      s=(s+1)%4+1
      cc=cc+1
    end
    print()
    -- fmt.dump(map)
    print('CC: ', cc)

    -- change input to zero first to get this answer
    local sumPainted = 0
    for y,row in pairs(map) do
      for x,col in pairs(map[y]) do
        sumPainted = sumPainted + 1
      end
    end

    for y=0,#map do
      for x=0,#map[0]-1 do
        if map[y][x] == 1 then
          io.write('#')
        else
          io.write('.')
        end
      end
      io.write('\n')
    end
end)
tap:run()
