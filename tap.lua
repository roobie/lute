local _module = {}

local inspect = require('inspect')
local fmt = require('fmt')
local printf = fmt.printf
local prototype = require('prototype')

local Test = prototype({
  name = function (self, aName)
    self._name = aName
  end;

  enter = function (self)
    print(('# %s'):format(self._name))
  end;

  exit = function (self)
    if self._expectedTestCount > 0 then
      if self._testCount ~= self._expectedTestCount then
        print(('not ok %d - expected %d tests'):format(self._testCount + 1, self._expectedTestCount))
      end
    end
  end;

  comment = function (self, message)
    print(string.format('# %s', message))
  end;

  plan = function (self, expectedTestCount)
    if self._expectedTestCount ~= 0 then
      -- TODO: cannot set this more than once
    end
    self._expectedTestCount = expectedTestCount
    print(('%d..%d'):format(1, self._expectedTestCount))
  end;

  check = function (self, args)
    self._testCount = self._testCount + 1
    if not args.assertion() then
      self._success = false
      printf('not ok %d %s', self._testCount, args.message)
      printf('  ---')
      args.printInfo()
      local tb = debug.traceback('', 2):sub(2)
      printf('  %s', tb)
      printf('  ---')
    else
      print(('ok %d'):format(self._testCount))
    end
  end;

  equal = function (self, actual, expected, message)
      self:check {
          message = message or 'should be equal';
          assertion = function ()
            return actual == expected
          end;
          printInfo = function ()
            printf('  operator: %s', 'equal')
            printf('  expected: %s', inspect(expected))
            printf('  actual  : %s', inspect(actual))
          end;
      }
  end;
})

function Test.new ()
  local instance = {
    _name = '(anonymous)';
    _testCount = 0;
    _expectedTestCount = 0;
    _success = true;
    _messages = {};
  }
  return Test(instance)
end

local TestHarness = prototype({
  addTest = function (self, testFunction)
    table.insert(self._tests, testFunction)
  end;
  run = function (self)
    print('TAP version 13')
    for n, testFunction in ipairs(self._tests) do
      local test = Test.new()
      test:enter()
      testFunction(test)
      test:exit()
    end
  end;
})

function _module.new (name)
  local instance = {
    _name = name;
    _tests = {}
  }

  return TestHarness(instance)
end

return _module
