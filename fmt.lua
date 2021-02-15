local inspect = require('inspect') -- TODO: add dump and printfInspect

local fmt = {}

local metatable = {
  --- Allows `fmt` to be called, and if so works as string.format
  __call = function (self, ...)
    return string.format(...)
  end;
}

setmetatable(fmt, metatable)

function fmt.printf (fmt, ...)
  print(string.format(fmt, ...))
end

function fmt.writef (fmt, ...)
  io.write(string.format(fmt, ...))
end

function fmt.fprintf (fd, fmt, ...)
  fd:write(string.format(fmt, ...))
end

function fmt.dump (object)
  print(inspect(object))
end

return fmt
