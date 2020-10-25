local Object = Object or require ("lib/object")
local Score = Object:extend()
local points
local position

function Score:new(pos)
  points = 0
  if(pos) then
    position = -45
  end
  if(not pos) then
    position = 20
  end
end

function Score:update(dt)
  
end

function Score:draw()
  love.graphics.print(points, love.graphics.getWidth()/2 + position, 20, 0, 1, 1, 0, 0, 0, 0 )
end

function Score:increasePoint()
  points = points + 1
end

function Score:getPoints()
  return points
end

return Score