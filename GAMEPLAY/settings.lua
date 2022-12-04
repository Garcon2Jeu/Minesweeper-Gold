function setMapData(seed)
    mapData = {}

    if seed.mapSize == "small" then
        mapData.rows         = 9
        mapData.columns      = 9
    end

    if seed.mapSize == "medium" then
        mapData.rows         = 16
        mapData.columns      = 16
    end

    if seed.mapSize == "big" then
        mapData.rows         = 30
        mapData.columns      = 30
    end
    

    mapData.totalSquares = mapData.rows * mapData.columns


    if seed.difficulty == "easy" then 
        mapData.mines    = 71
        mapData.gold     = 1
        mapData.sweepers = {inventoryMax = 99, progressMax  = 1} 
    end

    if seed.difficulty == "normal" then 
        mapData.mines    = 246
        mapData.gold     = 30
        mapData.sweepers = {inventoryMax = 99, progressMax  = 5} 
    end

    if seed.difficulty == "hard" then 
        mapData.mines    = 890
        mapData.gold     = 20
        mapData.sweepers = {inventoryMax = 2, progressMax  = 10} 
    end

    
    if seed.gameMode == "classic" then
        mapData.gold     = 0
        mapData.sweepers = {inventoryMax = 0, progressMax  = 999} 
    end


    if seed.mapMode == "presets" then
        return mapData
    end

    mapData.rows     = ui.menuScreen.custom.customSize.rows.gauge.number
    mapData.columns  = ui.menuScreen.custom.customSize.columns.gauge.number
    mapData.mines    = ui.menuScreen.custom.customMines.gauge.number
    mapData.gold     = ui.menuScreen.custom.customGold.gauge.number
    --mapData.sweepers = ui.menuscreen.custom.customSweepers.number
        
    return mapData
end