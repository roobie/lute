local fmt = {}

function fmt.printf (fmt, ...)
  print(string.format(fmt, ...))
end

function fmt.writef (fmt, ...)
  io.write(string.format(fmt, ...))
end

function fmt.fprintf (fd, fmt, ...)
  fd:write(string.format(fmt, ...))
end

return fmt
