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

    rates = {}


    if seed.difficulty == "easy" then 
        rates.mines = 0.12
        rates.gold  = 0.06
        rates.bonus = 10
    end

    if seed.difficulty == "normal" then 
        rates.mines = 0.15
        rates.gold  = 0.07
        rates.bonus = 5
    end

    if seed.difficulty == "hard" then 
        rates.mines = 0.20
        rates.gold  = 0.10
        rates.bonus = 3
    end

    
    if seed.gameMode == "classic" then
        mapData.gold     = 0
        mapData.sweepers = {inventoryMax = 0, progressMax  = 999} 
    end


    mapData.mines    = math.floor(mapData.totalSquares * rates.mines)
    mapData.gold     = math.floor(mapData.totalSquares * rates.gold)
    mapData.sweepers = {}
        mapData.sweepers.max      = mapData.mines + mapData.gold + rates.bonus
        mapData.sweepers.required = math.floor((mapData.totalSquares - mapData.mines - 
                                                mapData.gold) / mapData.sweepers.max)
        mapData.sweepers.limit    = mapData.sweepers.max * mapData.sweepers.required 


    if seed.mapMode == "custom" then
        mapData.rows     = ui.menuScreen.custom.customSize.rows.gauge.number
        mapData.columns  = ui.menuScreen.custom.customSize.columns.gauge.number
        mapData.mines    = ui.menuScreen.custom.customMines.gauge.number
        mapData.gold     = ui.menuScreen.custom.customGold.gauge.number
        mapData.sweepers = {}
            mapData.sweepers.max      = mapData.mines + mapData.gold + ui.menuScreen.custom.customSweepers.gauge.number
            mapData.sweepers.required = math.floor((mapData.totalSquares - mapData.mines - 
                                                    mapData.gold) / mapData.sweepers.max)
            mapData.sweepers.limit    = mapData.sweepers.max * mapData.sweepers.required 
    end

        
    return mapData
end