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
