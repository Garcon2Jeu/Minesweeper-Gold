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
    self:highlight()
    self:revealSelf()
    self:changeSquareColor(gamePlay)
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
    if  self.flagged                == false 
    and self.cleared                == false
    and self.isGolden               == false 
    and gamePlay.sweepers.activated == false then 

        if self.isMine then
            gamePlay:update("over")
        end

        self:clearEmptySquares(map, row, column)
    end
end


function Square:revealSelf()
    if self.cleared == true then
        self.drawMode = "line"
    end
end


function Square:changeSquareColor(gamePlay)    
    if gamePlay.play 
    or gamePlay.start then
        if self.swept then
            self.cleared = true
            self.color   = purple
            return
        end

        if self.flagged == true 
        and gamePlay.play then 
            self.color = red
            return
        end
    end
end


function Square:highlight()
    local mouse = getMousePosition()

    if gamePlay.start 
    or gamePlay.play then
        if isMouseOverSquare(self) then
            if gamePlay.sweepers.activated 
            and self.cleared == false then
                self.color = purple
            elseif self.cleared == false then
                self.color = grey
            end
        else
            if self.isGolden then 
                self.color = yellow
            else 
                self.color = white
            end
        end
    end
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

    if gamePlay.play then
        gamePlay.sweepers:update()
    end
    
    if self.clue == 0 then
        for i = row -1, row +1 do 
            for j = column -1, column +1 do
                if isSquareReal(map, i, j)
                and map.grid[i][j] ~= self
                and map.grid[i][j].cleared == false then
                    local surroundingSquare = map.grid[i][j]
                    
                    if surroundingSquare.clue > 0 then
                        surroundingSquare.cleared = true
                        gamePlay.sweepers:update()
                    else
                        surroundingSquare:clearEmptySquares(map, i, j)
                    end

                    if surroundingSquare.isGolden then
                        surroundingSquare.cleared = false
                    end
                end
            end
        end
    end
end


