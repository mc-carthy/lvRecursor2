local Class = {}

Class.__index = Class

function Class:new() 
    print('New from base')
end

function Class:derive(type) 
    local clss = {}
    clss['__call'] = Class.__call
    clss.type = type
    clss.__index = clss
    clss.super = self
    setmetatable(clss, self)
    return clss
end

function Class:is(class)
    assert(class ~= nil, 'Parameter class required')
    assert(type(class) == 'table', 'Parameter class must be of type class')
    local mt = getmetatable(self)
    while mt do
        if mt == class then return true end
        mt = getmetatable(mt)
    end
    return false
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