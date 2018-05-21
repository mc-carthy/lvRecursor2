local Label = require('src/utils/label')

local utf8 = require('utf8')
local U = require('src/utils/utils')

local TextField = Label:derive('TextField')

local cursor = '|'

function TextField:new(x, y, w, h, text, colour, textAlign)
    TextField.super.new(self, x, y, w, h, text, colour, textAlign)
    self.focus = false
    self.focusColour = { 127, 127, 127, 255 }
    self.unfocusColour = { 32, 32, 32, 255 }
    self.backColour = self.unfocusColour

    self.onKeyPressed = function(key)
        if key == 'backspace' then
            self:textInput(key)
        end
    end
    self.onTextInput = function(text)
        self:textInput(text)
    end
end

function TextField:onEnter()
    _G.events:hook('keyPressed', self.onKeyPressed)
    _G.events:hook('textInput', self.onTextInput)
end

function TextField:onExit()
    _G.events:unhook('keyPressed', self.onKeyPressed)
    _G.events:unhook('textInput', self.onTextInput)
end

function TextField:setFocus(focus)
    assert(type(focus) == 'boolean', 'Focus value should be a boolean')
    if focus then
        self.backColour = self.focusColour
        if not self.focus then
            self.text = self.text .. cursor
        end
    else
        self.backColour = self.unfocusColour
        if not focus and self.focus then
            self:removeEndCharacters(1)
        end
    end
    self.focus = focus
end

function TextField:textInput(key)
    if not self.focus or not self.enabled then return end
    if key == 'backspace' then
        self:removeEndCharacters(2)
        self.text = self.text .. cursor
    else
        self:removeEndCharacters(1)
        self.text = self.text .. key
        self.text = self.text .. cursor
    end
end

function TextField:removeEndCharacters(numCharacters)
    local byteOffset = utf8.offset(self.text, -numCharacters)
    if byteOffset then
        self.text = string.sub(self.text, 1, byteOffset - 1)
    end
end

function TextField:draw()
    love.graphics.setColor(self.backColour)
    love.graphics.rectangle('fill', self.pos.x - self.size.x / 2, self.pos.y - self.size.y / 2, self.size.x, self.size.y)
    TextField.super.draw(self)
end

return TextField