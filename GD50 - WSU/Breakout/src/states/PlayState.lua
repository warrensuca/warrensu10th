PlayState = Class{__includes = BaseState}


function PlayState:enter(params)
    self.paddle = params.paddle
    self.ball = params.ball

    self.ball.x = self.paddle.x + self.paddle.width/2 - 4
    self.ball.y = VIRTUAL_HEIGHT - 42

    self.ball.dx = math.random(-200,200)
    self.ball.dy = math.random(50,200)

    self.bricks = params.bricks

    self.health = params.health
    self.score = params.score

    self.level = params.level
    self.highScores = params.highScores
end

function PlayState:render()
    self.paddle:render()
    self.ball:render()
    
    for k, brick in pairs(self.bricks) do 
        brick:render()
        
    end
    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end


    renderHealth(self.health)
    renderScore(self.score)
end

function PlayState:update(dt)
    self.paddle:update(dt)
    self.ball:update(dt)
    if isVictory(self.bricks) then
        gStateMachine:change('victory', {level = self.level, paddle = self.paddle, health = self.health, score = self.score, ball = self.ball, highScores = self.highScores})
    end
    if self.ball:collides(self.paddle) then
        self.ball.y = self.paddle.y - 8
        self.ball.dy = -self.ball.dy

        gSounds['paddle-hit']:play()

        isPaddleMovingLeft = self.paddle.dx < 0
        paddleCenter = self.paddle.x + self.paddle.width / 2
        
        startingBounceDX = 50
        bounceAngleMultiplier = 8

        if self.ball.x < paddleCenter and isPaddleMovingLeft then
            ballOffSet = paddleCenter - self.ball.x
            self.ball.dx = -startingBounceDX - bounceAngleMultiplier * ballOffSet
        
        elseif self.ball.x > paddleCenter and not isPaddleMovingLeft then
            ballOffSet = self.ball.x - paddleCenter
            self.ball.dx = ballOffSet + bounceAngleMultiplier * ballOffSet
        end

    end

    if self.ball.y >= VIRTUAL_HEIGHT then

        self.health = self.health - 1
        gSounds['hurt']:play()
        print(self.score)
        if self.health == 0 then
            gStateMachine:change('game-over', {
                
                score = self.score,
                highScores = self.highScores
            })
    
        else
            gStateMachine:change('serve', {level = self.level, paddle = self.paddle, bricks = self.bricks, health = self.health, score = self.score, highScores = self.highScores})
        end
    end

    for k, brick in pairs(self.bricks) do

        if brick.inPlay and self.ball:collides(brick) then
            --understand this
            self.score = self.score + 1000000


            -- center of x and y or brick and ball

            cxB, cyB = brick.x + brick.width / 2, brick.y + brick.height / 2
            cxb, cyb = self.ball.x + self.ball.width / 2, self.ball.y + self.ball.height / 2

            ox = cxB - cxb
            oy = cyB - cyb

            px = brick.width / 2 + self.ball.width / 2 - math.abs(ox)
            py = brick.height / 2 + self.ball.height / 2 - math.abs(oy)

            if px < py then
                self.ball.dx = -self.ball.dx
                self.ball.x = self.ball.x + (ox > 0 and -px or px)
            else
                self.ball.dy = -self.ball.dy
                self.ball.y = self.ball.y + (oy>0 and -py or py)

            
            end
            self.ball.dy = self.ball.dy*1.02
           brick:hit() 
           
        end

    end
    for k, brick in pairs(self.bricks) do
        brick:update(dt)
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