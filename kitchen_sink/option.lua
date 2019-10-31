
local option = {}
option.__index = option


--- option a' -> bool
function option.hasValue (opt)
  return opt.isSome
end


--- option a' -> (a' -> b') -> option b'
function option.map (opt, fn)
  if opt:hasValue() then
    return option.Some(fn(opt._value))
  end

  return opt
end


--- option a' -> (a' -> option b') -> option b'
function option.flatMap (opt, fn)
  if opt:hasValue() then
    return fn(opt._value)
  end

  return opt
end


--- option a' -> a' -> a'
function option.unwrap (opt, default)
  if opt:hasValue() then
    return opt._value
  end

  return default
end


option.None = setmetatable({
  _type='Option.None';
  isSome = false;
}, option)


function option.Some (v)
  return setmetatable({
    _type='Option.Some';
    _value = v;
    isSome = true;
  }, option)
end


do
  local function inc (n)
    return n + 1
  end
  local o = option.Some(1)
  print(o:hasValue())
  print(o:map(inc):unwrap(-1))
  print(option.None:map(inc):unwrap(-1))

  local function incIfEven (n)
    if n % 2 == 0 then
      return option.Some(n + 1)
    end
    return option.None
  end
  print(o:flatMap(incIfEven):unwrap(-1))
  print(o:map(inc):flatMap(incIfEven):unwrap(-1))
end


return option
