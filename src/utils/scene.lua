local Class = require('src.utils.class')

local Scene = Class:derive('Scene')

function Scene:new(sceneManager)
    self.sceneManager = sceneManager
end

function Scene:update(dt)

end

function Scene:draw()

end

function Scene:enter()
    
end

function Scene:exit()

end

function Scene:destroy()

end

return Scene