local Class = require("src.utils.class")
local Vector2 = require("src.utils.vector2")
local Animation = Class:derive("Animation")

function Animation:new(xOffset, yOffset, w, h, frames, columnSize, fps, loop)
    self.fps = fps
    if type(frames) == 'table' then
        self.frames = frames
    else
        self.frames = {}
        for i = 1, frames do
            self.frames[i] = i
        end
    end
    self.columnSize = columnSize
    self.startOffset = Vector2(xOffset, yOffset)
    self.offset = Vector2()
    self.size = Vector2(w, h)
    self.loop = loop == nil or loop
    self:reset()
end

function Animation:update(dt, quad)
    if #self.frames <= 1 then
        return
    elseif self.timer > 0 then
        self.timer = self.timer - dt
        if self.timer <= 0 then
            self.timer = 1 / self.fps
            self.frameIndex = self.frameIndex + 1
            if self.frameIndex > #self.frames then
                if self.loop then
                    self.frameIndex = 1 
                else
                    self.frameIndex = #self.frames
                    self.timer = 0
                    self.done = true
                end
            end
            self.offset.x = self.startOffset.x + (self.size.x * ((self.frames[self.frameIndex] - 1) % self.columnSize))
            self.offset.y = self.startOffset.y + (self.size.y * math.floor((self.frames[self.frameIndex] - 1) / self.columnSize))
            self:set(quad)
        end
    end
end

function Animation:set(quad)
    quad:setViewport(self.offset.x, self.offset.y, self.size.x, self.size.y)
end

function Animation:reset()
    self.timer = 1 / self.fps
    self.frameIndex = 1
    self.done = false
    self.offset.x = self.startOffset.x
    self.offset.y = self.startOffset.y
end

return Animation