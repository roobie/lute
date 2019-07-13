
local Tap = require('tap')
local printf = require('fmt').printf

Tap.printHeader()

local tests = {
  require('set_test');
  require('quick_sort_test');
  require('linked_list_test');
  require('doubly_linked_list_test');
  require('min_heap_test');
  require('strings_test');
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
}
for _, test in ipairs(tests) do
  test:run()
end

Tap.printFooter()
