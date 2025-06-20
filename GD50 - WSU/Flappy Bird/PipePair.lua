PipePair = Class{}
require 'Pipe'
local GAP_HEIGHT = math.random(87,93)--90

function PipePair:init(y)
    self.x = VIRTUAL_WIDTH

    self.y = y
    self.pipes = {
        ['upper'] = Pipe("top", self.y),
        ['lower'] = Pipe("bottom", self.y + PIPE_HEIGHT + GAP_HEIGHT)
    }

    self.remove = false
    self.scored = false
end

function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED*dt
        self.pipes['upper'].x = self.x
        self.pipes['lower'].x = self.x
    else
        self.remove = true
    end

end

function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end