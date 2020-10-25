local Object = Object or require ("lib/object")
local Paddle = Object:extend()
local paddleX
local paddleY
local paddleSpeed

function Paddle:new(x, y)
  self.paddleX = x
  self.paddleY = y
  self.paddleSpeed = 1.5
end

function Paddle:update(dt)
  
end

function Paddle:draw()
  love.graphics.rectangle( "fill", self.paddleX, self.paddleY, 10, 50 )
end

function Paddle:up()
  self.paddleY = self.paddleY - self.paddleSpeed
end

function Paddle:down()
  self.paddleY = self.paddleY + self.paddleSpeed
end

function Paddle:getX()
  return self.paddleX
end

function Paddle:getY()
  return self.paddleY
end

function Paddle:setY(y)
  self.paddleY = y
end


return Paddle