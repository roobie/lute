
local csvCtor = require('charsepval')
local Tap = require('tap')
local inspect = require('inspect')

local tap = Tap.new {name = 'charsepval.lua'}

tap:addTest(
  'csv1',
  function (test)
    local sep = ';'
    local nl = '_'
    local csv = csvCtor {separator=sep, newline=nl}

    local data = {
      {a=1,b=2};
      {a=3,b=4};
    }

    local headers = csv.keys(data[1])
    table.sort(headers)

    local out = csv.stringSink()

    csv.encodeHeaders(out, headers)
    test:equal(out.buffer, 'a;b_')

    csv.encodeTables(out, headers, data)
    test:equal(out.buffer, 'a;b_1;2_3;4')
end)

return tap
