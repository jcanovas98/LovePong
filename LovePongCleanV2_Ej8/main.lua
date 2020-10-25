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

  --Game Status (for menus)
  isPlaying = "notPlaying"
  
  love.graphics.setFont(font)
  math.randomseed(os.time())
  
  --Objects construction
  b = Ball()
  p = Player(playerSpawnX, playerSpawnY)
  cpu = CpuPlayer(cpuSpawnX, cpuSpawnY)
  pPoints = PlayerPoints(true)
  cpuPoints = PlayerPoints(false)
end

function love.update(dt)
  --Status updates
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
  
  --Paddle, border collision & score check functions
    paddleCollisionCheck()
    borderCollisionCheck()
    scoreCheck()
  
  --CPU Paddle follows at its own speed ballY coordinates
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
  
  --Ingame drawing
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
  --Player paddle hitbox calculations
    pDeltaX = b:getX() - math.max(p:getX(), math.min(b:getX(), p:getX() + paddleHitboxX))
    pDeltaY = b:getY() - math.max(p:getY(), math.min(b:getY(), p:getY() + paddleHitboxY))
    
  --Hitbox collision
    if(pDeltaX * pDeltaX + pDeltaY * pDeltaY) < (ballRadius * ballRadius) then
    b:increaseSpeed()
    
  --Ball bounce
    changeAngle(180, 315, 45)
  end

 --CPU paddle hitbox calculations
  cpuDeltaX = b:getX() - math.max(cpu:getX(), math.min(b:getX(), cpu:getX() + paddleHitboxX))
  cpuDeltaY = b:getY() - math.max(cpu:getY(), math.min(b:getY(), cpu:getY() + paddleHitboxY))
  
  --Hitbox collision
  if(cpuDeltaX * cpuDeltaX + cpuDeltaY * cpuDeltaY) < (ballRadius * ballRadius) then
    b:increaseSpeed()
    
  --Ball bounce
    changeAngle(0, 135, 225)
  end
end

function borderCollisionCheck()
  --Upper game area limit
  if b:getY() < ballRadius then
    
  --Ball bounce
    changeAngle(270, 45, 135)
  end
  
  --Lower game area limit
  if b:getY() > screenHeight - ballRadius then
    
  --Ball bounce
    changeAngle(90, 225, 315)
  end
end

--Ball bounce function
function changeAngle(a, s, t)
  if b:getAngle() >= a and a > b:getAngle()-90 then
      b:setAngle(s)
  end
  if b:getAngle() < a and a < b:getAngle()+90 then
      b:setAngle(t)
  end
end

function scoreCheck()
  --Player + points counter
  if b:getX() > screenWidth then 
    pPoints:increasePoint()
    b:reset()
  end
  
  --CPU + points counter
  if b:getX() < 0 then
    cpuPoints:increasePoint()
    b:reset()
  end
end

--Main Menu control function
function mainMenu()
  if love.keyboard.isDown("return") then
      isPlaying = "playing"
  end
    
  if love.keyboard.isDown("escape") then
      os.exit()
  end
end

--Game Over control function
function gameOver()
  if cpuPoints:getPoints() == 11 or isPlaying == "gameOver" then
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

--Victory control function
function victory()
  if pPoints:getPoints() == 11 or isPlaying == "victory" then
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