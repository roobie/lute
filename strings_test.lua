local strings = require('strings')
local Tap = require('tap')
local inspect = require('inspect')
local fmt = require('fmt')

local StopWatch = require('stopwatch')

local function dump (what)
  print(inspect(what))
end

local tap = Tap.new {name = 'strings.lua'}

tap:addTest(
  'strings.split', function (test)
    local r = strings.split('')
    test:equal(#r, 0, 'Splitting an empty string should yield no results')


    test:comment('Even though splitting strings are so mundane, we test it more.')

    r = strings.split('a,b,c', ',')
    test:equal(#r, 3, 'We expect "a,b,c" split by "," should be 3 elements long')
    test:equal(r[1]..r[2]..r[3], 'abc')
end)

tap:addTest(
  'strings.iter',
  function (test)
    local str = 'a bc d'
    local acc = {}
    for i, c in strings.iter(str) do
      acc[i] = c
    end
    test:equal(acc[1], 'a')
    test:equal(acc[2], ' ')
    test:equal(acc[3], 'b')
    test:equal(acc[4], 'c')
    test:equal(acc[5], ' ')
    test:equal(acc[6], 'd')
end)

tap:addTest(
  'strings.padr',
  function (test)
    test:equal(strings.padr('1', 1, '0'), '1')
    test:equal(strings.padr('1', 2, '0'), '10')
    test:equal(strings.padr('1', -1, '0'), '1')
    test:equal(strings.padr('1', 4, '0'), '1000')
end)

tap:addTest(
  'strings.padl',
  function (test)
    test:equal(strings.padl('1', 1, '0'), '1')
    test:equal(strings.padl('1', 2, '0'), '01')
    test:equal(strings.padl('1', -1, '0'), '1')
    test:equal(strings.padl('1', 4, '0'), '0001')
end)

tap:addTest(
  'strings.isEmpty',
  function (test)
    test:isTrue(strings.isEmpty(''))
    test:isFalse(strings.isEmpty('a'))
end)

tap:addTest(
  'strings.isBlank',
  function (test)
    test:isTrue(strings.isBlank(''))
    test:isTrue(strings.isBlank(' '))
    test:isTrue(strings.isBlank('\n\r\t '))
    test:isFalse(strings.isBlank(' a'))
    test:isFalse(strings.isBlank(' _ \n'))
end)

tap:addTest(
  'strings.trim',
  function (test)
    test:equal(strings.trimStart(' a '), 'a ')
    test:equal(strings.trimEnd(' a '), ' a')
    test:equal(strings.trim(' a '), 'a')
    test:equal(strings.trim('\na\n'), 'a')
end)

tap:addTest(
  'strings.levenshteinDistance',
  function (test)
    test:equal(strings.levenshteinDistance('hello', 'helo'), 1)
    test:equal(strings.levenshteinDistance('helo', 'hello'), 1)
    test:equal(strings.levenshteinDistance('abc', 'cba'), 2)
    test:equal(strings.levenshteinDistance('thing', 'ahnt'), 3)
    test:equal(strings.levenshteinDistance('aaaa', 'bbbb'), 4)
    test:equal(strings.levenshteinDistance('local', 'qwert'), 5)
    test:equal(strings.levenshteinDistance('aaabbbccc', 'qqqbbbyyy'), 6)
end)

tap:addTest(
  'strings.startsWith',
  function (test)
    test:isTrue(strings.startsWith('abcdef', 'abc'))
    test:isFalse(strings.startsWith('abcdef', 'bcd'))
    test:isFalse(strings.startsWith('\nabcdef', 'abcd'))
end)

tap:addTest(
  'strings.endsWith',
  function (test)
    test:isTrue(strings.endsWith('abcdef', 'def'))
    test:isFalse(strings.endsWith('abcdef', 'cde'))
    test:isFalse(strings.endsWith('abcdef\n', 'def'))
end)

tap:addTest(
  'strings.template.compile',
  function (test)
    local render

    render = strings.template.compile('abc:%[1]%[2]')
    test:equal(render {'foo', 'bar'}, 'abc:foobar')

    render = strings.template.compile('abc:%[foo]%[bar]')
    test:equal(render {foo = 'foo', bar = 'bar'}, 'abc:foobar')

    render = strings.template.compile('abc:%[fn]')
    test:equal(render {fn=function () return 'foobar' end}, 'abc:foobar')
end)

tap:addTest(
  'strings.template.interpolate',
  function (test)
    local acc

    local result = strings.template.interpolate(
      '%[name] is 100%!', {name='World'})
    test:equal(result, 'World is 100%!')

    local sw = StopWatch.new()
    sw:reset()
    acc = {}
    for i = 1, 50000 do
      acc[#acc + 1] = string.format('header%s%s', 'foo', 'bar')
    end
    fmt.printf('# string.format, time taken: %f', sw:millis())

    sw:reset()
    acc = {}
    for i = 1, 50000 do
      acc[#acc + 1] = 'header'..'foo'..'bar'
    end
    fmt.printf('# concat, time taken: %f', sw:millis())

    local render = strings.template.compile('header%[1]%[2]')
    local data = {'foo', 'bar'}
    sw:reset()
    acc = {}
    for i = 1, 50000 do
      acc[#acc + 1] = render(data)
    end
    fmt.printf('# template, time taken: %f', sw:millis())
end)

tap:addTest(
  'strings.XYZ',
  function (test)
end)

return tap
