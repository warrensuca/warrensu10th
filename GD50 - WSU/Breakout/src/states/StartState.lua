StartState = Class{__includes = BaseState}

local highlighted = 1

function StartState:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = 3-highlighted

        gSounds['paddle-hit']:play()
    

    elseif love.keyboard.wasPressed('escape') then
        love.event.quit()
    elseif highlighted == 1 and (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) then
        gStateMachine:change('play')
    end
end

function StartState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])

    if highlighted == 1 then
        love.graphics.setColor(103/255,1,1,1)
    end
    
    love.graphics.printf("start", 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1,1,1,1)
    if highlighted == 2 then
        love.graphics.setColor(103/255,1,1,1)
    end

    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 90, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1,1,1,1)
end