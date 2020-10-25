local Object = Object or require ("lib/object")
local Paddle = Object:extend()
local paddleX
local paddleY
local paddleSpeed
local pinkPaddle

function Paddle:new(x, y)
  self.pinkPaddle = love.graphics.newImage("textures/PinkPaddle.png")
  self.paddleX = x
  self.paddleY = y
  self.paddleSpeed = initialSpeed
end

function Paddle:update(dt)
  
end

function Paddle:draw()
  -- love.graphics.rectangle( "fill", self.paddleX, self.paddleY, paddleWidth, paddleHeight)
  love.graphics.draw(self.pinkPaddle, self.paddleX, self.paddleY, 0, paddleWidth, paddleHeight)
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