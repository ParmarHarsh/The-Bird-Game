require 'Pipe'

TopLowerPipes = Class{}

-- Placement of the Upper and Lower Pipes and giving their respective funtions
local PG = 100
local ScrollSpeed = -60 

function TopLowerPipes:init()
  local TopPipes = math.random(40, VIRTUAL_HEIGHT / 2);
  self.x = VIRTUAL_WIDTH
  self.pipes = {
    ['upper'] = Pipe(self.x, TopPipes, 'top'),
    ['lower'] = Pipe(self.x, TopPipes + PG, 'bottom')
  }
  self.remove = false;
  self.scored = false;  
end

function TopLowerPipes:update(dt)
  if self.x + self.pipes['upper'].width > 0 then 
    self.x = self.x + ScrollSpeed * dt
    self.pipes['upper'].x = self.x
    self.pipes['lower'].x = self.x
  else
    self.remove = true
  end
end 

function TopLowerPipes:render()
  for k, pipe in pairs(self.pipes) do
    pipe:render()
  end
end