local Object = Object or require ("lib/object")
local Paddle = Object:extend()
local paddleX
local paddleY
local paddleSpeed

function Paddle:new(x, y)
  paddleX = x
  paddleY = y
  paddleSpeed = 1.5
end

function Paddle:update(dt)
  
end

function Paddle:draw()
  love.graphics.rectangle( "fill", paddleX, paddleY, 10, 50 )
end

function Paddle:up()
  paddleY = paddleY - paddleSpeed
end

function Paddle:down()
  paddleY = paddleY + paddleSpeed
end

function Paddle:getX()
  return paddleX
end

function Paddle:getY()
  return paddleY
end

function Paddle:setY(y)
  paddleY = y
end


return Paddle