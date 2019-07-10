local prototype = require('prototype')

local Set
Set = prototype {
  _size = 0;

  __tostring = function (self)
    local contents = ''
    for k in self:iter() do
      contents = contents..tostring(k)..', '
    end
    contents = contents:sub(1, -3)
    return string.format('Set(%s)', contents)
  end;

  add = function (self, element)
    if self._data[element] == nil then
      self._data[element] = true
      self._size = self._size + 1
    end
    return self
  end;

  remove = function (self, element)
    if self._data[element] == true then
      self._data[element] = nil
      self._size = self._size - 1
      return self, element
    end
    return self, nil
  end;

  has = function (self, element)
    return self._data[element] == true
  end;

  union = function (self, other)
    local result = Set.new()
    for k in self:iter() do
      result:add(k)
    end
    for k in other:iter() do
      result:add(k)
    end

    return result
  end;

  difference = function (self, other)
    local result = Set.new()
    for k in self:iter() do
      result:add(k)
    end
    for k in other:iter() do
      if not self:has(k) then
        result:add(k)
      end
    end

    return result
  end;

  intersect = function (self, other)
    local result = Set.new()
    for k in self:iter() do
      if other:has(k) then
        result:add(k)
      end
    end

    return result
  end;

  iter = function (self)
    return pairs(self._data)
  end;

  size = function (self)
    return self._size
  end;
}

function Set.new (elements)
  local instance = Set {
    _size = 0;
    _data = {};
  }

  for _, v in ipairs(elements or {}) do
    instance:add(v)
  end

  return instance
end

return Set
