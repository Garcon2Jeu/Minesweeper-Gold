Zoom = Object:extend()

function Zoom:new(leftBar)
    self.x              = leftBar.x
    self.y              = leftBar.y.zoom
    self.width          = leftBar.width
    self.height         = leftBar.height.zoom
    self.drawMode       = "line"
    self.text           = "ZOOM"
    self.color          = {filling = white, gauge = white}
    self.zoomPercentage = 0

    self.gauge = {
        x1 = self.x + self.width /2,
        y1 = getNumberFromPercentage(self.y + self.height, 20),
        x2 = self.x + self.width /2,
        y2 = getNumberFromPercentage(self.y + self.height, 90)
    }

    self.stopper1 = {
        x1 = self.gauge.x1 -5,
        y1 = self.gauge.y1,
        x2 = self.gauge.x1 +5,
        y2 = self.gauge.y1
    }

    self.stopper2 = {
        x1 = self.gauge.x2 -5,
        y1 = self.gauge.y2,
        x2 = self.gauge.x2 +5,
        y2 = self.gauge.y2
    }

    self.plusSymbol = {}
    self.plusSymbol.circle = {
        x        = self.gauge.x1,
        y        = self.gauge.y1 -20,
        radius   = 10,
        drawMode = "line"
    }
    self.plusSymbol.symbol = {
        character = "+",
        transform = love.math.newTransform(self.plusSymbol.circle.x -5, self.plusSymbol.circle.y -7),
        limit     = self.plusSymbol.circle.radius,
        align     = "center"
    }

    self.minusSymbol = {}
    self.minusSymbol.circle = {
        x        = self.gauge.x2,
        y        = self.gauge.y2 +20,
        radius   = 10,
        drawMode = "line"
    }
    self.minusSymbol.symbol = {
        character = "-",
        transform = love.math.newTransform(self.minusSymbol.circle.x -5, self.minusSymbol.circle.y -7),
        limit     = self.minusSymbol.circle.radius,
        align     = "center"
    }

    self.cursor = {
        x        = self.gauge.x2,
        y        = self.gauge.y2,
        radius   = 10,
        drawMode = "fill"
    }
end

function Zoom:update()
    self:drag()
    self.zoomPercentage = self:getZoomPercentage()
end

    

function Zoom:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
    
    love.graphics.setColor(self.color.gauge)
    love.graphics.line(self.gauge.x1, self.gauge.y1, self.gauge.x2, self.gauge.y2)
    love.graphics.line(self.stopper1.x1, self.stopper1.y1, self.stopper1.x2, self.stopper1.y2)
    love.graphics.line(self.stopper2.x1, self.stopper2.y1, self.stopper2.x2, self.stopper2.y2)

    love.graphics.circle(self.plusSymbol.circle.drawMode, self.plusSymbol.circle.x, self.plusSymbol.circle.y, self.plusSymbol.circle.radius)
    love.graphics.printf(self.plusSymbol.symbol.character, FontSmall, self.plusSymbol.symbol.transform,
                         self.plusSymbol.symbol.limit, self.plusSymbol.symbol.align)

    love.graphics.circle(self.minusSymbol.circle.drawMode, self.minusSymbol.circle.x,
                         self.minusSymbol.circle.y, self.minusSymbol.circle.radius)
    love.graphics.printf(self.minusSymbol.symbol.character, FontSmall, self.minusSymbol.symbol.transform, 
                         self.minusSymbol.symbol.limit, self.minusSymbol.symbol.align)

    love.graphics.circle(self.cursor.drawMode, self.cursor.x, self.cursor.y, self.cursor.radius)
end





function Zoom:drag()
    if isMouseOver(self) 
    and love.mouse.isDown(1) then
        mouse = getMousePosition()
        self.cursor.y = mouse.y
    end

    self:limitCursorPostition()
end


function Zoom:limitCursorPostition()
    if self.cursor.y < self.stopper1.y1 then
        self.cursor.y = self.stopper1.y1
    elseif self.cursor.y > self.stopper2.y2 then
        self.cursor.y = self.stopper2.y2
    end
end


function Zoom:getZoomPercentage()
    gaugeLenght    = self.gauge.y2 - self.gauge.y1
    cursorPosition = self.cursor.y - self.gauge.y1
    zoomPercentage = getPercentageFromNumber(gaugeLenght, cursorPosition)

    if zoomPercentage > 50 then
        zoomPercentage = 100 - zoomPercentage
    elseif zoomPercentage < 50 then
        zoomPercentage = 0 + (100 - zoomPercentage)
    end
    
    if zoomPercentage <= 0 then
        zoomPercentage = 0
    end

    return zoomPercentage
end


function Zoom:highlight()
    if isMouseOver(self) then 
        self.drawMode         = "fill"
        self.color.font       = black
        self.color.filling    = white
        self.color.gauge      = black
        self.cursor.drawMode  = "line"
    else
        self.drawMode         = "line"
        self.color.font       = white
        self.color.gauge      = white
        self.cursor.drawMode  = "fill"
    end
end