local _module = {}

local inspect = require('inspect')
local fmt = require('fmt')
local printf = fmt.printf
local prototype = require('prototype')
local StopWatch = require('stopwatch')

local sw = StopWatch.new()
local totalTestCount = 0
local totalPassCount = 0
local totalFailCount = 0

local Test = prototype({
  enter = function (self, suiteName)
    printf('# %s%s', string.format('%s: ', suiteName) or ' ', self._name)
    sw:reset()
  end;

  exit = function (self)
    if self._expectedTestCount > 0 then
      if self._testCount ~= self._expectedTestCount then
        printf('not ok %d - expected %d tests', self._testCount + 1, self._expectedTestCount)
      end
    end
    printf('# Time elapsed: %f ms', sw:millis())
  end;

  comment = function (self, message)
    print(string.format('# %s', message))
  end;

  plan = function (self, expectedTestCount)
    if self._expectedTestCount ~= 0 then
      -- TODO: cannot set this more than once
    end
    self._expectedTestCount = expectedTestCount
    -- printf('%d..%d', 1, self._expectedTestCount)
  end;

  check = function (self, args)
    self._testCount = self._testCount + 1
    totalTestCount = totalTestCount + 1
    if not args.assertion() then
      totalFailCount = totalFailCount + 1
      self._success = false
      printf('not ok %d %s', self._testCount, args.message)
      printf('  ---')
      args.printInfo()
      local tb = debug.traceback('', 2):sub(2)
      printf('  %s', tb)
      printf('  ...')
      self._failCount = self._failCount + 1
    else
      totalPassCount = totalPassCount + 1
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
  end;

  isFalse = function (self, actual, message)
    self:check {
      message = message or 'should be false';
      assertion = function ()
        return actual == false
      end;
      printInfo = function ()
        printf('  operator: %s', 'isFalse')
        printf('  expected: %s', false)
        printf('  actual  : %s', inspect(actual))
      end;
    }
  end;

  isNil = function (self, actual, message)
    self:check {
      message = message or 'should be nil';
      assertion = function ()
        return actual == nil
      end;
      printInfo = function ()
        printf('  operator: %s', 'isNil')
        printf('  expected: %s', 'nil')
        printf('  actual  : %s', inspect(actual))
      end;
    }
  end;

  isGt = function (self, actual, expected, message)
    self:check {
      message = message or 'should be greater than';
      assertion = function ()
        return actual > expected
      end;
      printInfo = function ()
        printf('  operator: %s', 'isGt')
        printf('  expected: %s', inspect(expected))
        printf('  actual  : %s', inspect(actual))
      end;
    }
  end;

  isLt = function (self, actual, expected, message)
    self:check {
      message = message or 'should be less than';
      assertion = function ()
        return actual < expected
      end;
      printInfo = function ()
        printf('  operator: %s', 'isLt')
        printf('  expected: %s', inspect(expected))
        printf('  actual  : %s', inspect(actual))
      end;
    }
  end;

  isGte = function (self, actual, expected, message)
    self:check {
      message = message or 'should be greater than or equal';
      assertion = function ()
        return actual >= expected
      end;
      printInfo = function ()
        printf('  operator: %s', 'isGte')
        printf('  expected: %s', inspect(expected))
        printf('  actual  : %s', inspect(actual))
      end;
    }
  end;

  isLte = function (self, actual, expected, message)
    self:check {
      message = message or 'should be less than or equal';
      assertion = function ()
        return actual <= expected
      end;
      printInfo = function ()
        printf('  operator: %s', 'isLte')
        printf('  expected: %s', inspect(expected))
        printf('  actual  : %s', inspect(actual))
      end;
    }
  end;
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
      --printf('# Suite: %s', self._name)
    end
    for n, test in ipairs(self._tests) do
      test:enter(self._name)
      ok = xpcall(
        function ()
          test._testFunction(test)
        end, function (err)
          printf('not ok (error occured) %s', err)
          printf('  ---')
          printf('  %s', debug.traceback())
          printf('  ...')
          totalFailCount = totalFailCount + 1
      end)
      test:exit()
    end
  end;
})

function _module.printHeader ()
  print('TAP version 13')
end
function _module.printFooter ()
  printf('1..%d', totalTestCount)
  printf('# tests %d', totalTestCount)
  printf('# pass %d', totalPassCount)
  printf('# fail %d', totalFailCount)
  printf('')
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
