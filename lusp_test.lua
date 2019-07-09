
local inspect = require('inspect')
local tap = require('tap') {name = 'lusp.lua'}

tap:addTest(
  'lusp',
  function (test)
    -- Lusp source code
    local source = [[
(define factorial
  (λ (n)
    (* n (factorial (- n 1)))))
(print (factorial 10))
]]
end)

return tap
