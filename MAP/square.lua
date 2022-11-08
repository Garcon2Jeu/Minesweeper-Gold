Square = Object:extend()

function Square:new(row, column)
    self.x            = 0
    self.y            = 0
    self.width        = 0
    self.height       = 0
    self.drawMode     = "fill"
    self.color        = white
    self.id           = {row, column}
    self.firstClicked = false
    self.isMine       = false
    self.isGolden     = false
    self.clue         = 0
    self.cleared      = false
    self.flagged      = false
    self.swept        = false

    
end


function Square:update(gamePlay)
    self:revealSelf()
    self:changeColor(gamePlay)
    self:highlight()
end


function Square:draw(ui, gamePlay)
    love.graphics.setColor(self.color)
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)

    if self.isMine then 
        love.graphics.circle("line", self.x + self.width /2, self.y + self.height /2, 10)
    elseif self.clue > 0 then 
        love.graphics.printf(self.textData.text, self.textData.font, self.textData.transform, 
                             self.textData.limit, self.textData.align)
    end

    love.graphics.setColor(white)
end




function Square:onClick(gamePlay, map, row, column)
    if self.flagged                
    or self.cleared               
    or self.isGolden               
    or gamePlay.sweepers.activated then 
        return
    end

    if self.isMine then
        gamePlay:update("over")
    end

    self:clearEmptySquares(map, row, column)
end


function Square:revealSelf()
    if self.cleared then
        self.drawMode = "line"
    end
end


function Square:changeColor(gamePlay)    
    if not gamePlay.play 
    and not gamePlay.start then
        return 
    end

    if self.swept then
        self.cleared = true
        self.color   = purple
        return
    end
    
    if self.isGolden then
        self.color = yellow
        return
    end
    
    if self.flagged
    and not self.cleared then 
        self.color = red
        return
    end
    
    if gamePlay.sweepers.activated 
    and self.isGolden 
    and self.flagged then
        self.color = yellow
        return
    end

    self.color = white
end


function Square:highlight()
    if not gamePlay.start 
    and not gamePlay.play then 
        return 
    end
    
    if not isMouseOverMapDisplay()
    or not isMouseOverSquare(self) 
    or self.cleared then
        return
    end
    
    if gamePlay.sweepers.activated then
        self.color = purple
        return
    end
    
    if ui.leftBar.flagMode.activated then
        self.color = red
        return
    end
    
    if self.isGolden 
    or self.flagged then 
        return
    end

    self.color = grey
end





function Square:isSurroundingSquareFirstClicked(map, row, column)
    for i = row -1, row +1 do 
        for j = column -1, column +1 do
            if isSquareReal(map, i, j) then
                local surroundingSquare = map.grid[i][j]

                if surroundingSquare.firstClicked then 
                    return true
                end
            end
        end
    end
    return false
end


function Square:processSurroundingSquaresClues(map, row, column)
    for i = row -1, row +1 do 
        for j = column -1, column +1 do
            if isSquareReal(map, i, j) then
                local surroundingSquare = map.grid[i][j]
                surroundingSquare.clue = surroundingSquare.clue +1
            end
        end
    end
end


function Square:clearEmptySquares(map, row, column)
    self.cleared = true

    if gamePlay.sweepers.activated then
        return
    end

    gamePlay.sweepers:update()
    
    if self.clue > 0 then
        return
    end

    for i = row -1, row +1 do 
        for j = column -1, column +1 do

            if isSquareReal(map, i, j)
            and map.grid[i][j] ~= self
            and not map.grid[i][j].cleared then
                local surroundingSquare = map.grid[i][j]
                
                if surroundingSquare.clue == 0 then
                    surroundingSquare:clearEmptySquares(map, i, j)
                else
                    surroundingSquare.cleared = true
                    gamePlay.sweepers:update()
                end
                
                if surroundingSquare.isGolden then
                    surroundingSquare.cleared = false
                end
            end
        end
    end
end


