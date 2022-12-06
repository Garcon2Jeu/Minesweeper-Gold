require "/MAP/square"

Map = Object:extend()

function Map:new(gamePlay)
    self.rows         = gamePlay.mapData.rows
    self.columns      = gamePlay.mapData.columns

    self.grid         = Map:makeGrid(self.rows, self.columns)
    self.totalSquares = gamePlay.mapData.totalSquares
    self.mines        = gamePlay.mapData.mines
    self.gold         = gamePlay.mapData.gold
    self.sweepCoins   = gamePlay.mapData.sweepers.limit
end


function Map:update(gamePlay)
    for i = 1, self.rows do 
        for j = 1, self.columns do
            local square = self.grid[i][j]

            square:update(gamePlay)   
        end
    end
end





function Map:makeGrid(rows, columns)
    local grid = {}

    for i = 1, rows do
        local row = {}
        for j = 1, columns do 
            table.insert(row, Square(i, j))
        end
        table.insert(grid, row)
    end

    return grid
end


function Map:populateGrid()
    self:plantGold()
    self:plantMines()
    self:plantSweepCoins()
end

function Map:plantMines()
    local minesCounter = 0

    while minesCounter <= self.mines do
        for row = 1, self.rows do
            for column = 1, self.columns do
                local square = self.grid[row][column]
                
                if not square.isMine 
                and not square.firstClicked
                and not square:isSurroundingSquareFirstClicked(self, row, column) then
                    if minesCounter >= self.mines then
                        return
                    end

                    if love.math.random(1, self.totalSquares) == 1 then
                        square.isMine = true
                        minesCounter = minesCounter +1
                        square:processSurroundingSquaresClues(self, row, column)
                    end
                end
            end
        end
    end
end


function Map:plantGold()
    local goldCounter = 0

    while goldCounter <= self.gold do 
        for row = 1, self.rows do
            for column = 1, self.columns do
                local square = self.grid[row][column]
                
                if not square.isGolden
                and not square.firstClicked
                and not square:isSurroundingSquareFirstClicked(self, row, column) then
                    
                    if goldCounter >= self.gold then
                        return
                    end
                    
                    if love.math.random(1, self.totalSquares) == 1 then
                        square.isGolden = true
                        goldCounter = goldCounter +1
                    end
                end
            end
        end
    end
end


function Map:plantSweepCoins()
    local coinsCounter = 0

    while coinsCounter <= self.sweepCoins do 
        for row = 1, self.rows do
            for column = 1, self.columns do
                local square = self.grid[row][column]
                
                if not square.isMine 
                and not square.isGolden
                and not square.sweepCoin
                and not square.firstClicked
                and not square:isSurroundingSquareFirstClicked(self, row, column) then
                    
                    if coinsCounter >= self.sweepCoins then
                        return
                    end
                    
                    if love.math.random(1, self.totalSquares) == 1 then
                        square.sweepCoin = true
                        coinsCounter = coinsCounter +1
                    end
                end
            end
        end
    end
end
