PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.paddle = Paddle()
    self.ball = Ball(4)

    self.ball.x = VIRTUAL_WIDTH / 2 - 4
    self.ball.y = VIRTUAL_HEIGHT - 42

    self.ball.dx = math.random(-200,200)
    self.ball.dy = math.random(50,200)

    self.bricks = LevelMaker.createMap()
    print(#self.bricks)
end

function PlayState:render()
    self.paddle:render()
    self.ball:render()

    for k, brick in pairs(self.bricks) do 
        brick:render()
    end
end

function PlayState:update(dt)
    self.paddle:update(dt)
    self.ball:update(dt)

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

    for k, brick in pairs(self.bricks) do

        if brick.inPlay and self.ball:collides(brick) then
            --understand this



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
end