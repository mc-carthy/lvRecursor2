local Class = require("src.utils.class")
local Vector2 = require("src.utils.vector2")
local Animation = Class:derive("Animation")

function Animation:new(xOffset, yOffset, w, h, numFrames, columnSize, fps, loop)
    self.fps = fps
    self.timer = 1 / self.fps
    self.frame = 1
    self.numFrames = numFrames
    self.columnSize = columnSize
    self.startOffset = Vector2(xOffset, yOffset)
    self.offset = Vector2()
    self.size = Vector2(w, h)
    self.loop = loop == nil or loop
    self.done = false
end

function Animation:update(dt, quad)
    if self.numFrames <= 1 then
        return
    elseif self.timer > 0 then
        self.timer = self.timer - dt
        if self.timer <= 0 then
            self.timer = 1 / self.fps
            self.frame = self.frame + 1
            if self.frame > self.numFrames then
                if self.loop then
                    self.frame = 1 
                else
                    self.frame = self.numFrames
                    self.timer = 0
                    self.done = true
                end
            end
            self.offset.x = self.startOffset.x + (self.size.x * ((self.frame - 1) % self.columnSize))
            self.offset.y = self.startOffset.y + (self.size.y * math.floor((self.frame - 1) / self.columnSize))
            self:set(quad)
        end
    end
end

function Animation:set(quad)
    quad:setViewport(self.offset.x, self.offset.y, self.size.x, self.size.y)
end

function Animation:reset()
    self.timer = 1 / self.fps
    self.frame = 1
    self.done = false
end

return Animation