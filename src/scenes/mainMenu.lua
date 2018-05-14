local Scene = require('src.utils.scene')
local Button = require('src.utils.button')
local Label = require('src.utils.label')
local TextField = require('src.utils.textField')

local MainMenu = Scene:derive('Main Menu')

local entered = false

local function _checkKeyInput(self,dt)
    if Key:keyPressed('escape') then
        love.event.quit()
    end
end

function MainMenu:enter()
    MainMenu.super.enter(self)
    if not entered then
        entered = true
        local w, h = love.graphics.getDimensions()
        local startButton = Button(w / 2, h / 2 - 30, 100, 40, 'Start')
        local quitButton = Button(w / 2, h / 2 + 30, 100, 40, 'Quit')
        local menuText = Label(w / 2, 30, love.graphics.getWidth(), 40, 'Main Menu', { 255, 255, 255, 255})
        local textField = TextField(w / 2, h / 2 + 90, 150, 40, 'Text Field', { 195, 195, 195, 255}, 'left')
        startButton:colours({ 0, 191, 0, 255}, { 0, 255, 0, 255}, { 0, 127, 0, 255}, { 63, 63, 63, 255})
        self.em:add(startButton)
        self.em:add(quitButton)
        self.em:add(menuText)
        self.em:add(textField)
    end
    _G.events:hook('onButtonClick', self.click)
end

function MainMenu:exit()
    MainMenu.super.exit(self)
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