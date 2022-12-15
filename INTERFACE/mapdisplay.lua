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
    self.zoomedGrid = self:zoomGrid(zoomPercentage, self.grid, self.draggedGrid)
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
        grid.dragged  = {x = grid.x, y = grid.y}
        
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


function MapDisplay:zoomGrid(zoomPercentage, grid, draggedGrid)
    if gamePlay.over then
        zoomPercentage = 0
    end

    if zoomPercentage == 0 then
        grid.dragged.x = self.center.x - grid.width /2
        grid.dragged.y = self.center.y - grid.height /2
    end
    
    local zoomedGrid = {}
        zoomedGrid.width  = grid.width + zoomPercentage *10
        zoomedGrid.height = grid.height + zoomPercentage *10
        zoomedGrid.x      = grid.dragged.x - zoomedGrid.width /2 + grid.width /2
        zoomedGrid.y      = grid.dragged.y - zoomedGrid.height /2 + grid.height /2
        zoomedGrid.squareArea = zoomedGrid.width / map.columns
        zoomedGrid.spacer     = getNumberFromPercentage(zoomedGrid.squareArea, 10)
        zoomedGrid.squareSize = zoomedGrid.squareArea - zoomedGrid.spacer

    return zoomedGrid
end


function MapDisplay:dragGrid(dx, dy)
    if not isMouseOverMapDisplay() 
    or not love.mouse.isDown(1) then 
        return
    end

    self.grid.dragged.x = self.grid.dragged.x + dx
    self.grid.dragged.y = self.grid.dragged.y + dy
end


function MapDisplay:moveGrid(key)
    if key == "up" then
        self.grid.dragged.y = self.grid.dragged.y -50
    end

    if key == "down" then
        self.grid.dragged.y = self.grid.dragged.y +50
    end

    if key == "left" then
        self.grid.dragged.x = self.grid.dragged.x -50
    end

    if key == "right" then
        self.grid.dragged.x = self.grid.dragged.x +50
    end
end


function MapDisplay:drawSquares(gamePlay, map)
    for row = 1, map.rows do
        for column = 1, map.columns do
            local square = map.grid[row][column]

            square.x        = self.zoomedGrid.x + self.zoomedGrid.squareArea * (column -1)
            square.y        = self.zoomedGrid.y + self.zoomedGrid.squareArea * (row -1)
            square.width    = self.zoomedGrid.squareSize
            square.height   = self.zoomedGrid.squareSize
            square.textData = centerText(square.clue, FontMedium, square)

            square:draw(ui, gamePlay)
        end
    end
end


function MapDisplay:drawCenterLines()
    love.graphics.setColor(blue)
    love.graphics.line(self.center.x, 0, self.center.x, self.height)
    love.graphics.line(0, self.center.y, self.width, self.center.y)

    love.graphics.rectangle("line", self.zoomedGrid.x, self.zoomedGrid.y, 
                            self.zoomedGrid.width, self.zoomedGrid.height)
end