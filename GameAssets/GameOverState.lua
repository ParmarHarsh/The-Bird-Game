GameOverState = Class{__includes = BaseState}

-- Finding the score and ending the game
function GameOverState:enter(PARAMETERS)
  self.score = PARAMETERS.score
end

-- Setting GameState to GameOver
function GameOverState:update(dt)
  if love.keyboard.wasPressed('return') then
    GameState:change('countdown')
  end
end

-- Render fucntion with input of what to display after collision of Bird
function GameOverState:render()
  love.graphics.setFont(bigFont)
  love.graphics.printf(self.score, 0, 100, VIRTUAL_WIDTH, 'center')

  love.graphics.setFont(smallFont)
  love.graphics.printf('Press Enter to play again', 0, 150, VIRTUAL_WIDTH, 'center')
end