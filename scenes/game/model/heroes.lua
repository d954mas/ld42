local CLASS = require("libs.middleclass")
local LUME = require "libs.lume"
local M = {}
---@class Hero
local BaseModel = CLASS.class("BaseModel")
function BaseModel:initialize(mp, mh, pr, h, im, ip, tm, tp, imp, nh, np, need)
    self.max_productivity = mp or 0
    self.max_happy = mh or 0
    self.productivity = pr or 0
    self.happy = h or 0
    self.irr_minus = im or 0
    self.irr_plus = ip or 0
    self.temp_minus = tm or 0
    self.temp_plus = tp or 0
    self.importance = imp or 0
    self.norm_happy = nh or 0
    self.norm_productivity = np or 0
    self.need_space = need or 0
end

function BaseModel:reset()
    self.productivity = 0.5
    self.happy = 0.7
end    

---@param number space_percent процент от диска
function BaseModel:act(space_percent)
    pprint(space_percent)
    if space_percent > self.need_space then
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


M.hero_1 = BaseModel(1,1,0.5,0.6,1,2,1,1.5,1,0.5,0.5,0,3)
M.hero_2 = BaseModel(1,1,0.1,0.5,5)
M.hero_3 = BaseModel(1,1,3,4,5)

return M



