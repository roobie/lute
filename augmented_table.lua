
local prototype = require('prototype')
local quickSort = require('quick_sort')
local tables = require('tables')

local Atable = prototype {}

function Atable.merge (self, ...)
  return Atable(tables.merge(self, ...))
end

function Atable.map (self, transform)
  return Atable(tables.map(self, transform))
end

function Atable.imap (self, transform)
  return Atable(tables.imap(self, transform))
end

function Atable.reduce (self, reducer, init)
  return Atable(tables.reduce(self, reducer, init))
end

function Atable.qsort (self, comparator)
  quickSort(self, comparator)
end

return Atable
