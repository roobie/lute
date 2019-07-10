--[[

  TBD

  @example

  local ondata = rx.stream()
  -- let's imagine that socket is something that receives data sometimes.
  socket.ondata = ondata

  rx.map(function (data)
    print(data)
  end, ondata)

]]

local rx = {}

local unpack = rawget(table, 'unpack') or unpack

function rx.stream (...)
  local values = {...}
  return function (...)
    if select('#', ...) == 0 then
      return unpack(values)
    else
      values = {...}
    end
  end
end

return rx
