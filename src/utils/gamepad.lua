local Class = require('src.utils.class')
local Events = require('src.utils.events')

local Gamepad = Class:derive('Gamepad')

local DEADZONE = 0.1

-- TODO: Add dpad controls

local function hookLoveEvents(self)
    function love.joystickadded(joystick)
        local joystickId = joystick:getID()
        assert(self.connectedSticks[joystickId] == nil, 'Joystick ' .. joystickId .. ' already exists.')
        self.connectedSticks[joystickId] = joystick
        self.isConnected[joystickId] = true
        self.buttonMap[joystickId] = {}
        -- print(joystickId .. ' added')
        self.event:invoke('controllerAdded', joystickId)
    end
    
    function love.joystickremoved(joystick)
        local joystickId = joystick:getID()
        self.connectedSticks[joystickId] = nil
        self.isConnected[joystickId] = false
        self.buttonMap[joystickId] = nil
        -- print(joystickId .. ' removed')
        self.event:invoke('controllerRemoved', joystickId)
    end

    function love.gamepadpressed(joystick, button)
        local joystickId = joystick:getID()
        self.buttonMap[joystickId][button] = true
        -- print(joystickId .. ' pressed ' .. button)
    end

    function love.gamepadreleased(joystick, button)
        local joystickId = joystick:getID()
        self.buttonMap[joystickId][button] = false
        -- print(joystickId .. ' released ' .. button)
    end
end

function Gamepad:new(dbFiles, adEnabled)
    if dbFiles ~= nil then
        for i = 1, #dbFiles do
            love.joystick.loadGamepadMappings(dbFiles[i])
        end
    end

    self.event = Events()
    self.event:add('controllerAdded')
    self.event:add('controllerRemoved')

    -- Converts analogue stick input to dpad
    self.adEnabled = adEnabled or false

    self.connectedSticks = {}
    self.isConnected = {}
    self.buttonMap = {}
    hookLoveEvents(self)
end

function Gamepad:button(joystickId, button)
    local stick = self.connectedSticks[joystickId]
    if self.isConnected[joystickId] == nil or self.isConnected[joystickId] == false then return false end
    local isDown = stick:isGamepadDown(button)

    if self.adEnabled and not isDown then
        local xAxis = stick:getGamepadAxis('leftx')
        local yAxis = stick:getGamepadAxis('lefty')

        if button == 'dpright' then
            isDown = xAxis > DEADZONE
        elseif button == 'dpleft' then
            isDown = xAxis < -DEADZONE
        end
        if button == 'dpup' then
            isDown = yAxis < -DEADZONE
        elseif button == 'dpdown' then
            isDown = yAxis > DEADZONE
        end
    end

    return isDown
end

function Gamepad:exists(joystickId)
    if self.isConnected[joystickId] == nil or self.isConnected[joystickId] == false then return false end
    return true    
end

function Gamepad:getStick(joystickId)
    return self.connectedSticks[joystickId]
end

function Gamepad:buttonDown(joystickId, button)
    if self.isConnected[joystickId] == nil or self.isConnected[joystickId] == false then 
        return false
    else
        return self.buttonMap[joystickId][button] == true
    end
end

function Gamepad:buttonUp(joystickId, button)
    if self.isConnected[joystickId] == nil or self.isConnected[joystickId] == false then 
        return false
    else
        return self.buttonMap[joystickId][button] == false
    end
end

function Gamepad:update(dt)
    for i = 1, #self.isConnected do
        if self.buttonMap[i] then
            for k, v in pairs(self.buttonMap[i]) do
                self.buttonMap[i][k] = nil
            end
        end
    end
end

return Gamepad