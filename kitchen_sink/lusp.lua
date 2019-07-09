--[=[

  Lusp to Lua compiler

]=]

local function tokenize (input)
  local len = #input
  local top = {}

  local function ignore (char)
    return string.match(char, '%s')
  end

  for i = 1, len do
    local c = string.sub(input, i, i)
    if not ignore(c) then
    end
  end

end

-- source code at Lsrc should be pure Lusp code.
local function Lsrc (input)
  return tokenize(input)
end

-- source code resulting from Lout should be pure Lua(jit) code.
local function Lout (input)
  return input
end

local function pipe (value)
  return function (transforms)
    for i = 1, #transforms do
      value = transforms[i](value)
    end
    return value
  end
end

local function compile (source)
  return pipe(source) {
    Lsrc;
    Lout;
  }
end

local function interpret (source)
  return load(compile(source))
end

print(interpret('return print(1)')())
