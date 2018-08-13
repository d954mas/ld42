local CLASS = require("libs.middleclass")
local HEROES = require "scenes.game.model.heroes"
local HASHES = require "libs.hashes"
local JESTER = require "Jester.jester"
---@class World
local World = CLASS.class("World")


local events = {
    {}
}

function World:initialize()
    ---@type Hero[]
    self.heroes = {HEROES.hero_1, HEROES.hero_2, HEROES.hero_3}
    self:reset()
end

function World:act(disk_spaces, gui, fn)
    local params = {}
    for i, hero in ipairs(self.heroes) do
        hero:act(disk_spaces[i])
        params[i] = hero.my_param
    end
    self.station_hp = self.station_hp - (params[1] + params[2] + params[3])
    self.days = self.days - 1
    self.current_day = self.current_day +1
    if self.days == 13 then
        self:change_system_space(0.9)
    end
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
    self.disk_space[1] = system
    self.disk_space[2] = v
    self.disk_space[3] = v
    self.disk_space[4] = v
end


function World:reset()
    self.station_hp = 1
    self.days = 15
    self.current_day = 0
    for i, hero in ipairs(self.heroes) do
        hero:reset()
    end
    self.disk_space = { 0.4, 0.1, 0.25, 0.25 }
end    

---SINGLETON
return World()