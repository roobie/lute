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
