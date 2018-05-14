local Class = require("src.utils.class")
local Animation = require('src.utils.animation')
local Vector2 = require("src.utils.vector2")

local Sprite = Class:derive("Sprite")

function Sprite:new(atlas, x, y, w, h, sx, sy, rot)
    self.atlas = atlas
    self.pos = Vector2(x, y)
    self.size = Vector2(w, h)
    self.scale = Vector2(sx or 1, sy or 1)
    self.rot = rot or 0
    self.animations = {}
    self.currentAnimation = nil
    self.quad = love.graphics.newQuad(0, 0, w, w, atlas:getDimensions())
    self.flip = Vector2(1, 1)
    self.colour = { 255, 255, 255, 255}
end

function Sprite:addAnimations(animations)
    assert(type(animations) == 'table', 'Animations must be in a table')
    for k, v in pairs(animations) do
        self:addAnimation(k, v)
    end
end

function Sprite:addAnimation(name, anim)
    self.animations[name] = anim
end

function Sprite:animate(animName)
    if self.currentAnimation ~= animName and self.animations[animName] ~= nil then
        self.animations[animName]:reset(self.quad)
        self.animations[animName]:set(self.quad)
        self.currentAnimation = animName
    end
end

function Sprite:animationFinished()
    if self.animations[self.currentAnimation] ~= nil then
        return self.animations[self.currentAnimation].done
    end
    return true
end

function Sprite:flipH(flip)
    if flip then
        self.flip.x = -1
    else
        self.flip.x = 1
    end
end

function Sprite:flipV(flip)
    if flip then
        self.flip.y = -1
    else
        self.flip.y = 1
    end
end

function Sprite:update(dt)
    if self.animations[self.currentAnimation] ~= nil then
        self.animations[self.currentAnimation]:update(dt, self.quad)
    end
end

function Sprite:draw()
    love.graphics.setColor(self.colour)
    love.graphics.draw(self.atlas, self.quad, self.pos.x, self.pos.y, self.rot, self.scale.x * self.flip.x, self.scale.y * self.flip.y, self.size.x / 2, self.size.y / 2)
end

return Sprite