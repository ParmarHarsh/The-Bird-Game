Bird = Class{}

-- Downward and Upward Velocity of Bird
local Gravity = 19
local FlapVelocity = 5

function Bird:init()
  self.image = love.graphics.newImage('Graphics/bird.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  self.x = VIRTUAL_WIDTH / 2 - self.width / 2
  self.y = VIRTUAL_HEIGHT / 2 - self.height / 2

  self.dy = 0    
end

-- Flag Cotrolling Key Input
function Bird:update(dt)
  self.dy = self.dy + Gravity * dt
  if love.keyboard.wasPressed('space') then
    self.dy = -FlapVelocity
    sounds['flap']:play()
  end
  
  self.y = self.y + self.dy
end

-- Setting Bird Movement Ratios
function Bird:collides(pipe)
  if(pipe.orientation == 'top') then
    if (self.x + self.width) < pipe.x or self.x > (pipe.x + pipe.width) then
      return false
    end
 
   if self.y > pipe.y or (self.y + self.height) < (pipe.y - pipe.height) then
     return false
   end

  else 
    if (self.x + self.width) < pipe.x or self.x > (pipe.x + pipe.width) then
      return false
    end
    
    if (self.y + self.height) < pipe.y or self.y > (pipe.y + pipe.height) then
      return false
    end
  end
  
  return true
end

-- Render Function
function Bird:render()
  love.graphics.draw(self.image, self.x, self.y)
end