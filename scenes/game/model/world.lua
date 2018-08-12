local CLASS = require("libs.middleclass")
local HEROES = require "scenes.game.model.heroes"
---@class World
local World = CLASS.class("World")

function World:initialize()
    ---@type Hero[]
    self.heroes = {HEROES.hero_1, HEROES.hero_2, HEROES.hero_3}
    self:reset()
end

function World:act(disk_spaces)
    for i, hero in ipairs(self.heroes) do
        hero:act(disk_spaces[i])
    end
    self.days = self.days - 1
end

function World:reset()
    self.station_hp = 1
    self.days = 15
end    

---SINGLETON
return World()