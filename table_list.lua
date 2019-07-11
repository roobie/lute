--[[



]]

local prototype = require('prototype')

local quickSort = require('quick_sort_generic')

local List

List = prototype {}

function List.__tostring (self)
  if self:isEmpty() then
    return 'List()'
  end

  local s = 'List('
  for i, v in self:iter() do
    s = s..tostring(v)..', '
  end

  return s:sub(1, -3)..')'
end

function List.insert (self, index, element)
  table.insert(self, index, element)
end

function List.prepend (self, element)
  table.insert(self, 1, element)
end

function List.removeAt (self, index)
  table.remove(self, index)
end

function List.shift (self)
  return table.remove(self, 1)
end

function List.iter (self)
  return ipairs(self)
end

function List.length (self)
  return #self
end

function List.isEmpty (self)
  return #self == 0
end

function List.append (self, element)
  self[#self + 1] = element
end

function List.pop (self)
  return table.remove(self, #self)
end

function List.map (self, transform)
  if self:isEmpty() then
    return List.new()
  end

  local result = List.new()
  for i, e in self:iter() do
    result:append(transform(e, i))
  end

  return result
end

function List.swap (self, i1, i2)
  local temp = self[i1]
  self[i1] = self[i2]
  self[i2] = temp
end

function List.sortInPlace (self, comparator)
  quickSort(self)
end

function List.cons (element, list)
  local result = List.new {element}
  if list == nil then
    return result
  end

  for i, e in list:iter() do
    result:append(e)
  end

  return result
end

function List.get (self, index)
  return self[index]
end

function List.skip (self, count)
  local result = List.new()
  local min = self:length(), count + 1
  for i = count + 1, #self do
    result:append(self[i])
  end

  return result
end

function List.first (self)
  return self:get(1)
end

function List.last (self)
  return self:get(#self)
end

List.__index = function (self, key)
  if type(key) == 'number' then
    return self:get(key)
  else
    return List[key]
  end
end

function List.new (elements)
  local result = List { }

  if type(elements) == 'table' then
    for i, e in ipairs(elements) do
      result:append(e)
    end
  end

  return result
end

return List
