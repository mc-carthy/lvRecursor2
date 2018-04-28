-- require('src.utils.debug')
Key = require('src.utils.keyboard')
local Gamepad = require('src.utils.gamepad')
local SceneManager = require('src.utils.sceneManager')

local gamepad = Gamepad({'src/assets/gameControllerDb.txt'}, true)
local scnMgr

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    Key:hookLoveEvents()
    scnMgr = SceneManager('src/scenes/', { 'mainMenu', 'testScene' })
    scnMgr:switch('testScene')

    gamepad.event:hook('controllerAdded', onControllerAdded)
    gamepad.event:hook('controllerRemoved', onControllerRemoved)
end

function love.update(dt)
    if Key:keyPressed(',') then
        scnMgr:switch('mainMenu')
    end
    if Key:keyPressed('.') then
        scnMgr:switch('testScene')
    end
    scnMgr:update(dt)
    Key:update(dt)
    gamepad:update(dt)
end

function love.draw()
    scnMgr:draw()
end

function onControllerAdded(joystickId)
    print('Joystick ' .. joystickId .. ' added!')
end

function onControllerRemoved(joystickId)
    print('Joystick ' .. joystickId .. ' removed!')
end