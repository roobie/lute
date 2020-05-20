
local _2d = {}

local function _2d.bresenham(x1, y1, x2, y2, callback)
  local delta_x = x2 - x1
  local ix = delta_x > 0 and 1 or -1
  local delta_x = 2 * math.abs(delta_x)

  local delta_y = y2 - y1
  local iy = delta_y > 0 and 1 or -1
  local delta_y = 2 * math.abs(delta_y)

  callback(x1, y1)

  if delta_x >= delta_y then
    local err = delta_y - delta_x / 2

    while x1 ~= x2 do
      if (err > 0) or ((err == 0) and (ix > 0)) then
        err = err - delta_x
        y1 = y1 + iy
      end

      err = err + delta_y
      x1 = x1 + ix

      if callback(x1, y1) then
        break
      end
    end
  else
    local err = delta_x - delta_y / 2

    while y1 ~= y2 do
      if (err > 0) or ((err == 0) and (iy > 0)) then
        err = err - delta_y
        x1 = x1 + ix
      end

      err = err + delta_x
      y1 = y1 + iy

      if callback(x1, y1) then
        break
      end
    end
  end
end

return _2d
