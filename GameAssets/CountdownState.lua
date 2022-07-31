CountdownState = Class { __includes = BaseState }

-- Inputing a counter before the game starts
local COUNTER = 5.5

function CountdownState:enter()
  love.graphics.setFont(bigFont) 
  self.timer = COUNTER
end

-- Setting GameState to Play
function CountdownState:update(dt)
  self.timer = self.timer - dt 
  if(self.timer <= 0.5) then
    GameState:change('play')
  end
end

-- Render Function
function CountdownState:render()
  love.graphics.printf(tostring(math.floor(self.timer + 0.5)), 0, 100, VIRTUAL_WIDTH, 'center')
end