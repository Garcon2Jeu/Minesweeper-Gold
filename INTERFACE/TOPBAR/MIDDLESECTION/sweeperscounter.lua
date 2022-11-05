SweepersCounter = Object:extend()

function SweepersCounter:new(topBar, middleSection)
    self.x         = topBar.x.sweepersCounter
    self.y         = topBar.y
    self.width     = topBar.width.sweepersCounter
    self.height    = topBar.height
    self.drawMode  = "line"
    self.color     = {filling = white, font = white}
    

    self.title = {}
        self.title.x        = self.x
        self.title.y        = self.y
        self.title.width    = self.width
        self.title.height   = getNumberFromPercentage(topBar.height, 30)
        self.title.textData = centerText("SWEEPERS", FontSmall, self.title)

    self.progress = {}
        self.progress.x       = self.x
        self.progress.y       = self.title.y + self.title.height
        self.progress.width   = getNumberFromPercentage(self.width, 80)
        self.progress.height  = getNumberFromPercentage(topBar.height, 70)
        self.progress.filling = 0

    self.inventory = {}
        self.inventory.x        = self.progress.x + self.progress.width
        self.inventory.y        = self.progress.y
        self.inventory.width    = getNumberFromPercentage(self.width, 20)
        self.inventory.height   = getNumberFromPercentage(topBar.height, 70)
        self.inventory.textData = centerText(self.available, FontBig, self.inventory)

end


function SweepersCounter:update()
    self.progress.filling = self.progress.width / gamePlay.sweepers.progress.max * gamePlay.sweepers.progress.current
    self.available = gamePlay.sweepers.inventory.current
end


function SweepersCounter:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.title.x, self.title.y, 
                            self.title.width, self.title.height)

    love.graphics.setColor(self.color.font)
    love.graphics.printf(self.title.textData.text, self.title.textData.font, 
                         self.title.textData.transform, self.title.textData.limit, 
                         self.title.textData.align)


    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.progress.x, self.progress.y, 
                            self.progress.width, self.progress.height)
    love.graphics.setColor(self.color.font)
    love.graphics.rectangle("fill", self.progress.x, self.progress.y, 
                            self.progress.filling, self.progress.height)

    
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.inventory.x, self.inventory.y, 
                            self.inventory.width, self.inventory.height)

    love.graphics.setColor(self.color.font)
    love.graphics.printf(self.available, self.inventory.textData.font, 
                         self.inventory.textData.transform, self.inventory.textData.limit, 
                         self.inventory.textData.align)
end


function SweepersCounter:highlight()
    if isMouseOver(self) then 
        self.drawMode         = "fill"
        self.color.font       = black
        self.color.filling    = white
    else
        self.drawMode         = "line"
        self.color.font       = white
    end
end