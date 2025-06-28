PowerUp = Class{}

function PowerUp:init()
    self.skin = math.random(1,10)

    self.x = math.random(0,VIRTUAL_WIDTH-16)
    self.y = 0

    self.width = 16
    self.height = 16

    self.dy = math.random(50,150)

    self.inPlay = true

    self.isKey = self.skin == 10
    
end

function PowerUp:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    return true
    
end

function PowerUp:update(dt)
    if self.inPlay then
        self.y = self.y + self.dy*dt

        if self.y >= VIRTUAL_HEIGHT then
            self.inPlay = false
        end
    end
end

function PowerUp:render()
    if self.inPlay then

        love.graphics.draw(gTextures['main'], gFrames['powerup'][self.skin], self.x, self.y)
    
    end
end