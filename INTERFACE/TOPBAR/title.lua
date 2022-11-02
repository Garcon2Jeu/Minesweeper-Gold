Title = Object:extend()

function Title:new(topBar)
    self.x        = topBar.x.title
    self.y        = topBar.y
    self.width    = topBar.width.title
    self.height   = topBar.height
    self.drawMode = "fill"
    self.color     = {filling = white, font = black}
    self.textData = centerText("MINESWEEPER GOLD", FontHuge, self)
end

function Title:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
    
    love.graphics.setColor(self.color.font)
    love.graphics.printf(self.textData.text, self.textData.font, self.textData.transform, 
                         self.textData.limit, self.textData.align)
end

function Title:highlight()
    if isMouseOver(self) then 
        self.drawMode = "fill"
        self.color.font = black
        self.color.filling = yellow
    else
        self.drawMode = "line"
        self.color.font = yellow
        self.color.filling = white
    end
end