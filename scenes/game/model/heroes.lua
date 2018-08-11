local CLASS = require("libs.middleclass")
local LUME = require "libs.lume"
local M = {}
---@class Hero
local BaseModel = CLASS.class("BaseModel")
function BaseModel:initialize(productivity_mul)
    self.max_productivity = 1
    self.max_happy = 1
    self.productivity = 0.5
    self.happy = 0.5
end

function BaseModel:reset()
    self.productivity = 0.5
    self.happy = 0.5
end    

---@param number space_percent процент от диска
function BaseModel:act(space_percent)
    if space_percent >= 0.25 then
        self.happy = self.happy + 0.1
    else
        self.happy = self.happy - 0.1
    end
    self.happy = LUME.clamp(self.happy,0,1)
    if self.happy < 0.0001 then
        self.happy = 0
    end
    if self.happy >= 0.5 then
        self.productivity = self.productivity + 0.1
    else
        self.productivity = self.productivity - 0.1
    end
    self.productivity = LUME.clamp(self.productivity,0,1)
    if self.productivity < 0.0001 then
        self.productivity = 0
    end
end


M.hero_1 = BaseModel(1,2,3,4,5)
M.hero_2 = BaseModel(1,2,3,4,5)
M.hero_3 = BaseModel(1,2,3,4,5)

return M



