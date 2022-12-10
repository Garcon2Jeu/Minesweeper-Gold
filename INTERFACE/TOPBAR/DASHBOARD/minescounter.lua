MinesCounter = Object:extend()

function MinesCounter:new(topBar, middleSection)
    self.x      = topBar.x.minesCounter
    self.y      = topBar.y
    self.width  = topBar.width.minesCounter
    self.height = topBar.height
    self.drawMode = "line"
    self.color     = {filling = white, font = white}
    self.remaining = gamePlay.mapData.mines

    self.title = {}
        self.title.x        = self.x
        self.title.y        = self.y
        self.title.width    = self.width
        self.title.height   = getNumberFromPercentage(topBar.height, 30)
        self.title.textData = centerText("MINES", FontSmall, self.title)

    self.counter = {}
        self.counter.x        = self.x
        self.counter.y        = self.title.y + self.title.height
        self.counter.width    = self.width
        self.counter.height   = getNumberFromPercentage(topBar.height, 70)
        self.counter.textData = centerText(self.remaining, FontBig, self.counter)
end


function MinesCounter:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.title.x, self.title.y, self.title.width, 
                            self.title.height)
    love.graphics.rectangle(self.drawMode, self.counter.x, self.counter.y, 
                            self.counter.width, self.counter.height)
    
    love.graphics.setColor(self.color.font)
    love.graphics.printf(self.title.textData.text, self.title.textData.font, 
                         self.title.textData.transform, self.title.textData.limit, 
                         self.title.textData.align)

    love.graphics.printf(self.remaining, self.counter.textData.font, 
                         self.counter.textData.transform, self.counter.textData.limit, 
                         self.counter.textData.align)
end





function MinesCounter:highlight()
    if isMouseOver(self) then 
        self.drawMode         = "fill"
        self.color.font       = black
        self.color.filling    = white
    else
        self.drawMode         = "line"
        self.color.font       = white
    end
end