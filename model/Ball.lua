Ball = {}

function Ball:new(x, y, size, speed)
    local ball = {
        x = x,
        y = y,
        speed = speed,
        size = size,
        dx = 1,
        dy = 1,
        lastTouch = nil
    }

    setmetatable(ball, self)
    self.__index = self
    return ball
end

function Ball:update(dt)
    self:moveBall(dt)
    self:resetBall()
end

function Ball:moveBall(dt)
    self.x = self.x + self.speed * self.dx * dt
    self.y = self.y + self.speed * self.dy * dt
end

function Ball:handleVerticalBorderCollisions()
    if self.y < 0 or self.y + self.size > love.graphics.getHeight() then
        self.dy = -self.dy
    end
end

function Ball:resetBall()
    if self.x < 0 or self.x > love.graphics.getWidth() then
        self.x = 400
        self.y = 300
    end
end

function Ball:checkPaddleCollision(paddle)
    return self.x < paddle.x + paddle.width and
           self.x + self.size > paddle.x and
           self.y < paddle.y + paddle.height and
           self.y + self.size > paddle.y
end

function Ball:draw()
    love.graphics.circle('fill', self.x + self.size / 2, self.y + self.size / 2, self.size / 2)
end

function Ball:setLastTouch(player)
    self.lastTouch = player
end
