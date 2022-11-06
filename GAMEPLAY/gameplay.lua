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
            and gamePlay.paused == false then 

                if button == 2 
                or ui.leftBar.flagMode.activated then
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
        square.firstClicked = true
        map:plantGold()
        map:plantMines()
    end
end


function GamePlay:leftClick(square, gamePlay, map, row, column)
    square:onClick(gamePlay, map, row, column)
    gamePlay.sweepers:onClick(square, gamePlay)
end


function GamePlay:rightClick(gamePlay, square)
    if gamePlay.play == true then 
        if square.flagged == false then
            square.flagged = true
        else
            square.flagged = false
        end
        ui.topBar.dashBoard.minesCounter:update(square)
        ui.leftBar.flagMode.activated = false
    end
end


function GamePlay:endGame(map)
    score = {
        squaresCleared = 0,
        minesFlagged   = 0,
        minesSwept     = 0,
        goldSwept      = 0
    }
    
    for i = 1, map.rows do 
        for j = 1, map.columns do
            local square = map.grid[i][j]
        
            if square.cleared then 
                score.squaresCleared = score.squaresCleared +1
                square.color = green
            else
                square.color = orange
            end
            
            if square.isGolden 
            and square.swept then
                score.goldSwept = score.goldSwept +1
            end
                
            if square.flagged then
                square.color = red
            end

            if square.swept then
                square.color = purple
            end

            if square.isMine then
                if square.flagged then
                    score.minesFlagged = score.minesFlagged +1
                    square.color = blue
                else 
                    square.color = red
                end
                
                if square.swept then
                    score.minesSwept = score.minesSwept +1
                    square.color = purple
                end
            end


            square.cleared = true
        end
    end

    print("Total squares cleared      = " .. score.squaresCleared)
    print("Total mines flagged        = " .. score.minesFlagged)
    print("Total mines swept          = " .. score.minesSwept)
    print("Total gold squares cleared = " .. score.goldSwept)
end


