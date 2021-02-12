
local Tap = require('tap')
local inspect = require('inspect')
local ffi = require('ffi')

local slice = require('slice')

local tap = Tap.new {name = 'slice.lua'}

tap:addTest(
  'basics',
  function (test)
  local int_t = ffi.typeof("int")
  local byte_t = ffi.typeof("uint8_t")

  local a, b

  a = slice.make(int_t, {})
  test:equal(a.len, 0)
  test:equal(a.cap, 0)

  a = slice.make(int_t, 5, 5)

  test:equal(a.len, 5)
  test:equal(a.cap, 5)

  a = slice.make(int_t,  {1, 2, 3, 4, 5})

  for i = 1, a.len do
    test:equal(a[i - 1], i)
  end

  test:equal(a.len, 5)
  test:equal(a.cap, 5)

  b = a:slice(1, 4)

  test:equal(b.len, 3)
  test:equal(tostring(b), "[2, 3, 4]")

  a = slice.make(int_t, 0, 5)
  test:equal(tostring(a), "[]")

  b = slice.make(int_t,  {1, 2, 3, 4, 5})

  b:copyTo(a)

  test:equal(tostring(a), "[1, 2, 3, 4, 5]")
  test:equal(#a:toTable(), 5)
  test:equal(a.len, 5, 'length check')

  a = slice.make(int_t, {1, 2, 3})
  b = slice.make(int_t, {4, 5, 6})
  test:equal(tostring(a..b), "[1, 2, 3, 4, 5, 6]")

  a = slice.make(byte_t, {1, 2, 3})
  test:equal(a.stride, 1)


  a = slice.make(int_t, {1, 2, 3, 4, 5})
  test:equal(a[0], 1)
  b = slice.make(int_t, 100, 100)
  -- print(b)
  for i=0,a.len-1 do
    b[i]=a[i]
  end
  a:copyTo(b)
  test:equal(a.len, b.len)
  b.len = 100
  test:equal(b.len, 100)
  -- for i=a.len,99 do
  --   b[i] = 0
  -- end

  a = slice.make(int_t, {1, 2, 3, 4, 5})
  test:equal(a[0], 1)
  b = slice.make(int_t, 100, 100)
  slice.copy(b, a)
  test:equal(b.len, 5)
  b.len = 100
  test:equal(b.len, 100)

  a = slice.make(byte_t, {999, 256, 9})
  test:equal(a[1], 0)
  test:equal(a[5], 9)
  test:equal(a[5], a[-1])
  test:equal(a[5], a[-4])

  a[-1] = 11
  test:equal(a[5], 11)
  test:equal(a[-1], a[5])

  a = slice.make(int_t, {1, 2, 3, 4, 5})
  b = a:copy()
  test:equal(a[0], b[0])
  test:equal(a[1], b[1])
  test:equal(a[2], b[2])
  test:equal(a[3], b[3])
  test:equal(a[4], b[4])
  test:equal(a.len, b.len)
  test:equal(a.cap, b.cap)
end)

return tap
