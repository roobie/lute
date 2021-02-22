local inspect = require('inspect') -- TODO: add dump and printfInspect

local fmt = {}

local metatable = {
  --- Allows `fmt` to be called, and if so works as string.format
  __call = function (_, ...)
    return string.format(...)
  end;
}

setmetatable(fmt, metatable)

function fmt.printf (format, ...)
  print(string.format(format, ...))
end

function fmt.writef (format, ...)
  io.write(string.format(format, ...))
end

function fmt.fprintf (fd, format, ...)
  fd:write(string.format(format, ...))
end

function fmt.dump (object)
  print(inspect(object))
end

return fmt
