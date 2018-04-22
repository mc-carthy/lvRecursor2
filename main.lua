-- require('src.utils.debug')

local heroAtlas
local heroSprite

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    heroAtlas = love.graphics.newImage('src/assets/img/hero.png')
    heroSprite = love.graphics.newQuad(32, 16, 16, 16, heroAtlas:getDimensions())
end

function love.update(dt)

end

function love.draw()
    -- love.graphics.draw(heroAtlas, 32, 32, 0, 4, 4)
    love.graphics.draw(heroAtlas, heroSprite, 32, 32, 0, 4, 4)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end