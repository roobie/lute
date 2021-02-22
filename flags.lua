
local bit = require('bit')
local AND, OR, NOT = bit.band, bit.bor, bit.bnot
local rshift, lshift = bit.rshift, bit.lshift
local prototype = require('prototype')

local b = setmetatable({}, {
    __call = function (_, bitOrdinal)
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
  local nbits = numbits or 32
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
  function newMt.__call (_, ...)
    local ival = 0
    for i = 1, select('#', ...) do
      ival = OR(ival, flags[select(i, ...)])
    end
    return Bits.new(ival)
  end
  return setmetatable(instance, newMt)
end

return Flags
