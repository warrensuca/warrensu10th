push = require "push"
Class = require "class"
require "Bird"
require "Pipe"
require "PipePair"

require "StateMachine"
require "states/BaseState"
require "states/ScoreState"
require "states/PlayState"
require "states/TitleScreenState"
require "states/CountdownState"

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0


local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

BACKGROUND_SCROLL_SPEED = 30
GROUND_SCROLL_SPEED = 60
BACKGROUND_LOOPING_POINT = 413

pause = false



function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())
    love.window.setTitle('Flappy Bird')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true,
    })
    smallFont = love.graphics.newFont("font.ttf", 8)
    mediumFont = love.graphics.newFont("flappy.ttf", 14)
    flappyFont = love.graphics.newFont("flappy.ttf", 28)
    hugeFont = love.graphics.newFont("flappy.ttf", 56)

    love.graphics.setFont(flappyFont)
    sounds = {
        ['jump'] = love.audio.newSource('jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('hurt.wav', 'static'),
        ['score'] = love.audio.newSource('score.wav', 'static'),
        ['music'] = love.audio.newSource('marios_way.mp3', 'static')
    }
    sounds['music']:setLooping(true)
    sounds['music']:play()
    medals = {
        ['gold'] = love.graphics.newImage('gold.png'),
        
        ['silver'] = love.graphics.newImage('silver.png'),
        ['bronze'] = love.graphics.newImage('bronze.png')
    }

    MEDAL_WIDTH = medals['gold']:getWidth()
    MEDAL_HEIGHT = medals['gold']:getHeight()

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    
    pauseImg = love.graphics.newImage('pause.webp')

    gStateMachine:change('title')
    
    love.keyboard.keysPressed = {}
end

function love.update(dt)

        

    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED*dt)%BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED*dt)%VIRTUAL_WIDTH
    
    gStateMachine:update(dt)
        

    love.keyboard.keysPressed = {}
    

end

function love.draw()
    push:start()
    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
    if pause then
        love.graphics.draw(pauseImg, VIRTUAL_WIDTH/2-(pauseImg:getWidth()/20), VIRTUAL_HEIGHT/2-(pauseImg:getHeight()/20), 0.1, 0.1) 
    end
    love.graphics.draw(ground, -groundScroll, VIRTUAL_WIDTH-16)
     
    push:finish()
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
    
    
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.resize(w,h)
    push:resize(w,h)
end
