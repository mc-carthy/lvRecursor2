local Class = require('src.utils.class')

local Gamepad = Class:derive('Gamepad')

local function hookLoveEvents(self)
    function love.joystickadded(joystick)

    end
    function love.joystickremoved(joystick)

    end
    function love.gamepadpressed(joystick, button)

    end
    function love.gamepadreleased(joystick, button)

    end
end

function Gamepad:new(dbFiles)
    if dbFiles ~= nil then
        for i = 1, #dbFiles do
            love.joystick.loadGamepadMappings(dbFiles[i])
        end
    end
    hookLoveEvents(self)
end

return Gamepad