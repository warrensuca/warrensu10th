PlayState = Class{__includes = BaseState}

PIPE_SPEED = 60

-- height of pipe image, globally accessible
PIPE_HEIGHT = 288
PIPE_WIDTH = 70
function PlayState:init()
    self.spawnTimer = 0
    self.pipePairs = {}

    self.bird = Bird()
    self.lastY = -PIPE_HEIGHT + math.random(50,80) + 20  
    self.score = 0
end


function PlayState:update(dt)
    if love.keyboard.wasPressed('p') then
        pause = not pause
        sounds['explosion']:play()
        sounds['hurt']:play()
        
    end
    if not pause then

        sounds['music']:play()

        self.spawnTimer = self.spawnTimer + dt
        --if self.spawnTimer > 2 then
        if self.spawnTimer > math.random(1.8,2.2) then
            local y = math.max(-PIPE_HEIGHT + 10, math.min(self.lastY + math.random(-20,20), VIRTUAL_HEIGHT-90-PIPE_HEIGHT))
            self.lastY = y
            table.insert(self.pipePairs, PipePair(y))
            self.spawnTimer = 0
        end

        self.bird:update(dt)

        for k, pair in pairs(self.pipePairs) do
            pair:update(dt)
            for _, pipe in pairs(pair.pipes) do
                if self.bird:collides(pipe) then
                    sounds['explosion']:play()
                    sounds['hurt']:play()
                    gStateMachine:change('score', {score = self.score})
                
                end
                if not pair.scored then
                    if self.bird.x > pipe.x + PIPE_WIDTH then
                        pair.scored = true
                        self.score = self.score + 1
                        sounds['score']:play()
                    end

                end
            end
        end
        for k, pair in pairs(self.pipePairs) do
            if pair.remove then
                table.remove(self.pipePairs, k)
            end
        end

        if self.bird.y > VIRTUAL_HEIGHT-15 then
            sounds['explosion']:play()
            sounds['hurt']:play()
            gStateMachine:change('score', {score = self.score})
        end
    else
        sounds['music']:pause()
    end
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
    self.bird:render()
end