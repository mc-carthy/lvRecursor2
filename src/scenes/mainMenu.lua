local Scene = require('src.utils.scene')

local MainMenu = Scene:derive('Main Menu')

function MainMenu:update(dt)
    _checkKeyInput(dt)
end

function MainMenu:draw()
    love.graphics.print('Hello from Main Menu', 10, 10)
end

function _checkKeyInput(dt)
    if Key:keyPressed('escape') then
        love.event.quit()
    end
end

return MainMenu