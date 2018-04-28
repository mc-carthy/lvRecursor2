local Scene = require('src.utils.scene')
local Button = require('src.utils.button')

local MainMenu = Scene:derive('Main Menu')

function MainMenu:new(sceneManager)
    self.super:new(sceneMgr)
    self.button = Button(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 200, 75)
end

function MainMenu:update(dt)
    _checkKeyInput(dt)
end

function MainMenu:draw()
    love.graphics.print('Hello from Main Menu', 10, 10)
    self.button:draw()
end

function _checkKeyInput(dt)
    if Key:keyPressed('escape') then
        love.event.quit()
    end
end

return MainMenu