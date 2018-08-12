local CLASS = require("libs.middleclass")
local HEROES = require "scenes.game.model.heroes"
local HASHES = require "libs.hashes"
local JESTER = require "Jester.jester"
---@class World
local World = CLASS.class("World")

function World:initialize()
    ---@type Hero[]
    self.heroes = {HEROES.hero_1, HEROES.hero_2, HEROES.hero_3}
    self:reset()
end

function World:act(disk_spaces, gui, fn)
    for i, hero in ipairs(self.heroes) do
        hero:act(disk_spaces[i])
    end
    self.days = self.days - 1
    self:check(gui, fn)
end
function World:check(gui, show_message_fn)
    if self.days <= 0  then
        show_message_fn(gui, "WIN", "", "Restart", function() JESTER.reload() end)
    elseif self.station_hp <=0.000001 then
        show_message_fn(gui, "Game Over", "Station destroyed", "Restart", function() JESTER.reload() end)
    end
end

function World:change_system_space(system)
    local v = (1-system)/3
    self.disk_space = {system, v,v,v }
end


function World:reset()
    self.station_hp = 1
    self.days = 15
    for i, hero in ipairs(self.heroes) do
        hero:reset()
    end
    self.disk_space = { 0.4, 0.1, 0.25, 0.25 }
end    

---SINGLETON
return World()