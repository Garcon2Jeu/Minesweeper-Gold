function setMapData(seed)
    mapData = {}
    mapData.sweepers = {}

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
        rates.mines = 0.13
        rates.gold  = 0.13
        rates.bonus = 5
    end

    if seed.difficulty == "normal" then 
        rates.mines = 0.16
        rates.gold  = 0.16
        rates.bonus = 3
    end

    if seed.difficulty == "hard" then 
        rates.mines = 0.21
        rates.gold  = 0.21
        rates.bonus = 0
    end


    mapData.mines        = math.floor(mapData.totalSquares * rates.mines)
    mapData.gold         = math.floor(mapData.totalSquares * rates.gold)
    mapData.sweepers.max = mapData.gold + rates.bonus


    if seed.mapMode == "custom" then
        mapData.rows         = ui.menuScreen.custom.customSize.rows.gauge.number
        mapData.columns      = ui.menuScreen.custom.customSize.columns.gauge.number
        mapData.mines        = ui.menuScreen.custom.customMines.gauge.number
        mapData.gold         = ui.menuScreen.custom.customGold.gauge.number
        mapData.sweepers.max = mapData.gold + 
                                ui.menuScreen.custom.customSweepers.gauge.number
        end
        
    mapData.sweepers.required = math.floor((mapData.totalSquares - mapData.mines -
                                            mapData.gold) / mapData.sweepers.max)
    mapData.sweepers.limit    = mapData.sweepers.max * mapData.sweepers.required 


    if seed.gameMode == "classic" then
        mapData.gold              = 0
        mapData.sweepers.max      = 0
        mapData.sweepers.required = 0
        mapData.sweepers.limit    = 0
    end

    print("!!!!!!!!!!!!!!!!!NEW GAME!!!!!!!!!!!!!!!!")
    print("Rows          : " ..mapData.rows)
    print("Columns       : " ..mapData.columns)
    print("Total Squares : " ..mapData.totalSquares)
    print("Mines         : " ..mapData.mines)
    print("Gold          : " ..mapData.gold)
    print("Sweepers:")
    print("     Max      : " ..mapData.sweepers.max)
    print("     Required : " ..mapData.sweepers.required)
    print("     Limit    : " ..mapData.sweepers.limit)
        
    return mapData
end