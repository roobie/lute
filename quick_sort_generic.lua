--[[

  A generic quick sort implementation. It requires the collection passed in to
  be sequential and sortable. It sorts the collection in place.

  The required methods on the `collection` are:

  -- compute the length of the collection
  -- this does not use the #/__len meta event, because we are compatible with 5.1
  :length() -> number

  -- retrieve one element by its index
  :get(integer) -> element

  -- swap the elements that exist on the indices
  :swap(integer, integer) -> nil

]]

local function partition (collection, lo, hi, comparator)
  local pivot = collection:get(hi)
  local i = lo
  for j = i, hi do
    if comparator(collection:get(j), pivot) then
      collection:swap(i, j)
      i = i + 1
    end
  end
  collection:swap(i, hi)
  return i
end

local function qsort (collection, lo, hi, comparator)
  if lo < hi then
    local p = partition(collection, lo, hi, comparator)
    qsort(collection, lo, p - 1, comparator)
    qsort(collection, p + 1, hi, comparator)
  end
end

local function lessThan (a, b)
  return a < b
end

local function quickSort (collection, comparator)
  qsort(collection, 1, collection:length(), comparator or lessThan)
end

return quickSort
