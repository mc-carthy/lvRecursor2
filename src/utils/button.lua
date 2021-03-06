local Class = require('src.utils.class')
local Vector2 = require('src.utils.vector2')
local Utils = require('src.utils.utils')

-- Buttons are drawn with the origin at the centre
-- Use align function to change this default
local Button = Class:derive('Button')

function Button:new(x, y, w, h, text, textAlign)
    self.pos = Vector2(x, y)
    self.size = Vector2(w, h)
    self.text = text or 'Button'
    self.textAlign = textAlign or 'center'

    self.normal = Utils.colour(191, 0, 0)
    self.highlight = Utils.colour(255, 0, 0)
    self.pressed = Utils.colour(127, 0, 0)
    self.disabled = Utils.colour(63)
    self.buttonColour = self.normal
    
    self.normaltext = Utils.colour(255)
    self.disabledText = Utils.colour(127)
    self.textColour = self.normaltext

    self.prevLeftClick = false
    self.enabled = true
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

function Button:colours(normal, highlight, pressed, disabled)
    assert(type(normal) == 'table', 'The normal colour must be a table')
    assert(type(highlight) == 'table', 'The normal colour must be a table')
    assert(type(pressed) == 'table', 'The normal colour must be a table')
    assert(type(disabled) == 'table', 'The disabled colour must be a table')
    self.normal = normal
    self.highlight = highlight
    self.pressed = pressed
    self.disabled = disabled
end

function Button:textColours(normal, disabled)
    assert(type(normal) == 'table', 'The normal colour must be a table')
    assert(type(disabled) == 'table', 'The disabled colour must be a table')
    self.normaltext = normal
    self.disabledText = disabled
end

function Button:enable(enabled)
    self.enabled = enabled
    if not enabled then 
        self.buttonColour = self.disabled
        self.textColour = self.disabledText
    else
        self.textColour = self.normaltext
    end
end

function Button:update(dt)
    if not self.enabled then return end
    local mx, my = love.mouse.getPosition()
    local leftClick = love.mouse.isDown(1)
    local inBounds = Utils.mouseInBounds(self, mx, my)
    if inBounds and not leftClick then
        if self.prevLeftClick and self.buttonColour == self.pressed then
            _G.events:invoke("onButtonClick", self)
        end
        self.buttonColour = self.highlight
    elseif inBounds and leftClick and not self.prevLeftClick then
        self.buttonColour = self.pressed
    elseif not inBounds then
        self.buttonColour = self.normal
    end
    self.prevLeftClick = leftClick
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
    local f = love.graphics.getFont()
    local fontW = f:getWidth(self.text)
    local fontH = f:getHeight()
    local _, lines = f:getWrap(self.text, self.size.x)
    love.graphics.setColor(self.textColour)
    -- love.graphics.print(self.text, self.pos.x - fontW / 2, self.pos.y - fontH / 2)
    love.graphics.printf(self.text, self.pos.x - self.size.x / 2, self.pos.y - (fontH / 2 * #lines), self.size.x, self.textAlign)
    love.graphics.setColor(pr, pg, pb, pa)

    -- love.graphics.line(self.pos.x, self.pos.y - self.size.y / 2, self.pos.x, self.pos.y + self.size.y / 2)
    -- love.graphics.line(self.pos.x - self.size.x / 2, self.pos.y, self.pos.x + self.size.x / 2, self.pos.y)
end

return Button