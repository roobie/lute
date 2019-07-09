local _module = {}

function _module.printf (fmt, ...)
  print(string.format(fmt, ...))
end

function _module.writef (fmt, ...)
  io.write(string.format(fmt, ...))
end

function _module.fprintf (fd, fmt, ...)
  fd:write(string.format(fmt, ...))
end

return _module
