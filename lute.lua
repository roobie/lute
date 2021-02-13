---! Built from commit hash: ecd66da85ceeed4f71ee6172e07e9b86e47a27ea

local export = {
--- The license defined here might be overridden in each underlying module.
--- Please refer to each module to see whether that is the case.

  _VERSION = 'v1.0.0',
  _DESCRIPTION = 'A Lua library that tries to fill the gaps',
  _URL = 'https://github.com/roobie/lute',
  _LICENSE = [[
                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/

   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

   1. Definitions.

      "License" shall mean the terms and conditions for use, reproduction,
      and distribution as defined by Sections 1 through 9 of this document.

      "Licensor" shall mean the copyright owner or entity authorized by
      the copyright owner that is granting the License.

      "Legal Entity" shall mean the union of the acting entity and all
      other entities that control, are controlled by, or are under common
      control with that entity. For the purposes of this definition,
      "control" means (i) the power, direct or indirect, to cause the
      direction or management of such entity, whether by contract or
      otherwise, or (ii) ownership of fifty percent (50%) or more of the
      outstanding shares, or (iii) beneficial ownership of such entity.

      "You" (or "Your") shall mean an individual or Legal Entity
      exercising permissions granted by this License.

      "Source" form shall mean the preferred form for making modifications,
      including but not limited to software source code, documentation
      source, and configuration files.

      "Object" form shall mean any form resulting from mechanical
      transformation or translation of a Source form, including but
      not limited to compiled object code, generated documentation,
      and conversions to other media types.

      "Work" shall mean the work of authorship, whether in Source or
      Object form, made available under the License, as indicated by a
      copyright notice that is included in or attached to the work
      (an example is provided in the Appendix below).

      "Derivative Works" shall mean any work, whether in Source or Object
      form, that is based on (or derived from) the Work and for which the
      editorial revisions, annotations, elaborations, or other modifications
      represent, as a whole, an original work of authorship. For the purposes
      of this License, Derivative Works shall not include works that remain
      separable from, or merely link (or bind by name) to the interfaces of,
      the Work and Derivative Works thereof.

      "Contribution" shall mean any work of authorship, including
      the original version of the Work and any modifications or additions
      to that Work or Derivative Works thereof, that is intentionally
      submitted to Licensor for inclusion in the Work by the copyright owner
      or by an individual or Legal Entity authorized to submit on behalf of
      the copyright owner. For the purposes of this definition, "submitted"
      means any form of electronic, verbal, or written communication sent
      to the Licensor or its representatives, including but not limited to
      communication on electronic mailing lists, source code control systems,
      and issue tracking systems that are managed by, or on behalf of, the
      Licensor for the purpose of discussing and improving the Work, but
      excluding communication that is conspicuously marked or otherwise
      designated in writing by the copyright owner as "Not a Contribution."

      "Contributor" shall mean Licensor and any individual or Legal Entity
      on behalf of whom a Contribution has been received by Licensor and
      subsequently incorporated within the Work.

   2. Grant of Copyright License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      copyright license to reproduce, prepare Derivative Works of,
      publicly display, publicly perform, sublicense, and distribute the
      Work and such Derivative Works in Source or Object form.

   3. Grant of Patent License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      (except as stated in this section) patent license to make, have made,
      use, offer to sell, sell, import, and otherwise transfer the Work,
      where such license applies only to those patent claims licensable
      by such Contributor that are necessarily infringed by their
      Contribution(s) alone or by combination of their Contribution(s)
      with the Work to which such Contribution(s) was submitted. If You
      institute patent litigation against any entity (including a
      cross-claim or counterclaim in a lawsuit) alleging that the Work
      or a Contribution incorporated within the Work constitutes direct
      or contributory patent infringement, then any patent licenses
      granted to You under this License for that Work shall terminate
      as of the date such litigation is filed.

   4. Redistribution. You may reproduce and distribute copies of the
      Work or Derivative Works thereof in any medium, with or without
      modifications, and in Source or Object form, provided that You
      meet the following conditions:

      (a) You must give any other recipients of the Work or
          Derivative Works a copy of this License; and

      (b) You must cause any modified files to carry prominent notices
          stating that You changed the files; and

      (c) You must retain, in the Source form of any Derivative Works
          that You distribute, all copyright, patent, trademark, and
          attribution notices from the Source form of the Work,
          excluding those notices that do not pertain to any part of
          the Derivative Works; and

      (d) If the Work includes a "NOTICE" text file as part of its
          distribution, then any Derivative Works that You distribute must
          include a readable copy of the attribution notices contained
          within such NOTICE file, excluding those notices that do not
          pertain to any part of the Derivative Works, in at least one
          of the following places: within a NOTICE text file distributed
          as part of the Derivative Works; within the Source form or
          documentation, if provided along with the Derivative Works; or,
          within a display generated by the Derivative Works, if and
          wherever such third-party notices normally appear. The contents
          of the NOTICE file are for informational purposes only and
          do not modify the License. You may add Your own attribution
          notices within Derivative Works that You distribute, alongside
          or as an addendum to the NOTICE text from the Work, provided
          that such additional attribution notices cannot be construed
          as modifying the License.

      You may add Your own copyright statement to Your modifications and
      may provide additional or different license terms and conditions
      for use, reproduction, or distribution of Your modifications, or
      for any such Derivative Works as a whole, provided Your use,
      reproduction, and distribution of the Work otherwise complies with
      the conditions stated in this License.

   5. Submission of Contributions. Unless You explicitly state otherwise,
      any Contribution intentionally submitted for inclusion in the Work
      by You to the Licensor shall be under the terms and conditions of
      this License, without any additional terms or conditions.
      Notwithstanding the above, nothing herein shall supersede or modify
      the terms of any separate license agreement you may have executed
      with Licensor regarding such Contributions.

   6. Trademarks. This License does not grant permission to use the trade
      names, trademarks, service marks, or product names of the Licensor,
      except as required for reasonable and customary use in describing the
      origin of the Work and reproducing the content of the NOTICE file.

   7. Disclaimer of Warranty. Unless required by applicable law or
      agreed to in writing, Licensor provides the Work (and each
      Contributor provides its Contributions) on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
      implied, including, without limitation, any warranties or conditions
      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
      PARTICULAR PURPOSE. You are solely responsible for determining the
      appropriateness of using or redistributing the Work and assume any
      risks associated with Your exercise of permissions under this License.

   8. Limitation of Liability. In no event and under no legal theory,
      whether in tort (including negligence), contract, or otherwise,
      unless required by applicable law (such as deliberate and grossly
      negligent acts) or agreed to in writing, shall any Contributor be
      liable to You for damages, including any direct, indirect, special,
      incidental, or consequential damages of any character arising as a
      result of this License or out of the use or inability to use the
      Work (including but not limited to damages for loss of goodwill,
      work stoppage, computer failure or malfunction, or any and all
      other commercial damages or losses), even if such Contributor
      has been advised of the possibility of such damages.

   9. Accepting Warranty or Additional Liability. While redistributing
      the Work or Derivative Works thereof, You may choose to offer,
      and charge a fee for, acceptance of support, warranty, indemnity,
      or other liability obligations and/or rights consistent with this
      License. However, in accepting such obligations, You may act only
      on Your own behalf and on Your sole responsibility, not on behalf
      of any other Contributor, and only if You agree to indemnify,
      defend, and hold each Contributor harmless for any liability
      incurred by, or claims asserted against, such Contributor by reason
      of your accepting any such warranty or additional liability.

   END OF TERMS AND CONDITIONS

   APPENDIX: How to apply the Apache License to your work.

      To apply the Apache License to your work, attach the following
      boilerplate notice, with the fields enclosed by brackets "[]"
      replaced with your own identifying information. (Don't include
      the brackets!)  The text should be enclosed in the appropriate
      comment syntax for the file format. We also recommend that a
      file or class name and description of purpose be included on the
      same "printed page" as the copyright notice for easier
      identification within third-party archives.

   Copyright [yyyy] [name of copyright owner]

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
  ]]

}

--- internal require, to accomodate interdependencies even when concat'd
local function require (name)
  if export[name] then
    return export[name]
  else
    return _G.require(name)
  end
end


--- BEGIN inspect.lua
export.inspect = (function ()
local inspect ={
  _VERSION = 'inspect.lua 3.1.0',
  _URL     = 'http://github.com/kikito/inspect.lua',
  _DESCRIPTION = 'human-readable representations of tables',
  _LICENSE = [[
    MIT LICENSE

    Copyright (c) 2013 Enrique García Cota

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ]]
}

local tostring = tostring

inspect.KEY       = setmetatable({}, {__tostring = function() return 'inspect.KEY' end})
inspect.METATABLE = setmetatable({}, {__tostring = function() return 'inspect.METATABLE' end})

local function rawpairs(t)
  return next, t, nil
end

-- Apostrophizes the string if it has quotes, but not aphostrophes
-- Otherwise, it returns a regular quoted string
local function smartQuote(str)
  if str:match('"') and not str:match("'") then
    return "'" .. str .. "'"
  end
  return '"' .. str:gsub('"', '\\"') .. '"'
end

-- \a => '\\a', \0 => '\\0', 31 => '\31'
local shortControlCharEscapes = {
  ["\a"] = "\\a",  ["\b"] = "\\b", ["\f"] = "\\f", ["\n"] = "\\n",
  ["\r"] = "\\r",  ["\t"] = "\\t", ["\v"] = "\\v"
}
local longControlCharEscapes = {} -- \a => nil, \0 => \000, 31 => \031
for i=0, 31 do
  local ch = string.char(i)
  if not shortControlCharEscapes[ch] then
    shortControlCharEscapes[ch] = "\\"..i
    longControlCharEscapes[ch]  = string.format("\\%03d", i)
  end
end

local function escape(str)
  return (str:gsub("\\", "\\\\")
             :gsub("(%c)%f[0-9]", longControlCharEscapes)
             :gsub("%c", shortControlCharEscapes))
end

local function isIdentifier(str)
  return type(str) == 'string' and str:match( "^[_%a][_%a%d]*$" )
end

local function isSequenceKey(k, sequenceLength)
  return type(k) == 'number'
     and 1 <= k
     and k <= sequenceLength
     and math.floor(k) == k
end

local defaultTypeOrders = {
  ['number']   = 1, ['boolean']  = 2, ['string'] = 3, ['table'] = 4,
  ['function'] = 5, ['userdata'] = 6, ['thread'] = 7
}

local function sortKeys(a, b)
  local ta, tb = type(a), type(b)

  -- strings and numbers are sorted numerically/alphabetically
  if ta == tb and (ta == 'string' or ta == 'number') then return a < b end

  local dta, dtb = defaultTypeOrders[ta], defaultTypeOrders[tb]
  -- Two default types are compared according to the defaultTypeOrders table
  if dta and dtb then return defaultTypeOrders[ta] < defaultTypeOrders[tb]
  elseif dta     then return true  -- default types before custom ones
  elseif dtb     then return false -- custom types after default ones
  end

  -- custom types are sorted out alphabetically
  return ta < tb
end

-- For implementation reasons, the behavior of rawlen & # is "undefined" when
-- tables aren't pure sequences. So we implement our own # operator.
local function getSequenceLength(t)
  local len = 1
  local v = rawget(t,len)
  while v ~= nil do
    len = len + 1
    v = rawget(t,len)
  end
  return len - 1
end

local function getNonSequentialKeys(t)
  local keys, keysLength = {}, 0
  local sequenceLength = getSequenceLength(t)
  for k,_ in rawpairs(t) do
    if not isSequenceKey(k, sequenceLength) then
      keysLength = keysLength + 1
      keys[keysLength] = k
    end
  end
  table.sort(keys, sortKeys)
  return keys, keysLength, sequenceLength
end

local function countTableAppearances(t, tableAppearances)
  tableAppearances = tableAppearances or {}

  if type(t) == 'table' then
    if not tableAppearances[t] then
      tableAppearances[t] = 1
      for k,v in rawpairs(t) do
        countTableAppearances(k, tableAppearances)
        countTableAppearances(v, tableAppearances)
      end
      countTableAppearances(getmetatable(t), tableAppearances)
    else
      tableAppearances[t] = tableAppearances[t] + 1
    end
  end

  return tableAppearances
end

local copySequence = function(s)
  local copy, len = {}, #s
  for i=1, len do copy[i] = s[i] end
  return copy, len
end

local function makePath(path, ...)
  local keys = {...}
  local newPath, len = copySequence(path)
  for i=1, #keys do
    newPath[len + i] = keys[i]
  end
  return newPath
end

local function processRecursive(process, item, path, visited)
  if item == nil then return nil end
  if visited[item] then return visited[item] end

  local processed = process(item, path)
  if type(processed) == 'table' then
    local processedCopy = {}
    visited[item] = processedCopy
    local processedKey

    for k,v in rawpairs(processed) do
      processedKey = processRecursive(process, k, makePath(path, k, inspect.KEY), visited)
      if processedKey ~= nil then
        processedCopy[processedKey] = processRecursive(process, v, makePath(path, processedKey), visited)
      end
    end

    local mt  = processRecursive(process, getmetatable(processed), makePath(path, inspect.METATABLE), visited)
    if type(mt) ~= 'table' then mt = nil end -- ignore not nil/table __metatable field
    setmetatable(processedCopy, mt)
    processed = processedCopy
  end
  return processed
end



-------------------------------------------------------------------

local Inspector = {}
local Inspector_mt = {__index = Inspector}

function Inspector:puts(...)
  local args   = {...}
  local buffer = self.buffer
  local len    = #buffer
  for i=1, #args do
    len = len + 1
    buffer[len] = args[i]
  end
end

function Inspector:down(f)
  self.level = self.level + 1
  f()
  self.level = self.level - 1
end

function Inspector:tabify()
  self:puts(self.newline, string.rep(self.indent, self.level))
end

function Inspector:alreadyVisited(v)
  return self.ids[v] ~= nil
end

function Inspector:getId(v)
  local id = self.ids[v]
  if not id then
    local tv = type(v)
    id              = (self.maxIds[tv] or 0) + 1
    self.maxIds[tv] = id
    self.ids[v]     = id
  end
  return tostring(id)
end

function Inspector:putKey(k)
  if isIdentifier(k) then return self:puts(k) end
  self:puts("[")
  self:putValue(k)
  self:puts("]")
end

function Inspector:putTable(t)
  if t == inspect.KEY or t == inspect.METATABLE then
    self:puts(tostring(t))
  elseif self:alreadyVisited(t) then
    self:puts('<table ', self:getId(t), '>')
  elseif self.level >= self.depth then
    self:puts('{...}')
  else
    if self.tableAppearances[t] > 1 then self:puts('<', self:getId(t), '>') end

    local nonSequentialKeys, nonSequentialKeysLength, sequenceLength = getNonSequentialKeys(t)
    local mt                = getmetatable(t)

    self:puts('{')
    self:down(function()
      local count = 0
      for i=1, sequenceLength do
        if count > 0 then self:puts(',') end
        self:puts(' ')
        self:putValue(t[i])
        count = count + 1
      end

      for i=1, nonSequentialKeysLength do
        local k = nonSequentialKeys[i]
        if count > 0 then self:puts(',') end
        self:tabify()
        self:putKey(k)
        self:puts(' = ')
        self:putValue(t[k])
        count = count + 1
      end

      if type(mt) == 'table' then
        if count > 0 then self:puts(',') end
        self:tabify()
        self:puts('<metatable> = ')
        self:putValue(mt)
      end
    end)

    if nonSequentialKeysLength > 0 or type(mt) == 'table' then -- result is multi-lined. Justify closing }
      self:tabify()
    elseif sequenceLength > 0 then -- array tables have one extra space before closing }
      self:puts(' ')
    end

    self:puts('}')
  end
end

function Inspector:putValue(v)
  local tv = type(v)

  if tv == 'string' then
    self:puts(smartQuote(escape(v)))
  elseif tv == 'number' or tv == 'boolean' or tv == 'nil' or
         tv == 'cdata' or tv == 'ctype' then
    self:puts(tostring(v))
  elseif tv == 'table' then
    self:putTable(v)
  else
    self:puts('<', tv, ' ', self:getId(v), '>')
  end
end

-------------------------------------------------------------------

function inspect.inspect(root, options)
  options       = options or {}

  local depth   = options.depth   or math.huge
  local newline = options.newline or '\n'
  local indent  = options.indent  or '  '
  local process = options.process

  if process then
    root = processRecursive(process, root, {}, {})
  end

  local inspector = setmetatable({
    depth            = depth,
    level            = 0,
    buffer           = {},
    ids              = {},
    maxIds           = {},
    newline          = newline,
    indent           = indent,
    tableAppearances = countTableAppearances(root)
  }, Inspector_mt)

  inspector:putValue(root)

  return table.concat(inspector.buffer)
end

setmetatable(inspect, { __call = function(_, ...) return inspect.inspect(...) end })

return inspect

