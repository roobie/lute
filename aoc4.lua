
require('_test_prelude')
local inspect = require('inspect')
local prototype = require('prototype')
local fmt = require('fmt')
local strings = require('strings')
local tables = require('tables')
local func = require('func')
local StopWatch = require('stopwatch')
-- local linalg = require('linalg')
-- local vec2i = linalg.vec2i

local sw = StopWatch.new()

local inputLow = 307237
local inputHigh = 769058

local function satisfiesRules (str)
  local hasDouble = false
  local lastC = nil
  for i, c in strings.iter(str) do
    if lastC ~= nil then
      if not hasDouble and (lastC == c) then
        hasDouble = true
      end

      if not (tonumber(lastC) <= tonumber(c)) then
        return false
      end
    end
    lastC = c
  end
  return hasDouble
end

local function satisfiesRules2 (str)
  local repeats = {}
  local lastC = nil
  for i, c in strings.iter(str) do
    if lastC ~= nil then
      if lastC == c then
        repeats[c] = 1 + (repeats[c] or 0)
      end

      if not (tonumber(lastC) <= tonumber(c)) then
        return false
      end
    end
    lastC = c
  end

  for k, v in pairs(repeats) do
    if v == 1 then
      return true
    end
  end

  return false
end

local tap = require('tap').new {name = 'AOC 4'}
tap:addTest(
  'satisfiesRules',
  function (test)
    test:isTrue(satisfiesRules('111111'))
    test:isTrue(satisfiesRules('111112'))
    test:isFalse(satisfiesRules('223450'))
    test:isFalse(satisfiesRules('213456'))
    test:isFalse(satisfiesRules('123789'))
end)

tap:addTest(
  'satisfiesRules2',
  function (test)
    test:isTrue(satisfiesRules2('112233'))
    test:isFalse(satisfiesRules2('123444'))
    test:isTrue(satisfiesRules2('111122'))
    test:isFalse(satisfiesRules2('222144'))
end)

tap:addTest(
  'A',
  function (test)
    local possiblePasswords = {}
    for passwordNum = inputLow, inputHigh do
      local passwordStr = tostring(passwordNum)
      if satisfiesRules(passwordStr) then
        table.insert(possiblePasswords, passwordStr)
      end
    end
    print('Answer A:', #possiblePasswords)
end)

tap:addTest(
  'B',
  function (test)
    local possiblePasswords = {}
    for passwordNum = inputLow, inputHigh do
      local passwordStr = tostring(passwordNum)
      if satisfiesRules2(passwordStr) then
        table.insert(possiblePasswords, passwordStr)
      end
    end
    print('Answer B:', #possiblePasswords)
end)

tap:run()
