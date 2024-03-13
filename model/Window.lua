local Constants = require("utils.Constants")

local WindowOptions = Constants.WindowOptions

Window = {}

function Window.init()
    love.window.setTitle("Pong")
    love.window.setMode(WindowOptions.WIDTH, WindowOptions.HEIGHT, { resizable = false })
end