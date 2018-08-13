local CLASS = require("libs.middleclass")
local HEROES = require "scenes.game.model.heroes"
local HASHES = require "libs.hashes"
local JESTER = require "Jester.jester"
local LUME = require "libs.lume"
---@class World
local World = CLASS.class("World")


local events = {
    {lbl="The technician worked with inoperative equipment and increased the size of the disk. System files began to take up less space.",
     function(world) world:change_system_space(world.disk_space - 0.2) end },
    {lbl="The medic developed a cure for stress. The level of contentment has increased.",
     function(world) world:add_all_happy(0.3) end },
    {lbl="The scientist has developed a unique method of work. Productivity of the whole team has increased.",
     function(world) world:add_all_productivity(0.1) end },
    {lbl="Bad news. The expedition is delayed. days remained +1",
     function(world) world.days = world.days + 1 end },
    {lbl="Space debris got to the station. Stability of the station has decreased.",
     function(world) world.station_hp = LUME.clamp(world.station_hp - 0.1,0,1) end },
}

function World:add_all_happy(value)
    for i, hero in ipairs(self.heroes) do
        hero.happy = LUME.clamp(hero.happy+value,0,1)
    end
end
function World:add_all_productivity(value)
    for i, hero in ipairs(self.heroes) do
        hero.productivity = LUME.clamp(hero.productivity+value,0,1)
    end
end

function World:initialize()
    ---@type Hero[]
    self.heroes = {HEROES.hero_1, HEROES.hero_2, HEROES.hero_3}
    self:reset()
    self.events = LUME.shuffle(events)
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

    if not self:check(gui, fn) and self.current_day % 3 == 0 then
        local event = table.remove(self.events)
        event[1](self)
        fn(gui, "Event", event.lbl, "ok", function ()  end)
    end
end
function World:check(gui, show_message_fn)
    if self.days <= 0  then
        show_message_fn(gui, "WIN", "", "Restart", function() JESTER.reload() end)
        return true
    elseif self.station_hp <=0.000001 then
        show_message_fn(gui, "Game Over", "Station destroyed", "Restart", function() JESTER.reload() end)
        return true
    end
    return false
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
        hero.prev_happy = nil
    end
    self.disk_space = { 0.4, 0.1, 0.25, 0.25 }
end    

---SINGLETON
return World()