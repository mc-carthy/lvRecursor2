local Animation = require('src.utils.animation')
local Sprite = require('src.utils.sprite')

local Scene = require('src.utils.scene')

local TestScene = Scene:derive('Test Scene')

local heroAtlas
local spr
local idleAnimation
local walkAnimation
local swimAnimation
local punchAnimation
local punchSfx

local function _checkKeyInput(dt)
    if Key:keyPressed('space') and spr.currentAnimation and spr.currentAnimation ~= 'punch' then
        spr:animate('punch')
        love.audio.stop()
        love.audio.play(punchSfx)
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
    if Key:keyPressed('escape') then
        love.event.quit()
    end
end

function TestScene:new(sceneMgr)
    TestScene.super.new(self, sceneMgr)
    heroAtlas = love.graphics.newImage('src/assets/img/hero.png')
    punchSfx = love.audio.newSource('src/assets/sfx/hit01.wav', 'static')
end

function TestScene:enter()
    spr = Sprite(heroAtlas, 100, 100, 16, 16, 10, 10)
    idleAnimation = Animation(16, 16, 16, 16, 4, 4, 6)
    walkAnimation = Animation(16, 32, 16, 16, 6, 6, 10)
    swimAnimation = Animation(16, 64, 16, 16, 6, 6, 10)
    punchAnimation = Animation(16, 80, 16, 16, { 1, 2, 3, 2, 1}, 3, 10, false)
    spr:addAnimations({ idle = idleAnimation, walk = walkAnimation, swim = swimAnimation, punch = punchAnimation })
    spr:animate('idle')
    self.em:add(spr)
end

function TestScene:update(dt)
    TestScene.super.update(self, dt)
    _checkKeyInput(dt)
    if spr.currentAnimation == 'punch' and spr:animationFinished() then
        spr:animate('idle')
    end
end

function TestScene:draw()
    TestScene.super.draw(self)
    love.graphics.print('Hello from Test Scene', 10, 10)
end

return TestScene