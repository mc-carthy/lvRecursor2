local Class = {}

Class.__index = Class

function Class:new() 
    print('New from base')
end

function Class:derive(type) 
    local clss = {}
    clss.type = type
    clss.__index = clss
    clss.super = self
    setmetatable(clss, self)
    return clss
end

function Class:__call(...)
    local inst = setmetatable({}, self)
    inst:new(...)
    return inst
end

function Class:getType()
    return self.type
end

local Player = Class:derive('Player')

function Player:new()
    print('New from Player')
end

local p1 = Player()

return Class