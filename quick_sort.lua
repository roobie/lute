local function swap (tbl, i1, i2)
  local temp = tbl[i1]
  tbl[i1] = tbl[i2]
  tbl[i2] = temp
end

local function partition (tbl, lo, hi, comparator)
  local pivot = tbl[hi]
  local i = lo
  for j = i, hi do
    if comparator(tbl[j], pivot) then
      swap(tbl, i, j)
      i = i + 1
    end
  end
  swap(tbl, i, hi)
  return i
end

local function qsort (tbl, lo, hi, comparator)
  if lo < hi then
    local p = partition(tbl, lo, hi, comparator)
    qsort(tbl, lo, p - 1, comparator)
    qsort(tbl, p + 1, hi, comparator)
  end
end

local function lessThan (a, b)
  return a < b
end

local function quickSort (tbl, comparator)
  qsort(tbl, 1, #tbl, comparator or lessThan)
end

return quickSort
