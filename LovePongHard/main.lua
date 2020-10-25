local w, h -- Variables to store the screen width and height

local ballX, ballY -- Variables to store the position of the ball in the screen (Uncomment at the start of TODO 6)
local ballSpeed -- Variable to store the ball speed (Uncomment at the start of TODO 8)
local playerX, playerY, cpuX, cpuY -- Variables to store the position of the player and cpu paddle (Uncomment at the start of TODO 10)
local paddleSpeed -- Variable to store the paddle speed (Uncomment at the start of TODO 12)
local ballAngle -- Variable to estore the ball movement angle (Uncomment at the start of TODO 16)
local playerPoints, cpuPoints -- Variable to store the player and cpu points (Uncomment at the start of TODO 21)

function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end -- Enable the debugging with ZeroBrane Studio
  
  w, h = love.graphics.getDimensions() -- Get the screen width and height
  
  -- TODO 5: Load the font to use in the game and set it
  font = love.graphics.newFont( "pong.ttf", 50, "normal", love.graphics.getDPIScale() )

  love.graphics.setFont( font )

  -- TODO 6: Initialize the position of the ball at the center of the screen
  ballX = love.graphics.getWidth()/2
  ballY = love.graphics.getHeight()/2
  w = love.graphics.getWidth()
  h = love.graphics.getHeight()
  -- TODO 8: Initialize the ball speed for going to the left
  --ballSpeed = -1.5
  -- TODO 10: Initialize the player and cpu paddles position
  playerX, playerY = 25, h/2-25
  cpuX, cpuY = w-35, h/2-25
  -- TODO 12: Initialize the paddle speed
  paddleSpeed = 1.5
  -- TODO 16: Initialize the ball angle
  math.randomseed(os.time())
  ballAngle = math.rad(math.random(150,210))
  -- TODO 18: Comment all the code of the TODO 8 and initialize the ball speed without sign
  ballSpeed = 1.5
  -- TODO 21: Initialize the player and cpu points variables
  playerPoints = 0
  cpuPoints = 0
end

function love.update(dt)
  -- TODO 9: Make the ball move using the ballSpeed variable
  --ballX = ballX + ballSpeed
  -- TODO 17: Comment all the code of the TODO 9 and make the ball move using the ballAngle variable
  math.randomseed(os.time())
  ballX = ballX + ballSpeed * math.cos(ballAngle)
  ballY = ballY + ballSpeed * math.sin(ballAngle)
  -- TODO 13: Move the player paddle getting the up and down arrows keys of the keyboard using the variable paddleSpeed
  if love.keyboard.isDown("down") then
    playerY = playerY + paddleSpeed
  end
  if love.keyboard.isDown("up") then
    playerY = playerY - paddleSpeed
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
  
  pDeltaX = ballX - math.max(playerX, math.min(ballX, playerX + 10))
  pDeltaY = ballY - math.max(playerY, math.min(ballY, playerY + 50))
  if(pDeltaX * pDeltaX + pDeltaY * pDeltaY) < (8 * 8) then
    ballSpeed = ballSpeed + 1
    if ballAngle >= math.rad(180) and math.rad(180) > (ballAngle - 90) then
      ballAngle = math.rad(315)
    end
    if ballAngle < math.rad(180) and math.rad(180) < (ballAngle + 90) then
      ballAngle = math.rad(45)
      end
  end

  cpuDeltaX = ballX - math.max(cpuX, math.min(ballX, cpuX + 10))
  cpuDeltaY = ballY - math.max(cpuY, math.min(ballY, cpuY + 50))
  if(cpuDeltaX * cpuDeltaX + cpuDeltaY * cpuDeltaY) < (8 * 8) then
    ballSpeed = ballSpeed + 1
    if ballAngle >= math.rad(0) and math.rad(0) > (ballAngle - 90) then
      ballAngle = math.rad(225)
    end
    if ballAngle < math.rad(0) and math.rad(0) < (ballAngle + 90) then
      ballAngle = math.rad(135)
      end
  end
  
  -- TODO 20: Detect the ball collision with the top and bottom of the field and make it bounce
  if ballY < 8 then
    if ballAngle >= math.rad(270) and math.rad(270) > (ballAngle - 90) then
     ballAngle = math.rad(45)
    end
    if ballAngle < math.rad(270) and math.rad(270) < (ballAngle + 90) then
      ballAngle = math.rad(135)
    end
  end
  
  if ballY > love.graphics.getHeight() - 8 then
      if ballAngle >= math.rad(90) and math.rad(90) > (ballAngle - 90) then
     ballAngle = math.rad(225)
    end
    if ballAngle < math.rad(90) and math.rad(90) < (ballAngle + 90) then
     ballAngle = math.rad(315)
    end

  end
  
  -- TODO 26: Add the needed code at TODO 23 to reset the ball speed
  -- TODO 23: Detect the ball collision with the player and cpu sides, increse the points accordingly and reset the ball
  if ballX > love.graphics.getWidth() then 
    playerPoints = playerPoints + 1
    ballSpeed = 1.5
    ballX = love.graphics.getWidth()/2
    ballY = love.graphics.getHeight()/2
    ballAngle = math.rad(math.random(150,210))
  end
  
  if ballX < 0 then
    cpuPoints = cpuPoints + 1
    ballSpeed = 1.5
    ballX = love.graphics.getWidth()/2
    ballY = love.graphics.getHeight()/2
    ballAngle = math.rad(math.random(150,210))
  end
  

  -- TODO 24: Make the cpu paddle move to get the ball
  cpuY = ballY
end

function love.draw()
  -- TODO 1: Draw the center of the field
  love.graphics.line( love.graphics.getWidth() / 2, 0, love.graphics.getWidth()/2, love.graphics.getHeight())
  -- TODO 2: Draw the ball at the center of the field
 -- love.graphics.circle( "fill", love.graphics.getWidth()/2, love.graphics.getHeight()/2, 8)
  -- TODO 3: Draw the player and cpu paddles
  -- love.graphics.rectangle( "fill", love.graphics.getWidth() - 35, love.graphics.getHeight()/2 - 25, 10, 50 )
  
  -- love.graphics.rectangle( "fill", 25, love.graphics.getHeight()/2 - 25, 10, 50 )
  -- TODO 4: Draw the player and cpu points
  --love.graphics.print( "0", love.graphics.getWidth() / 2 - 45, 20, 0, 1, 1, 0, 0, 0, 0 )
  
  --love.graphics.print( "0", love.graphics.getWidth() / 2 + 20, 20, 0, 1, 1, 0, 0, 0, 0 )
  -- TODO 7: Comment all the code of the TODO 2 and use the ballX and ballY variables to draw the ball
  love.graphics.circle( "fill", ballX, ballY, 8)
  -- TODO 11: Comment all the code of the TODO 3 and use the playerX, playerY, cpuX and cpuY variables to draw the player and cpu paddles
  love.graphics.rectangle( "fill", playerX, playerY, 10, 50 )
  
  love.graphics.rectangle( "fill", cpuX, cpuY, 10, 50 )
  -- TODO 22: Comment all the code of the TODO 4 and use the playerPoints and cpuPOints variables to draw the points
  love.graphics.print( playerPoints, love.graphics.getWidth() / 2 - 45, 20, 0, 1, 1, 0, 0, 0, 0 )
  love.graphics.print( cpuPoints, love.graphics.getWidth() / 2 + 20, 20, 0, 1, 1, 0, 0, 0, 0 )
end