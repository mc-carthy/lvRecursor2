local Keyboard = {}

local keyStates = {}

function Keyboard:update(dt)
    for k, v in pairs(keyStates) do
        keyStates[k] = nil
    end
end

function Keyboard:key(key)
    return love.keyboard.isDown(key)
end

function Keyboard:keyPressed(key)
    return keyStates[key]
end

function Keyboard:keyReleased(key)
    return keyStates[key] == false
end

function Keyboard:hookLoveEvents()
    function love.keypressed(key, scancode, isrepeat)
        keyStates[key] = true
        _G.events:invoke('keyPressed', key)
    end
    function love.keyreleased(key)
        keyStates[key] = false
        _G.events:invoke('keyReleased', key)
    end
        
    function love.textinput(text)
        _G.events:invoke('textInput', text)     
    end
end

return Keyboard