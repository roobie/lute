local ffi = require('ffi')

local function array (typ, len)

  ffi.cdef(string.format(
             'typedef struct { [%d]%s y; } dynarr_t;'
  len, typ))

  local arr
  local arr_mt = {
  }
  arr = ffi.metatype('dynarr_t', arr_mt)
  return arr
end

require('_test_prelude')
local tap = require('tap').new {name='zbarray'}
tap:addTest(
  'Basics',
  function (test)
    array()
end)
