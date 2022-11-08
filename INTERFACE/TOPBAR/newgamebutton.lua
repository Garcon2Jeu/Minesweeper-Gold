NewGameButton = Object:extend()

function NewGameButton:new(topBar)
    self.x        = topBar.x.newGameButton
    self.y        = topBar.y
    self.width    = topBar.width.newGameButton
    self.height   = topBar.height
    self.drawMode = "line"
    self.color    = {filling = white, font = white}
    self.textData = centerText("NEW", FontBig, self)
end


function NewGameButton:update()
    if gamePlay.play then
        self.textData.text = "END"
    end

    if gamePlay.over 
    or gamePlay.paused then
        self.textData.text = "NEW"
    end
end


function NewGameButton:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)

    love.graphics.setColor(self.color.font)
    love.graphics.printf(self.textData.text, self.textData.font, self.textData.transform, 
                         self.textData.limit, self.textData.align)
end


function NewGameButton:onClick()
    if not isMouseOver(self) then
        return
    end

    if gamePlay.play then 
        gamePlay:update("over")
    end
    
    if gamePlay.over 
    or gamePlay.paused then
        gamePlay:update("new")
    end
end