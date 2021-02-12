
local inspect = require('inspect')
local fmt = require('fmt')
local tap = require('tap').new {name = 'rx.lua'}
local rx = require('kitchen_sink.rx')

tap:addTest(
  'rx',
  function (test)
    if false then
      local function emitter (fn)
        local obj = {counter = 0; callback = fn}
        function obj.trigger (self)
          self.counter = self.counter + 1
          self.callback(self.counter)
        end
        return obj
      end
      local stream = rx.stream(1)
      test:equal(stream(), 1)
      local e = emitter(stream)
      e:trigger()
    end
end)

return tap
