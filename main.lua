-- require('src.utils.debug')

local heroAtlas
local heroSprite

local fps = 15
local animTime = 1 / fps
local frame = 1
local numFrames = 6
local xOffset
local cellWidth = 16

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    heroAtlas = love.graphics.newImage('src/assets/img/hero.png')
    heroSprite = love.graphics.newQuad(16, 32, 16, 16, heroAtlas:getDimensions())
end

function love.update(dt)
    animTime = animTime - dt
    if animTime <= 0 then
        animTime = 1 / fps
        frame = frame + 1
        if frame > numFrames then
            frame = 1
        end
        xOffset = cellWidth * frame
        heroSprite:setViewport(xOffset, 32, 16, 16, heroAtlas:getDimensions())
    end
end

function love.draw()
    -- love.graphics.draw(heroAtlas, 32, 32, 0, 4, 4)
    love.graphics.draw(heroAtlas, heroSprite, 32, 32, 0, 10, 10)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end