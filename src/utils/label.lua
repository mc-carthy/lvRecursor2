local Class = require('src.utils.class')
local Vector2 = require('src.utils.vector2')
local Utils = require('src.utils.utils')

-- Buttons are drawn with the origin at the centre
-- Use align function to change this default
local Label = Class:derive('Label')

function Label:new(x, y, w, h, text, colour, textAlign)
    self.pos = Vector2(x, y)
    self.size = Vector2(w, h)
    self.text = text or 'Button'
    self.colour = colour or Utils.colour(255)
    self.textAlign = textAlign or 'center'
end

function Label:draw()
    local r, g, b, a = love.graphics.getColor()
    local f = love.graphics.getFont()
    local fontW = f:getWidth(self.text)
    local fontH = f:getHeight()
    local _, lines = f:getWrap(self.text, self.size.x)
    love.graphics.setColor(self.colour)
    love.graphics.rectangle('line', self.pos.x - self.size.x / 2, self.pos.y - (fontH / 2 * #lines), self.size.x, fontH * #lines)
    love.graphics.printf(self.text, self.pos.x - self.size.x / 2, self.pos.y - (fontH / 2 * #lines), self.size.x, self.textAlign)
    love.graphics.setColor(r, g, b, a)
end

return Label