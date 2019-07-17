--[[

  TBD

  @example

  local stream = rx.stream(0)
  -------------------------^ initial value. May be nil,
  -- in which case the stream has no initial value.

  print(stream()) -- prints 0 (the initial value)

  rx.map(print, stream)

  stream(1) -- prints 1
  stream(2) -- prints 2

  print(stream()) -- prints 2 (the last value)

]]

local prototype = require('lute.prototype')

local rx = {}

local Stream = prototype {}
function Stream.new (...)
  local instance = Stream {
    values = {...}
  }
  local newMt = {}
  function newMt.__call (self, ...)
    if select('#', ...) == 0 then
      return unpack(self.values)
    else
      self.values = {...}
    end
  end

  local oldMt = getmetatable(instance)
  return setmetatable(instance, setmetatable(newMt, oldMt))
end

local unpack = rawget(table, 'unpack') or unpack

rx.stream = Stream.new

return rx
