WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 780


push = require 'push'
Class = require 'class'

require 'Paddle'
require 'Ball'

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
PADDLE_SPEED = 200

ai = false

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Pong')
    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(smallFont)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    
    fullscreen = false,
    resizable = true,
    vsync = true})

    player1Score = 0
    player2Score = 0

    player1 = Paddle(10,30,5,20)
    player2 = Paddle(VIRTUAL_WIDTH-10, VIRTUAL_HEIGHT-30,5,20)

    ball = Ball(VIRTUAL_WIDTH/2-2, VIRTUAL_HEIGHT/2-2, 4, 4)


    gameState = 'start'
    servingPlayer = 0

    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', "static"),
        ['score'] = love.audio.newSource('sounds/score.wav', "static"),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', "static")
    }
end

function love.draw()
    push:apply('start')
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    love.graphics.setFont(smallFont)
    --love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(scoreFont)

    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT/3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT/3)


    love.graphics.setFont(smallFont)

    currPlayer = servingPlayer == -2 and 2 or 1
    if gameState == 'start' then
        love.graphics.printf('Press enter to start the game!', 0, 10, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        
        love.graphics.printf('Player ' .. tostring(currPlayer) .. ' is serving', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'won' then
        love.graphics.setFont(scoreFont)
        love.graphics.printf('Player ' .. tostring(currPlayer) .. ' wins', 0, 0, VIRTUAL_WIDTH, "center")
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press enter to restart!', 0, 40, VIRTUAL_WIDTH, "center")

    end


    player1:render()
    player2:render()
    ball:render()

    displayFPS()

    push:apply('end')
end

function love.keypressed(key)
    if key == 'k' then
        ai = not ai
    end

    if key == 'escape' then
        love.event.quit()


    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'serve'
        
        elseif gameState == 'serve' then
            print(servingPlayer)
            ball.dx = (servingPlayer+1) * math.random(40,150)
            print(ball.dx)
            gameState = 'play'
        
        elseif gameState == 'won' then
            gameState = 'serve'
            ball:reset()

            player1Score = 0
            player2Score = 0

            servingPlayer = -(2-servingPlayer)
        else
            gameState = 'serve'

            ball:reset()
        end
    end



end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    --player 
    if not ai then
        if love.keyboard.isDown('up') then
            player2.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('down') then
            player2.dy = PADDLE_SPEED
        else
            player2.dy = 0
        end
    else

        --computer
        player2.y = ball.y-10
    end


    if gameState == 'play' then
        ball:update(dt)
        if ball:collides(player1) then
            ball.dx = ball.dx * -1.03
            ball.x = player1.x + 5


            ball.dy = (ball.dy/-ball.dy) * math.random(40,150)
            sounds['paddle_hit']:play()
        end 

        if ball:collides(player2) then
            ball.dx = ball.dx * -1.03
            ball.x = player2.x - 5

            ball.dy = (ball.dy/-ball.dy) * math.random(40,150)
            sounds['paddle_hit']:play()
        end

        if ball.y <= 0 or ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = ball.y <= 0 and 0 or VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy
            sounds['wall_hit']:play()
        end

        
        checkWinner()

        
        

        
    end
    player1:update(dt)
    player2:update(dt)

    
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0,255,0,255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

function checkWinner()
    if ball.x < 0 then
        player2Score = player2Score + 1
        servingPlayer = -2
        gameState = 'serve'
        ball:reset()
        sounds['score']:play()
    end

    if ball.x > VIRTUAL_WIDTH-4 then 
        player1Score = player1Score + 1
        servingPlayer = 0
        gameState = 'serve'
        ball:reset()
        sounds['score']:play()
    end

    if player1Score == 5 or player2Score == 5 then
        gameState = 'won'
        
    end

end

function love.resize(w,h)
    push:resize(w,h)
end

