Pipe = Class{}

local PipeImage = love.graphics.newImage('Graphics/pipe.png');
local ScrollSpeed = -60

-- Pipes Input Function
function Pipe:init(x, y, orientation)
  self.orientation = orientation;
  self.width = PipeImage:getWidth()
  self.height = PipeImage:getHeight()

  self.x = x
  self.y = y 
end

-- Render Function
function Pipe:render()
  local UpDown = self.orientation == 'top' and -1 or 1
  love.graphics.draw(PipeImage, self.x, self.y, 0, 1, UpDown)
end