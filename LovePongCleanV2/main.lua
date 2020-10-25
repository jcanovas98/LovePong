require "data"
local Ball = Ball or require ("src/ball")
local Player = Paddle or require ("src/paddle")
local CpuPlayer = Paddle or require ("src/paddle")
local PlayerPoints = Score or require ("src/score")
local CpuPoints = Score or require ("src/score")

function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end -- Enable the debugging with ZeroBrane Studio
  
  w, h = love.graphics.getDimensions() -- Get the screen width and height
  
  font = love.graphics.newFont( "pong.ttf", 50, "normal", love.graphics.getDPIScale() )

  love.graphics.setFont(font)
  b = Ball()
  p = Player(playerSpawnX, playerSpawnY)
  cpu = CpuPlayer(cpuSpawnX, cpuSpawnY)
  math.randomseed(os.time())
  pPoints = PlayerPoints(true)
  cpuPoints = PlayerPoints(false)
end

function love.update(dt)
  b:update(dt)
  if love.keyboard.isDown("down") then
    p:down()
  end
  if love.keyboard.isDown("up") then
    p:up()
  end
  
  paddleCollisionCheck()
  borderCollisionCheck()
  scoreCheck()
  
  cpu:setY(b:getY())
end

function love.draw()
  love.graphics.line(screenWidth/2, 0, screenWidth/2, screenHeight)
  b:draw()
  p:draw()
  cpu:draw()
  pPoints:draw()
  cpuPoints:draw()
end

function paddleCollisionCheck()
    pDeltaX = b:getX() - math.max(p:getX(), math.min(b:getX(), p:getX() + paddleHitboxX))
    pDeltaY = b:getY() - math.max(p:getY(), math.min(b:getY(), p:getY() + paddleHitboxY))
    if(pDeltaX * pDeltaX + pDeltaY * pDeltaY) < (ballRadius * ballRadius) then
    b:increaseSpeed()
    changeAngle(180, 315, 45)
  end

  cpuDeltaX = b:getX() - math.max(cpu:getX(), math.min(b:getX(), cpu:getX() + paddleHitboxX))
  cpuDeltaY = b:getY() - math.max(cpu:getY(), math.min(b:getY(), cpu:getY() + paddleHitboxY))
  if(cpuDeltaX * cpuDeltaX + cpuDeltaY * cpuDeltaY) < (ballRadius * ballRadius) then
    b:increaseSpeed()
    changeAngle(0, 135, 225)
  end
end

function borderCollisionCheck()
  if b:getY() < ballRadius then
    changeAngle(270, 45, 135)
  end
  if b:getY() > screenHeight - ballRadius then
    changeAngle(90, 225, 315)
  end
end

function changeAngle(a, s, t)
  if b:getAngle() >= a and a > b:getAngle()-90 then
      b:setAngle(s)
  end
  if b:getAngle() < a and a < b:getAngle()+90 then
      b:setAngle(t)
  end
end

function os.sleep(sec)
  local now = os.time() + sec
  repeat until os.time() >= now
end

function scoreCheck()
  if b:getX() > screenWidth then 
    pPoints:increasePoint()
    b:reset()
  end
  
  if b:getX() < 0 then
    cpuPoints:increasePoint()
    b:reset()
  end
end



-- -- By Grup P1_G21: Canovas Sanchez, Jose Antonio; Parladé Salvans, Martí Xavier.

