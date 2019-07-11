local tables = require('tables')

local curried = {}

-- ((a, b) -> a) -> a -> Listof b -> a
function curried.reduce (fn)
  return function (init)
    return function (tbl)
      return tables.reduce(tbl, fn, init)
    end
  end
end

-- (a -> b) -> Listof a -> Listof b
function curried.imap (fn)
  return function (tbl)
    return tables.imap(tbl, fn)
  end
end

-- (a -> boolean) -> Listof a -> Listof a
function curried.ifilter (fn)
  return function (tbl)
    return tables.ifilter(tbl, fn)
  end
end

return curried
