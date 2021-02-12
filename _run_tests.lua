
require('_test_prelude')
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
  require('collections_test');
  require('tables_test');
  require('curried_test');
  require('max_heap_test');
  require('prototype_test');
  require('table_list_test');
  require('quad_tree_test');
  require('queue_test');
  require('stack_test');
  require('set_test');
  require('flags_test');
  require('rx_test');
  require('pubsub_test');
  require('func_test');
  require('randy_test');
  require('avl_tree_test');
  require('linalg_test');
  require('charsepval_test');
  require('interop_rg_test');
  require('strings_test');
}

local sw = StopWatch.new()
for _, test in ipairs(tests) do
  test:run()
end
printf('# Time spent on tests: %s ms', tostring(sw:millis()))

Tap.printFooter()
