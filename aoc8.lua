require('_test_prelude')
local inspect = require('inspect')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')
local utils = require('aoc_utils')
require('fun')() -- pollute _G

local tap = require('tap').new {name='AoC 8'}

local VERBOSE = false
local imgWidth, imgHeight = 25, 6

local function getInput()
  local inputText = utils.getInputText('aoc8.input.txt')
  inputText = inputText:gsub('%\n', '')
  return totable(iter(inputText))
  -- return inputText
end

local function getStructuredData ()
  local imgData = getInput()
  local layers = {}
  for l=1,math.floor(#imgData/(imgWidth*imgHeight)) do
    local layer = {}
    layers[l] = layer
    local loffset = (l-1) * imgWidth*imgHeight
    for y=1,imgHeight do
      layer[y] = {}
      local yoffset = (y - 1) * imgWidth
      for x=1,imgWidth do
        layer[y][x] = tonumber(imgData[loffset+yoffset+x])
        if VERBOSE then
          fmt.printf(
            'layer[l=%d][y=%d][x=%d] = imgData[%d]',
            l, y, x, loffset+yoffset+x)
        end
      end
    end
  end

  return layers
end

tap:addTest(
  'A',
  function (test)
    local layers = getStructuredData()
    local function countZeros (t)
      local c = 0
      for i,v in ipairs(t) do
        if v == 0 then
          c = c + 1
        end
      end
      return c
    end
    local leastZeroCount = 100
    local leastZeroLayer = nil
    for i, l in ipairs(layers) do
      local acc = {}
      for y, yt in ipairs(l) do
        for x, xt in ipairs(l[y]) do
          acc[#acc+1] = l[y][x]
        end
      end
      local zeroCount = countZeros(acc)
      if zeroCount < leastZeroCount then
        leastZeroCount = zeroCount
        leastZeroLayer = acc
      end
    end

    if VERBOSE then
      fmt.dump(leastZeroLayer)
    end

    local oneDigitCount = 0
    local twoDigitCount = 0
    for i, v in ipairs(leastZeroLayer) do
      if v == 1 then
        oneDigitCount = oneDigitCount + 1
      elseif v == 2 then
        twoDigitCount = twoDigitCount + 1
      end
    end
    fmt.printf('Answer: %d', oneDigitCount * twoDigitCount)
end)

local function renderImage (layers)
  local output = {}
  for y=1,imgHeight do
    output[y] = {}
    for x=1,imgWidth do
      output[y][x] = 2 -- transparent
      for li, l in ipairs(layers) do
        if l[y][x] ~= 2 then
          output[y][x] = l[y][x]
          break
        end
      end
    end
  end
  return output
end

local function displayImage (output)
  for y=1,imgHeight do
    for x=1,imgWidth do
      if output[y][x] == 1 then
        io.write('#')
      elseif output[y][x] == 0 then
        io.write('.')
      end
    end
    io.write('\n')
  end
end

tap:addTest(
  'B',
  function (test)
    local layers = getStructuredData()
    local output = renderImage(layers)

    displayImage(output)
end)

tap:run()
