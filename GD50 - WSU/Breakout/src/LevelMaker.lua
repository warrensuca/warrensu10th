LevelMaker = Class{}

function LevelMaker.createMap(level) 
    local bricks = {}
    local numRows = math.random(1,5)
    local numCols = math.random(7,13)    

    for y = 0, numRows-1 do 
        for x = 0, numCols-1 do 
            if x % 3 == 0 then
                b = Brick(
                    x*32 
                    + 8 
                    + (13-numCols) * 16,

                    y*16, 
                    2
                )
            else
                b = Brick(
                    x*32 
                    + 8 
                    + (13-numCols) * 16,

                    y*16,
                    1
                )

            
            end
        table.insert(bricks, b)
        end
    end
    return bricks
end