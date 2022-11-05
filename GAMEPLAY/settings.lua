function setMapData(seed)
    mapData = {}
        if seed.size == "small" then
            mapData.rows         = 9
            mapData.columns      = 9
        end

        if seed.size == "medium" then
            mapData.rows         = 16
            mapData.columns      = 16
        end

        if seed.size == "big" then
            mapData.rows         = 30
            mapData.columns      = 16
        end
        

        mapData.totalSquares = mapData.rows * mapData.columns


        if seed.difficulty == "easy" then 
            mapData.mines    = 20
            mapData.gold     = 7
            mapData.sweepers = {inventoryMax = 99, progressMax  = 1} 
        end

        if seed.difficulty == "normal" then 
            mapData.mines    = 60
            mapData.gold     = 30
            mapData.sweepers = {inventoryMax = 99, progressMax  = 5} 
        end

        if seed.difficulty == "hard" then 
            mapData.mines    = 99
            mapData.gold     = 20
            mapData.sweepers = {inventoryMax = 2, progressMax  = 10} 
        end

    return mapData
end