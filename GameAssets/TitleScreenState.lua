TitleScreenState = Class{__includes = BaseState}

-- Main Screen Control Scheme
function TitleScreenState:update(dt)
  if love.keyboard.wasPressed('return') then
    GameState:change('countdown')
  end
end

-- Main Screen Display Setting and Information
function TitleScreenState:render()
  love.graphics.setFont(bigFont)
  love.graphics.printf('The Bird Game', 0, 100, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(smallFont)
  love.graphics.printf('Press ENTER to play', 0, 150, VIRTUAL_WIDTH, 'center')
end