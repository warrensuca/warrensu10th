ScoreState =  Class{__includes = BaseState}


function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')

    if self.score < 1 then
        love.graphics.draw(medals['bronze'], VIRTUAL_WIDTH/2 - (MEDAL_WIDTH / 20), 180, 0.1, 0.1)
    elseif self.score < 3 then
        love.graphics.draw(medals['silver'], VIRTUAL_WIDTH/2 - (MEDAL_WIDTH / 20), 180, 0.1, 0.1)
    else
        love.graphics.draw(medals['gold'], VIRTUAL_WIDTH/2 - (MEDAL_WIDTH / 20), 180, 0.1, 0.1)
    end
end