end)()
--- END inspect.lua


--- BEGIN fun.lua
export.fun = (function ()
---
--- Lua Fun - a high-performance functional programming library for LuaJIT
---
--- Copyright (c) 2013-2017 Roman Tsisyk <roman@tsisyk.com>
---
--- Distributed under the MIT/X11 License. See COPYING.md for more details.
---

local exports = {}
local methods = {}

-- compatibility with Lua 5.1/5.2
local unpack = rawget(table, "unpack") or unpack

--------------------------------------------------------------------------------
-- Tools
--------------------------------------------------------------------------------

local return_if_not_empty = function(state_x, ...)
    if state_x == nil then
        return nil
    end
    return ...
end

local call_if_not_empty = function(fun, state_x, ...)
    if state_x == nil then
        return nil
    end
    return state_x, fun(...)
end

local function deepcopy(orig) -- used by cycle()
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
    else
        copy = orig
    end
    return copy
end

local iterator_mt = {
    -- usually called by for-in loop
    __call = function(self, param, state)
        return self.gen(param, state)
    end;
    __tostring = function(self)
        return '<generator>'
    end;
    -- add all exported methods
    __index = methods;
}

local wrap = function(gen, param, state)
    return setmetatable({
        gen = gen,
        param = param,
        state = state
    }, iterator_mt), param, state
end
exports.wrap = wrap

local unwrap = function(self)
    return self.gen, self.param, self.state
end
methods.unwrap = unwrap

--------------------------------------------------------------------------------
-- Basic Functions
--------------------------------------------------------------------------------

local nil_gen = function(_param, _state)
    return nil
end

local string_gen = function(param, state)
    local state = state + 1
    if state > #param then
        return nil
    end
    local r = string.sub(param, state, state)
    return state, r
end

local ipairs_gen = ipairs({}) -- get the generating function from ipairs

local pairs_gen = pairs({ a = 0 }) -- get the generating function from pairs
local map_gen = function(tab, key)
    local value
    local key, value = pairs_gen(tab, key)
    return key, key, value
end

local rawiter = function(obj, param, state)
    assert(obj ~= nil, "invalid iterator")
    if type(obj) == "table" then
        local mt = getmetatable(obj);
        if mt ~= nil then
            if mt == iterator_mt then
                return obj.gen, obj.param, obj.state
            elseif mt.__ipairs ~= nil then
                return mt.__ipairs(obj)
            elseif mt.__pairs ~= nil then
                return mt.__pairs(obj)
            end
        end
        if #obj > 0 then
            -- array
            return ipairs(obj)
        else
            -- hash
            return map_gen, obj, nil
        end
    elseif (type(obj) == "function") then
        return obj, param, state
    elseif (type(obj) == "string") then
        if #obj == 0 then
            return nil_gen, nil, nil
        end
        return string_gen, obj, 0
    end
    error(string.format('object %s of type "%s" is not iterable',
          obj, type(obj)))
end

local iter = function(obj, param, state)
    return wrap(rawiter(obj, param, state))
end
exports.iter = iter

local method0 = function(fun)
    return function(self)
        return fun(self.gen, self.param, self.state)
    end
end

local method1 = function(fun)
    return function(self, arg1)
        return fun(arg1, self.gen, self.param, self.state)
    end
end

local method2 = function(fun)
    return function(self, arg1, arg2)
        return fun(arg1, arg2, self.gen, self.param, self.state)
    end
end

local export0 = function(fun)
    return function(gen, param, state)
        return fun(rawiter(gen, param, state))
    end
end

local export1 = function(fun)
    return function(arg1, gen, param, state)
        return fun(arg1, rawiter(gen, param, state))
    end
end

local export2 = function(fun)
    return function(arg1, arg2, gen, param, state)
        return fun(arg1, arg2, rawiter(gen, param, state))
    end
end

local each = function(fun, gen, param, state)
    repeat
        state = call_if_not_empty(fun, gen(param, state))
    until state == nil
end
methods.each = method1(each)
exports.each = export1(each)
methods.for_each = methods.each
exports.for_each = exports.each
methods.foreach = methods.each
exports.foreach = exports.each

--------------------------------------------------------------------------------
-- Generators
--------------------------------------------------------------------------------

local range_gen = function(param, state)
    local stop, step = param[1], param[2]
    local state = state + step
    if state > stop then
        return nil
    end
    return state, state
end

local range_rev_gen = function(param, state)
    local stop, step = param[1], param[2]
    local state = state + step
    if state < stop then
        return nil
    end
    return state, state
end

local range = function(start, stop, step)
    if step == nil then
        if stop == nil then
            if start == 0 then
                return nil_gen, nil, nil
            end
            stop = start
            start = stop > 0 and 1 or -1
        end
        step = start <= stop and 1 or -1
    end

    assert(type(start) == "number", "start must be a number")
    assert(type(stop) == "number", "stop must be a number")
    assert(type(step) == "number", "step must be a number")
    assert(step ~= 0, "step must not be zero")

    if (step > 0) then
        return wrap(range_gen, {stop, step}, start - step)
    elseif (step < 0) then
        return wrap(range_rev_gen, {stop, step}, start - step)
    end
end
exports.range = range

local duplicate_table_gen = function(param_x, state_x)
    return state_x + 1, unpack(param_x)
end

local duplicate_fun_gen = function(param_x, state_x)
    return state_x + 1, param_x(state_x)
end

local duplicate_gen = function(param_x, state_x)
    return state_x + 1, param_x
end

local duplicate = function(...)
    if select('#', ...) <= 1 then
        return wrap(duplicate_gen, select(1, ...), 0)
    else
        return wrap(duplicate_table_gen, {...}, 0)
    end
end
exports.duplicate = duplicate
exports.replicate = duplicate
exports.xrepeat = duplicate

local tabulate = function(fun)
    assert(type(fun) == "function")
    return wrap(duplicate_fun_gen, fun, 0)
end
exports.tabulate = tabulate

local zeros = function()
    return wrap(duplicate_gen, 0, 0)
end
exports.zeros = zeros

local ones = function()
    return wrap(duplicate_gen, 1, 0)
end
exports.ones = ones

local rands_gen = function(param_x, _state_x)
    return 0, math.random(param_x[1], param_x[2])
end

local rands_nil_gen = function(_param_x, _state_x)
    return 0, math.random()
end

local rands = function(n, m)
    if n == nil and m == nil then
        return wrap(rands_nil_gen, 0, 0)
    end
    assert(type(n) == "number", "invalid first arg to rands")
    if m == nil then
        m = n
        n = 0
    else
        assert(type(m) == "number", "invalid second arg to rands")
    end
    assert(n < m, "empty interval")
    return wrap(rands_gen, {n, m - 1}, 0)
end
exports.rands = rands

--------------------------------------------------------------------------------
-- Slicing
--------------------------------------------------------------------------------

local nth = function(n, gen_x, param_x, state_x)
    assert(n > 0, "invalid first argument to nth")
    -- An optimization for arrays and strings
    if gen_x == ipairs_gen then
        return param_x[n]
    elseif gen_x == string_gen then
        if n <= #param_x then
            return string.sub(param_x, n, n)
        else
            return nil
        end
    end
    for i=1,n-1,1 do
        state_x = gen_x(param_x, state_x)
        if state_x == nil then
            return nil
        end
    end
    return return_if_not_empty(gen_x(param_x, state_x))
end
methods.nth = method1(nth)
exports.nth = export1(nth)

local head_call = function(state, ...)
    if state == nil then
        error("head: iterator is empty")
    end
    return ...
end

local head = function(gen, param, state)
    return head_call(gen(param, state))
end
methods.head = method0(head)
exports.head = export0(head)
exports.car = exports.head
methods.car = methods.head

local tail = function(gen, param, state)
    state = gen(param, state)
    if state == nil then
        return wrap(nil_gen, nil, nil)
    end
    return wrap(gen, param, state)
end
methods.tail = method0(tail)
exports.tail = export0(tail)
exports.cdr = exports.tail
methods.cdr = methods.tail

local take_n_gen_x = function(i, state_x, ...)
    if state_x == nil then
        return nil
    end
    return {i, state_x}, ...
end

local take_n_gen = function(param, state)
    local n, gen_x, param_x = param[1], param[2], param[3]
    local i, state_x = state[1], state[2]
    if i >= n then
        return nil
    end
    return take_n_gen_x(i + 1, gen_x(param_x, state_x))
end

local take_n = function(n, gen, param, state)
    assert(n >= 0, "invalid first argument to take_n")
    return wrap(take_n_gen, {n, gen, param}, {0, state})
end
methods.take_n = method1(take_n)
exports.take_n = export1(take_n)

local take_while_gen_x = function(fun, state_x, ...)
    if state_x == nil or not fun(...) then
        return nil
    end
    return state_x, ...
end

local take_while_gen = function(param, state_x)
    local fun, gen_x, param_x = param[1], param[2], param[3]
    return take_while_gen_x(fun, gen_x(param_x, state_x))
end

local take_while = function(fun, gen, param, state)
    assert(type(fun) == "function", "invalid first argument to take_while")
    return wrap(take_while_gen, {fun, gen, param}, state)
end
methods.take_while = method1(take_while)
exports.take_while = export1(take_while)

local take = function(n_or_fun, gen, param, state)
    if type(n_or_fun) == "number" then
        return take_n(n_or_fun, gen, param, state)
    else
        return take_while(n_or_fun, gen, param, state)
    end
end
methods.take = method1(take)
exports.take = export1(take)

local drop_n = function(n, gen, param, state)
    assert(n >= 0, "invalid first argument to drop_n")
    local i
    for i=1,n,1 do
        state = gen(param, state)
        if state == nil then
            return wrap(nil_gen, nil, nil)
        end
    end
    return wrap(gen, param, state)
end
methods.drop_n = method1(drop_n)
exports.drop_n = export1(drop_n)

local drop_while_x = function(fun, state_x, ...)
    if state_x == nil or not fun(...) then
        return state_x, false
    end
    return state_x, true, ...
end

local drop_while = function(fun, gen_x, param_x, state_x)
    assert(type(fun) == "function", "invalid first argument to drop_while")
    local cont, state_x_prev
    repeat
        state_x_prev = deepcopy(state_x)
        state_x, cont = drop_while_x(fun, gen_x(param_x, state_x))
    until not cont
    if state_x == nil then
        return wrap(nil_gen, nil, nil)
    end
    return wrap(gen_x, param_x, state_x_prev)
end
methods.drop_while = method1(drop_while)
exports.drop_while = export1(drop_while)

local drop = function(n_or_fun, gen_x, param_x, state_x)
    if type(n_or_fun) == "number" then
        return drop_n(n_or_fun, gen_x, param_x, state_x)
    else
        return drop_while(n_or_fun, gen_x, param_x, state_x)
    end
end
methods.drop = method1(drop)
exports.drop = export1(drop)

local split = function(n_or_fun, gen_x, param_x, state_x)
    return take(n_or_fun, gen_x, param_x, state_x),
           drop(n_or_fun, gen_x, param_x, state_x)
end
methods.split = method1(split)
exports.split = export1(split)
methods.split_at = methods.split
exports.split_at = exports.split
methods.span = methods.split
exports.span = exports.split

--------------------------------------------------------------------------------
-- Indexing
--------------------------------------------------------------------------------

local index = function(x, gen, param, state)
    local i = 1
    for _k, r in gen, param, state do
        if r == x then
            return i
        end
        i = i + 1
    end
    return nil
end
methods.index = method1(index)
exports.index = export1(index)
methods.index_of = methods.index
exports.index_of = exports.index
methods.elem_index = methods.index
exports.elem_index = exports.index

local indexes_gen = function(param, state)
    local x, gen_x, param_x = param[1], param[2], param[3]
    local i, state_x = state[1], state[2]
    local r
    while true do
        state_x, r = gen_x(param_x, state_x)
        if state_x == nil then
            return nil
        end
        i = i + 1
        if r == x then
            return {i, state_x}, i
        end
    end
end

local indexes = function(x, gen, param, state)
    return wrap(indexes_gen, {x, gen, param}, {0, state})
end
methods.indexes = method1(indexes)
exports.indexes = export1(indexes)
methods.elem_indexes = methods.indexes
exports.elem_indexes = exports.indexes
methods.indices = methods.indexes
exports.indices = exports.indexes
methods.elem_indices = methods.indexes
exports.elem_indices = exports.indexes

--------------------------------------------------------------------------------
-- Filtering
--------------------------------------------------------------------------------

local filter1_gen = function(fun, gen_x, param_x, state_x, a)
    while true do
        if state_x == nil or fun(a) then break; end
        state_x, a = gen_x(param_x, state_x)
    end
    return state_x, a
end

-- call each other
local filterm_gen
local filterm_gen_shrink = function(fun, gen_x, param_x, state_x)
    return filterm_gen(fun, gen_x, param_x, gen_x(param_x, state_x))
end

filterm_gen = function(fun, gen_x, param_x, state_x, ...)
    if state_x == nil then
        return nil
    end
    if fun(...) then
        return state_x, ...
    end
    return filterm_gen_shrink(fun, gen_x, param_x, state_x)
end

local filter_detect = function(fun, gen_x, param_x, state_x, ...)
    if select('#', ...) < 2 then
        return filter1_gen(fun, gen_x, param_x, state_x, ...)
    else
        return filterm_gen(fun, gen_x, param_x, state_x, ...)
    end
end

local filter_gen = function(param, state_x)
    local fun, gen_x, param_x = param[1], param[2], param[3]
    return filter_detect(fun, gen_x, param_x, gen_x(param_x, state_x))
end

local filter = function(fun, gen, param, state)
    return wrap(filter_gen, {fun, gen, param}, state)
end
methods.filter = method1(filter)
exports.filter = export1(filter)
methods.remove_if = methods.filter
exports.remove_if = exports.filter

local grep = function(fun_or_regexp, gen, param, state)
    local fun = fun_or_regexp
    if type(fun_or_regexp) == "string" then
        fun = function(x) return string.find(x, fun_or_regexp) ~= nil end
    end
    return filter(fun, gen, param, state)
end
methods.grep = method1(grep)
exports.grep = export1(grep)

local partition = function(fun, gen, param, state)
    local neg_fun = function(...)
        return not fun(...)
    end
    return filter(fun, gen, param, state),
           filter(neg_fun, gen, param, state)
end
methods.partition = method1(partition)
exports.partition = export1(partition)

--------------------------------------------------------------------------------
-- Reducing
--------------------------------------------------------------------------------

local foldl_call = function(fun, start, state, ...)
    if state == nil then
        return nil, start
    end
    return state, fun(start, ...)
end

local foldl = function(fun, start, gen_x, param_x, state_x)
    while true do
        state_x, start = foldl_call(fun, start, gen_x(param_x, state_x))
        if state_x == nil then
            break;
        end
    end
    return start
end
methods.foldl = method2(foldl)
exports.foldl = export2(foldl)
methods.reduce = methods.foldl
exports.reduce = exports.foldl

local length = function(gen, param, state)
    if gen == ipairs_gen or gen == string_gen then
        return #param
    end
    local len = 0
    repeat
        state = gen(param, state)
        len = len + 1
    until state == nil
    return len - 1
end
methods.length = method0(length)
exports.length = export0(length)

local is_null = function(gen, param, state)
    return gen(param, deepcopy(state)) == nil
end
methods.is_null = method0(is_null)
exports.is_null = export0(is_null)

local is_prefix_of = function(iter_x, iter_y)
    local gen_x, param_x, state_x = iter(iter_x)
    local gen_y, param_y, state_y = iter(iter_y)

    local r_x, r_y
    for i=1,10,1 do
        state_x, r_x = gen_x(param_x, state_x)
        state_y, r_y = gen_y(param_y, state_y)
        if state_x == nil then
            return true
        end
        if state_y == nil or r_x ~= r_y then
            return false
        end
    end
end
methods.is_prefix_of = is_prefix_of
exports.is_prefix_of = is_prefix_of

local all = function(fun, gen_x, param_x, state_x)
    local r
    repeat
        state_x, r = call_if_not_empty(fun, gen_x(param_x, state_x))
    until state_x == nil or not r
    return state_x == nil
end
methods.all = method1(all)
exports.all = export1(all)
methods.every = methods.all
exports.every = exports.all

local any = function(fun, gen_x, param_x, state_x)
    local r
    repeat
        state_x, r = call_if_not_empty(fun, gen_x(param_x, state_x))
    until state_x == nil or r
    return not not r
end
methods.any = method1(any)
exports.any = export1(any)
methods.some = methods.any
exports.some = exports.any

local sum = function(gen, param, state)
    local s = 0
    local r = 0
    repeat
        s = s + r
        state, r = gen(param, state)
    until state == nil
    return s
end
methods.sum = method0(sum)
exports.sum = export0(sum)

local product = function(gen, param, state)
    local p = 1
    local r = 1
    repeat
        p = p * r
        state, r = gen(param, state)
    until state == nil
    return p
end
methods.product = method0(product)
exports.product = export0(product)

local min_cmp = function(m, n)
    if n < m then return n else return m end
end

local max_cmp = function(m, n)
    if n > m then return n else return m end
end

local min = function(gen, param, state)
    local state, m = gen(param, state)
    if state == nil then
        error("min: iterator is empty")
    end

    local cmp
    if type(m) == "number" then
        -- An optimization: use math.min for numbers
        cmp = math.min
    else
        cmp = min_cmp
    end

    for _, r in gen, param, state do
        m = cmp(m, r)
    end
    return m
end
methods.min = method0(min)
exports.min = export0(min)
methods.minimum = methods.min
exports.minimum = exports.min

local min_by = function(cmp, gen_x, param_x, state_x)
    local state_x, m = gen_x(param_x, state_x)
    if state_x == nil then
        error("min: iterator is empty")
    end

    for _, r in gen_x, param_x, state_x do
        m = cmp(m, r)
    end
    return m
end
methods.min_by = method1(min_by)
exports.min_by = export1(min_by)
methods.minimum_by = methods.min_by
exports.minimum_by = exports.min_by

local max = function(gen_x, param_x, state_x)
    local state_x, m = gen_x(param_x, state_x)
    if state_x == nil then
        error("max: iterator is empty")
    end

    local cmp
    if type(m) == "number" then
        -- An optimization: use math.max for numbers
        cmp = math.max
    else
        cmp = max_cmp
    end

    for _, r in gen_x, param_x, state_x do
        m = cmp(m, r)
    end
    return m
end
methods.max = method0(max)
exports.max = export0(max)
methods.maximum = methods.max
exports.maximum = exports.max

local max_by = function(cmp, gen_x, param_x, state_x)
    local state_x, m = gen_x(param_x, state_x)
    if state_x == nil then
        error("max: iterator is empty")
    end

    for _, r in gen_x, param_x, state_x do
        m = cmp(m, r)
    end
    return m
end
methods.max_by = method1(max_by)
exports.max_by = export1(max_by)
methods.maximum_by = methods.maximum_by
exports.maximum_by = exports.maximum_by

local totable = function(gen_x, param_x, state_x)
    local tab, key, val = {}
    while true do
        state_x, val = gen_x(param_x, state_x)
        if state_x == nil then
            break
        end
        table.insert(tab, val)
    end
    return tab
end
methods.totable = method0(totable)
exports.totable = export0(totable)

local tomap = function(gen_x, param_x, state_x)
    local tab, key, val = {}
    while true do
        state_x, key, val = gen_x(param_x, state_x)
        if state_x == nil then
            break
        end
        tab[key] = val
    end
    return tab
end
methods.tomap = method0(tomap)
exports.tomap = export0(tomap)

--------------------------------------------------------------------------------
-- Transformations
--------------------------------------------------------------------------------

local map_gen = function(param, state)
    local gen_x, param_x, fun = param[1], param[2], param[3]
    return call_if_not_empty(fun, gen_x(param_x, state))
end

local map = function(fun, gen, param, state)
    return wrap(map_gen, {gen, param, fun}, state)
end
methods.map = method1(map)
exports.map = export1(map)

local enumerate_gen_call = function(state, i, state_x, ...)
    if state_x == nil then
        return nil
    end
    return {i + 1, state_x}, i, ...
end

local enumerate_gen = function(param, state)
    local gen_x, param_x = param[1], param[2]
    local i, state_x = state[1], state[2]
    return enumerate_gen_call(state, i, gen_x(param_x, state_x))
end

local enumerate = function(gen, param, state)
    return wrap(enumerate_gen, {gen, param}, {1, state})
end
methods.enumerate = method0(enumerate)
exports.enumerate = export0(enumerate)

local intersperse_call = function(i, state_x, ...)
    if state_x == nil then
        return nil
    end
    return {i + 1, state_x}, ...
end

local intersperse_gen = function(param, state)
    local x, gen_x, param_x = param[1], param[2], param[3]
    local i, state_x = state[1], state[2]
    if i % 2 == 1 then
        return {i + 1, state_x}, x
    else
        return intersperse_call(i, gen_x(param_x, state_x))
    end
end

-- TODO: interperse must not add x to the tail
local intersperse = function(x, gen, param, state)
    return wrap(intersperse_gen, {x, gen, param}, {0, state})
end
methods.intersperse = method1(intersperse)
exports.intersperse = export1(intersperse)

--------------------------------------------------------------------------------
-- Compositions
--------------------------------------------------------------------------------

local function zip_gen_r(param, state, state_new, ...)
    if #state_new == #param / 2 then
        return state_new, ...
    end

    local i = #state_new + 1
    local gen_x, param_x = param[2 * i - 1], param[2 * i]
    local state_x, r = gen_x(param_x, state[i])
    if state_x == nil then
        return nil
    end
    table.insert(state_new, state_x)
    return zip_gen_r(param, state, state_new, r, ...)
end

local zip_gen = function(param, state)
    return zip_gen_r(param, state, {})
end

-- A special hack for zip/chain to skip last two state, if a wrapped iterator
-- has been passed
local numargs = function(...)
    local n = select('#', ...)
    if n >= 3 then
        -- Fix last argument
        local it = select(n - 2, ...)
        if type(it) == 'table' and getmetatable(it) == iterator_mt and
           it.param == select(n - 1, ...) and it.state == select(n, ...) then
            return n - 2
        end
    end
    return n
end

local zip = function(...)
    local n = numargs(...)
    if n == 0 then
        return wrap(nil_gen, nil, nil)
    end
    local param = { [2 * n] = 0 }
    local state = { [n] = 0 }

    local i, gen_x, param_x, state_x
    for i=1,n,1 do
        local it = select(n - i + 1, ...)
        gen_x, param_x, state_x = rawiter(it)
        param[2 * i - 1] = gen_x
        param[2 * i] = param_x
        state[i] = state_x
    end

    return wrap(zip_gen, param, state)
end
methods.zip = zip
exports.zip = zip

local cycle_gen_call = function(param, state_x, ...)
    if state_x == nil then
        local gen_x, param_x, state_x0 = param[1], param[2], param[3]
        return gen_x(param_x, deepcopy(state_x0))
    end
    return state_x, ...
end

local cycle_gen = function(param, state_x)
    local gen_x, param_x, state_x0 = param[1], param[2], param[3]
    return cycle_gen_call(param, gen_x(param_x, state_x))
end

local cycle = function(gen, param, state)
    return wrap(cycle_gen, {gen, param, state}, deepcopy(state))
end
methods.cycle = method0(cycle)
exports.cycle = export0(cycle)

-- call each other
local chain_gen_r1
local chain_gen_r2 = function(param, state, state_x, ...)
    if state_x == nil then
        local i = state[1]
        i = i + 1
        if param[3 * i - 1] == nil then
            return nil
        end
        local state_x = param[3 * i]
        return chain_gen_r1(param, {i, state_x})
    end
    return {state[1], state_x}, ...
end

chain_gen_r1 = function(param, state)
    local i, state_x = state[1], state[2]
    local gen_x, param_x = param[3 * i - 2], param[3 * i - 1]
    return chain_gen_r2(param, state, gen_x(param_x, state[2]))
end

local chain = function(...)
    local n = numargs(...)
    if n == 0 then
        return wrap(nil_gen, nil, nil)
    end

    local param = { [3 * n] = 0 }
    local i, gen_x, param_x, state_x
    for i=1,n,1 do
        local elem = select(i, ...)
        gen_x, param_x, state_x = iter(elem)
        param[3 * i - 2] = gen_x
        param[3 * i - 1] = param_x
        param[3 * i] = state_x
    end

    return wrap(chain_gen_r1, param, {1, param[3]})
end
methods.chain = chain
exports.chain = chain

--------------------------------------------------------------------------------
-- Operators
--------------------------------------------------------------------------------

local operator = {
    ----------------------------------------------------------------------------
    -- Comparison operators
    ----------------------------------------------------------------------------
    lt  = function(a, b) return a < b end,
    le  = function(a, b) return a <= b end,
    eq  = function(a, b) return a == b end,
    ne  = function(a, b) return a ~= b end,
    ge  = function(a, b) return a >= b end,
    gt  = function(a, b) return a > b end,

    ----------------------------------------------------------------------------
    -- Arithmetic operators
    ----------------------------------------------------------------------------
    add = function(a, b) return a + b end,
    div = function(a, b) return a / b end,
    floordiv = function(a, b) return math.floor(a/b) end,
    intdiv = function(a, b)
        local q = a / b
        if a >= 0 then return math.floor(q) else return math.ceil(q) end
    end,
    mod = function(a, b) return a % b end,
    mul = function(a, b) return a * b end,
    neq = function(a) return -a end,
    unm = function(a) return -a end, -- an alias
    pow = function(a, b) return a ^ b end,
    sub = function(a, b) return a - b end,
    truediv = function(a, b) return a / b end,

    ----------------------------------------------------------------------------
    -- String operators
    ----------------------------------------------------------------------------
    concat = function(a, b) return a..b end,
    len = function(a) return #a end,
    length = function(a) return #a end, -- an alias

    ----------------------------------------------------------------------------
    -- Logical operators
    ----------------------------------------------------------------------------
    land = function(a, b) return a and b end,
    lor = function(a, b) return a or b end,
    lnot = function(a) return not a end,
    truth = function(a) return not not a end,
}
exports.operator = operator
methods.operator = operator
exports.op = operator
methods.op = operator

--------------------------------------------------------------------------------
-- module definitions
--------------------------------------------------------------------------------

-- a special syntax sugar to export all functions to the global table
setmetatable(exports, {
    __call = function(t, override)
        for k, v in pairs(t) do
            if rawget(_G, k) ~= nil then
                local msg = 'function ' .. k .. ' already exists in global scope.'
                if override then
                    rawset(_G, k, v)
                    print('WARNING: ' .. msg .. ' Overwritten.')
                else
                    print('NOTICE: ' .. msg .. ' Skipped.')
                end
            else
                rawset(_G, k, v)
            end
        end
    end,
})

return exports

end)()
--- END fun.lua


