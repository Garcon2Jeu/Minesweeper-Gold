MenuButton = Object:extend()

function MenuButton:new(topBar)
    self.x        = topBar.x.menuButton
    self.y        = topBar.y
    self.width    = topBar.width.menuButton
    self.height   = topBar.height
    self.drawMode = "line"
    self.color     = {filling = white, font = white}
    self.textData = centerText("MENU", FontBig, self)
end


function MenuButton:update()
    if gamePlay.play 
    or gamePlay.start 
    or gamePlay.over then
        self.textData.text = "MENU"
    end

    if gamePlay.paused then
        self.textData.text = "BACK"
    end
end


function MenuButton:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
    
    love.graphics.setColor(self.color.font)
    love.graphics.printf(self.textData.text, self.textData.font, self.textData.transform, 
                         self.textData.limit, self.textData.align)
end


function MenuButton:onClick()
    if isMouseOver(self) then
        ui.menuScreen:toggle()
    end
end