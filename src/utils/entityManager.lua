local Class = require('src.utils.class')

local EntityManager = Class:derive('EntityManager')

local function contains(tbl, item)
    for k, v in pairs(tbl) do
        if v == item then
            return true
        end
    end
    return false
end

local function compareLayers(e1, e2)
    return e1.layer < e2.layer
end

function EntityManager:new()
    self.entities = {}
end

function EntityManager:onEnter()
    for i = 1, #self.entities do
        local e = self.entities[i]
        if e.onEnter then e:onEnter() end
    end
end

function EntityManager:onExit()
    for i = 1, #self.entities do
        local e = self.entities[i]
        if e.onExit then e:onExit() end
    end
end

function EntityManager:add(entity)
    if contains(self.entities, entity) then return end
    
    entity.layer = entity.layer or 1
    entity.started = entity.started or false
        
    self.entities[#self.entities + 1] = entity
    
    table.sort(self.entities, compareLayers)
end

function EntityManager:remove(entity)

end

function EntityManager:update(dt)
    for i = #self.entities, 1, -1 do
        local e = self.entities[i]

        if e.remove then
            e.remove = false
            if e.onRemove then
                e.onRemove()
            end
            table.remove(self.entities, i)
        end

        if not e.started then
            e.started = true
            if e.onStart then
                e.onStart()
            end
        elseif e.update then
            e:update(dt)
        end


    end
end

function EntityManager:draw()
    for i = 1, #self.entities do
        self.entities[i]:draw()
    end
end

return EntityManager