-- require('src.utils.debug')
local Animation = require('src.utils.animation')
local Sprite = require('src.utils.sprite')

local heroAtlas
local spr
local idleAnimation
local walkAnimation
local swimAnimation
local punchAnimation
local punchSfx

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    heroAtlas = love.graphics.newImage('src/assets/img/hero.png')
    spr = Sprite(heroAtlas, 100, 100, 16, 16, 10, 10)
    idleAnimation = Animation(16, 16, 16, 16, 4, 4, 6)
    walkAnimation = Animation(16, 32, 16, 16, 6, 6, 10)
    swimAnimation = Animation(16, 64, 16, 16, 6, 6, 10)
    punchAnimation = Animation(16, 80, 16, 16, { 1, 2, 3, 2, 1}, 3, 10, false)
    spr:addAnimation('idle', idleAnimation)
    spr:addAnimation('walk', walkAnimation)
    spr:addAnimation('swim', swimAnimation)
    spr:addAnimation('punch', punchAnimation)
    spr:animate('walk')
    punchSfx = love.audio.newSource('src/assets/sfx/hit01.wav', 'static')
end

function love.update(dt)
    spr:update(dt)

    if spr.currentAnimation == 'punch' and spr:animationFinished() then
        spr:animate('idle')
    end
end

function love.draw()
    spr:draw()
end

function love.keypressed(key)
    if key == 'space' and spr.currentAnimation ~= 'punch' then
        spr:animate('punch')
        love.audio.stop()
        love.audio.play(punchSfx)
    end
    if key == 'a' or key == 'left' then
        spr:flipH(true)
    end
    if key == 'd' or key == 'right' then
        spr:flipH(false)
    end
    if key == 'w' or key == 'up' then
        spr:flipV(true)
    end
    if key == 's' or key == 'down' then
        spr:flipV(false)
    end
    if key == 'escape' then
        love.event.quit()
    end
end