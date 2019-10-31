local strings = require('strings')
local Tap = require('tap')
local inspect = require('inspect')
local fmt = require('fmt')
local tables = require('tables')
local F = require('func')
local curried = require('curried')

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
  'strings.includes',
  function (test)
    test:isTrue(strings.includes('abcdef', 'bcd'))
    test:isFalse(strings.includes('abcdef', 'aa'))
    test:isTrue(strings.includes('\nabcdef', 'abcd'))
end)

tap:addTest(
  'strings.template (HTML example)',
  function (test)
    local render = strings.template.compile [[
    <div>
      <h1>%[title]</h1>
      %[paragraphs]
    </div>
    ]]
    local renderParagraph = strings.template.compile('<p>%[content]</p>')
    local renderParagraphs = F.pipe {
      curried.map(function (content) return renderParagraph {content = content} end),
      function (tbl) return table.concat(tbl, '\n') end
    }

    local output = render {
      title = 'Lute',
      paragraphs = renderParagraphs {
        'This is a paragraph',
        'This is another paragraph'
      }
    }
    print(output)
end)

tap:addTest(
  'strings.template.compile',
  function (test)
    local render

    render = strings.template.compile('abc:%[a[1]:upper()]%[a[2]]')
    test:equal(render {a={'foo', 'bar'}}, 'abc:FOObar')

    render = strings.template.compile('abc:%[foo]%[bar]')
    test:equal(render {foo = 'foo', bar = 'bar'}, 'abc:foobar')

    render = strings.template.compile('abc:%[fn("bar")]')
    test:equal(render {fn=function (bar) return 'foo'..bar end}, 'abc:foobar')
end)

tap:addTest(
  'strings.template.interpolate',
  function (test)
    local acc

    local result = strings.template.interpolate(
      '%[name or "default"] is|| # []~100%!', {name='World'})
    test:equal(result, 'World is|| # []~100%!')

    local sw = StopWatch.new()

    local function performTest (name, fn)
      if true then
        return 0
      end
      sw:reset()
      acc = {}
      local count = 5000
      for i = 1, count do
        acc[#acc + 1] = fn()
      end
      local time = sw:millis()
      fmt.printf('# %s, time taken: %f avg. per run: %f', name, time, time / count)
    end

    performTest('string.format', function ()
                  local args = {}
                  for i = 1, 10 do
                    args[i] = math.random()
                  end
                  return string.format(
                    'header%s%s%s%s%s%s%s%s%s%s', unpack(args)) -- slowest so far. On par with .. (concat) and template
                    -- 'header%d%d%d%d%d%d%d%d%d%d', unpack(args)) -- a lot faster
                    -- 'header%f%f%f%f%f%f%f%f%f%f', unpack(args)) -- somewhat faster
    end)
    performTest('concat', function ()
                  return 'header'..
                    math.random()..
                    math.random()..
                    math.random()..
                    math.random()..
                    math.random()..
                    math.random()..
                    math.random()..
                    math.random()..
                    math.random()..
                    math.random()
    end)
    performTest('table.concat', function ()
                  return table.concat {
                    math.random();
                    math.random();
                    math.random();
                    math.random();
                    math.random();
                    math.random();
                    math.random();
                    math.random();
                    math.random();
                    math.random();
                  }
    end)
    local render = strings.template.compile('header%[d[1]]%[d[2]]%[d[3]]%[d[4]]%[d[5]]%[d[6]]%[d[7]]%[d[8]]%[d[9]]%[d[10]]')
    performTest('template', function ()
                  return render {
                    d = {
                      math.random();
                      math.random();
                      math.random();
                      math.random();
                      math.random();
                      math.random();
                      math.random();
                      math.random();
                      math.random();
                      math.random();
                    }
                  }
    end)
end)

tap:addTest(
  'strings.withLpeg',
  function (test)
    if pcall(require, 'lpeg') then
      local result = strings.withLpeg(function ()
          test:isTrue(P ~= nil)

          local maybe_a = maybe(P'a')
          local either_ab = either(P'a', P'b')
          test:equal(maybe_a:match('ab'), 2)
          test:equal(either_ab:match('aaa'), 4)
          return 1
      end)
      test:isFalse(P ~= nil)
      test:equal(result, 1)
    end
end)

tap:addTest(
  'strings.XYZ',
  function (test)
end)

return tap
