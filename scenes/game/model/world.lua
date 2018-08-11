local CLASS = require("libs.middleclass")
local HEROES = require "scenes.game.model.heroes"
---@class World
local World = CLASS.class("World")

function World:initialize(productivity_mul)
    ---@type Hero[]
   self.heroes = {HEROES.hero_1, HEROES.hero_2, HEROES.hero_3}
end

function World:act()
    for _, hero in ipairs(self.heroes) do
        hero:act(0.33)
    end
end


return World
