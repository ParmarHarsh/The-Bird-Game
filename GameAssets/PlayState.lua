PlayState = Class{__includes = BaseState}

local Interval = 2.5
local PipeWidth = 70

function PlayState:init()
  self.bird = Bird()
  self.toplowerpipes = {}
  self.timer = 0
  self.score = 0
end

-- Sound Managment and Insertion of Pipes parallely with proper intervals
function PlayState:update(dt)

  self.timer = self.timer + dt

  if(self.timer > Interval) then
    table.insert(self.toplowerpipes, TopLowerPipes())
    self.timer = 0
  end

  if(self.bird.y + self.bird.height) >= VIRTUAL_HEIGHT - 16 then
    sounds['collision']:play()
      GameState:change('gameOver', {
        score = self.score
      })
  end

  for k, pair in pairs(self.toplowerpipes) do
    pair:update(dt)
    self:checkForScore(pair)
    self:checkForCollision(pair)
  end

  self.bird:update(dt)

  for k, pipe in pairs(self.toplowerpipes) do
    if pipe.remove then
      table.remove(self.toplowerpipes, k)
    end
  end
end

-- Checking the score update
function PlayState:checkForScore(pipe)
  if(pipe.x + PipeWidth < self.bird.x and not pipe.scored) then
    self.score = self.score + 1
    pipe.scored = true
    sounds['scored']:play()
  end
end

-- Checking successful collision and ending the game with sound
function PlayState:checkForCollision(pair)
  for k, pipe in pairs(pair.pipes) do
    if self.bird:collides(pipe) then
      sounds['collision']:play()
      GameState:change('gameOver', {
        score = self.score
      })
    end
  end
end

-- Render Function with Increment of score after each Pipe Cross
function PlayState:render()
  
  for k, pipe in pairs(self.toplowerpipes) do 
    pipe:render()
  end
  self.bird:render()
  love.graphics.setFont(smallFont)
  love.graphics.print('SCORE: ' .. tostring(self.score), 10, 10)
end