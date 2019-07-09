
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
