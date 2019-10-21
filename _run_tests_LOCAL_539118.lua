-- we do this so that the require path for modules in this package is always
-- 'lute.xyz'. So when require'ing modules from other modules in this package,
-- you type `require('lute.xyz')`. But when running tests, since we are running
-- them inside here, we drop the `lute` prefix.
table.insert(
  package.loaders,
  function (moduleName)
    local transformations = {
      function (name) return string.gsub(name, '^lute', '') end;
      function (name) return string.gsub(name, '^win32', 'lj2win32.win32') end;
      function (name) return string.gsub(name, '^syscall', 'ljsyscall.syscall') end;
    }
    local n = moduleName
    for _, t in ipairs(transformations) do
      n = t(n)
    end
    return function ()
      return require(n)
    end
end)

local Tap = require('tap')
local printf = require('fmt').printf
local StopWatch = require('stopwatch')

local args = ...

Tap.printHeader()

local tests = {
  require('quick_sort_test');
  require('linked_list_test');
  require('doubly_linked_list_test');
  require('min_heap_test');
  require('func_test');
  require('collections_test');
  require('tables_test');
  require('curried_test');
  require('max_heap_test');
  require('prototype_test');
  require('randy_test');
  require('table_list_test');
  require('quad_tree_test');
  require('avl_tree_test');
  require('queue_test');
  require('stack_test');
  require('set_test');
  require('flags_test');
  require('linalg');
  require('interop_rg_test');
  require('rx_test');
  require('strings_test');
  require('pubsub_test');
}

local sw = StopWatch.new()
for _, test in ipairs(tests) do
  test:run()
end
printf('# Time spent on tests: %s ms', tostring(sw:millis()))

Tap.printFooter()
