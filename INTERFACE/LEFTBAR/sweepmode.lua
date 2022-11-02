SweepMode = Object:extend()

function SweepMode:new(leftBar)
    self.x        = leftBar.x
    self.y        = leftBar.y.sweepMode
    self.width    = leftBar.width
    self.height   = leftBar.height.sweepMode
    self.drawMode = "line"
    self.color     = {filling = white, font = white}

    self.name      = {"SWEEP", "MODE"}
    self.transform = {love.math.newTransform(self.x , self.y + (self.height /4) -5), 
                      love.math.newTransform(self.x , self.y + (self.height /4) +15)}
    self.limit     = self.width
    self.align     = "center"

    self.counter = {
        left = 0, 
        transform = love.math.newTransform(self.x, self.y + (self.height /2 +10)),
        limit     = self.width,
        align     = "center",
    }
end

function SweepMode:update()
    self.counter.left = gamePlay.sweepers.inventory.current

    self:highlight()
end


function SweepMode:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)

    love.graphics.setColor(self.color.font)
    love.graphics.printf(self.name[1], FontMedium, self.transform[1], self.limit, self.align)
    love.graphics.printf(self.name[2], FontBig, self.transform[2], self.limit, self.align)
    love.graphics.printf("(" ..self.counter.left .." left)", FontTiny, self.counter.transform, self.counter.limit, self.counter.align)
    love.graphics.setColor(white)
end


function SweepMode:onClick()
    if isMouseOver(self) then
        gamePlay.sweepers:toggle()
    end
end


function SweepMode:highlight()
    if isMouseOver(self) then
        self.drawMode      = "fill"
        self.color.font    = purple
        self.color.filling = white

        if gamePlay.sweepers.activated then
            self.color.font    = white
            self.color.filling = purple
        else
            self.color.font    = purple
            self.color.filling = white
        end
    else
        self.drawMode      = "line"
        self.color.font    = white
        self.color.filling = white
        
        if gamePlay.sweepers.activated then
            self.drawMode      = "fill"
            self.color.font    = white
            self.color.filling = purple
        end
    end
end