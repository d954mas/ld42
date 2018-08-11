local CLASS = require("libs.middleclass")
local M = {}
local BaseModel = CLASS.class("BaseModel")

function BaseModel:initialize(productivity_mul)
    self.max_productivity = 1
    self.max_happy = 1
    self.productivity = 0.5
    self.happy = 0.5
end


M.hero_1 = BaseModel(1,2,3,4,5)
M.hero_2 = BaseModel(1,2,3,4,5)
M.hero_3 = BaseModel(1,2,3,4,5)

return M



