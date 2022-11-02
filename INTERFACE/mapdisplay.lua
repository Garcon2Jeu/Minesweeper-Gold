MapDisplay = Object:extend()


function MapDisplay:new(windowBox, topBar, leftBar)
    self.x        = leftBar.x + leftBar.width
    self.y        = topBar.y + topBar.height
    self.width    = windowBox.width - leftBar.width
    self.height   = windowBox.height - topBar.height
    self.center   = {x = self.width /2, y = self.height /2}

    self.canvas = love.graphics.newCanvas(self.width, self.height)
    self.grid   = self:processGridData()
end
    

function MapDisplay:update(zoomPercentage)
    self.updatedGrid = self:zoomGrid(zoomPercentage, self.grid)
end


function MapDisplay:draw(gamePlay, map)
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()

        --self:drawCenterLines()
        self:drawSquares(gamePlay, map)

        
    love.graphics.setCanvas()
    love.graphics.draw(self.canvas, self.x, self.y)
end
    




function MapDisplay:processGridData()
    grid = {}
        grid.squareArea = processSquareArea(self.width, self.height)
        grid.spacer     = getNumberFromPercentage(grid.squareArea, 10)
        grid.squareSize = grid.squareArea - grid.spacer
    
        grid.width    = grid.squareArea * map.columns - grid.spacer
        grid.height   = grid.squareArea * map.rows - grid.spacer
        grid.x        = self.center.x - grid.width /2
        grid.y        = self.center.y - grid.height /2
        grid.drawMode = "line"
        
    return grid
end


function processSquareArea(width, height)
    squareArea = 0

    while squareArea * map.rows <= getNumberFromPercentage(height, 90) 
    and squareArea * map.columns <= getNumberFromPercentage(width, 80) do 
        squareArea = squareArea +1
    end

    return squareArea
end


function MapDisplay:zoomGrid(zoomPercentage, grid)
    local updatedGrid = {}
        updatedGrid.width      = grid.width + zoomPercentage *4
        updatedGrid.height     = grid.height + zoomPercentage *4
        updatedGrid.x          = grid.x - updatedGrid.width /2 + grid.width /2
        updatedGrid.y          = grid.y - updatedGrid.height /2 + grid.height /2

        updatedGrid.squareArea = updatedGrid.width / map.columns
        updatedGrid.spacer     = getNumberFromPercentage(updatedGrid.squareArea, 10)
        updatedGrid.squareSize = updatedGrid.squareArea - updatedGrid.spacer

    return updatedGrid
end


function MapDisplay:drawSquares(gamePlay, map)
    for row = 1, map.rows do
        for column = 1, map.columns do
            local square = map.grid[row][column]

            square.x        = self.updatedGrid.x + self.updatedGrid.squareArea * (column -1)
            square.y        = self.updatedGrid.y + self.updatedGrid.squareArea * (row -1)
            square.width    = self.updatedGrid.squareSize
            square.height   = self.updatedGrid.squareSize
            square.textData = centerText(square.clue, FontBig, square)

            square:draw(ui, gamePlay)
        end
    end
end


function MapDisplay:drawCenterLines()
    love.graphics.setColor(blue)
    love.graphics.line(self.center.x, 0, self.center.x, self.height)
    love.graphics.line(0, self.center.y, self.width, self.center.y)

    love.graphics.rectangle("line", self.updatedGrid.x, self.updatedGrid.y, 
                            self.updatedGrid.width, self.updatedGrid.height)
end