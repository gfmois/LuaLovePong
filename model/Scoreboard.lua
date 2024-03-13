local Constants = require("utils.Constants")

Scoreboard = {}

function Scoreboard:new()
    local scoreboard = {}

    setmetatable(scoreboard, self)
    self.__index = self

    return scoreboard
end

return Scoreboard