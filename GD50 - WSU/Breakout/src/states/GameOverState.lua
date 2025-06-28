GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    self.score = params.score
    self.highScores = params.highScores
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local highScore = false
        local scoreIndex = 11

        for i = 10, 1, -1 do
            local score = self.highScores[i].score or 0

            if self.score > score then
                highScoreIndex = i
                highScore = true
            end
        end

        if highScore then
            gSounds['high-score']:play()
            gStateMachine:change('enter-high-score', {
                highScores = self.highScores,
                score = self.score,
                scoreIndex = highScoreIndex

            })
        else
            gStateMachine:change('start', {
                highScores = self.highScores
            })
        end


    end
end


function GameOverState:render()
    renderHealth(0)
    renderScore(self.score)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.print("Press Enter to Play Again!", VIRTUAL_WIDTH / 2 - 100, VIRTUAL_HEIGHT / 2 - 16)
end