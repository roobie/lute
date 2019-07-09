local _module = {}

local inspect = require('inspect')
local fmt = require('fmt')
local printf = fmt.printf
local prototype = require('prototype')

local Test = prototype({
  enter = function (self)
    printf('# %s', self._name)
  end;

  exit = function (self)
    if self._expectedTestCount > 0 then
      if self._testCount ~= self._expectedTestCount then
        printf('not ok %d - expected %d tests', self._testCount + 1, self._expectedTestCount)
      end
    else
      printf('1..%d', self._testCount)
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
    printf('%d..%d', 1, self._expectedTestCount)
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
      self._failCount = self._failCount + 1
    else
      printf('ok %d %s', self._testCount, args.message)
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

  isTrue = function (self, actual, message)
    self:check {
      message = message or 'should be true';
      assertion = function ()
        return actual == true
      end;
      printInfo = function ()
        printf('  operator: %s', 'isTrue')
        printf('  expected: %s', true)
        printf('  actual  : %s', inspect(actual))
      end;
    }
  end
})

function Test.new (name, testFunction)
  local instance = {
    _name = name;
    _testFunction = testFunction;
    _testCount = 0;
    _failCount = 0;
    _expectedTestCount = 0;
    _success = true;
    _messages = {};
  }
  return Test(instance)
end

local TestSuite = prototype({
  addTest = function (self, maybeName, testFunction)
    if testFunction == nil then
      testFunction = maybeName
      maybeName = '(anonymous)'
    end
    local test = Test.new(maybeName, testFunction)
    table.insert(self._tests, test)
  end;
  run = function (self)
    if self._name then
      printf('# Suite: %s', self._name)
    end
    for n, test in ipairs(self._tests) do
      test:enter()
      test._testFunction(test)
      test:exit()
    end
  end;
})

function _module.printHeader ()
  print('TAP version 13')
end

function _module.new (opts)
  opts = opts or {}
  local instance = {
    _name = opts.name;
    _tests = {};
  }

  return TestSuite(instance)
end

return _module
