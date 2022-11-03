SweepersCounter = Object:extend()

function SweepersCounter:new(topBar, middleSection)
    self.x        = topBar.x.sweepersCounter
    self.y        = topBar.y
    self.width    = topBar.width.sweepersCounter
    self.height   = topBar.height
    self.drawMode = "line"
    self.color    = {filling = white, font = white}

    self.title = {}
        self.title.x        = self.x
        self.title.y        = self.y
        self.title.width    = self.width
        self.title.height   = getNumberFromPercentage(topBar.height, 30)
        self.title.textData = centerText("SWEEPERS", FontSmall, self.title)

    self.progress = {}
        self.progress.x      = self.x
        self.progress.y      = self.title.y + self.title.height
        self.progress.width  = self.width
        self.progress.height = getNumberFromPercentage(topBar.height, 20)

    self.inventory = {}
        self.inventory.x      = self.x
        self.inventory.y      = self.progress.y + self.progress.height
        self.inventory.width  = self.width
        self.inventory.height = getNumberFromPercentage(topBar.height, 50)
end

function SweepersCounter:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.title.x, self.title.y, self.title.width, self.title.height)

    love.graphics.setColor(self.color.font)
    love.graphics.printf(self.title.textData.text, self.title.textData.font, self.title.textData.transform, 
                         self.title.textData.limit, self.title.textData.align)

    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.inventory.x, self.inventory.y, self.inventory.width, self.inventory.height)
    
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.inventory.x, self.inventory.y, self.inventory.width, self.inventory.height)
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