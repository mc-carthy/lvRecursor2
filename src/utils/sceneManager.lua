local Class = require('src.utils.class')
local Scene = require('src.utils.scene')

local SceneManager = Class:derive('SceneManager')

function SceneManager:new(sceneDir, scenes)
    self.scenes = {}
    self.sceneDir = sceneDir
    if scenes then
        assert(type(scenes) == 'table', 'Scenes parameter must be a table')
        for i = 1, #scenes do
            local scene = require(sceneDir .. scenes[i])
            assert(scene:is(Scene), 'File: ' .. sceneDir .. scenes[i] .. '.lua is not of type Scene.')
            self.scenes[scenes[i]] = scene(self)
        end
    else
    end

    self.previousSceneName = nil
    self.currentSceneName = nil
    self.currentScene = nil
end

function SceneManager:add(scene, sceneName)
    if scene then
        assert(type(scene) == 'table', 'Scene must be a table')
        assert(type(sceneName) == 'string', 'SceneName must be a string')
        assert(scene:is(Scene), 'Can not add non-scene objects to the scene manager.')        
        self.scenes[sceneName] = scene
    end
end

function SceneManager:remove(sceneName)
    if scene then
        for k, v in pairs(self.scenes) do
            if k == sceneName then
                self.scenes[k]:destroy()
                self.scenes[k] = nil
                if sceneName == self.currentSceneName then
                    self.currentScene = nil
                end
                break
            end
        end
    end
end

function SceneManager:switch(nextSceneName)
    if self.currentScene ~= nil then
        self.currentScene:exit()
    end

    if nextSceneName then
        assert(self.scenes[nextSceneName] ~= nil, 'Unable to find scene: ' .. nextSceneName)
        self.previousSceneName = self.currentSceneName
        self.currentSceneName = nextSceneName
        self.currentScene = self.scenes[self.currentSceneName]
        self.currentScene:enter()
    end
end

function SceneManager:pop()
    if self.previousSceneName then
        self:switch(self.previousSceneName)
        self.previousSceneName = nil
    end
end

function SceneManager:getSceneNames()
    local sceneNames = {}
    
    for k, v in pairs(self.scenes) do
        sceneNames[#sceneNames + 1] = k
    end

    return sceneNames
end

function SceneManager:update(dt)
    if self.currentScene then
        self.currentScene:update(dt)
    end
end

function SceneManager:draw()
    if self.currentScene then
        self.currentScene:draw()
    end
end

return SceneManager