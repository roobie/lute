
local Tap = require('tap')
local printf = require('fmt').printf

Tap.printHeader()

-- we do this so that the require path for modules in this package is always
-- 'lute.xyz'. So when require'ing modules from other modules in this package,
-- you type `require('lute.xyz')`. But when running tests, since we are running
-- them inside here, we drop the `lute` prefix.
table.insert(
  package.loaders,
  function (moduleName)
    local n = moduleName:gsub('^lute', '')
    return function ()
      return require(n)
    end
end)

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
  require('pubsub_test');
  require('queue_test');
  require('stack_test');
}
for _, test in ipairs(tests) do
  test:run()
end

Tap.printFooter()
