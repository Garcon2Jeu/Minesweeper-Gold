

GoldCounter = Object:extend()

function GoldCounter:new(topBar, middleSection)
    self.x      = topBar.x.goldCounter
    self.y      = topBar.y
    self.width  = topBar.width.goldCounter
    self.height = topBar.height
    self.drawMode = "line"

    self.name      = "GOLD"
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
        y1 = self.y + self.height,
        x2 = self.x + self.width,
        y2 = self.separators.title.y2,
    }

    self.counter = {
        current = 0, 
        total   = map.gold,
        currentTransform = love.math.newTransform(self.x +15 , self.y +32),
        totalTransform = love.math.newTransform(self.x -10 , self.y +55),
        limit     = self.width,
        currentAlign     = "left",
        totalAlign     = "right",
    }
end

function GoldCounter:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)

    love.graphics.setColor(self.color.font)
    love.graphics.printf(self.name, FontTiny, self.transform, self.limit, self.align)
    love.graphics.printf(self.counter.current, FontTiny, self.counter.currentTransform, self.counter.limit, self.counter.currentAlign)
    love.graphics.printf(self.counter.total, FontTiny, self.counter.totalTransform, self.counter.limit, self.counter.totalAlign)

    love.graphics.setColor(self.separators.color)
    love.graphics.line(self.separators.title.x1, self.separators.title.y1, self.separators.title.x2, self.separators.title.y2)
    love.graphics.line(self.separators.data.x1, self.separators.data.y1, self.separators.data.x2, self.separators.data.y2)
end


function GoldCounter:highlight()
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