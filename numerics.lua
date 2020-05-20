local numerics = {}

function numerics.gcd (m, n)
  while n ~= 0 do
    local q = m
    m = n
    n = q % n
  end

  return m
end

function numerics.lcm (m, n)
  return (m ~= 0 and n ~= 0) and m * n / numerics.gcd(m, n) or 0
end

return numerics
