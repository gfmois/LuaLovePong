require("model.Paddle")
require("model.Ball")
require ("model.Window")
require("model.Scoreboard")

local Menu = require("model.Menu")
local Utils = require("utils.Utils") 
local Constants = require("utils.Constants")

-- Constants
local States = Constants.States
local PaddleOptions = Constants.PaddleOptions
local BallOptions = Constants.BallOptions
local PlayerOptions = Constants.Player

-- To pass an Window Model
local menu = Menu:new()
local scoreboard = Scoreboard:new()

-- Paddle and ball initialization
local leftPaddle = Paddle:new(PlayerOptions.LEFT_PLAYER.X, PlayerOptions.LEFT_PLAYER.Y, PaddleOptions.WIDTH, PaddleOptions.HEIGHT, PaddleOptions.SPEED, PlayerOptions.LEFT_PLAYER)
local rightPaddle = Paddle:new(740, 250, PaddleOptions.WIDTH, PaddleOptions.HEIGHT, PaddleOptions.SPEED, PlayerOptions.RIGHT_PLAYER)
local topPaddle = Paddle:new(370, 50, PaddleOptions.HEIGHT, PaddleOptions.WIDTH, PaddleOptions.SPEED, PlayerOptions.TOP_PLAYER, true)
local bottomPaddle = Paddle:new(370, 545, PaddleOptions.HEIGHT, PaddleOptions.WIDTH, PaddleOptions.SPEED, PlayerOptions.BOTTOM_PLAYER, true)

local ball = Ball:new(400, 300, BallOptions.SIZE, BallOptions.SPEED)
local score = { player1 = 0, player2 = 0 }

local isMultiple = false

-- Function to initialize the game
function love.load()
    Window.init()
end

-- Function to handle keyboard navigation on menu
function love.keypressed(key)
    if key == "q" then
        love.event.quit()
    end

    if key == "p" then
        ball.speed = ball.speed + 20
        leftPaddle.speed = leftPaddle.speed + 20
        rightPaddle.speed = rightPaddle.speed + 20
        topPaddle.speed = topPaddle.speed + 20
        bottomPaddle.speed = bottomPaddle.speed + 20
    end

    if menu:getCurrentState() == States.MENU then
        if key == "return" then
            Utils.switch(menu.selectedOption, {
                [1] = function()
                    menu:setCurrentState(States.DEFAULT_GAME)
                end,
                [2] = function()
                    menu:setCurrentState(States.MULTIPLE_GAME)
                    isMultiple = true
                end,
                [3] = function()
                    menu:setCurrentState(States.FOOSBALL_GAME)

                    bottomPaddle:setMovement(PlayerOptions.TOP_PLAYER)
                    rightPaddle:setMovement(PlayerOptions.LEFT_PLAYER)

                    isMultiple = true
                end,
                default = function()
                    love.event.quit()
                end
            })
        elseif key == "up" then
            menu:setSelectedOption(math.max(1, menu.selectedOption - 1))
        elseif key == "down" then
            menu:setSelectedOption(math.min(#menu.options, menu.selectedOption + 1))
        end
    end
end

-- Function to update the game state
function love.update(dt)
    if menu.currentState == States.DEFAULT_GAME or isMultiple then
        updatePaddles(dt)
        ball:update(dt)
        handleCollisions()
        scoreboard:update(ball, menu.currentState)
    end
end

-- Function to draw the game
function love.draw()
    if menu.currentState == States.MENU then
        drawMenu()
    elseif menu.currentState == States.DEFAULT_GAME or isMultiple then
        scoreboard:draw(menu.currentState)
        drawPaddlesAndBall()
    end
end

function drawMenu()
    love.graphics.print("Main menu", 100, 100)

    -- Draw menu options and highlight the selected option
    for i = 1, #menu.options do
        local arrow = ''
        local optionText = menu.options[i]

        if i == menu.selectedOption then
            arrow = '--> '
            love.graphics.setColor(255, 0, 0)
        end

        love.graphics.print(arrow .. optionText, 100, 150 + i * 30)
        love.graphics.setColor(255, 255, 255)
    end
end

-- Function to update paddles
function updatePaddles(dt)
    leftPaddle:movePaddle(dt)
    rightPaddle:movePaddle(dt)
    
    if isMultiple then
        topPaddle:movePaddle(dt)
        bottomPaddle:movePaddle(dt)
    end
end

-- Function to handle collisions
function handleCollisions()
    handleBallPaddleCollisions()
    
    if menu.currentState == States.DEFAULT_GAME then
        ball:handleVerticalBorderCollisions()
    end
end

-- Function to handle collisions with paddles
function handleBallPaddleCollisions()
    if checkBallPaddleCollision(leftPaddle) then
        ball.dx = 1
    end

    if checkBallPaddleCollision(rightPaddle) then
        ball.dx = -1
    end

    if isMultiple then
        if checkBallPaddleCollision(topPaddle) then
            ball.dy = 1
        end
    
        if checkBallPaddleCollision(bottomPaddle) then
            ball.dy = -1
        end
    end
end

-- Function to check collision with a paddle
function checkBallPaddleCollision(paddle)
    return ball.x < paddle.x + paddle.width and
           ball.x + ball.size > paddle.x and
           ball.y < paddle.y + paddle.height and
           ball.y + ball.size > paddle.y
end

-- Function to draw paddles and ball
function drawPaddlesAndBall()
    leftPaddle:draw()
    rightPaddle:draw()
    ball:draw()

    if isMultiple then
        topPaddle:draw()
        bottomPaddle:draw()
    end
end

-- Function to update scoreboard
function updateScoreboard()
    if ball.x < 0 then
        scorePoint("player2")
    elseif ball.x > love.graphics.getWidth() then
        scorePoint("player1")
    end
end

-- Function to award a point to a player
function scorePoint(player)
    score[player] = score[player] + 1
end