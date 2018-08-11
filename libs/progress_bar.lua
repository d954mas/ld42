local CLASS = require "libs.middleclass"
local LUME = require "libs.lume"

local Progress = CLASS.class("ProgressBar")

function Progress:initialize(id)
    self.bg = gui.get_node(id .. "/bg")
    self.fg = gui.get_node(id .. "/fg")
    self.max_width = gui.get_size(self.bg).x
    self.fg_height = gui.get_size(self.fg).y
end

function Progress:set_progress(value)
    local w = self.max_width * LUME.clamp(value,0,1)
    gui.set_size(self.fg, vmath.vector3(w, self.fg_height,0))
end

return Progress
