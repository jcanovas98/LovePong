local w, h -- Variables to store the screen width and height
local Ball = Ball or require ("src/ball")
local Player = Paddle or require ("src/paddle")
local CpuPlayer = Paddle or require ("src/paddle")
local PlayerPoints = Score or require ("src/score")
local CpuPoints = Score or require ("src/score")

--local ballX, ballY -- Variables to store the position of the ball in the screen (Uncomment at the start of TODO 6)
--local ballSpeed -- Variable to store the ball speed (Uncomment at the start of TODO 8)
--ocal playerX, playerY, cpuX, cpuY -- Variables to store the position of the player and cpu paddle (Uncomment at the start of TODO 10)
--local paddleSpeed -- Variable to store the paddle speed (Uncomment at the start of TODO 12)
--local ballAngle -- Variable to estore the ball movement angle (Uncomment at the start of TODO 16)
--local playerPoints, cpuPoints -- Variable to store the player and cpu points (Uncomment at the start of TODO 21)

function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end -- Enable the debugging with ZeroBrane Studio
  
  w, h = love.graphics.getDimensions() -- Get the screen width and height
  
  -- TODO 5: Load the font to use in the game and set it
  font = love.graphics.newFont( "pong.ttf", 50, "normal", love.graphics.getDPIScale() )

  love.graphics.setFont( font )

  -- TODO 6: Initialize the position of the ball at the center of the screen
  b = Ball()
  --[[  w = love.graphics.getWidth()
  h = love.graphics.getHeight()
  ballX = w/2
  ballY = h/2
  --]]
  -- TODO 8: Initialize the ball speed for going to the left
  --ballSpeed = -1.5
  -- TODO 10: Initialize the player and cpu paddles position
  p = Player(25, h/2-25)
  cpu = CpuPlayer(w-35, h/2-25)
  -- TODO 12: Initialize the paddle speed
  --paddleSpeed = 1.5
  -- TODO 16: Initialize the ball angle
  math.randomseed(os.time())
  --ballAngle = math.rad(math.random(150,210))
  -- TODO 18: Comment all the code of the TODO 8 and initialize the ball speed without sign
  --ballSpeed = 1.5
  -- TODO 21: Initialize the player and cpu points variables
  --playerPoints = 0
  pPoints = PlayerPoints(true)
  cpuPoints = PlayerPoints(false)
  --cpuPoints = 0
end

