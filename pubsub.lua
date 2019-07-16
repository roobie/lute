local List = require('lute.doubly_linked_list')
local prototype = require('lute.prototype')

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
  for _, listener in ipairs(self.listeners) do
    listener(...)
  end
end

function Pubsub.__call (self, ...)
  self:publish(...)
end

return Pubsub