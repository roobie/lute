local utils = {}

function utils.getInputText (fileName)
  local fd = io.open(fileName)
  local text = fd:read('*a')
  fd:close()
  return text
end

function utils.getInputLines (fileName, transformLine)
  local lines = {}
  for line in io.lines(fileName) do
    if type(transformLine) == 'function' then
      lines[#lines+1] = transformLine(line)
    else
      lines[#lines+1] = line
    end
  end

  return lines
end

return utils
