local utf8 = require('utf8')
local Label = require('src/utils/label')

local TextField = Label:derive('TextField')

function TextField:new(x, y, w, h, text, colour, textAlign)
    TextField.super.new(self, x, y, w, h, text, colour, textAlign)
    self.focus = false

    self.onKeyPressed = function(key)
        if key == 'backspace' then
            self:textInput(key)
        end
    end
    self.onTextInput = function(text)
        self:textInput(text)
    end

    _G.events:hook('keyPressed', self.onKeyPressed)
    _G.events:hook('textInput', self.onTextInput)
end

function TextField:setFocus(focus)
    assert(type(focus) == 'Boolean', 'Focus value should be a boolean')
    self.focus = focus
end

function TextField:textInput(key)
    -- if not self.focus or not self.enabled then return end
    if key == 'backspace' then
        local byteOffset = utf8.offset(self.text, -1)
        if byteOffset then
            self.text = string.sub(self.text, 1, byteOffset - 1)
        end
    else
        self.text = self.text .. key
    end
end

function TextField:draw()
    love.graphics.setColor(63, 63, 63, 255)
    love.graphics.rectangle('fill', self.pos.x - self.size.x / 2, self.pos.y - self.size.y / 2, self.size.x, self.size.y)
    TextField.super.draw(self)
end

return TextField