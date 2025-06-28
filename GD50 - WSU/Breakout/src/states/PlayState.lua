PlayState = Class{__includes = BaseState}

elapsedTime = 10
prevTime = 0


function PlayState:enter(params)

    self.paddle = params.paddle
    self.ball = params.ball

    self.ball.x = self.paddle.x + self.paddle.width/2 - 4
    self.ball.y = VIRTUAL_HEIGHT - 42

    --self.ball.dx = math.random(-200,200)
    --self.ball.dy = math.random(50,200)

    self.bricks = params.bricks

    self.health = params.health
    self.score = params.score
    self.prevScore = self.score

    self.level = params.level
    self.highScores = params.highScores

    
    self.powerUpTable = {}
    self.ballsTable = {}
    self.hasKey = false
    table.insert(self.ballsTable, self.ball)
    
end

function PlayState:render()
    self.paddle:render()
    for k, ball in pairs(self.ballsTable) do
        ball:render()
    end

    
    for k, brick in pairs(self.bricks) do 
        brick:render()
        
    end
    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end

    for k, powerup in pairs(self.powerUpTable) do
        powerup:render()
    end

    
    renderHealth(self.health)
    renderScore(self.score)
end

function PlayState:update(dt)
    self.paddle:update(dt)
    print(self.hasKey)
    if self.score - self.prevScore >= 250 then
        self.paddle.size = math.min(4, self.paddle.size + 1)
        self.prevScore = self.score

        self.paddle.width = 32*self.paddle.size
    end


    elapsedTime = elapsedTime + dt
    if elapsedTime > prevTime + 10 then
        table.insert(self.powerUpTable, PowerUp())

        prevTime = elapsedTime
    end

    --print(elapsedTime)

    for k, powerup in pairs(self.powerUpTable) do


        powerup:update(dt)

        if powerup:collides(self.paddle) and powerup.inPlay then
            

            gSounds['paddle-hit']:play()
            
            if powerup.isKey then
                self.hasKey = true
            
            else
                ball1 = Ball(math.random(1,7))
                ball1.x = self.paddle.x + self.paddle.width/2 - 4
                ball1.y = VIRTUAL_HEIGHT - 42

                ball2 = Ball(math.random(1,7))
                ball2.x = self.paddle.x + self.paddle.width/2 - 4
                ball2.y = VIRTUAL_HEIGHT - 42

                table.insert(self.ballsTable, ball1)
                table.insert(self.ballsTable, ball2)
            end
            powerup.inPlay = false

            
        end
    end



    if isVictory(self.bricks) then
        gStateMachine:change('victory', {level = self.level, paddle = self.paddle, health = self.health, score = self.score, ball = self.ball, highScores = self.highScores})
    end
    for k, ball in pairs(self.ballsTable) do
        ball:update(dt)
        if ball:collides(self.paddle) then
            ball.y = self.paddle.y - 8
            ball.dy = -ball.dy

            gSounds['paddle-hit']:play()

            isPaddleMovingLeft = self.paddle.dx < 0
            paddleCenter = self.paddle.x + self.paddle.width / 2
            
            startingBounceDX = 50
            bounceAngleMultiplier = 8

            if ball.x < paddleCenter and isPaddleMovingLeft then
                ballOffSet = paddleCenter - ball.x
                ball.dx = -startingBounceDX - bounceAngleMultiplier * ballOffSet
            
            elseif ball.x > paddleCenter and not isPaddleMovingLeft then
                ballOffSet = ball.x - paddleCenter
                ball.dx = ballOffSet + bounceAngleMultiplier * ballOffSet
            end

        end

        if ball.y >= VIRTUAL_HEIGHT and ball.inPlay then

            
            gSounds['hurt']:play()
            ball.inPlay = false

            
        end
        for k, brick in pairs(self.bricks) do

            if brick.inPlay and ball:collides(brick) then
                --understand this
                
                

                -- center of x and y or brick and ball

                cxB, cyB = brick.x + brick.width / 2, brick.y + brick.height / 2
                cxb, cyb = ball.x + ball.width / 2, ball.y + ball.height / 2

                ox = cxB - cxb
                oy = cyB - cyb

                px = brick.width / 2 + ball.width / 2 - math.abs(ox)
                py = brick.height / 2 + ball.height / 2 - math.abs(oy)

                if px < py then
                    ball.dx = -ball.dx
                    ball.x = ball.x + (ox > 0 and -px or px)
                else
                    ball.dy = -ball.dy
                    ball.y = ball.y + (oy>0 and -py or py)

                
                end
                ball.dy = ball.dy*1.02
                
                if brick.locked then
                    if self.hasKey then
                        brick:hit()  
                    end
                else
                    brick:hit() 
                end
                
                self.score = self.score + 10

        end
    end
    

    end
    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end
    for k, ball in pairs(self.ballsTable) do
        if not ball.inPlay then
            table.remove(self.ballsTable, k)
        end
    end
    if #self.ballsTable == 0 then
        self.health = self.health - 1

        if self.health == 0 then
            gStateMachine:change('game-over', {
                score = self.score,
                highScores = self.highScores
            })
    
        else
            self.paddle.size = math.max(1, self.paddle.size - 1)
            gStateMachine:change('serve', {level = self.level, paddle = self.paddle, bricks = self.bricks, health = self.health, score = self.score, highScores = self.highScores})
    
        end
    end
end

function isVictory(bricks)
    for k, brick in pairs(bricks) do
        if brick.inPlay then
            return false
        end
    end
    return true
end