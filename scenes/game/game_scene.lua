local ProxyScene = require "Jester.proxy_scene"
local Scene = ProxyScene:subclass("LogoScene")
local FLOW = require "libs.flow"
local JESTER = require "Jester.jester"
local HASHES = require "libs.hashes"
local STENCIL = require "Jester.stencil.stencil_render"
--- Constructor
-- @param name Name of scene.Must be unique
function Scene:initialize()
    ProxyScene.initialize(self, "GameScene", "/game#proxy", "game:/scene_controller")
end

function Scene:on_show(input)
 --   msg.post("/gui#game_end_gui", HASHES.MSG_DISABLE)
end

function Scene:final(go_self)
    FLOW.stop()
end

function Scene:update(go_self, dt)
end

function Scene:show_out(co)
    STENCIL.show(2, false, false)
    FLOW.start(function()
        FLOW.frames(1)
        coroutine.resume(co)
    end)
    coroutine.yield()
end
return Scene