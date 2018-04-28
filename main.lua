-- require('src.utils.debug')
local Animation = require('src.utils.animation')
local Sprite = require('src.utils.sprite')
local Key = require('src.utils.keyboard')
local Gamepad = require('src.utils.gamepad')
local Event = require('src.utils.events')

local heroAtlas
local spr
local E

local gamepad = Gamepad({'src/assets/gameControllerDb.txt'}, true)

local idleAnimation
local walkAnimation
local swimAnimation
local punchAnimation
local punchSfx

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    Key:hookLoveEvents()
    E = Event()
    E:add('onSpace')
    E:hook('onSpace', onSpace)
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

    gamepad.event:hook('controllerAdded', onControllerAdded)
    gamepad.event:hook('controllerRemoved', onControllerRemoved)
end

function love.update(dt)
    spr:update(dt)
    _checkKeyInput(dt)
    Key:update(dt)
    gamepad:update(dt)

    if spr.currentAnimation == 'punch' and spr:animationFinished() then
        spr:animate('idle')
    end
end

function love.draw()
    spr:draw()
end

function onSpace()
    print('Space!')
end

function onControllerAdded(joystickId)
    print('Joystick ' .. joystickId .. ' added!')
end

function onControllerRemoved(joystickId)
    print('Joystick ' .. joystickId .. ' removed!')
end

function _checkKeyInput(dt)
    if Key:keyPressed('space') and spr.currentAnimation ~= 'punch' then
        spr:animate('punch')
        love.audio.stop()
        love.audio.play(punchSfx)
        E:invoke('onSpace')
    end
    if Key:keyPressed('a') or Key:keyPressed('left') then
        spr:flipH(true)
    end
    if Key:keyPressed('d') or Key:keyPressed('right') then
        spr:flipH(false)
    end
    if Key:keyPressed('w') or Key:keyPressed('up') then
        spr:flipV(true)
    end
    if Key:keyPressed('s') or Key:keyPressed('down') then
        spr:flipV(false)
    end
    if Key:keyPressed('u') then
        E:unhook('onSpace', onSpace)
    end
    if Key:keyPressed('escape') then
        love.event.quit()
    end
end