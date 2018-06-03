local Class = require('src.utils.class')
local Vector2 = require('src.utils.vector2')
local Utils = require('src.utils.utils')

local Slider = Class:derive('Slider')

-- x coord is left side, y coord is centre
function Slider:new(x, y, w, h)
    self.pos = Vector2(x, y)
    self.barSize = Vector2(w, h)
    self.nubSize = Vector2(20, 20)
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
        self.pos.y - self.barSize.y / 2, 
        self.barSize.x, 
        self.barSize.y,
        4,
        4
    )
    love.graphics.setColor(self.colour)
    -- love.graphics.circle('fill', self.pos.x + (self.value * self.barSize.x), self.pos.y, self.nubSize.x / 2)
    love.graphics.rectangle(
        'fill', 
        self.pos.x + (self.value * self.barSize.x) - self.nubSize.x / 2, 
        self.pos.y - self.nubSize.y / 2, 
        self.nubSize.x, 
        self.nubSize.y,
        self.nubSize.x / 2,
        self.nubSize.y / 2
    )
    love.graphics.setColor(pr, pg, pb, pa)
end

return Slider