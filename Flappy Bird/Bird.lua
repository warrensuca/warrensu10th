Bird = Class{}
BIRD_FALL_SPEED = 20
function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    self.dy = 0
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end

function Bird:update(dt)
    self.dy = self.dy + BIRD_FALL_SPEED*dt
    if love.keyboard.wasPressed('space') then
        self.dy = -5
        sounds['jump']:play()
    end

    self.y = self.y + self.dy
end

function Bird:collides(pipe)
    if self.x > pipe.x + pipe.width or self.x + self.width < pipe.x or self.y > pipe.y + pipe.height or self.y + self.height < pipe.y then
        return false
    end

    return true

end
