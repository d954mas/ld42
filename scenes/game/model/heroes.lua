local CLASS = require("libs.middleclass")
local LUME = require "libs.lume"
local M = {}
---@class Hero
local BaseModel = CLASS.class("BaseModel")
function BaseModel:initialize(mp, mh, pr, h, im, ip, tm, tp, imp, nh, np, need)
    self.max_productivity = mp
    self.max_happy = mh
    self.productivity = pr
    self.happy = h
    self.irr_minus = im
    self.irr_plus = ip
    self.temp_minus = tm
    self.temp_plus = tp
    self.importance = imp
    self.norm_happy = nh
    self.norm_productivity = np
    self.need_space = need
end

function BaseModel:reset()
    self.productivity = 0.5
    self.happy = 0.5
end    

---@param number space_percent процент от диска
function BaseModel:act(space_percent)
    pprint(space_percent)
    if space_percent > self.need_space then
        self.happy = self.happy + (space_percent - self.need_space) * self.irr_plus
    else
        self.happy = self.happy - (self.need_space - space_percent) * self.irr_minus
    end
    self.happy = LUME.clamp(self.happy,0,1)
    if self.happy < 0.0001 then
        self.happy = 0
    end
    if self.happy >= self.norm_happy then
        self.productivity = self.productivity + 0.1 * self.temp_plus
    else
        self.productivity = self.productivity - (self.norm_happy - self.happy) * self.temp_minus
    end
    self.productivity = LUME.clamp(self.productivity,0,1)
    if self.productivity < 0.0001 then
        self.productivity = 0
    end
    self.my_param = 0
    if self.productivity < self.norm_productivity then
        self.my_param = 0.075 * self.importance
    end
end


M.hero_1 = BaseModel(
--[[max_productivity]]   1,
--[[max_happy]]          1,
--[[productivity]]       0.5,
--[[happy]]              0.6,
--[[irr_minus]]          1,
--[[irr_plus]]           2,
--[[temp_minus]]         1,
--[[temp_plus]]          1.5,
--[[importance]]         1,
--[[norm_happy]]         0.4,
--[[norm_productivity]]  0.1,
--[[need_space]]         0.18)

M.hero_2 = BaseModel(
--[[max_productivity]]   1,
--[[max_happy]]          1,
--[[productivity]]       0.5,
--[[happy]]              0.6,
--[[irr_minus]]          0.5,
--[[irr_plus]]           1,
--[[temp_minus]]         2,
--[[temp_plus]]          1,
--[[importance]]         1.5,
--[[norm_happy]]         0.6,
--[[norm_productivity]]  0.1,
--[[need_space]]         0.15)

M.hero_3 = BaseModel(
--[[max_productivity]]   1,
--[[max_happy]]          1,
--[[productivity]]       0.5,
--[[happy]]              0.6,
--[[irr_minus]]          1.5,
--[[irr_plus]]           1,
--[[temp_minus]]         0.5,
--[[temp_plus]]          1.5,
--[[importance]]         2,
--[[norm_happy]]         0.3,
--[[norm_productivity]]  0.1,
--[[need_space]]         0.33)

return M



