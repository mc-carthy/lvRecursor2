local Scene = require('src.utils.scene')
local Button = require('src.utils.button')

local MainMenu = Scene:derive('Main Menu')

local function _checkKeyInput(self,dt)
    if Key:keyPressed('escape') then
        love.event.quit()
    end
    if Key:keyPressed('space') then
        self.button:enable(not self.button.enabled)
    end
end

function MainMenu:enter()
    _G.events:hook('onButtonClick', onClick)
end

function MainMenu:exit()
    _G.events:unhook('onButtonClick', onClick)
end

function MainMenu:new(sceneManager)
    self.super:new(sceneMgr)
    self.button = Button(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 100, 50, 'Test label')
end

function onClick(button)
    print('Button clicked: ' .. button.label)
    button:enable(false)
end

function MainMenu:update(dt)
    _checkKeyInput(self, dt)
    self.button:update(dt)
end

function MainMenu:draw()
    love.graphics.print('Hello from Main Menu', 10, 10)
    self.button:draw()
end


return MainMenu