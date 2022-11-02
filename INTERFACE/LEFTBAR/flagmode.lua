FlagMode = Object:extend()

function FlagMode:new(leftBar)
    self.x         = leftBar.x
    self.y         = leftBar.y.flagMode
    self.width     = leftBar.width
    self.height    = leftBar.height.flagMode
    self.drawMode  = "line"
    self.color     = {filling = white, font = white}
    self.activated = false

    self.name      = "FLAG MODE"
    self.transform = love.math.newTransform(self.x , self.y + (self.height /4))
    self.limit     = self.width
    self.align     = "center"

    self.counter = {
        left = 0, 
        transform = love.math.newTransform(self.x, self.y + (self.height /2 + 25)),
        limit     = self.width,
        align     = "center",
    }
end

function FlagMode:onClick()
    if isMouseOver(self) then
        self:toggle()
    end
end

function FlagMode:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
    
    love.graphics.setColor(self.color.font)
    love.graphics.printf(self.name, FontBig, self.transform, self.limit, self.align)
    love.graphics.printf("(" ..self.counter.left .." left)", FontTiny, self.counter.transform, self.counter.limit, self.counter.align)
end


function FlagMode:toggle()
    if gamePlay.play then
        if self.activated then
            self.activated = false
        else
            self.activated = true
        end
    end
end


function FlagMode:highlight()
    if isMouseOver(self) then
        self.drawMode      = "fill"
        self.color.font    = red
        self.color.filling = white

        if self.activated then
            self.color.font    = white
            self.color.filling = red
        else
            self.color.font    = red
            self.color.filling = white
        end
    else
        self.drawMode      = "line"
        self.color.font    = white
        self.color.filling = white
        
        if self.activated then
            self.drawMode      = "fill"
            self.color.font    = white
            self.color.filling = red
        end
    end



    

end
