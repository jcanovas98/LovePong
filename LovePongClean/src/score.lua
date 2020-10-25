local Object = Object or require ("lib/object")
local Score = Object:extend()
local points
local position

function Score:new(pos)
  self.points = 0
  if(pos) then
    self.position = -45
  end
  if(not pos) then
    self.position = 20
  end
end

function Score:update(dt)
  
end

function Score:draw()
  love.graphics.print(self.points, love.graphics.getWidth()/2 + self.position, 20, 0, 1, 1, 0, 0, 0, 0 )
end

function Score:increasePoint()
  self.points = self.points + 1
end

function Score:getPoints()
  return self.points
end

return Score