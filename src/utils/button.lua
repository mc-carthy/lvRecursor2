local Class = require('src.utils.class')
local Vector2 = require('src.utils.vector2')

-- Buttons are drawn with the origin at the centre
-- 
local Button = Class:derive('Button')

local function _colour(r, g, b, a)
    return { r, g or r, b or r, a or 255 }
end

local function _mouseInBounds(self, mouseX, mouseY)
    return 
        mouseX >= self.pos.x - self.size.x / 2 and
        mouseX <= self.pos.x + self.size.x / 2 and
        mouseY >= self.pos.y - self.size.y / 2 and
        mouseY <= self.pos.y + self.size.y / 2
end

function Button:new(x, y, w, h, label)
    self.pos = Vector2(x, y)
    self.size = Vector2(w, h)
    self.label = label or 'Button'
    self.normal = _colour(191, 0, 0, 191)
    self.highlight = _colour(191, 0, 0)
    self.pressed = _colour(127, 0, 0)
    self.disabled = _colour(95)
    self.buttonColour = self.normal
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

function Button:update(dt)
    x, y = love.mouse.getPosition()
    if _mouseInBounds(self, x, y) then
        if love.mouse.isDown(1) then
            self.buttonColour = self.pressed
        else
            self.buttonColour = self.highlight
        end
    else
        self.buttonColour = self.normal
    end
end

function Button:draw()
    local pr, pg, pb, pa = love.graphics.getColor()
    love.graphics.setColor(self.buttonColour)
    love.graphics.rectangle(
        'fill', 
        self.pos.x - self.size.x / 2, 
        self.pos.y - self.size.y / 2, 
        self.size.x, 
        self.size.y,
        10
    )
    love.graphics.setColor(pr, pg, pb, pa)
    local f = love.graphics.getFont()
    local fontW = f:getWidth(self.label)
    local fontH = f:getHeight()
    love.graphics.print(self.label, self.pos.x - fontW / 2, self.pos.y - fontH / 2)
end

return Button