--- BEGIN func.lua
export.func = (function ()
--[[

  This module contains commonly used functions and higher order functions.

]]

local func = {}

function func.inc (n, c)
  if c == nil then
    return n + 1
  else
    return n + c
  end
end

function func.dec (n, c)
  if c == nil then
    return n - 1
  else
    return n - c
  end
end

function func.add (a, b)
  return a + b
end

function func.mul (a, b)
  return a * b
end

function func.transpose (a, b)
  return b, a
end

function func.bnot (b)
  return not b
end

function func.invert (n)
  return 1 / n
end

function func.negate (n)
  return -n
end

function func.double (n)
  return n * 2
end

function func.halve (n)
  return n / 2
end

function func.identity (a)
  return a
end

function func.compose (f, g)
  return function (...)
    return f(g(...))
  end
end

function func.pipe (pipeline)
  return function (a)
    local result = a
    for _, fn in ipairs(pipeline) do
      result = fn(result)
    end
    return result
  end
end

function func.collect1 (iterator)
  local result = {}
  for e in iterator do
    result[#result + 1] = e
  end

  return result
end

function func.collect2 (iterator)
  local result = {}
  for _, e in iterator do
    result[#result + 1] = e
  end

  return result
end

function func.lt (a, b)
  return a < b
end
function func.lte (a, b)
  return a <= b
end
function func.gt (a, b)
  return a > b
end
function func.gte (a, b)
  return a >= b
end
function func.eq (a, b)
  return a == b
end

function func.divisible (a, b)
  return a % b == 0
end

--- conditional logic
--- @example
--- local e = func.cond {
---   {func.eq; 'equal'};
---   {func.divisible; 'divisible'};
---   'unknown'
--- }
--- return e(10, 5)
function func.cond (tbl)
  local branchCount = #tbl
  local elseBranch = tbl[branchCount]
  return function (...)
    for i = 1, branchCount - 1 do
      if tbl[i][1](...) then
        return tbl[i][2]
      end
    end
    return elseBranch
  end
end

function func.bind (fn, ...)
  local args = {...}
  return function (...)
    local args2 = {}
    for _, v in ipairs(args) do
      args2[#args2 + 1] = v
    end
    for i=1,select('#', ...) do
      args2[#args2 + 1] = select(i, ...)
    end
    return fn(unpack(args2))
  end
end

function func.transform (object, transformation)
  return transformation(object)
end

function func.memoize1 (fn)
  local cache = {}
  return function (a)
    assert(a ~= nil, 'argument #1 must not be nil')

    if cache[a] then
      cache[a] = fn(a)
    end

    return cache[a]
  end
end

function func.memoize2 (fn)
  local cache = {}
  return function (a, b)
    assert(a ~= nil, 'argument #1 must not be nil')
    assert(b ~= nil, 'argument #2 must not be nil')

    if cache[a] then
      if cache[a][b] then
        return cache[a][b]
      else
        cache[a][b] = fn(a, b)
      end
    else
      cache[a] = {}
      cache[a][b] = fn(a, b)
    end
    return cache[a][b]
  end
end

return func

end)()
--- END func.lua


--- BEGIN prototype.lua
export.prototype = (function ()
--[[
  A light weight implementation allowing creation of so called "prototypes"
  which can be used to easily create "objects" with certain methods.

  The value passed in to this function is mutated, so it is not recommended
  to store a separate reference to this value.

  @example
  local MyProto = prototype {doStuff = ...}
  function MyProto.new (arg1)
    local instance = {_value = arg1}
    ...
    return MyProto(instance)
  end
  local myobj = MyProto.new('some value')
  myobj:doStuff()
  myobj:isa(MyProto)

  local MyDerivedProto = prototype {
    MyProto; -- derive from MyProto
    {
      extraMethod = function () ... end
    }
  }
  local myobj2 = MyDerivedProto {}
  myobj2:isa(MyProto)
  myobj2:isa(MyDerivedProto)
]]

local function simplePrototype (definition)
  local mmt = {
    __call = function (self, obj)
      return setmetatable(obj, self)
    end
  }
  local proto = definition or {}
  proto.__index = proto
  function proto.isa (self, protoref)
    return getmetatable(self) == protoref
  end

  return setmetatable(proto, mmt)
end

local function inheritPrototype (super, definition)
  local mmt = setmetatable({
    __call = function (self, obj)
      return setmetatable(obj, self)
    end
  }, super)
  mmt.__index = mmt

  local proto = definition or {}
  proto.__index = proto
  function proto.isa (self, protoref)
    local t = self
    repeat
      t = getmetatable(t)
      if t == protoref then
        return true
      end
    until type(t) ~= 'table'
  end

  return setmetatable(proto, mmt)
end

local function prototype (definition)
  if #definition == 2 then
    return inheritPrototype(definition[1], definition[2])
  end
  return simplePrototype(definition)
end

return prototype

end)()
--- END prototype.lua


--- BEGIN fmt.lua
export.fmt = (function ()
local inspect = require('inspect') -- TODO: add dump and printfInspect

local fmt = {}

function fmt.printf (fmt, ...)
  print(string.format(fmt, ...))
end

function fmt.writef (fmt, ...)
  io.write(string.format(fmt, ...))
end

function fmt.fprintf (fd, fmt, ...)
  fd:write(string.format(fmt, ...))
end

function fmt.dump (object)
  print(inspect(object))
end

return fmt

end)()
--- END fmt.lua


--- BEGIN flags.lua
export.flags = (function ()

local bit = require('bit')
local AND, OR, NOT, XOR = bit.band, bit.bor, bit.bnot, bit.bxor
local rshift, lshift = bit.rshift, bit.lshift
local prototype = require('prototype')
local inspect = require('inspect')

local b = setmetatable({}, {
    __call = function (self, bitOrdinal)
      return 2 ^ bitOrdinal
    end;
})
function b.mask (lowbit, highbit)
  assert(lowbit <= highbit, 'lowbit must be <= highbit')
  -- create a mask which matches the desired range of bits
  local bitcount = highbit - lowbit + 1

  local mask = 0xffffffff
  mask = lshift(mask, bitcount)
  mask = NOT(mask)
  mask = lshift(mask, lowbit)

  return mask
end

function b.slice (bits, lowbit, highbit)
  if highbit == nil then
    highbit = lowbit
    lowbit = 0
  end
  lowbit = lowbit or 0
  highbit = highbit or 0

  return rshift(AND(bits, b.mask(lowbit, highbit)), lowbit)
end

function b.isset (bits, bitOrd)
  return AND(bits, 2 ^ bitOrd) > 0
end

function b.setbit (bits, bitOrd)
  return OR(bits, 2 ^ bitOrd)
end

function b.clearbit (bits, bitOrd)
  return AND(bits, NOT(2 ^ bitOrd))
end

local Bits = prototype {}
function Bits.new (ival)
  return Bits {ival=ival}
end

function Bits.has (self, ival)
  return AND(self.ival, ival) ~= 0
end

-- TODO consider prealloc an array with '0' and change only if needed
function Bits.__tostring (self, numbits, bigendian)
  local value = self.ival
  nbits = nbits or 32
  local res = {}

  if bigendian then
    for i = nbits - 1, 0, -1 do
      if b.isset(value, i) then
        res[#res + 1] = '1'
      else
        res[#res + 1] = '0'
      end
    end
  else
    for i = 0, nbits - 1 do
      if b.isset(value, i) then
        res[#res + 1] = '1'
      else
        res[#res + 1] = '0'
      end
    end
  end

  return table.concat(res)
end

local Flags = prototype {}
Flags.Bits = Bits

function Flags.new (flags)
  local instance = Flags(flags)
  local preMt = getmetatable(instance)
  local newMt = setmetatable({}, preMt)
  newMt.__index = newMt
  function newMt.__call (self, ...)
    local ival = 0
    for i = 1, select('#', ...) do
      ival = OR(ival, flags[select(i, ...)])
    end
    return Bits.new(ival)
  end
  return setmetatable(instance, newMt)
end

return Flags

end)()
--- END flags.lua


--- BEGIN strings.lua
export.strings = (function ()
local F = require('func')

local strings = {}

local EMPTYSTRING = ''

--[[

  @parameter str <string> - The string to split

  @parameter [separator] <string/regex> - What to split by. Defaults to %s
  (whitespace).

  @returns a table with the elements from splitting the string.

]]
function strings.split (str, separator)
  separator = separator or '%s'
  local t = {}

  if str == EMPTYSTRING or separator == EMPTYSTRING then
    return t
  end

  local pattern = string.format('([^%s]*)(%s?)', separator, separator)
  for field, s in string.gmatch(str, pattern) do
    table.insert(t, field)
    if s == EMPTYSTRING then
      return t
    end
  end
end

--[[

  strings.iter

  Allows for iterating through a string for each character.

  @parameter str <string>

  @returns an iterator<index, character>

  @example
  local str = 'a bc d'
  local acc = {}
  for i, c in strings.iter(str) do
    acc[i] = c
  end

]]
function strings.iter (str)
  local len = #str
  local i = 0
  return function ()
    i = i + 1
    if i <= len then
      return i, str:sub(i, i)
    end
  end
end

function strings.join (tbl, separator)
  return table.concat(tbl, separator)
end

function strings.padr (str, length, char)
  str = tostring(str)
  local diff = length - #str
  if diff > 0 then
    return str..string.rep(char, diff)
  end

  return str
end

function strings.padl (str, length, char)
  str = tostring(str)
  local diff = length - #str
  if diff > 0 then
    return string.rep(char, diff)..str
  end

  return str
end

function strings.isEmpty (str)
  return #str == 0
end

function strings.isBlank (str)
  if strings.isEmpty(str) then
    return true
  end

  local isWhitespaceOnly = (string.find(str, '[^%s]')) == nil
  return isWhitespaceOnly
end

function strings.trimStart (str)
  return string.gsub(str, '^%s', '')
end

function strings.trimEnd (str)
  return string.gsub(str, '%s$', '')
end

strings.trim = F.compose(strings.trimStart, strings.trimEnd)

-- Ported from https://github.com/gustf/js-levenshtein (MIT)
function strings.levenshteinDistance (a, b)
  local function _min (d0, d1, d2, bx, ay)
    if d0 < d1 or d2 < d1 then
      if d0 > d2 then
        return d2 + 1
      else
        return d0 + 1
      end
    else
      if bx == ay then
        return d1
      else
        return d1 + 1
      end
    end
  end

  local function distance (a, b)
    -- identical strings means 0 edit distance
    if a == b then
      return 0
    end

    -- make sure that a is the shortest string
    if string.len(a) > string.len(b) then
      local tmp = a
      a = b
      b = tmp
    end

    local la = string.len(a)
    local lb = string.len(b)

    -- check each char in the string from back to front and decrease the length
    -- if they are the same
    while la > 1 and (string.byte(a, la) == string.byte(b, lb)) do
      la = la - 1
      lb = lb - 1
    end

    -- check each char from front to back and increase the offset by one for
    -- each match
    local offset = 1
    while offset < la and (string.byte(a, offset) == string.byte(b, offset)) do
      offset = offset + 1
    end

    -- adjust the length according to the offset
    la = la - offset;
    lb = lb - offset;

    -- if the length of a is zero, we know that the length of b is the edit distance.
    if la == 0 or lb < 3 then
      return lb
    end

    local x = 0, y,
    d0, d1, d2, d3, dd, dy, ay,
    bx0, bx1, bx2, bx3

    local vector = {}

    for y = 1, la do
      table.insert(vector, y);
      table.insert(vector, string.byte(a, offset + y));
    end

    local len = #vector

    while x <= lb - 3 do
      d0 = x
      bx0 = string.byte(b, offset + d0)
      d1 = x + 1
      bx1 = string.byte(b, offset + d1)
      d2 = x + 2
      bx2 = string.byte(b, offset + d2)
      d3 = x + 3
      bx3 = string.byte(b, offset + d3)
      x = x + 4
      dd = x

      for y = 1, len, 2 do
        dy = vector[y];
        ay = vector[y + 1];
        d0 = _min(dy, d0, d1, bx0, ay);
        d1 = _min(d0, d1, d2, bx1, ay);
        d2 = _min(d1, d2, d3, bx2, ay);
        dd = _min(d2, d3, dd, bx3, ay);
        vector[y] = dd;
        d3 = d2;
        d2 = d1;
        d1 = d0;
        d0 = dy;
      end
    end

    while x <= lb do
      d0 = x
      bx0 = string.byte(b, offset + d0)
      x = x + 1
      dd = x
      for y = 1, len, 2 do
        dy = vector[y]
        dd = _min(dy, d0, dd, bx0, vector[y + 1])
        vector[y] = dd
        d0 = dy
      end
    end

    return dd
  end

  return distance(a, b)
end

function strings.startsWith (str, substr)
  return (string.find(str, string.format('^%s', substr)) ~= nil)
end

function strings.endsWith (str, substr)
  return (string.find(str, string.format('%s$', substr)) ~= nil)
end

function strings.includes (str, substr)
  return (string.find(str, substr) ~= nil)
end

function strings.compare (a, b)
  if     a < b then return -1
  elseif a > b then return  1
  else              return  0
  end
end

local function charAt (str, index)
  return string.sub(str, index, index)
end

local template = {}
strings.template = template

local TEMPLATE_BEGIN_TAG, TEMPLATE_END_TAG = '%[', ']'
local TEMPLATE_BEGIN_BRACKET, TEMPLATE_END_BRACKET = '[', ']'

--- Creates a function based on the supplied template string. This function
--- accepts a table to be used as the data when rendering the template.
--- TODO error handling
---
--- Signature: string -> tbl -> string
---
--- Template DSL: Lua code may be included within the square brackets following
--- a percent sign: %[]. An example of this would be: 'This is static text, but
--- the following is code: %[akey]'. Calling metamethods are allowed, e.g.:
--- 'Calling a metamethod: %[stringVal:upper()]'
---
--- Compiling a template means that the template string is parsed and
--- transformed into Lua code consisting of one table, which is returned by a
--- dynamically created function using `load`. This table is then
--- `table.concat`ted to finally yield the result.
---
--- Full example of usage: TODO
function template.compile (tmpl)
  if type(tmpl) ~= 'string' then
    error('argument #1 must be a string')
  end

  local gsub = string.gsub
  local code = {}
  local len = #tmpl

  local function makeTransform (i)
    local accumulator = ''
    local depth = 0
    while i <= len do
      local c = charAt(tmpl, i)
      if c == TEMPLATE_BEGIN_BRACKET then
        depth = depth + 1
      elseif c == TEMPLATE_END_BRACKET then
        if depth == 0 then
          break
        end
        depth = depth - 1
      end
      accumulator = accumulator..c
      i = i + 1
    end

    return accumulator, i + #TEMPLATE_END_TAG -- skip end tag
  end

  local function makeValue (i)
    local accumulator = ''
    while i <= len and string.sub(tmpl, i, i + 1) ~= TEMPLATE_BEGIN_TAG do
      accumulator = accumulator..charAt(tmpl, i)
      i = i + 1
    end

    return accumulator, i
  end

  local function escape (str)
    return gsub(gsub(str, '"', '\\"'), '\n', '\\n')
  end

  local i = 1
  while i <= len do
    local value
    if string.sub(tmpl, i, i + 1) == TEMPLATE_BEGIN_TAG then
      value, i = makeTransform(i + #TEMPLATE_BEGIN_TAG) -- skip begin tag
      code[#code + 1] = '('..value..')'
    else
      value, i = makeValue(i)
      code[#code + 1] = '"'..escape(value)..'"'
    end
  end


  -- table.insert(code, 1, 'return {')
  -- code[#code + 1] = '}'
  code = table.concat(code, ',')
  code = string.format('return {%s}', code)
  -- print(code)
  local renderer = load(code)
  if renderer == nil then
    error('Invalid template definition')
  end

  return function (data)
    -- local env = {}
    -- env.__index = _G
    -- return setfenv(renderer, setmetatable(data, env))()
    return table.concat(setfenv(renderer, data)())
  end
end

function template.interpolate (tmpl, data)
  return template.compile(tmpl)(data)
end

do
  ok, lpeg = pcall(function ()
      return require('lpeg')
  end)
  if ok then
    --- This function sets an fenv on the supplied function so that LPeg and a
    --- couple of helper functions are available unqualified.
    ---
    --- @example:
    --- local result = withLpeg(function ()
    ---   return (P'123'):match('x123x')
    --- end)
    function strings.withLpeg (fn)
      local envObj = {
        --- match pat1 XOR pat2 one or more times
        either = function (pat1, pat2)
          return (pat1 + pat2) ^ 1
        end;
        --- match `pat` 0 or 1 times
        maybe = function (pat)
          return pat ^ -1
        end;
      }
      local mt = {}
      mt.__index = function (self, key)
        if lpeg[key] then
          return lpeg[key]
        elseif envObj[key] then
          return envObj[key]
        elseif _G[key] then
          return _G[key]
        end

        return nil
      end

      local env = setmetatable(envObj, mt)

      return setfenv(fn, env)()
    end
  end
end

return strings

end)()
--- END strings.lua


--- BEGIN tables.lua
export.tables = (function ()
local prototype = require('prototype')
local strings = require('strings')

local tables = prototype {}

function tables.partition (tbl, partsize)
  local result = {}
  for i = 1, #tbl, partsize do
    local part = {}
    for j = 1, partsize do
      part[j] = tbl[i+j-1]
    end
    result[#result + 1] = part
  end

  return result
end

function tables.map (tbl, transform)
  local result = {}
  if #tbl == 0 then
    for k, e in pairs(tbl) do
      result[k] = transform(e, k)
    end
  else
    for i, e in ipairs(tbl) do
      result[#result + 1] = transform(e, i)
    end
  end
  return result
end

function tables.reduce (tbl, reducer, init)
  if #tbl == 0 then
    for k, e in pairs(tbl) do
      init = reducer(init, e, k)
    end
  else
    for i, e in ipairs(tbl) do
      init = reducer(init, e, i)
    end
  end

  return init
end

function tables.filter (tbl, predicate)
  local result = {}
  if #tbl == 0 then
    for k, e in pairs(tbl) do
      if predicate(e, k) then
        result[k] = e
      end
    end
  else
    for i, e in ipairs(tbl) do
      if predicate(e, i) then
        result[#result + 1] = e
      end
    end
  end

  return result
end

--[[

  Concatenate two or more tables into a new table.

]]
function tables.concat (tbl, ...)
  local result = {}
  for _, e in ipairs(tbl) do
    result[#result + 1] = e
  end

  for i = 1, select('#', ...) do
    local other = select(i, ...)
    for _, e in ipairs(other) do
      result[#result + 1] = e
    end
  end

  return result
end

function tables.merge (tbl, ...)
  local result = {}
  for k, e in pairs(tbl) do
    result[k] = e
  end

  for i = 1, select('#', ...) do
    local other = select(i, ...)
    for k, e in pairs(other) do
      result[k] = e
    end
  end

  return result
end

function tables.skip (tbl, count)
  local result = {}
  for i = count+1, #tbl do
    result[#result + 1] = tbl[i]
  end

  return result
end

function tables.take (tbl, count)
  local result = {}
  for i = 1, math.min(#tbl, count) do
    result[#result + 1] = tbl[i]
  end

  return result
end

function tables.get (tbl, path, default)
  -- todo numbers
  if type(path) ~= 'table' then
    path = strings.split(path, '%.')
  end
  if #path == 0 then
    return tbl or default
  end
  local key = path[1]
  local asnum = tonumber(key)
  if asnum ~= nil then
    key = asnum
  end
  local value = tbl[key]
  local nextPath = tables.skip(path, 1)
  --require('debugger')()
  return tables.get(value, nextPath, default)
end

function tables.swap (tbl, i1, i2)
  local temp = tbl[i1]
  tbl[i1] = tbl[i2]
  tbl[i2] = temp
  -- return tbl[i1], tbl[i2], tbl
end

function tables.collect (iterable)
  local result = {}
  for v in iterable do
    result[#result + 1] = v
  end
  return result
end

function tables.reverse (tbl)
  local acc = {}
  for i = #tbl, 1, -1 do
    acc[#acc+1] = tbl[i]
  end
  return acc
end

function tables.padEnd (tbl, minLength, value)
  if #tbl < minLength then
    for i = #tbl + 1, minLength do
      tbl[i] = value
    end
  end

  return tbl
end

function tables.createIndex (tbl)
  local index = {}
  for i, v in ipairs(tbl) do
    index[v] = i
  end

  return index
end

return tables

end)()
--- END tables.lua


--- BEGIN quick_sort.lua
export.quick_sort = (function ()
local function swap (tbl, i1, i2)
  local temp = tbl[i1]
  tbl[i1] = tbl[i2]
  tbl[i2] = temp
end

local function partition (tbl, lo, hi, comparator)
  local pivot = tbl[hi]
  local i = lo
  for j = i, hi do
    if comparator(tbl[j], pivot) then
      swap(tbl, i, j)
      i = i + 1
    end
  end
  swap(tbl, i, hi)
  return i
end

local function qsort (tbl, lo, hi, comparator)
  if lo < hi then
    local p = partition(tbl, lo, hi, comparator)
    qsort(tbl, lo, p - 1, comparator)
    qsort(tbl, p + 1, hi, comparator)
  end
end

local function lessThan (a, b)
  return a < b
end

local function quickSort (tbl, comparator)
  qsort(tbl, 1, #tbl, comparator or lessThan)
end

return quickSort

end)()
--- END quick_sort.lua


--- BEGIN quick_sort_generic.lua
export.quick_sort_generic = (function ()
--[[

  A generic quick sort implementation. It requires the collection passed in to
  be sequential and sortable. It sorts the collection in place.

  The required methods on the `collection` are:

  -- compute the length of the collection
  -- this does not use the #/__len meta event, because we are compatible with 5.1
  :length() -> number

  -- retrieve one element by its index
  :get(integer) -> element

  -- swap the elements that exist on the indices
  :swap(integer, integer) -> nil

]]

local function partition (collection, lo, hi, comparator)
  local pivot = collection:get(hi)
  local i = lo
  for j = i, hi do
    if comparator(collection:get(j), pivot) then
      collection:swap(i, j)
      i = i + 1
    end
  end
  collection:swap(i, hi)
  return i
end

local function qsort (collection, lo, hi, comparator)
  if lo < hi then
    local p = partition(collection, lo, hi, comparator)
    qsort(collection, lo, p - 1, comparator)
    qsort(collection, p + 1, hi, comparator)
  end
end

local function lessThan (a, b)
  return a < b
end

local function quickSort (collection, comparator)
  qsort(collection, 1, collection:length(), comparator or lessThan)
end

return quickSort

end)()
--- END quick_sort_generic.lua


--- BEGIN table_list.lua
export.table_list = (function ()
--[[

  This is a List type implemented using "arrays" in the form of tables.

  Insertion and deletion of elements in all but the end are not fast.

]]

local prototype = require('prototype')
local tables = require('tables')
local func = require('func')

local quickSort = require('quick_sort_generic')

local List

List = prototype {}

function List.__tostring (self)
  if self:isEmpty() then
    return 'List()'
  end

  local s = 'List('
  for i, v in self:iter() do
    s = s..tostring(v)
    if i ~= #self then
      s = s..', '
    end
  end

  return s..')'
end

function List.insert (self, index, element)
  table.insert(self, index, element)
end

function List.prepend (self, element)
  table.insert(self, 1, element)
end

function List.removeAt (self, index)
  table.remove(self, index)
end

function List.shift (self)
  return table.remove(self, 1)
end

function List.iter (self)
  return ipairs(self)
end

function List.length (self)
  return #self
end

function List.isEmpty (self)
  return #self == 0
end

function List.append (self, element)
  self[#self + 1] = element
end

function List.pop (self)
  return table.remove(self, #self)
end

function List.map (self, transform)
  return List(tables.map(self, transform))
end

function List.swap (self, i1, i2)
  local temp = self[i1]
  self[i1] = self[i2]
  self[i2] = temp
end

-- function List.slice (self, start, end) ... end

function List.clone (self)
  local newList = List.new()
  for _, e in self:iter() do
    newList:append(e)
  end
  return newList
end

function List.sortInPlace (self, comparator)
  quickSort(self, comparator)
end

-- insertion sort. I think this is a stable sort, but I gotta analyse it more.
-- could have been implemented via:
-- local l = self:clone()
-- l:sortInPlace()
-- return l
function List.sort (self, comparator)
  comparator = comparator or func.lt
  local l = List.new()
  for _, e in self:iter() do
    if #l == 0 then
      l[1] = e
    else
      local handled = false
      for i, e2 in l:iter() do
        if comparator(e, e2) then
          l:insert(i, e)
          handled = true
          break
        end
      end
      if not handled then
        l:append(e)
      end
    end
  end

  return l
end

function List.cons (element, list)
  local result = List.new {element}
  if list == nil then
    return result
  end

  for i, e in list:iter() do
    result:append(e)
  end

  return result
end

function List.get (self, index)
  return self[index]
end

-- TODO: consider a generator instead
function List.skip (self, count)
  local result = List.new()
  local min = self:length(), count + 1
  for i = count + 1, #self do
    result:append(self[i])
  end

  return result
end

function List.first (self)
  return self:get(1)
end

function List.last (self)
  return self:get(#self)
end

function List.__concat (self, other)
  return List(tables.concat(self, other))
end

-- O(n) time complexity
function List.contains (self, element)
  for _, e in self:iter() do
    if e == element then
      return true
    end
  end

  return false
end

function List.__div (self, other)
  other = List(other)
  local result = List.new()
  for i, v in ipairs(self) do
    if not other:contains(v) then
      result:append(v)
    end
  end

  return result
end

List.__index = function (self, key)
  if type(key) == 'number' then
    return self:get(key)
  else
    return List[key]
  end
end

function List.__newindex (self, key, element)
  if type(key) == 'number' and 1 <= key and key <= (#self + 1) then
    rawset(self, key, element)
  else
    error('Invalid index')
  end
end

function List.new (elements)
  local result = List { }

  if type(elements) == 'table' then
    for i, e in ipairs(elements) do
      result:append(e)
    end
  end

  return result
end

return List

end)()
--- END table_list.lua


--- BEGIN avl_tree.lua
export.avl_tree = (function ()
--[[

  This is an attempt at implementing an AVL tree as described here:
  https://en.wikipedia.org/wiki/AVL_tree

  It could be used as a map or dictionary, as a mapping of keys to values. The
  keys must be orderable. This implementation supports user-defined comparator
  functions, so complex keys could be used, as long as they contain data that
  uniquely identifies and (absolute) orders them.

  @example

  -- use a complex key, where each key is a table with at least the field `key`
  -- that is orderable using < and >
  -- returning a zero indicates that the keys are the same (identity)
  local t = Tree.new(function (a, b)
    if a.key < b.key then return -1 end
    if a.key > b.key then return  1 end
    return  0
  end)

  t:insert({key = 1}, 'a value stored with the key')
  t:insert({key = 2}, 'another value')

  assert(t:has {key = 2})
  assert(t:find {key = 2} == 'another value')
  t:delete {key = 2}
  assert(not t:has {key = 2})
]]

local prototype = require('prototype')

local Node = {
  _balance = 0;
  _key = nil;
  _value = nil;
  _left = nil;
  _right = nil;
}

local Tree = prototype {
  _root = nil;
  _comparator = function (key1, key2)
    if key1 < key2 then return -1 end
    if key1 > key2 then return  1 end
    return  0
  end;
}

function rebalance (tree, node)
  local rotated = false
  if node._balance > 1 then
    if node._right._balance < 0 then
      -- turn the right node triplet clockwise
      -- R<-RL ; RL<-RLR ; RLR<-R
      node._right,
      node._right._left,
      node._right._left._right = node._right._left,
      node._right._left._right,
      node._right

      node._right._right._balance = node._right._balance > -1 and 0 or 1
      node._right._balance = node._right._balance > 0 and 2 or 1
    end
    -- turn this triplet counter-clockwise
    -- N<-NR ; NRL<-N ; NR<-NRL
    node, node._right._left, node._right = node._right, node, node._right._left
    node._left._balance = 1 - node._balance
    node._balance = node._balance == 0 and -1 or 0
    rotated = true
  elseif node._balance < -1 then
    if node._left._balance > 0 then
      -- rotate left triplet counter-clockwise
      -- L<-LR ; LRL<-L ; LR<-LRL
      node._left,
      node._left._right._left,
      node._left._right = node._left._right,
      node._left,
      node._left._right._left

      node._left._left._balance = node._left._balance < 1 and 0 or -1
    end
    node, node._left._right, node._left = node._left, node, node._left._right
    node._right._balance = -1 - node._balance
    node._balance = node._balance == 0 and 1 or 0
    rotated = true
  end
  return node, rotated
end

function insert (tree, node, key, value)
  if node == nil then
    local newNode = {
      _balance = 0;
      _key = key;
      _value = value;
      _left = nil;
      _right = nil;
    }
    return newNode, 1
  end

  local grow
  local comparison = tree._comparator(key, node._key)
  if comparison == 0 then
    return node, 0
  elseif comparison < 0 then
    node._left, grow = insert(tree, node._left, key, value)
    node._balance = node._balance - grow
  else -- comparison > 0
    node._right, grow = insert(tree, node._right, key, value)
    node._balance = node._balance + grow
  end
  node, rotated = rebalance(tree, node)
  return node, (rotated or node._balance == 0) and 0 or grow
end

local LEFT = '_left'
local RIGHT = '_right'
local oppositeDirection = {[LEFT] = RIGHT ; [RIGHT] = LEFT}

local function deleteMove (tree, node, direction, multiplier)
  if node[direction] then
    local rotated, key
    node[direction], rotated, key = deleteMove(tree, node[direction], direction, multiplier)
    node._balance = node._balance + rotated * multiplier
    node, rotated = rebalance(tree, node)
    return node, (rotated or node._balance == 0) and -1 or 0, key
  else
    return node[oppositeDirection[direction]], -1, node._key
  end
end

local function delete (tree, node, key)
  local grow = 0
  local comparison = tree._comparator(key, node._key)
  if comparison == 0 then
    local key
    -- FIXME why balance vs. nil-check
    if node._balance > 0 then
      node._right, grow, key = deleteMove(tree, node._right, LEFT, -1)
    elseif node._left then
      node._left, grow, key = deleteMove(tree, node._left, RIGHT, 1)
      grow = -grow
    else
      -- return not isSubTree and nil, -1
      return nil, -1
    end
    node._key = key
    node._balance = node._balance + grow
  elseif comparison < 0 then
    node._left, grow = delete(tree, node._left, key, true)
    node._balance = node._balance - grow
  else -- comparison > 0
    node._right, grow = delete(tree, node._right, key, true)
    node._balance = node._balance + grow
  end
  node, rotated = rebalance(tree, node)
  return node, grow ~= 0 and (rotated or node._balance == 0) and -1 or 0
end

function Tree.delete (self, key)
  self._root = delete(self, self._root, key, false)
  return self
end

function Tree.insert (self, key, value)
  assert( -- FIXME this raises an error instead of the assertion failing.
    type(self._comparator(key, key)) == 'number',
    "The tree's comparator function must be able to order the keys")
  self._root = insert(self, self._root, key, value)
  return self
end

local function find (tree, node, key)
  if node == nil then
    return nil
  end

  local comparison = tree._comparator(key, node._key)
  if comparison == 0 then
    return node
  elseif comparison < 0 then
    return find(tree, node._left, key)
  else -- comparison > 0
    return find(tree, node._right, key)
  end
end

function Tree.has (self, key)
  return find(self, self._root, key) ~= nil
end

function Tree.find (self, key)
  local node = find(self, self._root, key)
  if node then
    return node._value
  else
    error(string.format('The element for key=%s does not exist', tostring(key)))
  end
end

function Tree.insertMany (self, keys)
  for _, v in ipairs(keys) do
    if type(v) == 'table' then
      self:insert(v[1], v[2])
    else
      self:insert(v)
    end
  end
  return self
end

function Tree.__tostring (self)
  local function stringifyNode (node)
    local s = ''
    if node == nil then
      return s
    end

    if node._left then
      s = s..stringifyNode(node._left)..', '
    end
    s = s..tostring(node._key)
    if node._right then
      s = s..', '..stringifyNode(node._right)
    end
    return s
  end
  return string.format('Tree(%s)', stringifyNode(self._root))
end

local function enumerate (node, tbl)
  tbl = tbl or {}
  if node._left ~= nil then
    enumerate(node._left, tbl)
  end
  tbl[#tbl + 1] = node._key
  if node._right ~= nil then
    enumerate(node._right, tbl)
  end
  return tbl
end

function Tree.enumerate (self)
  return enumerate(self._root)
end

function Tree.iter (self)
  return ipairs(self:enumerate())
end

function Tree.new (comparator)
  local tree = Tree {
    _comparator = comparator
  }
  return tree
end

return Tree

end)()
--- END avl_tree.lua


--- BEGIN linked_list.lua
export.linked_list = (function ()
local prototype = require('prototype')

local Node = prototype {
  _element = nil;
  _next = nil;
}
function Node.new (element)
  return Node { _element = element; }
end

local List

List = prototype {
  Node = Node;
  _head = nil;
}

function List.__tostring (self)
  local s = 'List('
  for i, v in self:iter() do
    s = s..tostring(v)..', '
  end

  return s:sub(1, -3)..')'
end

function List.insertAfterNode (self, node, newNode)
  newNode._next = node._next
  node._next = newNode
end

function List.prependNode (self, newNode)
  newNode._next = self._head
  self._head = newNode
end

function List.prepend (self, element)
  return self:prependNode(Node.new(element))
end

function List.removeAfterNode (self, node)
  local obsoleteNode = node._next
  if node._next ~= nil then
    node._next = node._next._next
  end
end

function List.removeFirstNode (self)
  local obsoleteNode = self._head
  if self._head ~= nil then
    self._head = self._head._next
  end
end

function List.iter (self)
  local currentNode = self._head
  local count = 0
  return function ()
    count = count + 1
    local result = currentNode
    if result ~= nil then
      currentNode = currentNode._next
      return count, result._element
    end
  end
end

function List.length (self)
  local count = 0
  for _, _ in self:iter() do
    count = count + 1
  end

  return count
end

function List.isEmpty (self)
  return self._head == nil
end

function List.map (self, transform)
  if self:isEmpty() then
    return List.new()
  end

  local result = List.new()
  local currentNode = nil
  local lastNode = nil
  local firstNode = nil
  for i, e in self:iter() do
    currentNode = Node.new(transform(e, i))
    if firstNode == nil then
      firstNode = currentNode
    end
    if lastNode ~= nil then
      lastNode._next = currentNode
    end
    lastNode = currentNode
  end
  result._head = firstNode
  return result
end

function List.cons (element, list)
  if list == nil then
    return List.new { element }
  end
  local result = List.new()
  result._head = Node.new(element)
  -- result._head._next = list._head
  local currentNode = result._head
  for _, e in list:iter() do
    currentNode._next = Node.new(e)
    currentNode = currentNode._next
  end
  return result
end

function List.new (elements)
  local result = List {}
  if type(elements) == 'table' then
    for i = #elements, 1, -1 do
      result:prepend(elements[i])
    end
  end

  return result
end

return List

end)()
--- END linked_list.lua


--- BEGIN doubly_linked_list.lua
export.doubly_linked_list = (function ()
local prototype = require('prototype')

-- for sortInPlace
local quickSort = require('quick_sort_generic')
-- for sort
local quickSortTable = require('quick_sort')

--[[

  This is an implementation of the List abstract data type. It is a circular
  doubly linked list, so appending and prepending are O(1) operations. The
  length of the list is cached, so reading that state is also O(1). However,
  removing and inserting items are linear in time complexity: O(n) because of a
  linear search to find the element to insert after or remove. Reverse
  operations are supported and have the same time complexity as forward
  operations.

  It is implemented with "external" structures (node elements), so the elements
  that are stored in it are _not_ mutated by the data structure. This is worse
  for space complexity, but better for sanity. Also makes it possible to store
  the same object in different list instances.

  Reasons for using this would be to allow for efficient appending or prepending
  of items, when random access is not as important. Because it is circular, it
  can be thought of as a "ring" that supports moving the head efficiently both
  forwards and backwards. Also works nicely if reverse iteration is needed.

  This data structure would fit nicely when implementing a Queue or a Stack.

  If random access is more important, try using a `table_list` instead.

  TODO:
  addRange

  insertBefore
  insertAfter

  replace

  last

  sort -- in place?

  filter
  reduce

]]

-- Internal data structure. Represents a single node in the list.
-- Instances of this prototype havea link to the previous and next nodes
local Node = {}
function Node.new (element)
  local node = {
      _element = element;
      _prevNode = nil;
      _nextNode = nil;
  }
  node._prevNode = node
  node._nextNode = node
  return node
end

-- This is the actual module.
local List = prototype {}

-- Stringifies the list by enumerating the elements in the list starting with
-- the head and continues forward concatenating a comma separated string
function List.__tostring (self)
  local str = ''
  for i, v in self:iter() do
    str = str..tostring(v)
    if i < self._length then
      str = str..', '
    end
  end
  return string.format('List(%s)', str)
end

-- Moves the head by `diff` steps in an efficient manner. `diff` may be
-- negative, and in which case the head moves backwards.
function List.moveHead (self, diff)
  if diff == 0 or self:isEmpty() then
    return
  elseif diff < 0 then
    while diff < 0 do
      diff = diff + 1
      self._head = self._head._prevNode
    end
  elseif diff > 0 then
    while diff > 0 do
      diff = diff - 1
      self._head = self._head._nextNode
    end
  end
end;

-- returns the pre-computed length of the list. Cheap operation.
function List.length (self)
  return self._length
end

-- Lua 5.2+, support for the #-operator.
function List.__len (self)
  return self:length()
end

-- Returns a generator which will yield [i, e], where `i` is the index (1-based)
-- and `e` is the element at index `i`.
function List.iter (self)
  local currentNode = self._head
  local index = 0
  return function ()
    index = index + 1
    if index <= self:length() then
      local result = currentNode
      currentNode = currentNode._nextNode
      return index, result._element
    end
  end
end

-- Like `iter` only it walks backwards instead of forwards.
function List.iterReverse (self)
  if self:isEmpty() then
    return function ()
    end
  end

  local currentNode = self._head --._prevNode
  local index = self:length()
  return function ()
    if index >= 1 then
      index = index - 1
      local result = currentNode
      currentNode = currentNode._prevNode
      return index, result._element
    end
  end
end

-- Enumerate the list and constructs a table representing the list.
function List.enumerate (self)
  local collect = {}
  for _, e in self:iter() do
    table.insert(collect, e)
  end
  return collect
end

-- Allows for using `ipairs` with an instance of the list. Works the same as if
-- you would use :iter() directly
function List.__ipairs (self)
  return self:iter()
end

-- Allows for using `..` to concatenate two `List`s. As in `list3 = list1..list2`
function List.__concat (self, other)
  local newList = List.new()
  for _, v1 in self:iter() do
    newList:add(v1)
  end
  for _, v2 in other:iter() do
    newList:add(v2)
  end
  return newList
end

-- Appends an element to the end of the list.
function List.append (self, element)
  local newNode = Node.new(element)
  if self._head == nil then
    self._head = newNode
  else
    local endNode = self._head._prevNode
    endNode._nextNode = newNode
    self._head._prevNode = newNode
    newNode._prevNode = endNode
    newNode._nextNode = self._head
  end

  self._length = self._length + 1
end

-- Alias for `append`
function List.add (self, element)
  return self:append(element)
end

-- Finds the first node in the list whose element is equal to `element`
function List.find (self, element)
  local found = false
  local reference = nil
  local currentNode = self._head
  local count = 0
  while count < self._length and not found do
    count = count + 1
    if currentNode._element == element then
      found = true
      reference = currentNode
    else
      currentNode = currentNode._nextNode
    end
  end

  return reference
end

-- Tests whether a node exists in the list whose element is equal to `element`
function List.contains (self, element)
  return self:find(element) ~= nil
end

-- Finds a node in the list based on the index
function List.findAt (self, index)
  local found = false
  local reference = nil
  local currentNode = self._head

  local count = 1
  -- FIXME: if index is greater than half of length, we should iterate
  -- backwards. Still linear, but hey.
  while count < index and count <= self._length do
    currentNode = currentNode._nextNode
    count = count + 1
  end

  return currentNode
end

-- Removes the first node from the list whose element is equal to `element`
function List.remove (self, element)
  local reference = self:find(element)
  if reference ~= nil then
    local p, n = reference._prevNode, reference._nextNode
    if reference == self._head then
      if self._length == 1 then
        self._head = nil
      else
        self._head = n
      end
    end
    if p ~= nil then
      p._nextNode = n
    end
    if n ~= nil then
      n._prevNode = p
    end
    reference._prevNode = nil
    reference._nextNode = nil

    self._length = self._length - 1
    return true
  else
    return false
  end
end

-- Removes the node at `index`
function List.removeAt (self, index)
  local reference = self:findAt(index)
  if reference ~= nil then
    local p, n = reference._prevNode, reference._nextNode
    if reference == self._head then
      if self._length == 1 then
        self._head = nil
      else
        self._head = n
      end
    end
    if p ~= nil then
      p._nextNode = n
    end
    if n ~= nil then
      n._prevNode = p
    end
    reference._prevNode = nil
    reference._nextNode = nil

    self._length = self._length - 1
    return true
  else
    return false
  end
end

function List.pop (self)
  if self:isEmpty() then
    return nil
  end
  local element = self._head._element
  self:removeAt(1)
  return element
end

function List.popLast (self)
  if self:isEmpty() then
    return nil
  elseif self:length() == 1 then
    return self:pop()
  else
    local node = self._head._prevNode
    node._prevNode._nextNode = self._head
    self._head._prevNode = node._prevNode
    node._prevNode = nil
    node._nextNode = nil
    return node._element
  end
end

-- Gets the node's element at `index`
-- This is O(n) time complexity, because indices are not cached
function List.get (self, index)
  for i, v in self:iter() do
    if i == index then
      return v
    end
  end
end;

-- Inserts an element in a new node at `index`, if the index is in the interval
-- [1,#list+1]
function List.insertAt(self, index, element)
  if self._length == 0 then
    if index == 1 then
      self._head = Node.new(element)
      self._length = 1
      return
    else
      error('Out of bounds')
    end
  end
  local currentNode = self:findAt(index)
  if currentNode == nil then
    return
  end
  local newNode = Node.new(element)
  local prevNode = currentNode._prevNode
  prevNode._nextNode = newNode
  newNode._prevNode = prevNode
  newNode._nextNode = currentNode
  currentNode._prevNode = newNode
  if index == 1 then
    self._head = newNode
  end
  self._length = self._length + 1
end

-- Allows for assigning new elements using the `list[n] = v` syntax
function List.__newindex (self, index, element)
  if type(index) == 'number' then
    return self:insertAt(index, element)
  else
    rawset(self, index, element)
  end
end

-- Inserts an element in a new node at the start of the list.
-- Cheap operation.
function List.prepend (self, element)
  self:insertAt(1, element)
end

-- Indicates whether the list has any nodes at all or not.
function List.isEmpty (self)
  return self._head == nil
end

-- Gets the element of the first node in the list.
function List.first (self)
  if self:isEmpty() then
    return nil
  end
  return self._head._element
end

-- Gets the element of the last node in the list.
function List.last (self)
  if self:isEmpty() then
    return nil
  else
    return self._head._prevNode._element
  end
end

-- Returns a new list where the first `count` nodes are not in
function List.skip (self, count)
  local result = List.new()
  for i, e in self:iter() do
    if i > count then
      result:append(e)
    end
  end
  return result
end;

-- Applies a transform on each element in the list, building a new list and
-- returning that as the result
function List.map (self, transform)
  local result = List.new()
  for i, e in self:iter() do
    result:append(transform(e, i))
  end
  return result
end

-- Swaps the links to the elements stored in the nodes found at the indices `i1`
-- and `i2`. Linear search, so O(n), but the swap itself is cheap.
function List.swap (self, i1, i2)
  local node1 = self:findAt(i1)
  local node2 = self:findAt(i2)
  local temp = node1._element
  node1._element = node2._element
  node2._element = temp
end;

function List.sortInPlace (self, comparator)
  quickSort(self, comparator)
end

-- FIXME: insertion sort would be better perhaps. Or enumerating into an array, and sorting that, because of bad performance on random access/linear search.
function List.sort (self, comparator)
  -- local result = List.new()
  -- for _, e in self:iter() do
  --   result:append(e)
  -- end
  -- result:sortInPlace(comparator)
  -- return result
  local t = self:enumerate()
  quickSortTable(t)
  return List.new(t)
end

-- Allows indexing the list by list[x], but still be able to look up metatable
-- methods.
List.__index = function (self, key)
  if type(key) == 'number' then
    return self:get(key)
  else
    return List[key]
  end
end


-- `new` creates a new List. The first and only argument is optional, and if it
-- is a table, all (ipairs) elements of the table will be appended in order to
-- the new list
function List.new (elements)
  local list = List {
    _length = 0;
    _head = nil;
  }

  if type(elements) == 'table' then
    for _, element in ipairs(elements) do
      list:append(element)
    end
  end

  return list
end


-- `cons` constructs a new List by prepending the `element` to the `list`
--
-- @example
-- local l1 = List.new()
-- local l2 = List.cons(1, l1)
-- assert(l1:length() == 0 and l2:length() == 1 and l1 ~= l2)
function List.cons (element, list)
  local result = List.new()
  result:append(element)

  for _, e in list:iter() do
    result:append(e)
  end

  return result
end

return List

end)()
--- END doubly_linked_list.lua


--- BEGIN max_heap.lua
export.max_heap = (function ()
--[[

  This is an implementation of a max heap. It is procedural/imperative, in that
  it is mutated when insert or pop are invoked so that the next element is the
  one with the highest (>) priority.

  The public API for creating an instance is:

  `MaxHeap.new()` creates a new, empty, instance

  `MaxHeap.from(tuples)` creates a new instance with the supplied elements.
  `tuples` is a linear table where each item is a tuple of {priority, element}.

  The public API for an instance of MaxHeap is:

  `heap:insert(priority, element)` inserts an element with the specified
  priority, updating the internal structure as necessary.

  `heap:pop()` pops the next element off of the heap (the element with the
  highest priority), updating the internal structure as necessary. An error is
  raised if this is invoked on a heap with no elements.

  `heap:isEmpty()` indicates whether this heap instance has elements or not.

]]

local prototype = require('prototype')
local tables = require('tables')

local MaxHeap = prototype {}

function MaxHeap.new ()
  return MaxHeap { _root = nil; }
end

function MaxHeap.isEmpty (self)
  return self._root == nil
end

local function compare (n1, n2)
  return n1.priority > n2.priority
end

local function meld (node1, node2)
  if node1 == nil then
    return node2
  elseif node2 == nil then
    return node1
  elseif compare(node1, node2) then
    local subnodes = node1.subnodes
    subnodes[#subnodes + 1] = node2
    return {
      priority=node1.priority,
      element=node1.element,
      subnodes=subnodes
    }
  else
    local subnodes = node2.subnodes
    subnodes[#subnodes + 1] = node1
    return {
      priority=node2.priority,
      element=node2.element,
      subnodes=subnodes
    }
  end
end

local function mergePairs (nodes)
  if #nodes == 0 then
    return nil
  elseif #nodes == 1 then
    return table.remove(nodes, 1)
  else
    local n1, n2 = table.remove(nodes, #nodes), table.remove(nodes, #nodes-1)
    return meld(meld(n1, n2), mergePairs(nodes))
  end
end

function MaxHeap.insert (self, priority, element)
  local newNode = {priority=priority, element=element, subnodes={}}
  self._root = meld(self._root, newNode)
end

function MaxHeap.pop (self)
  if self:isEmpty() then
    error('Cannot pop from an empty heap.')
  end
  local e = self._root.element
  self._root = mergePairs(self._root.subnodes)
  return e
end

function MaxHeap.from (tuples)
  local h = MaxHeap.new()
  for _, tuple in ipairs(tuples) do
    h:insert(tuple[1], tuple[2])
  end
  return h
end

function MaxHeap.__tostring (self)
  if self:isEmpty() then
    return 'MaxHeap()'
  end
  if #self._root.subnodes == 0 then
    return string.format(
      'MaxHeap(%s)', self._root.element)
  end
  return string.format(
    'MaxHeap(%s...)', self._root.element)
end

return MaxHeap

end)()
--- END max_heap.lua


--- BEGIN min_heap.lua
export.min_heap = (function ()
--[[
  Pairing (min) heap. Used https://en.wikipedia.org/wiki/Pairing_heap as reference.

  This heap has a "functional" interface in that it returns a new heap object on each "mutation".
  TODO: consider a less "functional" implementation and interface.
]]

local prototype = require('prototype')
local List = require('table_list')

local MinHeap

MinHeap = prototype {
  __tostring = function (self)
    if self:isEmpty() then
      return 'MinHeap(Empty)'
    elseif self._subheaps:isEmpty() then
      return string.format(
        'MinHeap(%s)',
        self._element)
    else
      local subheaps = self._subheaps:map(tostring)
      local rest = ''
      for i, h in subheaps:iter() do
        rest = rest..h
        if i < subheaps:length() then
          rest = rest..', '
        end
      end
      return string.format(
        'MinHeap(%s| %s)',
        self._element,
        rest)
    end
  end;
  isEmpty = function (self)
    return self._isEmpty
  end;
  pop = function (self)
    if self:isEmpty() then
      error('This heap is empty, so cannot pop an element.')
    else
      return self._element, MinHeap.mergePairs(self._subheaps)
    end
  end;
  peek = function (self)
    if self:isEmpty() then
      error('This heap is empty, so cannot peek.')
    else
      return self._element
    end
  end;
  meld = function (self, heap2)
    if self:isEmpty() then
      return heap2
    elseif heap2:isEmpty() then
      return self
    elseif MinHeap.compare(self, heap2) then
      return MinHeap.new(
        self._priority,
        self._element,
        List.cons(heap2, self._subheaps)
      )
    else
      return MinHeap.new(
        heap2._priority,
        heap2._element,
        List.cons(self, heap2._subheaps)
      )
    end
  end;
  insert = function (self, priority, element)
    return self:meld(MinHeap.new(priority, element))
  end;
}

function MinHeap.new (priority, element, subheaps)
  local instance = MinHeap {
    _priority = priority;
    _element = element;
    _subheaps = subheaps or List.new();
  }

  return instance
end

MinHeap.empty = MinHeap {
  _priority = 0;
  _isEmpty = true;
  _subheaps = List.new()
}

function MinHeap.compare (heap1, heap2)
  return heap1._priority < heap2._priority
end

function MinHeap.mergePairs (heaps)
  if heaps:isEmpty() then
    return MinHeap.empty
  elseif heaps:length() == 1 then
    return heaps:first()
  else
    local h1, h2 = heaps[1], heaps[2]
    return h1:meld(h2):meld(MinHeap.mergePairs(heaps:skip(2)))
  end
end

function MinHeap.from (tuples)
  local result = MinHeap.empty
  for _, tuple in ipairs(tuples) do
    result = result:insert(tuple[1], tuple[2])
  end
  return result
end

return MinHeap

end)()
--- END min_heap.lua


--- BEGIN quad_tree.lua
export.quad_tree = (function ()
--[[

  https://en.wikipedia.org/wiki/Quadtree

]]

local prototype = require('prototype')
local tables = require('tables')

local Vector2 = prototype {x=0; y=0}

function Vector2.length (self)
  return self.x * math.cos(self.x) + self.y * math.sin(self.y)
end

function Vector2.normal (self)
  return Vector2 {
    math.cos(self.x);
    math.sin(self.y);
  }
end

function Vector2.__tostring (self)
  return string.format('[%d; %d]', self.x, self.y)
end


local Box = prototype {
  center = Vector2 {};
  halfDimension = 0.0;
}

function Box.new (init)
  return Box {
    center = Vector2(init.center);
    halfDimension = init.halfDimension
  }
end

function Box.corners (self)
  --[[
    1 +---+ 2
      |   |
    4 +---+ 3
  ]]
  return {
    Vector2 {self.center.x - self.halfDimension, self.center.y + self.halfDimension};
    Vector2 {self.center.x + self.halfDimension, self.center.y + self.halfDimension};
    Vector2 {self.center.x + self.halfDimension, self.center.y - self.halfDimension};
    Vector2 {self.center.x - self.halfDimension, self.center.y - self.halfDimension};
  }
end

function Box.contains (self, point)
  local x1, x2 = self.center.x - self.halfDimension, self.center.x + self.halfDimension
  local y1, y2 = self.center.y - self.halfDimension, self.center.y + self.halfDimension
  -- not sure if it should be <= or <
  return x1 <= point.x and point.x <= x2 and
    y1 <= point.y and point.y <= y2
end

function Box.intersects (self, box)
  local points = box:corners()
  return self:contains(points[1]) or
    self:contains(points[2]) or
    self:contains(points[3]) or
    self:contains(points[4])
end

local QTREE_CAPACITY = 4
local QTree = prototype {
  boundary = Box {};
  points = {};

  -- QTree references
  nw = nil;
  ne = nil;
  sw = nil;
  se = nil;
}

function QTree.new (boundary)
  return QTree {
    boundary = Box(boundary);
    points = {};
  }
end

function QTree.insert (self, point)
  point = Vector2(point)
  if not self.boundary:contains(point) then
    return false
  end

  if #self.points < QTREE_CAPACITY and self.nw == nil then
    self.points[#self.points + 1] = point
    return true
  end

  if self.nw == nil then
    self:subdivide()
  end

  if self.nw:insert(point) then return true end
  if self.ne:insert(point) then return true end
  if self.sw:insert(point) then return true end
  if self.se:insert(point) then return true end

  error('This should not occur')
end

function QTree.subdivide (self)
  local box = self.boundary
  local newDim = box.halfDimension / 2
  self.nw = QTree.new {
    center = {x=box.center.x - newDim; y=box.center.y + newDim};
    halfDimension = newDim;
  }
  self.ne = QTree.new {
    center = {x=box.center.x + newDim; y=box.center.y + newDim};
    halfDimension = newDim;
  }
  self.sw = QTree.new {
    center = {x=box.center.x - newDim; y=box.center.y - newDim};
    halfDimension = newDim;
  }
  self.se = QTree.new {
    center = {x=box.center.x + newDim; y=box.center.y - newDim};
    halfDimension = newDim;
  }
end

function QTree.hasChildren (self)
  return self.nw ~= nil
end

function QTree.queryRange (self, range)
  range = Box(range)
  local results = {}
  if not self.boundary:intersects(range) then
    return results
  end

  for _, p in ipairs(self.points) do
    if range:contains(p) then
      results[#results + 1] = p
    end
  end

  if not self:hasChildren() then
    return results
  end


  return tables.concat(
    results,
    self.nw:queryRange(range),
    self.ne:queryRange(range),
    self.sw:queryRange(range),
    self.se:queryRange(range)
  )
end

local function dump (tree, name, depth)
  depth = depth or 0
  name = name or ''
  local s = string.rep('\t', depth)..name..':QTree('
  for i, p in ipairs(tree.points) do
    if i > 1 then
      s = s..', '
    end
    s = s..tostring(p)
  end
  local hasChildren = false
  local function str (name, t)
    if t ~= nil then
      hasChildren = true
      s = s..'\n'..dump(t, name, depth + 1)
    end
  end
  str('nw', tree.nw)
  str('ne', tree.ne)
  str('sw', tree.sw)
  str('se', tree.se)
  if hasChildren then
    s = s..string.format('\n%s)', string.rep('\t', depth))
  else
    s = s..')'
  end

  return s
end

function QTree.__tostring (self)
  return dump(self, nil, 0)
end

return QTree

end)()
--- END quad_tree.lua


--- BEGIN queue.lua
export.queue = (function ()
--[[

  This is an implementation of a simple queue data structure (first in, first out).

]]

local prototype = require('prototype')
local List = require('doubly_linked_list')

local Queue = prototype {}

function Queue.new ()
  return Queue { _data = List.new() }
end

function Queue.length (self)
  return self._data:length()
end

function Queue.__len (self)
  return self:length()
end

function Queue.isEmpty ()
  return self._data:isEmpty()
end

function Queue.push (self, element)
  return self._data:append(element)
end

function Queue.peek (self)
  return self._data:get(1)
end

function Queue.pop (self)
  return self._data:pop()
end

return Queue

end)()
--- END queue.lua


--- BEGIN set.lua
export.set = (function ()
local prototype = require('prototype')

local Set
Set = prototype {
  _size = 0;

  __tostring = function (self)
    local contents = ''
    for k in self:iter() do
      contents = contents..tostring(k)..', '
    end
    contents = contents:sub(1, -3)
    return string.format('Set(%s)', contents)
  end;

  add = function (self, element)
    if self._data[element] == nil then
      self._data[element] = true
      self._size = self._size + 1
    end
    return self
  end;

  remove = function (self, element)
    if self._data[element] == true then
      self._data[element] = nil
      self._size = self._size - 1
      return self, element
    end
    return self, nil
  end;

  has = function (self, element)
    return self._data[element] == true
  end;

  union = function (self, other)
    local result = Set.new()
    for k in self:iter() do
      result:add(k)
    end
    for k in other:iter() do
      result:add(k)
    end

    return result
  end;

  difference = function (self, other)
    local result = Set.new()
    for k in self:iter() do
      result:add(k)
    end
    for k in other:iter() do
      if not self:has(k) then
        result:add(k)
      end
    end

    return result
  end;

  intersect = function (self, other)
    local result = Set.new()
    for k in self:iter() do
      if other:has(k) then
        result:add(k)
      end
    end

    return result
  end;

  iter = function (self)
    return pairs(self._data)
  end;

  size = function (self)
    return self._size
  end;
}

function Set.new ()
  return Set {
    _size = 0;
    _data = {};
  }
end

function Set.from (elements)
  local set = Set.new()

  if type(elements) == 'table' and #elements > 0 then
    for _, v in ipairs(elements) do
      set:add(v)
    end
  end

  return set
end

return Set

end)()
--- END set.lua


--- BEGIN stack.lua
export.stack = (function ()
--[[

  This is an implementation of a simple stack data structure (last in, first out).

]]

local prototype = require('prototype')
local List = require('doubly_linked_list')

local Stack = prototype {}

function Stack.new ()
  return Stack { _data = List.new() }
end

function Stack.length (self)
  return self._data:length()
end

function Stack.__len (self)
  return self:length()
end

function Stack.isEmpty ()
  return self._data:isEmpty()
end

function Stack.push (self, element)
  return self._data:prepend(element)
end

function Stack.peek (self)
  return self._data:get(1)
end

function Stack.pop (self)
  return self._data:pop()
end

return Stack

end)()
--- END stack.lua


--- BEGIN curried.lua
export.curried = (function ()
local tables = require('tables')

local curried = {}

-- ((a, b) -> a) -> a -> Listof b -> a
function curried.reduce (fn)
  return function (init)
    return function (tbl)
      return tables.reduce(tbl, fn, init)
    end
  end
end

-- (a -> b) -> Listof a -> Listof b
function curried.map (fn)
  return function (tbl)
    return tables.map(tbl, fn)
  end
end

-- (a -> boolean) -> Listof a -> Listof a
function curried.filter (fn)
  return function (tbl)
    return tables.filter(tbl, fn)
  end
end

return curried

end)()
--- END curried.lua


--- BEGIN pubsub.lua
export.pubsub = (function ()
local List = require('doubly_linked_list')
local prototype = require('prototype')

local Pubsub = prototype {}

function Pubsub.new (config)
  config = config or {}
  return Pubsub {
    name = config.name;
    listeners = List.new();
  }
end

function Pubsub.subscribe (self, listener)
  self.listeners:append(listener)
end

function Pubsub.unsubscribe (self, listener)
  self.listeners:remove(listener)
end

function Pubsub.publish (self, ...)
  for _, listener in self.listeners:iter() do
    listener(...)
  end
end

function Pubsub.__call (self, ...)
  self:publish(...)
end

return Pubsub

end)()
--- END pubsub.lua


--- BEGIN utf8.lua
export.utf8 = (function ()
-- $Id: utf8.lua 179 2009-04-03 18:10:03Z pasta $
--
-- Provides UTF-8 aware string functions implemented in pure lua:
-- * utf8len(s)
-- * utf8sub(s, i, j)
-- * utf8reverse(s)
-- * utf8char(unicode)
-- * utf8unicode(s, i, j)
-- * utf8gensub(s, sub_len)
-- * utf8find(str, regex, init, plain)
-- * utf8match(str, regex, init)
-- * utf8gmatch(str, regex, all)
-- * utf8gsub(str, regex, repl, limit)
--
-- If utf8data.lua (containing the lower<->upper case mappings) is loaded, these
-- additional functions are available:
-- * utf8upper(s)
-- * utf8lower(s)
--
-- All functions behave as their non UTF-8 aware counterparts with the exception
-- that UTF-8 characters are used instead of bytes for all units.

--[[
Copyright (c) 2006-2007, Kyle Smith
All rights reserved.

Contributors:
	Alimov Stepan

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of its contributors may be
      used to endorse or promote products derived from this software without
      specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--]]

-- ABNF from RFC 3629
--
-- UTF8-octets = *( UTF8-char )
-- UTF8-char   = UTF8-1 / UTF8-2 / UTF8-3 / UTF8-4
-- UTF8-1      = %x00-7F
-- UTF8-2      = %xC2-DF UTF8-tail
-- UTF8-3      = %xE0 %xA0-BF UTF8-tail / %xE1-EC 2( UTF8-tail ) /
--               %xED %x80-9F UTF8-tail / %xEE-EF 2( UTF8-tail )
-- UTF8-4      = %xF0 %x90-BF 2( UTF8-tail ) / %xF1-F3 3( UTF8-tail ) /
--               %xF4 %x80-8F 2( UTF8-tail )
-- UTF8-tail   = %x80-BF
--

local byte    = string.byte
local char    = string.char
local dump    = string.dump
local find    = string.find
local format  = string.format
local len     = string.len
local lower   = string.lower
local rep     = string.rep
local sub     = string.sub
local upper   = string.upper

-- returns the number of bytes used by the UTF-8 character at byte i in s
-- also doubles as a UTF-8 character validator
local function utf8charbytes (s, i)
	-- argument defaults
	i = i or 1

	-- argument checking
	if type(s) ~= "string" then
		error("bad argument #1 to 'utf8charbytes' (string expected, got ".. type(s).. ")")
	end
	if type(i) ~= "number" then
		error("bad argument #2 to 'utf8charbytes' (number expected, got ".. type(i).. ")")
	end

	local c = byte(s, i)

	-- determine bytes needed for character, based on RFC 3629
	-- validate byte 1
	if c > 0 and c <= 127 then
		-- UTF8-1
		return 1

	elseif c >= 194 and c <= 223 then
		-- UTF8-2
		local c2 = byte(s, i + 1)

		if not c2 then
			error("UTF-8 string terminated early")
		end

		-- validate byte 2
		if c2 < 128 or c2 > 191 then
			error("Invalid UTF-8 character")
		end

		return 2

	elseif c >= 224 and c <= 239 then
		-- UTF8-3
		local c2 = byte(s, i + 1)
		local c3 = byte(s, i + 2)

		if not c2 or not c3 then
			error("UTF-8 string terminated early")
		end

		-- validate byte 2
		if c == 224 and (c2 < 160 or c2 > 191) then
			error("Invalid UTF-8 character")
		elseif c == 237 and (c2 < 128 or c2 > 159) then
			error("Invalid UTF-8 character")
		elseif c2 < 128 or c2 > 191 then
			error("Invalid UTF-8 character")
		end

		-- validate byte 3
		if c3 < 128 or c3 > 191 then
			error("Invalid UTF-8 character")
		end

		return 3

	elseif c >= 240 and c <= 244 then
		-- UTF8-4
		local c2 = byte(s, i + 1)
		local c3 = byte(s, i + 2)
		local c4 = byte(s, i + 3)

		if not c2 or not c3 or not c4 then
			error("UTF-8 string terminated early")
		end

		-- validate byte 2
		if c == 240 and (c2 < 144 or c2 > 191) then
			error("Invalid UTF-8 character")
		elseif c == 244 and (c2 < 128 or c2 > 143) then
			error("Invalid UTF-8 character")
		elseif c2 < 128 or c2 > 191 then
			error("Invalid UTF-8 character")
		end

		-- validate byte 3
		if c3 < 128 or c3 > 191 then
			error("Invalid UTF-8 character")
		end

		-- validate byte 4
		if c4 < 128 or c4 > 191 then
			error("Invalid UTF-8 character")
		end

		return 4

	else
		error("Invalid UTF-8 character")
	end
end

-- returns the number of characters in a UTF-8 string
local function utf8len (s)
	-- argument checking
	if type(s) ~= "string" then
		for k,v in pairs(s) do print('"',tostring(k),'"',tostring(v),'"') end
		error("bad argument #1 to 'utf8len' (string expected, got ".. type(s).. ")")
	end

	local pos = 1
	local bytes = len(s)
	local length = 0

	while pos <= bytes do
		length = length + 1
		pos = pos + utf8charbytes(s, pos)
	end

	return length
end

-- functions identically to string.sub except that i and j are UTF-8 characters
-- instead of bytes
local function utf8sub (s, i, j)
	-- argument defaults
	j = j or -1

	local pos = 1
	local bytes = len(s)
	local length = 0

	-- only set l if i or j is negative
	local l = (i >= 0 and j >= 0) or utf8len(s)
	local startChar = (i >= 0) and i or l + i + 1
	local endChar   = (j >= 0) and j or l + j + 1

	-- can't have start before end!
	if startChar > endChar then
		return ""
	end

	-- byte offsets to pass to string.sub
	local startByte,endByte = 1,bytes

	while pos <= bytes do
		length = length + 1

		if length == startChar then
			startByte = pos
		end

		pos = pos + utf8charbytes(s, pos)

		if length == endChar then
			endByte = pos - 1
			break
		end
	end

	if startChar > length then startByte = bytes+1   end
	if endChar   < 1      then endByte   = 0         end

	return sub(s, startByte, endByte)
end

--[[
  -- replace UTF-8 characters based on a mapping table
  local function utf8replace (s, mapping)
	-- argument checking
	if type(s) ~= "string" then
  error("bad argument #1 to 'utf8replace' (string expected, got ".. type(s).. ")")
	end
	if type(mapping) ~= "table" then
  error("bad argument #2 to 'utf8replace' (table expected, got ".. type(mapping).. ")")
	end

	local pos = 1
	local bytes = len(s)
	local charbytes
	local newstr = ""

	while pos <= bytes do
  charbytes = utf8charbytes(s, pos)
  local c = sub(s, pos, pos + charbytes - 1)

  newstr = newstr .. (mapping[c] or c)

  pos = pos + charbytes
	end

	return newstr
  end


  -- identical to string.upper except it knows about unicode simple case conversions
  local function utf8upper (s)
	return utf8replace(s, utf8_lc_uc)
  end

  -- identical to string.lower except it knows about unicode simple case conversions
  local function utf8lower (s)
	return utf8replace(s, utf8_uc_lc)
  end
]]

-- identical to string.reverse except that it supports UTF-8
local function utf8reverse (s)
	-- argument checking
	if type(s) ~= "string" then
		error("bad argument #1 to 'utf8reverse' (string expected, got ".. type(s).. ")")
	end

	local bytes = len(s)
	local pos = bytes
	local charbytes
	local newstr = ""

	while pos > 0 do
		local c = byte(s, pos)
		while c >= 128 and c <= 191 do
			pos = pos - 1
			c = byte(s, pos)
		end

		charbytes = utf8charbytes(s, pos)

		newstr = newstr .. sub(s, pos, pos + charbytes - 1)

		pos = pos - 1
	end

	return newstr
end

-- http://en.wikipedia.org/wiki/Utf8
-- http://developer.coronalabs.com/code/utf-8-conversion-utility
local function utf8char(unicode)
	if unicode <= 0x7F then return char(unicode) end

	if (unicode <= 0x7FF) then
		local Byte0 = 0xC0 + math.floor(unicode / 0x40);
		local Byte1 = 0x80 + (unicode % 0x40);
		return char(Byte0, Byte1);
	end;

	if (unicode <= 0xFFFF) then
		local Byte0 = 0xE0 +  math.floor(unicode / 0x1000);
		local Byte1 = 0x80 + (math.floor(unicode / 0x40) % 0x40);
		local Byte2 = 0x80 + (unicode % 0x40);
		return char(Byte0, Byte1, Byte2);
	end;

	if (unicode <= 0x10FFFF) then
		local code = unicode
		local Byte3= 0x80 + (code % 0x40);
		code       = math.floor(code / 0x40)
		local Byte2= 0x80 + (code % 0x40);
		code       = math.floor(code / 0x40)
		local Byte1= 0x80 + (code % 0x40);
		code       = math.floor(code / 0x40)
		local Byte0= 0xF0 + code;

		return char(Byte0, Byte1, Byte2, Byte3);
	end;

	error 'Unicode cannot be greater than U+10FFFF!'
end

local shift_6  = 2^6
local shift_12 = 2^12
local shift_18 = 2^18

local utf8unicode
utf8unicode = function(str, i, j, byte_pos)
	i = i or 1
	j = j or i

	if i > j then return end

	local ch,bytes

	if byte_pos then
		bytes = utf8charbytes(str,byte_pos)
		ch  = sub(str,byte_pos,byte_pos-1+bytes)
	else
		ch,byte_pos = utf8sub(str,i,i), 0
		bytes       = #ch
	end

	local unicode

	if bytes == 1 then unicode = byte(ch) end
	if bytes == 2 then
		local byte0,byte1 = byte(ch,1,2)
		local code0,code1 = byte0-0xC0,byte1-0x80
		unicode = code0*shift_6 + code1
	end
	if bytes == 3 then
		local byte0,byte1,byte2 = byte(ch,1,3)
		local code0,code1,code2 = byte0-0xE0,byte1-0x80,byte2-0x80
		unicode = code0*shift_12 + code1*shift_6 + code2
	end
	if bytes == 4 then
		local byte0,byte1,byte2,byte3 = byte(ch,1,4)
		local code0,code1,code2,code3 = byte0-0xF0,byte1-0x80,byte2-0x80,byte3-0x80
		unicode = code0*shift_18 + code1*shift_12 + code2*shift_6 + code3
	end

	return unicode,utf8unicode(str, i+1, j, byte_pos+bytes)
end

-- Returns an iterator which returns the next substring and its byte interval
local function utf8gensub(str, sub_len)
	sub_len        = sub_len or 1
	local byte_pos = 1
	local length   = #str
	return function(skip)
		if skip then byte_pos = byte_pos + skip end
		local char_count = 0
		local start      = byte_pos
		repeat
			if byte_pos > length then return end
			char_count  = char_count + 1
			local bytes = utf8charbytes(str,byte_pos)
			byte_pos    = byte_pos+bytes

		until char_count == sub_len

		local last  = byte_pos-1
		local slice = sub(str,start,last)
		return slice, start, last
	end
end

local function binsearch(sortedTable, item, comp)
	local head, tail = 1, #sortedTable
	local mid = math.floor((head + tail)/2)
	if not comp then
		while (tail - head) > 1 do
			if sortedTable[tonumber(mid)] > item then
				tail = mid
			else
				head = mid
			end
			mid = math.floor((head + tail)/2)
		end
	end
	if sortedTable[tonumber(head)] == item then
		return true, tonumber(head)
	elseif sortedTable[tonumber(tail)] == item then
		return true, tonumber(tail)
	else
		return false
	end
end
local function classMatchGenerator(class, plain)
	local codes = {}
	local ranges = {}
	local ignore = false
	local range = false
	local firstletter = true
	local unmatch = false

	local it = utf8gensub(class)

	local skip
	for c, _, be in it do
		skip = be
		if not ignore and not plain then
			if c == "%" then
				ignore = true
			elseif c == "-" then
				table.insert(codes, utf8unicode(c))
				range = true
			elseif c == "^" then
				if not firstletter then
					error('!!!')
				else
					unmatch = true
				end
			elseif c == ']' then
				break
			else
				if not range then
					table.insert(codes, utf8unicode(c))
				else
					table.remove(codes) -- removing '-'
					table.insert(ranges, {table.remove(codes), utf8unicode(c)})
					range = false
				end
			end
		elseif ignore and not plain then
			if c == 'a' then -- %a: represents all letters. (ONLY ASCII)
				table.insert(ranges, {65, 90}) -- A - Z
				table.insert(ranges, {97, 122}) -- a - z
			elseif c == 'c' then -- %c: represents all control characters.
				table.insert(ranges, {0, 31})
				table.insert(codes, 127)
			elseif c == 'd' then -- %d: represents all digits.
				table.insert(ranges, {48, 57}) -- 0 - 9
			elseif c == 'g' then -- %g: represents all printable characters except space.
				table.insert(ranges, {1, 8})
				table.insert(ranges, {14, 31})
				table.insert(ranges, {33, 132})
				table.insert(ranges, {134, 159})
				table.insert(ranges, {161, 5759})
				table.insert(ranges, {5761, 8191})
				table.insert(ranges, {8203, 8231})
				table.insert(ranges, {8234, 8238})
				table.insert(ranges, {8240, 8286})
				table.insert(ranges, {8288, 12287})
			elseif c == 'l' then -- %l: represents all lowercase letters. (ONLY ASCII)
				table.insert(ranges, {97, 122}) -- a - z
			elseif c == 'p' then -- %p: represents all punctuation characters. (ONLY ASCII)
				table.insert(ranges, {33, 47})
				table.insert(ranges, {58, 64})
				table.insert(ranges, {91, 96})
				table.insert(ranges, {123, 126})
			elseif c == 's' then -- %s: represents all space characters.
				table.insert(ranges, {9, 13})
				table.insert(codes, 32)
				table.insert(codes, 133)
				table.insert(codes, 160)
				table.insert(codes, 5760)
				table.insert(ranges, {8192, 8202})
				table.insert(codes, 8232)
				table.insert(codes, 8233)
				table.insert(codes, 8239)
				table.insert(codes, 8287)
				table.insert(codes, 12288)
			elseif c == 'u' then -- %u: represents all uppercase letters. (ONLY ASCII)
				table.insert(ranges, {65, 90}) -- A - Z
			elseif c == 'w' then -- %w: represents all alphanumeric characters. (ONLY ASCII)
				table.insert(ranges, {48, 57}) -- 0 - 9
				table.insert(ranges, {65, 90}) -- A - Z
				table.insert(ranges, {97, 122}) -- a - z
			elseif c == 'x' then -- %x: represents all hexadecimal digits.
				table.insert(ranges, {48, 57}) -- 0 - 9
				table.insert(ranges, {65, 70}) -- A - F
				table.insert(ranges, {97, 102}) -- a - f
			else
				if not range then
					table.insert(codes, utf8unicode(c))
				else
					table.remove(codes) -- removing '-'
					table.insert(ranges, {table.remove(codes), utf8unicode(c)})
					range = false
				end
			end
			ignore = false
		else
			if not range then
				table.insert(codes, utf8unicode(c))
			else
				table.remove(codes) -- removing '-'
				table.insert(ranges, {table.remove(codes), utf8unicode(c)})
				range = false
			end
			ignore = false
		end

		firstletter = false
	end

	table.sort(codes)

	local function inRanges(charCode)
		for _,r in ipairs(ranges) do
			if r[1] <= charCode and charCode <= r[2] then
				return true
			end
		end
		return false
	end
	if not unmatch then
		return function(charCode)
			return binsearch(codes, charCode) or inRanges(charCode)
		end, skip
	else
		return function(charCode)
			return charCode ~= -1 and not (binsearch(codes, charCode) or inRanges(charCode))
		end, skip
	end
end

--[[
  -- utf8sub with extra argument, and extra result value
  local function utf8subWithBytes (s, i, j, sb)
	-- argument defaults
	j = j or -1

	local pos = sb or 1
	local bytes = len(s)
	local length = 0

	-- only set l if i or j is negative
	local l = (i >= 0 and j >= 0) or utf8len(s)
	local startChar = (i >= 0) and i or l + i + 1
	local endChar   = (j >= 0) and j or l + j + 1

	-- can't have start before end!
	if startChar > endChar then
  return ""
	end

	-- byte offsets to pass to string.sub
	local startByte,endByte = 1,bytes

	while pos <= bytes do
  length = length + 1

  if length == startChar then
  startByte = pos
  end

  pos = pos + utf8charbytes(s, pos)

  if length == endChar then
  endByte = pos - 1
  break
  end
	end

	if startChar > length then startByte = bytes+1   end
	if endChar   < 1      then endByte   = 0         end

	return sub(s, startByte, endByte), endByte + 1
  end
]]

local cache = setmetatable({},{
    __mode = 'kv'
})
local cachePlain = setmetatable({},{
    __mode = 'kv'
})
local function matcherGenerator(regex, plain)
	local matcher = {
		functions = {},
		captures = {}
	}
	if not plain then
		cache[regex] =  matcher
	else
		cachePlain[regex] = matcher
	end
	local function simple(func)
		return function(cC)
			if func(cC) then
				matcher:nextFunc()
				matcher:nextStr()
			else
				matcher:reset()
			end
		end
	end
	local function star(func)
		return function(cC)
			if func(cC) then
				matcher:fullResetOnNextFunc()
				matcher:nextStr()
			else
				matcher:nextFunc()
			end
		end
	end
	local function minus(func)
		return function(cC)
			if func(cC) then
				matcher:fullResetOnNextStr()
			end
			matcher:nextFunc()
		end
	end
	local function question(func)
		return function(cC)
			if func(cC) then
				matcher:fullResetOnNextFunc()
				matcher:nextStr()
			end
			matcher:nextFunc()
		end
	end

	local function capture(id)
		return function(_)
			local l = matcher.captures[id][2] - matcher.captures[id][1]
			local captured = utf8sub(matcher.string, matcher.captures[id][1], matcher.captures[id][2])
			local check = utf8sub(matcher.string, matcher.str, matcher.str + l)
			if captured == check then
				for _ = 0, l do
					matcher:nextStr()
				end
				matcher:nextFunc()
			else
				matcher:reset()
			end
		end
	end
	local function captureStart(id)
		return function(_)
			matcher.captures[id][1] = matcher.str
			matcher:nextFunc()
		end
	end
	local function captureStop(id)
		return function(_)
			matcher.captures[id][2] = matcher.str - 1
			matcher:nextFunc()
		end
	end

	local function balancer(str)
		local sum = 0
		local bc, ec = utf8sub(str, 1, 1), utf8sub(str, 2, 2)
		local skip = len(bc) + len(ec)
		bc, ec = utf8unicode(bc), utf8unicode(ec)
		return function(cC)
			if cC == ec and sum > 0 then
				sum = sum - 1
				if sum == 0 then
					matcher:nextFunc()
				end
				matcher:nextStr()
			elseif cC == bc then
				sum = sum + 1
				matcher:nextStr()
			else
				if sum == 0 or cC == -1 then
					sum = 0
					matcher:reset()
				else
					matcher:nextStr()
				end
			end
		end, skip
	end

	matcher.functions[1] = function(_)
		matcher:fullResetOnNextStr()
		matcher.seqStart = matcher.str
		matcher:nextFunc()
		if (matcher.str > matcher.startStr and matcher.fromStart) or matcher.str >= matcher.stringLen then
			matcher.stop = true
			matcher.seqStart = nil
		end
	end

	local lastFunc
	local ignore = false
	local skip = nil
	local it = (function()
      local gen = utf8gensub(regex)
      return function()
        return gen(skip)
      end
             end)()
	local cs = {}
	for c, bs, be in it do
		skip = nil
		if plain then
			table.insert(matcher.functions, simple(classMatchGenerator(c, plain)))
		else
			if ignore then
				if find('123456789', c, 1, true) then
					if lastFunc then
						table.insert(matcher.functions, simple(lastFunc))
						lastFunc = nil
					end
					table.insert(matcher.functions, capture(tonumber(c)))
				elseif c == 'b' then
					if lastFunc then
						table.insert(matcher.functions, simple(lastFunc))
						lastFunc = nil
					end
					local b
					b, skip = balancer(sub(regex, be + 1, be + 9))
					table.insert(matcher.functions, b)
				else
					lastFunc = classMatchGenerator('%' .. c)
				end
				ignore = false
			else
				if c == '*' then
					if lastFunc then
						table.insert(matcher.functions, star(lastFunc))
						lastFunc = nil
					else
						error('invalid regex after ' .. sub(regex, 1, bs))
					end
				elseif c == '+' then
					if lastFunc then
						table.insert(matcher.functions, simple(lastFunc))
						table.insert(matcher.functions, star(lastFunc))
						lastFunc = nil
					else
						error('invalid regex after ' .. sub(regex, 1, bs))
					end
				elseif c == '-' then
					if lastFunc then
						table.insert(matcher.functions, minus(lastFunc))
						lastFunc = nil
					else
						error('invalid regex after ' .. sub(regex, 1, bs))
					end
				elseif c == '?' then
					if lastFunc then
						table.insert(matcher.functions, question(lastFunc))
						lastFunc = nil
					else
						error('invalid regex after ' .. sub(regex, 1, bs))
					end
				elseif c == '^' then
					if bs == 1 then
						matcher.fromStart = true
					else
						error('invalid regex after ' .. sub(regex, 1, bs))
					end
				elseif c == '$' then
					if be == len(regex) then
						matcher.toEnd = true
					else
						error('invalid regex after ' .. sub(regex, 1, bs))
					end
				elseif c == '[' then
					if lastFunc then
						table.insert(matcher.functions, simple(lastFunc))
					end
					lastFunc, skip = classMatchGenerator(sub(regex, be + 1))
				elseif c == '(' then
					if lastFunc then
						table.insert(matcher.functions, simple(lastFunc))
						lastFunc = nil
					end
					table.insert(matcher.captures, {})
					table.insert(cs, #matcher.captures)
					table.insert(matcher.functions, captureStart(cs[#cs]))
					if sub(regex, be + 1, be + 1) == ')' then matcher.captures[#matcher.captures].empty = true end
				elseif c == ')' then
					if lastFunc then
						table.insert(matcher.functions, simple(lastFunc))
						lastFunc = nil
					end
					local cap = table.remove(cs)
					if not cap then
						error('invalid capture: "(" missing')
					end
					table.insert(matcher.functions, captureStop(cap))
				elseif c == '.' then
					if lastFunc then
						table.insert(matcher.functions, simple(lastFunc))
					end
					lastFunc = function(cC) return cC ~= -1 end
				elseif c == '%' then
					ignore = true
				else
					if lastFunc then
						table.insert(matcher.functions, simple(lastFunc))
					end
					lastFunc = classMatchGenerator(c)
				end
			end
		end
	end
	if #cs > 0 then
		error('invalid capture: ")" missing')
	end
	if lastFunc then
		table.insert(matcher.functions, simple(lastFunc))
	end

	table.insert(matcher.functions, function()
                 if matcher.toEnd and matcher.str ~= matcher.stringLen then
                   matcher:reset()
                 else
                   matcher.stop = true
                 end
	end)

	matcher.nextFunc = function(self)
		self.func = self.func + 1
	end
	matcher.nextStr = function(self)
		self.str = self.str + 1
	end
	matcher.strReset = function(self)
		local oldReset = self.reset
		local str = self.str
		self.reset = function(s)
			s.str = str
			s.reset = oldReset
		end
	end
	matcher.fullResetOnNextFunc = function(self)
		local oldReset = self.reset
		local func = self.func +1
		local str = self.str
		self.reset = function(s)
			s.func = func
			s.str = str
			s.reset = oldReset
		end
	end
	matcher.fullResetOnNextStr = function(self)
		local oldReset = self.reset
		local str = self.str + 1
		local func = self.func
		self.reset = function(s)
			s.func = func
			s.str = str
			s.reset = oldReset
		end
	end

	matcher.process = function(self, str, start)

		self.func = 1
		start = start or 1
		self.startStr = (start >= 0) and start or utf8len(str) + start + 1
		self.seqStart = self.startStr
		self.str = self.startStr
		self.stringLen = utf8len(str) + 1
		self.string = str
		self.stop = false

		self.reset = function(s)
			s.func = 1
		end

		-- local lastPos = self.str
		-- local lastByte
		local ch
		while not self.stop do
			if self.str < self.stringLen then
				--[[ if lastPos < self.str then
					print('last byte', lastByte)
					ch, lastByte = utf8subWithBytes(str, 1, self.str - lastPos - 1, lastByte)
					ch, lastByte = utf8subWithBytes(str, 1, 1, lastByte)
					lastByte = lastByte - 1
          else
					ch, lastByte = utf8subWithBytes(str, self.str, self.str)
          end
          lastPos = self.str ]]
				ch = utf8sub(str, self.str,self.str)
				--print('char', ch, utf8unicode(ch))
				self.functions[self.func](utf8unicode(ch))
			else
				self.functions[self.func](-1)
			end
		end

		if self.seqStart then
			local captures = {}
			for _,pair in pairs(self.captures) do
				if pair.empty then
					table.insert(captures, pair[1])
				else
					table.insert(captures, utf8sub(str, pair[1], pair[2]))
				end
			end
			return self.seqStart, self.str - 1, unpack(captures)
		end
	end

	return matcher
end

-- string.find
local function utf8find(str, regex, init, plain)
	local matcher = cache[regex] or matcherGenerator(regex, plain)
	return matcher:process(str, init)
end

-- string.match
local function utf8match(str, regex, init)
	init = init or 1
	local found = {utf8find(str, regex, init)}
	if found[1] then
		if found[3] then
			return unpack(found, 3)
		end
		return utf8sub(str, found[1], found[2])
	end
end

-- string.gmatch
local function utf8gmatch(str, regex, all)
	regex = (utf8sub(regex,1,1) ~= '^') and regex or '%' .. regex
	local lastChar = 1
	return function()
		local found = {utf8find(str, regex, lastChar)}
		if found[1] then
			lastChar = found[2] + 1
			if found[all and 1 or 3] then
				return unpack(found, all and 1 or 3)
			end
			return utf8sub(str, found[1], found[2])
		end
	end
end

local function replace(repl, args)
	local ret = ''
	if type(repl) == 'string' then
		local ignore = false
		local num
		for c in utf8gensub(repl) do
			if not ignore then
				if c == '%' then
					ignore = true
				else
					ret = ret .. c
				end
			else
				num = tonumber(c)
				if num then
					ret = ret .. args[num]
				else
					ret = ret .. c
				end
				ignore = false
			end
		end
	elseif type(repl) == 'table' then
		ret = repl[args[1] or args[0]] or ''
	elseif type(repl) == 'function' then
		if #args > 0 then
			ret = repl(unpack(args, 1)) or ''
		else
			ret = repl(args[0]) or ''
		end
	end
	return ret
end
-- string.gsub
local function utf8gsub(str, regex, repl, limit)
	limit = limit or -1
	local ret = ''
	local prevEnd = 1
	local it = utf8gmatch(str, regex, true)
	local found = {it()}
	local n = 0
	while #found > 0 and limit ~= n do
		local args = {[0] = utf8sub(str, found[1], found[2]), unpack(found, 3)}
		ret = ret .. utf8sub(str, prevEnd, found[1] - 1)
      .. replace(repl, args)
		prevEnd = found[2] + 1
		n = n + 1
		found = {it()}
	end
	return ret .. utf8sub(str, prevEnd), n
end

return {
    len = utf8len;
    sub = utf8sub;
    reverse = utf8reverse;
    char = utf8char;
    unicode = utf8unicode;
    gensub = utf8gensub;
    byte = utf8unicode;
    find = utf8find;
    match = utf8match;
    gmatch = utf8gmatch;
    gsub = utf8gsub;
    dump = dump;
    format = format;
    lower = lower;
    upper = upper;
    rep = rep;
}

end)()
--- END utf8.lua


--- BEGIN charsepval_temp.lua
export.charsepval_temp = (function ()
local function reduce(iterator, tbl, initial_value, transform)
  local accumulator = initial_value
  for k, v in iterator(tbl) do
    transform(accumulator, v, k)
  end
  return accumulator
end
local function mutate(root, key, transform)
  local result = transform(root[key])
  root[key] = result
  return result
end
local function _0_(configuration)
  local cfg = (configuration or {})
  local csv = {newline = (cfg.newline or "\n"), separator = (cfg.separator or ",")}
  csv.keys = function(atable)
    local function _1_(a, _, k)
      return table.insert(a, k)
    end
    return reduce(pairs, atable, {}, _1_)
  end
  csv["string-sink"] = function()
    local function _1_(self, data)
      local function _2_(v)
        return (v .. data)
      end
      return mutate(self, "buffer", _2_)
    end
    return {buffer = "", write = _1_}
  end
  csv["stringSink"] = csv["string-sink"]
  local function is_last(index, itable)
    return (index == #itable)
  end
  csv["encode-headers"] = function(destination, headers)
    for i, header in ipairs(headers) do
      destination:write(header)
      if not is_last(i, headers) then
        destination:write(csv.separator)
      end
    end
    return destination:write(csv.newline)
  end
  csv["encodeHeaders"] = csv["encode-headers"]
  csv["encode-table"] = function(destination, headers, source)
    for i, header in ipairs(headers) do
      destination:write(source[header])
      if not is_last(i, headers) then
        destination:write(csv.separator)
      end
    end
    return nil
  end
  csv["encodeTable"] = csv["encode-table"]
  csv["encode-tables"] = function(destination, headers, sequence)
    for i, source in ipairs(sequence) do
      csv["encode-table"](destination, headers, source)
      if not is_last(i, sequence) then
        destination:write(csv.newline)
      end
    end
    return nil
  end
  csv["encodeTables"] = csv["encode-tables"]
  return csv
end
return _0_
end)()
--- END charsepval_temp.lua



--[[
  inspect
  fun
  func
  prototype
  fmt
  flags
  strings
  tables
  quick_sort
  quick_sort_generic
  table_list
  avl_tree
  linked_list
  doubly_linked_list
  max_heap
  min_heap
  quad_tree
  queue
  set
  stack
  curried
  pubsub
  utf8
  charsepval_temp
]]
return export
