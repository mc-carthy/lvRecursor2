local Class = require('src.utils.class')
local Vector2 = require('src.utils.vector2')
local Utils = require('src.utils.utils')

local Checkbox = Class:derive('Checkbox')

local padding = 10
local boxHeightPercentage = 0.8
local lineWidth = 5

function Checkbox:new(x, y, w, h, text)
    self.pos = Vector2(x, y)
    self.size = Vector2(w, h)
    self.boxSize = Vector2(self.size.y * boxHeightPercentage, self.size.y * boxHeightPercentage)
    self.text = text
    self.checked = true

    self.normal = Utils.colour(127)
    self.highlight = Utils.colour(191)
    self.pressed = Utils.colour(255)
    self.disabled = Utils.colour(63)
    self.colour = self.normal
    
    self.prevLeftClick = false
    self.enabled = true
end

function Checkbox:setBox(width, height)
    
end

function Checkbox:update(dt)

end

function Checkbox:draw()
    local pr, pg, pb, pa = love.graphics.getColor()
    love.graphics.setColor(self.colour)

    local pl = love.graphics.getLineWidth()
    love.graphics.setLineWidth(lineWidth)
    love.graphics.rectangle('line', self.pos.x + (self.size.y - self.boxSize.x) / 2, self.pos.y + (self.size.y - self.boxSize.y) / 2, self.boxSize.x, self.boxSize.y, 5, 5)
    love.graphics.setColor(self.colour, 255)
    if self.checked then
        love.graphics.rectangle('fill', self.pos.x + (self.size.y - self.boxSize.x) / 2 + lineWidth, self.pos.y + (self.size.y - self.boxSize.y) / 2 + lineWidth, self.boxSize.x - 2 * lineWidth, self.boxSize.y - 2 * lineWidth)
    end
    love.graphics.setLineWidth(pl)

    local f = love.graphics.getFont()
    local fontW = f:getWidth(self.text)
    local fontH = f:getHeight()
    local _, lines = f:getWrap(self.text, self.size.x)
    love.graphics.setColor(Utils.colour(255))
    love.graphics.printf(self.text, self.pos.x + self.boxSize.x / boxHeightPercentage + padding, self.pos.y + (fontH / 2 * #lines), self.size.x, 'left')

    love.graphics.rectangle('line', self.pos.x, self.pos.y, self.size.x, self.size.y)
    
    love.graphics.setColor(pr, pg, pb, pa)
end

return Checkbox