SweepersCounter = Object:extend()

function SweepersCounter:new(topBar, middleSection)
    self.x      = topBar.x.sweepersCounter
    self.y      = topBar.y
    self.width  = topBar.width.sweepersCounter
    self.height = topBar.height
    self.drawMode = "line"

    self.name      = "SWEEPERS"
    self.color     = {filling = white, font = white}
    self.transform = love.math.newTransform(self.x , (self.y + 4))
    self.limit     = self.width
    self.align     = "center"

    self.hasSeparators    = true
    self.separators       = {}
    self.separators.color = white

    self.separators.title = {
        x1 = self.x,
        y1 = middleSection.separatorTitle_Y,
        x2 = self.x + self.width,
        y2 = middleSection.separatorTitle_Y
    }
    self.separators.data = {
        x1 = self.x,
        y1 = middleSection.separatorSweepers_Y ,
        x2 = self.x + self.width,
        y2 = middleSection.separatorSweepers_Y
    }
end

function SweepersCounter:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)

    love.graphics.setColor(self.color.font)
    love.graphics.printf(self.name, FontTiny, self.transform, self.limit, self.align)

    love.graphics.setColor(self.separators.color)
    love.graphics.line(self.separators.title.x1, self.separators.title.y1, self.separators.title.x2, self.separators.title.y2)
    love.graphics.line(self.separators.data.x1, self.separators.data.y1, self.separators.data.x2, self.separators.data.y2)
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