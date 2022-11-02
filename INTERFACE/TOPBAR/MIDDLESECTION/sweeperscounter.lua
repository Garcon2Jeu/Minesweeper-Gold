SweepersCounter = Object:extend()

function SweepersCounter:new(topBar, middleSection)
    self.x        = topBar.x.sweepersCounter
    self.y        = topBar.y
    self.width    = topBar.width.sweepersCounter
    self.height   = topBar.height
    self.drawMode = "line"
    self.color    = {filling = white, font = white}

    self.title = {}
        self.title.x      = self.x
        self.title.y      = self.y
        self.title.width  = self.width
        self.title.height = middleSection.separatorTitle_Y
        self.title.textData = centerText("Sweepers", FontSmall, self.title)
end

function SweepersCounter:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.title.x, self.title.y, self.title.width, self.title.height)

    love.graphics.setColor(self.color.font)
    love.graphics.printf(self.title.textData.text, self.title.textData.font, self.title.textData.transform, 
                         self.title.textData.limit, self.title.textData.align)

end


function SweepersCounter:highlight()
    if isMouseOver(self) then 
        self.drawMode         = "fill"
        self.color.font       = black
        self.color.filling    = white
        self.separators.color = black
    else
        self.drawMode         = "line"
        self.color.font       = white
        self.separators.color = white
    end
end