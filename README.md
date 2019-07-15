# lute

> A Lua library that tries to fill the gaps.

Some items here are from other repos - will make them submodules or something in
the future.

# General usage and information

This library is intended to be used as a git submodule, so when using it in your projects you would go to your source folder and invoke git somewhat like this:

`git submodule add https://github.com/roobie/lute lute`

and then

`git submodule --init --recursive`

which will then allow you to

`local MOD = require('lute.MOD')`

In general, the modules follow the basic structure that they:

1. Always return a `table`
2. Allows for easy monkey-patching
3. Allows for extending, from the class/prototype inheritance perspective.

# Naming and structure

Modules filenames are `snake_case` because some OS use case-insensitive file
system. The purpose being that the names should be readable. However symbol
names in source code use `PascalCase` and `camelCase` such that prototype
constructors use `PascalCase` and methods and variables use `camelCase`. It is
not yet determined whether the package should alias all methods so that the
consumer can choose between using `camelCase`, `luacase` and `snake_case` naming
conventions.

# Source code

## Programming style

* Use `local` whenever possible. Avoid globals. Use modules
* function definitions should have a space between the function name and the
  start of the parameter list, e.g.

```
local function addOne (n) ...
---------------------^-here
```

* put all `require`s at the top of the file.

* avoid aliasing table values as local values (if not strictly necessary), e.g.

```
local unpack = table.unpack or unpack -- OK

-- avoid:
local mod = require(...)
local a = mod.a
local b = mod.b
```

* large modules are not a problem (i.e. SLoC per module is not an important
  metric)
  
* parameter names (especially in public functions) should have descriptive
  names. The code is not faster because symbols are short and hard to decipher.
  
* source code should be formatted and easier to read than to write.



# Reference

## The `prototype` module
