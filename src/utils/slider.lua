local Class = require('src.utils.class')
local Vector2 = require('src.utils.vector2')
local Utils = require('src.utils.utils')

local Slider = Class:derive('Slider')

-- x coord is left side, y coord is centre
function Slider:new(x, y, w, h)
    self.pos = Vector2(x, y)
    self.size = Vector2(w, h)
    self.value = 1

    -- Slider colours
    self.normal = Utils.colour(191, 0, 0)
    self.highlight = Utils.colour(255, 0, 0)
    self.pressed = Utils.colour(127, 0, 0)
    self.disabled = Utils.colour(63)
    self.colour = self.normal

    self.enabled = true
end

function Slider:draw()
    local pr, pg, pb, pa = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle(
        'fill', 
        self.pos.x, 
        self.pos.y - self.size.y / 2, 
        self.size.x, 
        self.size.y
    )
    love.graphics.setColor(self.colour)
    love.graphics.circle('fill', self.pos.x + (self.value * self.size.x), self.pos.y, 10)
    love.graphics.setColor(pr, pg, pb, pa)
end

return Slider