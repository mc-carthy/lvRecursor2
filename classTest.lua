local Class = require('src.utils.class')

local Animal = Class:derive('Animal')

function Animal:soundOff()
    print('uh?')
end

local a = Animal()
a:soundOff()
print(a:getType())

local Cat = Animal:derive('Cat')

function Cat:soundOff()
    print('Meow!')
end

local c = Cat()
c:soundOff()
print(c:getType())

local Minx = Cat:derive('Minx')
local m = Minx()
print(m:getType(), m.super:getType(), m.super.super:getType())
print(m:is(Animal))