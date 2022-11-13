require "/GAMEPLAY/sweepers"
require "/GAMEPLAY/settings"

GamePlay = Object:extend()

function GamePlay:new(seed)
    self.start  = true
    self.play   = false
    self.over   = false
    self.paused = false

    self.mapData  = setMapData(seed)
    self.sweepers = Sweepers(self.mapData)
end


function GamePlay:update(status)
    if status == "start" then 
        self.start  = true
        self.play   = false
        --self.paused = false
        self.ended  = false
    elseif status == "play" then 
        self.start  = false
        self.play   = true
        --self.paused = false
        self.ended  = false
    --elseif status == "paused" then 
        --self.start  = false
        --self.play   = false
        --self.paused = true
        --self.ended  = false
    elseif status == "over" then 
        self.start  = false
        self.play   = false
        --self.paused = false
        self.over   = true

        self:endGame(map)
    elseif status == "new" then 
        love.load()
    end
end





function GamePlay:onClick(map, button)
    for row = 1, map.rows do
        for column = 1, map.columns do 
            local square = map.grid[row][column]

            if isMouseOverSquare(square) 
            and not gamePlay.paused then 

                if button == 2 then
                    gamePlay:rightClick(gamePlay, square)
                    return
                end

                if gamePlay.start then
                    gamePlay:startGame(map, square)
                end

                if gamePlay.play then
                    gamePlay:leftClick(square, gamePlay, map, row, column)
                end
            end 
        end
    end
end



function GamePlay:startGame(map, square)
    if self.start then 
        self:update("play")
        self.time = love.timer.getTime()
        square.firstClicked = true
        map:plantGold()
        map:plantMines()
    end
end


function GamePlay:leftClick(square, gamePlay, map, row, column)
    if gamePlay.sweepers.activated then
        gamePlay.sweepers:onClick(square, gamePlay)
        return
    end

    if ui.leftBar.flagMode.activated then
        ui.leftBar.flagMode:flag(square)
        return
    end

    square:onClick(gamePlay, map, row, column)
end


function GamePlay:rightClick(gamePlay, square)
    if not gamePlay.play then 
        return
    end

    ui.leftBar.flagMode:toggle()
    ui.leftBar.flagMode:flag(square)
end


function GamePlay:endGame(map)
    score = {}
        score.squares = {cleared = 0, missed = 0}
        score.mines   = {flagged = 0, swept = 0, missed = 0}
        score.gold    = {swept = 0, missed = 0}

    for row = 1, map.rows do 
        for column = 1, map.columns do
            local square = map.grid[row][column]

            if square.cleared then
                score.squares.cleared = score.squares.cleared +1
                square.color = green
            else
                score.squares.missed = score.squares.missed +1
                square.color = orange
            end
            
            if square.isMine then
                if square.flagged then
                    score.mines.flagged = score.mines.flagged +1
                    square.color = blue
                end

                if square.swept then
                    score.mines.swept = score.mines.swept +1
                    square.color = purple
                end
                
                if not square.flagged 
                and not square.swept then
                    score.mines.missed = score.mines.missed +1
                    square.color = red
                end
            end

            if square.isGolden then
                if square.swept then
                    score.gold.swept = score.gold.swept +1
                    square.color = purple
                else
                    score.gold.missed = score.gold.missed +1
                    square.color = yellow
                end
            end

            square.cleared = true
        end
    end

    score.exploration = math.floor(getPercentageFromNumber(mapData.totalSquares, score.squares.cleared))
    score.time        = math.floor(love.timer.getTime() - self.time)
    --score.final       = self:processFinalScore(score)

    print("Squares Cleared = " ..score.squares.cleared)
    print("Squares Missed  = " ..score.squares.missed)
    print("Mines Flagged   = " ..score.mines.flagged)
    print("Mines Swept     = " ..score.mines.swept)
    print("Mines Missed    = " ..score.mines.missed)
    print("Gold Swept      = " ..score.gold.swept)
    print("Gold Missed     = " ..score.gold.missed)
    print("Exploration     = " ..score.exploration .."%")
    print("Time            = " ..score.time .." seconds")

    ui.topBar.scoreBoard:update(score)
end