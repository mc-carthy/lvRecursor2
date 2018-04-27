local Class = require('src.utils.class')

local Gamepad = Class:derive('Gamepad')

local function hookLoveEvents(self)
    function love.joystickadded(joystick)
        local id = joystick:getID()
        assert(self.connectedSticks[id] == nil, 'Joystick ' .. id .. ' already exists.')
        self.connectedSticks[id] = joystick
        self.isConnected[id] = true
        self.buttonMap[id] = {}
    end

    function love.joystickremoved(joystick)
        local id = joystick:getID()
        self.connectedSticks[id] = nil
        self.isConnected[id] = false
        self.buttonMap[id] = nil
    end

    function love.gamepadpressed(joystick, button)
        local id = joystick:getID()
        self.buttonMap[id][button] = true
    end

    function love.gamepadreleased(joystick, button)
        local id = joystick:getID()
        self.buttonMap[id][button] = false
    end
end

function Gamepad:new(dbFiles)
    if dbFiles ~= nil then
        for i = 1, #dbFiles do
            love.joystick.loadGamepadMappings(dbFiles[i])
        end
    end
    self.connectedSticks = {}
    self.isConnected = {}
    self.buttonMap = {}
    hookLoveEvents(self)
end

function Gamepad:button(joystickId, button)
    local stick = self.connectedSticks[joystickId]
    if self.isConnected[id] == nil or self.isConnected[id] == false then return false end
    local isDown = stick:isGamepadDown(button)

    return isDown
end

function Gamepad:buttonDown(joystickId, button)
    if self.isConnected[id] == nil or self.isConnected[id] == false then return false end
    return self.buttonMap[joystickId][button] == true
end

function Gamepad:buttonUp(joystickId, button)
    if self.isConnected[id] == nil or self.isConnected[id] == false then return false end
    return self.buttonMap[joystickId][button] == false
end

function Gamepad:update(dt)

end

return Gamepad