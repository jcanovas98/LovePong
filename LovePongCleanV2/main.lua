require "data"
local Ball = Ball or require ("src/ball")
local Player = Paddle or require ("src/paddle")
local CpuPlayer = Paddle or require ("src/paddle")
local PlayerPoints = Score or require ("src/score")
local CpuPoints = Score or require ("src/score")
local isPlaying 



function love.load(arg)
  
  if arg[#arg] == "-debug" then require("mobdebug").start() end -- Enable the debugging with ZeroBrane Studio
  
  font = love.graphics.newFont( "pong.ttf", 50, "normal", love.graphics.getDPIScale() )

  isPlaying = "notPlaying"
  love.graphics.setFont(font)
  
  b = Ball()
  p = Player(playerSpawnX, playerSpawnY)
  cpu = CpuPlayer(cpuSpawnX, cpuSpawnY)
  math.randomseed(os.time())
  pPoints = PlayerPoints(true)
  cpuPoints = PlayerPoints(false)
  end


function love.update(dt)
  
  if isPlaying == "notPlaying" then
    mainMenu()
  end
  
  if isPlaying == "playing" then
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
gameOver()
victory()
end
function love.draw()
  love.graphics.print("\n \n \n \n \t      LOVE PONG \nPRESS ENTER TO START PLAYING\n PRESS ESC TO EXIT THE GAME")
  if isPlaying == "gameOver" then
    love.graphics.clear()
    love.graphics.print("\n \n \n \n \t     GAME OVER! \n   PRESS ENTER TO CONTINUE\n PRESS ESC TO EXIT THE GAME")
  end
  
  if isPlaying == "victory" then
    love.graphics.clear()
    love.graphics.print("\n \n \n \n \t      YOU WON!   \n   PRESS ENTER TO CONTINUE\n PRESS ESC TO EXIT THE GAME")
  end
  
  if isPlaying == "playing" then
  love.graphics.clear()
  love.graphics.line(screenWidth/2, 0, screenWidth/2, screenHeight)
  b:draw()
  p:draw()
  cpu:draw()
  pPoints:draw()
  cpuPoints:draw()
end
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

function mainMenu()
    if love.keyboard.isDown("return") then
      isPlaying = "playing"
    end
    if love.keyboard.isDown("escape") then
      os.exit()
    end
  end


function gameOver()
  if cpuPoints:getPoints() == 1 or isPlaying == "gameOver" then
    isPlaying = "gameOver"
    if love.keyboard.isDown("return") then
      isPlaying = "playing"
      pPoints:newGame()
      cpuPoints:newGame()
      b:reset()
    end
    if love.keyboard.isDown("escape") then
      os.exit()
    end
  end
  end


function victory()
  if pPoints:getPoints() == 1 or isPlaying == "victory" then
    isPlaying = "victory"
    if love.keyboard.isDown("return") then
      isPlaying = "playing"
      pPoints:newGame()
      cpuPoints:newGame()
      b:reset()
    end
    if love.keyboard.isDown("escape") then
      os.exit()
    end
  end
  end

-- By Grup P1_G21: Canovas Sanchez, Jose Antonio; Parladé Salvans, Martí Xavier.


