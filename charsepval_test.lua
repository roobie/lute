
local csvCtor = require('charsepval')
local Tap = require('tap')
local inspect = require('inspect')

local tap = Tap.new {name = 'tables.lua'}

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

    local out = {
      val = '';
      write = function (self, data)
        self.val = self.val .. data
      end;
    }

    csv.encodeHeaders(out, headers)
    test:equal(out.val, 'a;b_')

    csv.encodeTables(out, headers, data)
    test:equal(out.val, 'a;b_1;2_3;4')
end)

return tap
