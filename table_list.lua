--[[

  This is a List type implemented using "arrays" in the form of tables.

  Insertion and deletion of elements in all but the end are not fast.

]]

local prototype = require('prototype')
local tables = require('tables')
local func = require('func')

local quickSort = require('quick_sort_generic')

local List

List = prototype {}

function List.__tostring (self)
  if self:isEmpty() then
    return 'List()'
  end

  local s = 'List('
  for i, v in self:iter() do
    s = s..tostring(v)
    if i ~= #self then
      s = s..', '
    end
  end

  return s..')'
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
  return List(tables.map(self, transform))
end

function List.swap (self, i1, i2)
  local temp = self[i1]
  self[i1] = self[i2]
  self[i2] = temp
end

-- function List.slice (self, start, end) ... end

function List.clone (self)
  local newList = List.new()
  for _, e in self:iter() do
    newList:append(e)
  end
  return newList
end

function List.sortInPlace (self, comparator)
  quickSort(self, comparator)
end

-- insertion sort. I think this is a stable sort, but I gotta analyse it more.
-- could have been implemented via:
-- local l = self:clone()
-- l:sortInPlace()
-- return l
function List.sort (self, comparator)
  comparator = comparator or func.lt
  local l = List.new()
  for _, e in self:iter() do
    if #l == 0 then
      l[1] = e
    else
      local handled = false
      for i, e2 in l:iter() do
        if comparator(e, e2) then
          l:insert(i, e)
          handled = true
          break
        end
      end
      if not handled then
        l:append(e)
      end
    end
  end

  return l
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

-- TODO: consider a generator instead
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

function List.__concat (self, other)
  return List(tables.concat(self, other))
end

-- O(n) time complexity
function List.contains (self, element)
  for _, e in self:iter() do
    if e == element then
      return true
    end
  end

  return false
end

function List.__div (self, other)
  other = List(other)
  local result = List.new()
  for i, v in ipairs(self) do
    if not other:contains(v) then
      result:append(v)
    end
  end

  return result
end

List.__index = function (self, key)
  if type(key) == 'number' then
    return self:get(key)
  else
    return List[key]
  end
end

function List.__newindex (self, key, element)
  if type(key) == 'number' and 1 <= key and key <= (#self + 1) then
    rawset(self, key, element)
  else
    error('Invalid index')
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
