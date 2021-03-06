local Object = Object or require ("lib/object")
local Ball = Object:extend()
local ballX, ballY
local ballSpeed
local ballAngle
local ballImage

function Ball:new()
  ballImage = love.graphics.newImage("textures/basketball2.png")
  Ball:reset()
end


function Ball:update(dt)
  ballX = ballX + ballSpeed * math.cos(ballAngle)
  ballY = ballY + ballSpeed * math.sin(ballAngle)
end

function Ball:draw()
   love.graphics.draw(ballImage, ballX, ballY, ballRadius)
end

function Ball:getX()
  return ballX
end

function Ball:getY()
  return ballY
end

function Ball:increaseSpeed()
  ballSpeed = ballSpeed + 1
end

function Ball:getSpeed()
  return ballSpeed
end

function Ball:getAngle()
  return ballAngle/math.pi*180
end

function Ball:setAngle(a)
  ballAngle = math.rad(a)
end

function Ball:reset()
  ballX = love.graphics.getWidth()/2
  ballY = love.graphics.getHeight()/2
  ballAngle = math.rad(math.random(150,210))
  ballSpeed = initialSpeed
end

return Ball