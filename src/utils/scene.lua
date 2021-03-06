local Class = require('src.utils.class')
local EntityManager = require('src.utils.entityManager')

local Scene = Class:derive('Scene')

function Scene:new(sceneManager)
    self.sceneManager = sceneManager
    self.em = EntityManager()
end

function Scene:update(dt)
    self.em:update(dt)
end

function Scene:draw()
    self.em:draw()
end

function Scene:enter()
    self.em:onEnter()
end

function Scene:exit()
    self.em:onExit()
end

function Scene:destroy()

end

return Scene