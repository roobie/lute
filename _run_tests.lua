
local Tap = require('tap')
local printf = require('fmt').printf

Tap.printHeader()

local ok, err = pcall(function ()
    local tests = {
      require('set_test');
      require('quick_sort_test');
      require('linked_list_test');
      require('doubly_linked_list_test');
      require('min_heap_test');
      require('table_list_test');
      require('strings_test');
      require('func_test');
      require('collections_test');
      require('prototype_test');
      require('tables_test');
      require('curried_test');
      require('max_heap_test');
    }
end)

if not ok then
  printf('not ok %s', err)
end

Tap.printFooter()
