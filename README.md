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

* large modules are not a problem (i.e. SLoC per module is not an important
  metric)
  
* parameter names (especially in public functions) should have descriptive
  names. The code is not faster because symbols are short and hard to decipher.



# Reference

## The `prototype` module
