local w, h -- Variables to store the screen width and height
local Ball = Ball or require ("src/ball")
local Player = Paddle or require ("src/paddle")
local CpuPlayer = Paddle or require ("src/paddle")
local PlayerPoints = Score or require ("src/score")
local CpuPoints = Score or require ("src/score")

function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end -- Enable the debugging with ZeroBrane Studio
  
  w, h = love.graphics.getDimensions() -- Get the screen width and height
  
  font = love.graphics.newFont( "pong.ttf", 50, "normal", love.graphics.getDPIScale() )

  love.graphics.setFont( font )
  b = Ball()
  p = Player(25, h/2-25)
  cpu = CpuPlayer(w-35, h/2-25)
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
    
  pDeltaX = b:getX() - math.max(p:getX(), math.min(b:getX(), p:getX() + 10))
  pDeltaY = b:getY() - math.max(p:getY(), math.min(b:getY(), p:getY() + 50))
  if(pDeltaX * pDeltaX + pDeltaY * pDeltaY) < (8 * 8) then
    b:increaseSpeed()
    if b:getAngle() == 180 then
      b:setAngle(0)
    end
    if b:getAngle() > 180 then
      b:setAngle(315)
    end
    if b:getAngle() < 180 then
      b:setAngle(45)
      end
  end

  cpuDeltaX = b:getX() - math.max(cpu:getX(), math.min(b:getX(), cpu:getX() + 10))
  cpuDeltaY = b:getY() - math.max(cpu:getY(), math.min(b:getY(), cpu:getY() + 50))
  if(cpuDeltaX * cpuDeltaX + cpuDeltaY * cpuDeltaY) < (8 * 8) then
    b:increaseSpeed()
    if b:getAngle() == 0 then
      b:setAngle(180)
    end
    if b:getAngle() > 0 then
      b:setAngle(225)
    end
    if b:getAngle() < 0 then
      b:setAngle(135)
      end
  end
  
  if b:getY() < 8 then
    print("up")
    if b:getAngle() > 270 then
     b:setAngle(135)
    end

    if b:getAngle() < 270 then
      b:setAngle(45)
    end
  end
  if b:getY() > h - 8 then
    print("down")
    if b:getAngle() > 90 then
     b:setAngle(225)
    end
    
    if b:getAngle() < 90 then
     b:setAngle(315)
    end
  end
  
  if b:getX() > w then 
    pPoints:increasePoint()
    b:reset()
  end
  
  if b:getX() < 0 then
    cpuPoints:increasePoint()
    b:reset()
  end
  

  cpu:setY(b:getY())
end

function love.draw()
  love.graphics.line( w/2, 0, w/2, h)
  b:draw()

  p:draw()
  cpu:draw()
  pPoints:draw()
  cpuPoints:draw()
end