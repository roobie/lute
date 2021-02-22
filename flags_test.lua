
local Flags = require('lute.flags')
local Bits = Flags.Bits
local tap = require('tap').new {name='flags.lua'}

local fmt = require('fmt')

tap:addTest(
  'flags',
  function (test)
    local fsPerm = Flags.new {
      execute = 1;
      write = 2;
      read = 4;
    }

    local fp1 = fsPerm('execute', 'read')

    local hasAccess = fp1:has(fsPerm.execute)
    test:isTrue(hasAccess)
    test:isTrue(fp1:has(fsPerm.execute))
    test:isFalse(fp1:has(fsPerm.write))
    -- print(hasAccess)
    -- print(fp1:has(fsPerm.write))

    fmt.printf('# %s', Bits.new(0xab41))
    fmt.printf('# %s', #tostring(Bits.new(0xab41)))

    -- local sw = StopWatch.new()
    -- for i = 1, 100 do
    --   fmt.printf('# %s', Bits.new(math.floor(math.random() * 0xffffffff)))
    -- end
    -- fmt.printf('# => Time taken: %f ms', sw:millis())
end)

return tap
