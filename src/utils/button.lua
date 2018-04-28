local Class = require('src.utils.class')
local Vector2 = require('src.utils.vector2')

-- Buttons are drawn with the origin at the centre
-- 
local Button = Class:derive('Button')

local function _colour(r, g, b, a)
    return { r, g or r, b or r, a or 255 }
end

function Button:new(x, y, w, h)
    self.pos = Vector2(x, y)
    self.size = Vector2(w, h)

    self.normal = _colour(191, 0, 0, 191)
    self.highlight = _colour(191, 0, 0)
    self.pressed = _colour(191, 63, 63)
    self.disabled = _colour(95)
end

function Button:align(alignment, value)
    if alignment == 'left' then
        self.pos.x = value + self.size.x / 2
    elseif alignment == 'right' then
        self.pos.x = value - self.size.x / 2
    end
    if alignment == 'top' then
        self.pos.y = value + self.size.y / 2
    elseif alignment == 'bottom' then
        self.pos.y = value - self.size.y / 2
    end
end

function Button:draw()
    local pr, pg, pb, pa = love.graphics.getColor()
    love.graphics.setColor(self.disabled)
    love.graphics.rectangle('fill', self.pos.x - self.size.x / 2, self.pos.y - self.size.y / 2, self.size.x, self.size.y, 10)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setColor(pr, pg, pb, pa)
    love.graphics.print('Button', self.pos.x - 50, self.pos.y - 30)
end

return Button