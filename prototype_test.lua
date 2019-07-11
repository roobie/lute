local prototype = require('prototype')

local Tap = require('tap')

local tap = Tap.new {name='prototype.lua'}

tap:addTest(
  'isa',
  function (test)
    local T1 = prototype {}
    local t1 = T1 {}
    test:isTrue(t1:isa(T1), 'isa should say yes')
end)

tap:addTest(
  'reuse prototype',
  function (test)
    local Type = prototype {
      methodA = function (self)
        return 1
      end;
      methodB = function (self)
        return 1
      end;
    }
    local SubType = prototype {
      Type;
      {
        methodA = function (self)
          return 2
        end;
        methodC = function (self)
          return 2
        end;
      }
    }
    local instance = SubType {}
    test:isTrue(instance:isa(Type), 'isa should say yes')
    test:isTrue(instance:isa(SubType), 'isa should say yes')
    test:equal(instance:methodA(), 2)
    test:equal(instance:methodB(), 1)
    test:equal(instance:methodC(), 2)

    local SubSubType = prototype {
      SubType;
      {
        methodD = function ()
          return 3
        end;
      }
    }
    instance = SubSubType {}
    test:isTrue(instance:isa(Type), 'isa should say yes')
    test:isTrue(instance:isa(SubType), 'isa should say yes')
    test:isTrue(instance:isa(SubSubType), 'isa should say yes')
    test:equal(instance:methodB(), 1)
    test:equal(instance:methodC(), 2)
    test:equal(instance:methodD(), 3)

    local Type2 = prototype {}
    instance = Type2 {}
    test:isFalse(instance:isa(Type))
end)

tap:run()
