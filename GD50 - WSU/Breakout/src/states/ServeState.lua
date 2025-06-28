ServeState = Class{__includes = BaseState}

function ServeState:enter(params)
    self.level = params.level
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score

    self.ball = Ball()
    self.ball.skin = math.random(7)
    self.highScores = params.highScores
    
end

function ServeState:update(dt)
    self.paddle:update(dt)
    self.ball.x = self.paddle.x + self.paddle.width/2 - 4
    self.ball.y = self.paddle.y - 8

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        
        
        gStateMachine:change('play', {
            level = self.level,
            paddle = self.paddle,
            bricks = self.bricks,
            health = self.health,
            score = self.score,
            ball = self.ball,
            highScores = self.highScores
        })
    end
end

function ServeState:render()
    self.paddle:render()
    self.ball:render()


    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    renderHealth(self.health)
    renderScore(self.score)

    love.graphics.setFont(gFonts['medium'])

    love.graphics.print("Press Enter to serve!", VIRTUAL_WIDTH / 2 - 100, VIRTUAL_HEIGHT / 2 - 16)
end