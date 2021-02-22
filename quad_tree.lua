--[[

  https://en.wikipedia.org/wiki/Quadtree

]]

local prototype = require('prototype')
local tables = require('tables')

local Vector2 = prototype {x=0; y=0}

function Vector2.length (self)
  return self.x * math.cos(self.x) + self.y * math.sin(self.y)
end

function Vector2.normal (self)
  return Vector2 {
    math.cos(self.x);
    math.sin(self.y);
  }
end

function Vector2.__tostring (self)
  return string.format('[%d; %d]', self.x, self.y)
end


local Box = prototype {
  center = Vector2 {};
  halfDimension = 0.0;
}

function Box.new (init)
  return Box {
    center = Vector2(init.center);
    halfDimension = init.halfDimension
  }
end

function Box.corners (self)
  --[[
    1 +---+ 2
      |   |
    4 +---+ 3
  ]]
  return {
    Vector2 {self.center.x - self.halfDimension, self.center.y + self.halfDimension};
    Vector2 {self.center.x + self.halfDimension, self.center.y + self.halfDimension};
    Vector2 {self.center.x + self.halfDimension, self.center.y - self.halfDimension};
    Vector2 {self.center.x - self.halfDimension, self.center.y - self.halfDimension};
  }
end

function Box.contains (self, point)
  local x1, x2 = self.center.x - self.halfDimension, self.center.x + self.halfDimension
  local y1, y2 = self.center.y - self.halfDimension, self.center.y + self.halfDimension
  -- not sure if it should be <= or <
  return x1 <= point.x and point.x <= x2 and
    y1 <= point.y and point.y <= y2
end

function Box.intersects (self, box)
  local points = box:corners()
  return self:contains(points[1]) or
    self:contains(points[2]) or
    self:contains(points[3]) or
    self:contains(points[4])
end

local QTREE_CAPACITY = 4
local QTree = prototype {
  boundary = Box {};
  points = {};

  -- QTree references
  nw = nil;
  ne = nil;
  sw = nil;
  se = nil;
}

function QTree.new (boundary)
  return QTree {
    boundary = Box(boundary);
    points = {};
  }
end

function QTree.insert (self, point)
  point = Vector2(point)
  if not self.boundary:contains(point) then
    return false
  end

  if #self.points < QTREE_CAPACITY and self.nw == nil then
    self.points[#self.points + 1] = point
    return true
  end

  if self.nw == nil then
    self:subdivide()
  end

  if self.nw:insert(point) then return true end
  if self.ne:insert(point) then return true end
  if self.sw:insert(point) then return true end
  if self.se:insert(point) then return true end

  error('This should not occur')
end

function QTree.subdivide (self)
  local box = self.boundary
  local newDim = box.halfDimension / 2
  self.nw = QTree.new {
    center = {x=box.center.x - newDim; y=box.center.y + newDim};
    halfDimension = newDim;
  }
  self.ne = QTree.new {
    center = {x=box.center.x + newDim; y=box.center.y + newDim};
    halfDimension = newDim;
  }
  self.sw = QTree.new {
    center = {x=box.center.x - newDim; y=box.center.y - newDim};
    halfDimension = newDim;
  }
  self.se = QTree.new {
    center = {x=box.center.x + newDim; y=box.center.y - newDim};
    halfDimension = newDim;
  }
end

function QTree.hasChildren (self)
  return self.nw ~= nil
end

function QTree.queryRange (self, range)
  range = Box(range)
  local results = {}
  if not self.boundary:intersects(range) then
    return results
  end

  for _, p in ipairs(self.points) do
    if range:contains(p) then
      results[#results + 1] = p
    end
  end

  if not self:hasChildren() then
    return results
  end


  return tables.concat(
    results,
    self.nw:queryRange(range),
    self.ne:queryRange(range),
    self.sw:queryRange(range),
    self.se:queryRange(range)
  )
end

local function dump (tree, name, depth)
  depth = depth or 0
  name = name or ''
  local s = string.rep('\t', depth)..name..':QTree('
  for i, p in ipairs(tree.points) do
    if i > 1 then
      s = s..', '
    end
    s = s..tostring(p)
  end
  local hasChildren = false
  local function str (name1, t)
    if t ~= nil then
      hasChildren = true
      s = s..'\n'..dump(t, name1, depth + 1)
    end
  end
  str('nw', tree.nw)
  str('ne', tree.ne)
  str('sw', tree.sw)
  str('se', tree.se)
  if hasChildren then
    s = s..string.format('\n%s)', string.rep('\t', depth))
  else
    s = s..')'
  end

  return s
end

function QTree.__tostring (self)
  return dump(self, nil, 0)
end

return QTree
