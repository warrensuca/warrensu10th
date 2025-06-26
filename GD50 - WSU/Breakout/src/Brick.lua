Brick = Class{}

function Brick:init(x, y, touchCount)
    
    self.x = x
    self.y = y
    
    self.width = 32
    self.height = 16

    self.inPlay = true
    self.touchCount = touchCount
    self.color = 3-self.touchCount
    self.tier = 1
end


function Brick:hit()
    gSounds['brick-hit-2']:play()
    self.touchCount = self.touchCount - 1
    self.color = 3-self.touchCount
    self.inPlay = not (self.touchCount == 0)
end

function Brick:render()
    if self.inPlay then
        
        love.graphics.draw(gTextures['main'], gFrames['brick'][1+((self.color-1) * 4) + self.tier], self.x, self.y)
    end
end