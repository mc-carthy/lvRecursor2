local Scene = require('src.utils.scene')

local MainMenu = Scene:derive('Main Menu')

function MainMenu:draw()
    love.graphics.print('Hello from Main Menu', 10, 10)
end

return MainMenu