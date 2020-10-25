local Object = Object or require "object"
local Ball = Object:extend()

function Ball:new()
  
end


function Ball:update(dt)
  
end

function Ball:draw()
   love.graphics.circle( "fill", ballX, ballY, 8)
end

return Ball