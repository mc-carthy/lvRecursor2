local Scene = require('src.utils.scene')
local Button = require('src.utils.button')
local Label = require('src.utils.label')

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
        local menuText = Label(w / 2, 30, love.graphics.getWidth(), 40, 'Main Menu', { 0, 255, 0, 255})
        startButton:colours({ 0, 191, 0, 255}, { 0, 255, 0, 255}, { 0, 127, 0, 255}, { 63, 63, 63, 255})
        self.em:add(startButton)
        self.em:add(quitButton)
        self.em:add(menuText)
    end
    _G.events:hook('onButtonClick', self.click)
end

function MainMenu:exit()
    _G.events:unhook('onButtonClick', self.click)
end

function MainMenu:new(sceneManager)
    MainMenu.super.new(self, sceneManager)
    self.click = function(btn) self:onClick(btn) end
end

function MainMenu:onClick(button)
    print('Button clicked: ' .. button.text)
    if button.text == 'Start' then
        self.sceneManager:switch('testScene')
    elseif button.text == 'Quit' then
        love.event.quit()
    end
end

function MainMenu:update(dt)
    _checkKeyInput(self, dt)
    MainMenu.super.update(self, dt)
end

function MainMenu:draw()
    MainMenu.super.draw(self)
end


return MainMenu