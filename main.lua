push = require 'push'

-- Different States with different functions
Class = require 'class'
require 'GameAssets/BaseState'
require 'Bird'
require 'TopLowerPipes'
require 'GameAssets/TitleScreenState'
require 'GameAssets/CountdownState'
require 'GameAssets/PlayState'
require 'GameAssets/GameOverState'
require 'MachineState'

-- Viewing Ratios
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 450

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- Input of Images and Speed Settings
local background = love.graphics.newImage('Graphics/background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('Graphics/ground.png')
local groundScroll = 0

local Background_ScrollSpeed = 30
local Ground_ScrollSpeed = 60
local Background_Looping = 413
local Interval = 2.5

-- Setting Window Title and adding Font and Sounds
function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle('The Bird Game')

  smallFont = love.graphics.newFont('Graphics/font.ttf', 25)
  bigFont = love.graphics.newFont('Graphics/font.ttf', 60)
  love.graphics.setFont(smallFont)

  sounds = {
    ['flap'] = love.audio.newSource('Graphics/flap.wav', 'static'),
    ['scored'] = love.audio.newSource('Graphics/scored.mp3', 'static'),
    ['collision'] = love.audio.newSource('Graphics/collision.mp3', 'static'),
    ['music'] = love.audio.newSource('Graphics/marios_way.mp3', 'static')
  }

  sounds['music']:setLooping(true)
  sounds['music']:play()

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizabe = true
  })

  GameState = MachineState{
    ['titleScreen'] = function() return TitleScreenState() end,
    ['countdown'] = function() return CountdownState() end,
    ['play'] = function() return PlayState() end,
    ['gameOver'] = function() return GameOverState() end
  }
  GameState:change('titleScreen')

  love.keyboard.keysPressed = {}
end

-- ReSize Enabled
function love.resize(width, height)
  push:resize(width, height)
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true
  if key == 'escape' then
	love.event.quit()
  end	
end

function love.keyboard.wasPressed(key)
  if love.keyboard.keysPressed[key] then
    return true
  else
    return false
  end
end

-- Movement of Background
function love.update(dt)
  backgroundScroll = (backgroundScroll + Background_ScrollSpeed * dt) % Background_Looping
  groundScroll = (groundScroll + Ground_ScrollSpeed * dt) % VIRTUAL_WIDTH

  GameState:update(dt);

  love.keyboard.keysPressed = {}
end

function love.draw()
  push:start()
  love.graphics.draw(background, -backgroundScroll, 0)
  GameState:render()
  love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
  push:finish()
end