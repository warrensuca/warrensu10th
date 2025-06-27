LevelMaker = Class{}

function LevelMaker.createMap(level) 
    local bricks = {}
    local numRows = math.random(1,5)
    local numCols = math.random(7,13)    

    local tier = math.min(3, math.floor(level/5))
    local highestColor = math.min(5, level+1 % 5)
    
    for y = 1, numRows do 
        local ColorPatternInterval = math.random(0,4)
        alternateColor1 = math.random(1, highestColor)
        alternateColor2 = math.random(1, highestColor)

        
        for x = 1, numCols do 
            

            if x % ColorPatternInterval == 0 then
                b = Brick(
                    (x-1)*32 
                    + 8 
                    + (13-numCols) * 16,

                    y*16, 
                    alternateColor1,
                    tier
                )
            else
                b = Brick(
                    (x-1)*32 
                    + 8 
                    + (13-numCols) * 16,

                    y*16,
                    alternateColor2,
                    tier
                )

            
            end
        table.insert(bricks, b)
        end
    end
    return bricks
end