Paddle = {}

-- Paddle constructor
function Paddle:new(x, y, width, height, speed, movement, isHorizontal)
    local paddle = {
        x = x,
        y = y,
        width = width,
        height = height,
        speed = speed,
        movement = movement,
        isHorizontal = isHorizontal or false
    }

    setmetatable(paddle, self)
    self.__index = self
    return paddle
end

-- Function to move the paddle
function Paddle:movePaddle(dt)
    if self.isHorizontal then
        self:_moveHorizontal(dt)
    elseif not self.isHorizontal then
        self:_moveVertically(dt)
    end
end

-- Handles the vertical movement
function Paddle:_moveVertically(dt)
    if love.keyboard.isDown(self.movement.UP) and self.y > 0 then
        self.y = self.y - self.speed * dt
    elseif love.keyboard.isDown(self.movement.DOWN) and self.y < love.graphics.getHeight() - self.height then
        self.y = self.y + self.speed * dt
    end
end

-- Handles the horizontal movement
function Paddle:_moveHorizontal(dt)
    if love.keyboard.isDown(self.movement.UP) and self.x > 0 then
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown(self.movement.DOWN) and self.x < love.graphics.getWidth() - self.width then
        self.x = self.x + self.speed * dt
    end
end

-- Function to change movement variable to change game modes
function Paddle:setMovement(newMovementSet)
    self.movement = newMovementSet
end

-- Function to draw the paddle
function Paddle:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
