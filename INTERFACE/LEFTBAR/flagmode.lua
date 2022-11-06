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
    self.transform = love.math.newTransform(self.x , self.y + (self.height /3))
    self.limit     = self.width
    self.align     = "center"
end

function FlagMode:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
    
    love.graphics.setColor(self.color.font)
    love.graphics.printf(self.name, FontBig, self.transform, self.limit, self.align)
end





function FlagMode:onClick()
    if isMouseOver(self) then
        self:toggle()
    end
end


function FlagMode:toggle()
    if gamePlay.sweepers.activated then
        gamePlay.sweepers.activated = false 
    end
    
    if gamePlay.play then
        if self.activated then
            self.activated = false
        else
            self.activated = true
        end
    end
end


function FlagMode:highlight()
    self.drawMode      = "line"
    self.color.font    = white
    self.color.filling = white
    
    if self.activated then
        self.drawMode      = "fill"
        self.color.font    = white
        self.color.filling = red
    end
    
    if not isMouseOver(self) then
        return
    end

    self.drawMode      = "fill"
    self.color.font    = red
    self.color.filling = white
    
    if self.activated then
        self.color.font    = white
        self.color.filling = red
    end
end
