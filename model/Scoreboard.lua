local Constants = require("utils.Constants")

Scoreboard = {}

function Scoreboard:new()
    local scoreboard = {
        players = {
            player1 = 0,
            player2 = 0,
            player3 = 0,
            player4 = 0
        }
    }

    setmetatable(scoreboard, self)
    self.__index = self

    return scoreboard
end

function Scoreboard:draw(gamemode)
    if gamemode == Constants.States.DEFAULT_GAME then
        love.graphics.print("Player 1: " .. self.players["player1"], 10, 10)
        love.graphics.print("Player 2: " .. self.players["player1"], love.graphics.getWidth() - 100, 10)
    end
end

function Scoreboard:update(ball, gamemode)
    if gamemode == Constants.States.DEFAULT_GAME then
        if ball.x < Constants.Player.LEFT_PLAYER.X + 1 then
            self:scorePoint("player1")
            print(self.players["player1"])
            love.graphics.print("Player 1: " .. self.players["player1"], 10, 10)
        elseif ball.x > love.graphics.getWidth() then
            self:scorePoint("player2")
            love.graphics.print("Player 2: " .. self.players["player1"], love.graphics.getWidth() - 100, 10)
        end
    end
end

function Scoreboard:scorePoint(player)
    self.players[player] = player +1
end

return Scoreboard