local CLASS = require("libs.middleclass")
local HEROES = require "scenes.game.model.heroes"
---@class World
local World = CLASS.class("World")

function World:initialize()
    ---@type Hero[]
   self.heroes = {HEROES.hero_1, HEROES.hero_2, HEROES.hero_3}
end

function World:act(disk_spaces)
    for i, hero in ipairs(self.heroes) do
        hero:act(disk_spaces[i])
    end
end

function World:reset()

end    

---SINGLETON
return World()