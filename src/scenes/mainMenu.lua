local Scene = require('src.utils.scene')
local Button = require('src.utils.button')

local MainMenu = Scene:derive('Main Menu')

local entered = false

local function _checkKeyInput(self,dt)
    if Key:keyPressed('escape') then
        love.event.quit()
    end
    if Key:keyPressed('space') then
        self.button:enable(not self.button.enabled)
    end
end

function MainMenu:enter()
    if not entered then
        entered = true
        local w, h = love.graphics.getDimensions()
        local startButton = Button(w / 2, h / 2 - 30, 100, 40, 'Start')
        local quitButton = Button(w / 2, h / 2 + 30, 100, 40, 'Quit')
        startButton:colours({ 0, 191, 0, 255}, { 0, 255, 0, 255}, { 0, 127, 0, 255}, { 63, 63, 63, 255})
        self.em:add(startButton)
        self.em:add(quitButton)
    end
    _G.events:hook('onButtonClick', self.click)
end

function MainMenu:exit()
    _G.events:unhook('onButtonClick', self.click)
end

function MainMenu:new(sceneManager)
    self.super:new(sceneMgr)
    self.click = function(btn) self:onClick(btn) end
end

function MainMenu:onClick(button)
    print('Button clicked: ' .. button.label)
    if button.label == 'Start' then
        self.sceneManager:switch('testScene')
    elseif button.label == 'Quit' then
        love.event.quit()
    end
end

function MainMenu:update(dt)
    _checkKeyInput(self, dt)
    self.super:update(dt)
end

function MainMenu:draw()
    love.graphics.printf('Main Menu', 0, 25, love.graphics.getWidth(), 'center')
    self.super:draw()
end


return MainMenu