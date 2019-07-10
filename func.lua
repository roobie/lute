--[[

  This module contains commonly used functions and higher order functions.

]]

local func = {}

function func.inc (n, c)
  if c == nil then
    return n + 1
  else
    return n + c
  end
end

function func.dec (n, c)
  if c == nil then
    return n - 1
  else
    return n - c
  end
end

function func.transpose (a, b)
  return b, a
end

function func.bnot (b)
  return not b
end

function func.invert (n)
  return -n
end

function func.double (n)
  return n * 2
end

function func.half (n)
  return n / 2
end

function func.identity (a)
  return a
end

function func.compose (f, g)
  return function (...)
    return f(g(...))
  end
end

function func.pipe (pipeline)
  return function (a)
    local result = a
    for _, fn in ipairs(pipeline) do
      result = fn(result)
    end
    return result
  end
end

function func.collect1 (iterator)
  local result = {}
  for e in iterator do
    result[#result + 1] = e
  end

  return result
end

function func.collect2 (iterator)
  local result = {}
  for _, e in iterator do
    result[#result + 1] = e
  end

  return result
end

function func.lt (a, b)
  return a < b
end
function func.lte (a, b)
  return a <= b
end
function func.gt (a, b)
  return a > b
end
function func.gte (a, b)
  return a >= b
end

return func
