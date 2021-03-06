local Scene = require('src.utils.scene')
local Button = require('src.utils.button')
local Label = require('src.utils.label')
local TextField = require('src.utils.textField')
local Slider = require('src.utils.slider')
local Checkbox = require('src.utils.checkbox')
local Utils = require('src.utils.utils')

local MainMenu = Scene:derive('Main Menu')

local entered = false

local function _checkKeyInput(self,dt)
    if Key:keyPressed('escape') then
        love.event.quit()
    end
end

function MainMenu:new(sceneManager)
    MainMenu.super.new(self, sceneManager)

    entered = true
    local w, h = love.graphics.getDimensions()
    local startButton = Button(w / 2, h / 2 - 30, 100, 40, 'Start')
    local quitButton = Button(w / 2, h / 2 + 30, 100, 40, 'Quit')
    local menuText = Label(w / 2, 30, love.graphics.getWidth(), 40, 'Main Menu', { 255, 255, 255, 255})
    local horizontalSlider = Slider(love.graphics.getWidth() / 2, love.graphics.getHeight() - 25, 200, 10, 'volume')
    local verticalSlider = Slider(20, love.graphics.getHeight() / 2, 10, 200, 'VerticalSlider', true)
    self.label = Label(love.graphics.getWidth() / 2 + 230, love.graphics.getHeight() - 22.5, 250, 40, '0', { 255, 255, 255, 255}, 'left')
    local checkbox = Checkbox(love.graphics.getWidth() / 2 + 100, h / 2 + 70, 200, 40, 'Check Me!')
    
    self.textField = TextField(w / 2, h / 2 + 90, 150, 40, 'Text Field', { 195, 195, 195, 255}, 'left')
    startButton:colours({ 0, 191, 0, 255}, { 0, 255, 0, 255}, { 0, 127, 0, 255}, { 63, 63, 63, 255})
    self.em:add(startButton)
    self.em:add(quitButton)
    self.em:add(menuText)
    self.em:add(self.textField)
    self.em:add(horizontalSlider)
    self.em:add(verticalSlider)
    self.em:add(self.label)
    self.em:add(checkbox)

    self.click = function(btn) self:onClick(btn) end
    self.sliderChanged = function(slider) self:onSliderChanged(slider) end
end

function MainMenu:enter()
    MainMenu.super.enter(self)
    _G.events:hook('onButtonClick', self.click)
    _G.events:hook('onSliderChanged', self.sliderChanged)
end

function MainMenu:exit()
    MainMenu.super.exit(self)
    _G.events:unhook('onButtonClick', self.click)
    _G.events:unhook('onSliderChanged', self.sliderChanged)
end

function MainMenu:onClick(button)
    print('Button clicked: ' .. button.text)
    if button.text == 'Start' then
        self.sceneManager:switch('testScene')
    elseif button.text == 'Quit' then
        love.event.quit()
    end
end

function MainMenu:onSliderChanged(slider)
    if slider.id == 'volume' then
        self.label.text = string.format('%d', slider:getValue() * 100)
    end
    print(slider.id .. ' - ' .. slider:getValue())
end

local prevDown = false
function MainMenu:update(dt)
    _checkKeyInput(self, dt)
    MainMenu.super.update(self, dt)
    mousePosX, mousePosY = love.mouse.getPosition()
    local down = love.mouse.isDown(1)
    if down and not prevDown then
        if Utils.pointInRect(
            { x = mousePosX, y = mousePosY}, 
            { 
                x = self.textField.pos.x - self.textField.size.x / 2, 
                y = self.textField.pos.y - self.textField.size.y / 2,
                w = self.textField.size.x, h = self.textField.size.y 
            }
        ) then
            self.textField:setFocus(true)
        else
            self.textField:setFocus(false)
        end
    end
    prevDown = down
end

function MainMenu:draw()
    MainMenu.super.draw(self)
end


return MainMenu