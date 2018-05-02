local Class = require('src.utils.class')
local Vector2 = require('src.utils.vector2')

-- Buttons are drawn with the origin at the centre
-- Use align function to change this default
local Label = Class:derive('Label')

function Label:new(x, y, w, h, text, textAlign)
    self.pos = Vector2(x, y)
    self.size = Vector2(w, h)
    self.text = text or 'Button'
    self.textAlign = textAlign or 'center'
end

function Label:draw()
    local f = love.graphics.getFont()
    local fontW = f:getWidth(self.text)
    local fontH = f:getHeight()
    local _, lines = f:getWrap(self.text, self.size.x)
    love.graphics.printf(self.text, self.pos.x - self.size.x / 2, self.pos.y - (fontH / 2 * #lines), self.size.x, self.textAlign)
end

return Label