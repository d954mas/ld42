local CLASS = require("libs.middleclass")
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

end


M.hero_1 = BaseModel(1,2,3,4,5)
M.hero_2 = BaseModel(1,2,3,4,5)
M.hero_3 = BaseModel(1,2,3,4,5)

return M



