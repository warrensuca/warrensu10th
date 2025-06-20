Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage("pipe.png")
local PIPE_SCROLL = -60



function Pipe:init(pos, y)
    self.pos = pos
    self.x = VIRTUAL_WIDTH
    --self.y = math.random(VIRTUAL_HEIGHT/4, VIRTUAL_HEIGHT-10)
    self.y = y

    self.width = PIPE_IMAGE:getWidth()
    self.height = PIPE_IMAGE:getHeight()
end

function Pipe:update(dt)
   -- self.x = self.x + PIPE_SCROLL * dt
end

function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, self.x, 
        (self.pos == 'top' and self.y + PIPE_HEIGHT or self.y), 
        0, --rotation
        1, --xscale
        self.pos == 'top' and -1 or 1) --reflection
end