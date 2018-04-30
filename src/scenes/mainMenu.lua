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
    _G.events:hook('onButtonClick', self.click)
end

function MainMenu:exit()
    _G.events:unhook('onButtonClick', self.click)
end

function MainMenu:new(sceneManager)
    self.super:new(sceneMgr)
    local w, h = love.graphics.getDimensions()
    self.button = Button(w / 2, h / 2 - 60, 100, 40, 'Start')
    self.click = function(btn) self:onClick(btn) end
end

function MainMenu:onClick(button)
    print('Button clicked: ' .. button.label)
    self.sceneManager:switch('testScene')
end

function MainMenu:update(dt)
    _checkKeyInput(self, dt)
    self.button:update(dt)
end

function MainMenu:draw()
    love.graphics.printf('Main Menu', 0, 25, love.graphics.getWidth(), 'center')
    self.button:draw()
end


return MainMenu