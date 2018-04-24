-- require('src.utils.debug')
local Animation = require('src.utils.animation')
local Sprite = require('src.utils.sprite')

local heroAtlas
local spr
local walkAnimation
local swimAnimation

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    heroAtlas = love.graphics.newImage('src/assets/img/hero.png')
    spr = Sprite(heroAtlas, 100, 100, 16, 16, 10, 10)
    idleAnimation = Animation(16, 16, 16, 16, 4, 4, 6)
    walkAnimation = Animation(16, 32, 16, 16, 6, 6, 10)
    swimAnimation = Animation(16, 64, 16, 16, 6, 6, 10)
    punchAnimation = Animation(16, 80, 16, 16, 3, 3, 8, false)
    spr:addAnimation('idle', idleAnimation)
    spr:addAnimation('walk', walkAnimation)
    spr:addAnimation('swim', swimAnimation)
    spr:addAnimation('punch', punchAnimation)
    spr:animate('idle')
end

function love.update(dt)
    spr:update(dt)
end

function love.draw()
    spr:draw()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end