function love.update(dt)
  -- TODO 9: Make the ball move using the ballSpeed variable
  --ballX = ballX + ballSpeed
  -- TODO 17: Comment all the code of the TODO 9 and make the ball move using the ballAngle variable
  --[[ballX = ballX + ballSpeed * math.cos(ballAngle)
  ballY = ballY + ballSpeed * math.sin(ballAngle)
  --]]
  -- TODO 13: Move the player paddle getting the up and down arrows keys of the keyboard using the variable paddleSpeed
  if love.keyboard.isDown("down") then
    p:down()
    --playerY = playerY + paddleSpeed
  end
  if love.keyboard.isDown("up") then
    p:up()
    --playerY = playerY - paddleSpeed
  end
  
  
  -- TODO 14: Detect the ball collision with the player paddle and make it bounce
  --[[pDeltaX = ballX - math.max(playerX, math.min(ballX, playerX + 10))
  pDeltaY = ballY - math.max(playerY, math.min(ballY, playerY + 50))
  if(pDeltaX * pDeltaX + pDeltaY * pDeltaY) < (8 * 8) then
    ballSpeed = math.abs(ballSpeed)
  end
  --]]
  
  -- TODO 15: Detect the ball collision with the cpu paddle and make it bounce
  --[[cpuDeltaX = ballX - math.max(cpuX, math.min(ballX, cpuX + 10))
  cpuDeltaY = ballY - math.max(cpuY, math.min(ballY, cpuY + 50))
  if(cpuDeltaX * cpuDeltaX + cpuDeltaY * cpuDeltaY) < (8 * 8) then
    ballSpeed = -ballSpeed
  end
  --]]

  -- TODO 25: Add the needed code at TODO 19 to make the ball quicker at paddle collision
  -- TODO 19: Comment all the code of the TODO 14 and TODO 15 and make it bounce using the new ball angle
  
  pDeltaX = b:getX() - math.max(p:getX(), math.min(b:getX(), p:getX() + 10))
  pDeltaY = b:getY() - math.max(p:getY(), math.min(b:getY(), p:getX() + 50))
  if(pDeltaX * pDeltaX + pDeltaY * pDeltaY) < (8 * 8) then
    b:increaseSpeed()
    if b:getAngle() == math.rad(180) then
      b:setAngle(0)
    end
    if b:getAngle() > math.rad(180) then
      b:setAngle(315)
    end
    if b:getAngle() < math.rad(180) then
      b:setAngle(45)
      end
  end

  cpuDeltaX = b:getX() - math.max(cpu:getX(), math.min(b:getX(), cpu:getX() + 10))
  cpuDeltaY = b:getY() - math.max(cpu:getY(), math.min(b:getY(), cpu:getY() + 50))
  if(cpuDeltaX * cpuDeltaX + cpuDeltaY * cpuDeltaY) < (8 * 8) then
    b:increaseSpeed()
    if b:getAngle() == math.rad(0) then
      b:setAngle(180)
    end
    if b:getAngle() > math.rad(0) then
      b:setAngle(225)
    end
    if b:getAngle() < math.rad(0) then
      b:setAngle(135)
      end
  end
  
  -- TODO 20: Detect the ball collision with the top and bottom of the field and make it bounce
  if b:getY() < 8 then
    if b:getAngle() > math.rad(270) then
     b:setAngle(45)
    end

    if b:getAngle() < math.rad(270) then
      b:setAngle(135)
    end
  end
  if b:getY() > h - 8 then
    if b:getAngle() > math.rad(90) then
     b:setAngle(225)
    end
    
    if b:getAngle() < math.rad(90) then
     b:setAngle(315)
    end

  end
  
  -- TODO 26: Add the needed code at TODO 23 to reset the ball speed
  -- TODO 23: Detect the ball collision with the player and cpu sides, increse the points accordingly and reset the ball
  if b:getX() > w then 
    pPoints:increasePoint()
    b:reset()
  end
  
  if b:getX() < 0 then
    cpuPoints:increasePoint()
    b:reset()
  end
  

  -- TODO 24: Make the cpu paddle move to get the ball
  cpu:setY(b:getY())
end

function love.draw()
  -- TODO 1: Draw the center of the field
  love.graphics.line( w/2, 0, w/2, h)
  -- TODO 2: Draw the ball at the center of the field
 -- love.graphics.circle( "fill", love.graphics.getWidth()/2, love.graphics.getHeight()/2, 8)
  -- TODO 3: Draw the player and cpu paddles
  -- love.graphics.rectangle( "fill", love.graphics.getWidth() - 35, love.graphics.getHeight()/2 - 25, 10, 50 )
  
  -- love.graphics.rectangle( "fill", 25, love.graphics.getHeight()/2 - 25, 10, 50 )
  -- TODO 4: Draw the player and cpu points
  --love.graphics.print( "0", love.graphics.getWidth() / 2 - 45, 20, 0, 1, 1, 0, 0, 0, 0 )
  
  --love.graphics.print( "0", love.graphics.getWidth() / 2 + 20, 20, 0, 1, 1, 0, 0, 0, 0 )
  -- TODO 7: Comment all the code of the TODO 2 and use the ballX and ballY variables to draw the ball
  -- CLEAN love.graphics.circle( "fill", ballX, ballY, 8)
  -- TODO 11: Comment all the code of the TODO 3 and use the playerX, playerY, cpuX and cpuY variables to draw the player and cpu paddles
  --love.graphics.rectangle( "fill", playerX, playerY, 10, 50 )
  
 -- love.graphics.rectangle( "fill", cpuX, cpuY, 10, 50 )
  -- TODO 22: Comment all the code of the TODO 4 and use the playerPoints and cpuPOints variables to draw the points
 -- love.graphics.print( playerPoints, love.graphics.getWidth() / 2 - 45, 20, 0, 1, 1, 0, 0, 0, 0 )
  --love.graphics.print( cpuPoints, love.graphics.getWidth() / 2 + 20, 20, 0, 1, 1, 0, 0, 0, 0 )
end