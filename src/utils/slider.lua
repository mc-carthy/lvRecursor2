local Class = require('src.utils.class')
local Vector2 = require('src.utils.vector2')
local Utils = require('src.utils.utils')

local Slider = Class:derive('Slider')

-- x coord is left side, y coord is centre
function Slider:new(x, y, w, h, id, isVertical)
    self.barPos = Vector2(x, y)
    self.barSize = Vector2(w, h)
    self.id = id or ''
    self.isVertical = isVertical or false
    self.value = 0
    self.prevValue = self.value
    self.delta = 0
    -- TODO : Fix these hard-coded values
    self.nubPos = Vector2(0, 0)
    if self.isVertical then
        self.nubSize = Vector2(20, 10)
    else
        self.nubSize = Vector2(10, 20)
    end

    -- Slider colours
    self.grooveColour = Utils.colour(191)
    self.normal = Utils.colour(191, 0, 0)
    self.highlight = Utils.colour(255, 0, 0)
    self.pressed = Utils.colour(127, 0, 0)
    self.disabled = Utils.colour(63)
    self.colour = self.normal

    self.enabled = true
    self.movingSlider = false
end

function Slider:getValue()
    return self.value
end

function Slider:update(dt)
    if not self.enabled then return end

    if self.isVertical then
        self.nubPos.x = self.barPos.x - self.nubSize.x / 2
        self.nubPos.y = self.barPos.y + self.barSize.y / 2 - (self.value * (self.barSize.y - self.nubSize.y)) - self.nubSize.y
    else
        self.nubPos.x = self.barPos.x - self.barSize.x / 2 + (self.value * (self.barSize.x - self.nubSize.x))
        self.nubPos.y = self.barPos.y - self.nubSize.y / 2
    end

    local mx, my = love.mouse.getPosition()
    local leftClick = love.mouse.isDown(1)
    local rect
    if self.isVertical then
        rect = {
            x = self.nubPos.x,
            y = self.nubPos.y,
            w = self.nubSize.x,
            h = self.nubSize.y 
        }
    else
        rect = {
            x = self.nubPos.x,
            y = self.nubPos.y,
            w = self.nubSize.x, 
            h = self.nubSize.y 
        }
    end
    if Utils.pointInRect({ x = mx, y = my }, rect) then
        if leftClick then
            -- self.colour = self.pressed
            if not self.prevLeftClick then
                self.movingSlider = true
                if self.isVertical then
                    self.delta = self.value * -self.barSize.y - my
                else
                    self.delta = self.value * self.barSize.x - mx
                end
            end
        else
            self.colour = self.highlight
        end
    else
        self.colour = self.normal
    end

    if not leftClick then
        self.movingSlider = false
    end

    if self.movingSlider then
        self.prevValue = self.value
        self.colour = self.highlight
        if self.isVertical then
            self.value = (my + self.delta) / -self.barSize.y
        else
            self.value = (mx + self.delta) / self.barSize.x
        end
        if self.value > 1 then
            self.value = 1
        elseif self.value < 0 then
            self.value = 0
        end
        if self.value ~= self.prevValue then
            -- print('Value changed from ' .. self.prevValue .. ' to ' .. self.value)
            _G.events:invoke("onSliderChanged", self)
        end
    end

    self.prevLeftClick = leftClick
end

function Slider:draw()
    local pr, pg, pb, pa = love.graphics.getColor()
    love.graphics.setColor(self.grooveColour)
    love.graphics.rectangle(
        'fill', 
        self.barPos.x - self.barSize.x / 2, 
        self.barPos.y - self.barSize.y / 2, 
        self.barSize.x, 
        self.barSize.y,
        4,
        4
    )
    love.graphics.setColor(self.colour)
    love.graphics.rectangle(
        'fill', 
        self.nubPos.x,
        self.nubPos.y,
        self.nubSize.x, 
        self.nubSize.y,
        0,
        0
    )
    love.graphics.setColor(pr, pg, pb, pa)
end

return Slider