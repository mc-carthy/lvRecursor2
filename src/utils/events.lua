local Class = require('src.utils.class')

local Events = Class:derive('Events')

local function indexOf(tbl, callback)
    if tbl == nil or callback == nil then return -1 end
    for i = 1, #tbl do
        if tbl[i] == callback then
            return i
        end
    end
    return -1
end

function Events:new(eventMustExist)
    self.handlers = {}
    self.eventMustExist = (eventMustExist == nil) or eventMustExist
end

function Events:add(eventType)
    assert(self.handlers[eventType] == nil, 'Event type ' .. eventType .. ' already exists')
    self.handlers[eventType] = {}
end

function Events:exists(eventType)
    return self.handlers[eventType] ~= nil
end

function Events:remove(eventType)
    self.handlers[eventType] = nil
end

function Events:hook(eventType, callback)
    assert(type(callback) == 'function', 'Callback parameter must be a function')
    if self.eventMustExist then
        assert(self.handlers[eventType] ~= nil, 'Event type ' .. eventType .. ' not present')
    elseif self.handlers[eventType] == nil then
        self:add(eventType)
    end
    assert(indexOf(self.handlers[eventType], callback) == -1, 'Callback has already been registered')
    self.handlers[eventType][#self.handlers[eventType] + 1] = callback
end

function Events:unhook(eventType, callback)
    assert(type(callback) == 'function', 'Callback parameter must be a function')
    if self.handlers[eventType] == nil then return end
    local index = indexOf(self.handlers[eventType], callback)
    if index > -1 then
        table.remove(self.handlers[eventType], index)
    end
end

function Events:clear(eventType)
    if eventType == nil then
        for k, v in pairs(self.handlers) do
            self.handlers[k] = {}
        end
    else
        if self.handlers[eventType] ~= nil then
            self.handlers[eventType] = {}
        end
    end
end

function Events:invoke(eventType, ...)
    -- assert(self.handlers[eventType] ~= nil, 'Event type ' .. eventType .. ' does not exist')
    if self.handlers[eventType] == nil then return end
    local tbl = self.handlers[eventType]
    for i = 1, #tbl do
        tbl[i](...)
    end
end

return Events