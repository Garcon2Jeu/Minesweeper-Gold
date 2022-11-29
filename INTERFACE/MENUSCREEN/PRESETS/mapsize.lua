MapSize = Object:extend()

function MapSize:new(menuScreen)
    self.small = {}
        self.small.x        = menuScreen.x
        self.small.y        = menuScreen.containers.y.mapSize
        self.small.width    = menuScreen.width /3
        self.small.height   = menuScreen.containers.height.mapSize
        self.small.drawMode = "line"
        self.small.color    = {filling = white, font = white}
        self.small.textData = centerText("SMALL", FontBig, self.small)
        
    self.medium = {}
        self.medium.x        = self.small.x + self.small.width
        self.medium.y        = self.small.y
        self.medium.width    = self.small.width
        self.medium.height   = self.small.height
        self.medium.drawMode = "line"
        self.medium.color    = {filling = white, font = white}
        self.medium.textData = centerText("MEDIUM", FontBig, self.medium)
    
    self.big = {}
        self.big.x        = self.medium.x + self.medium.width
        self.big.y        = self.small.y
        self.big.width    = self.small.width
        self.big.height   = self.small.height
        self.big.drawMode = "line"
        self.big.color    = {filling = white, font = white}
        self.big.textData = centerText("BIG", FontBig, self.big)
end


function MapSize:draw()
    love.graphics.setColor(self.small.color.filling)
    love.graphics.rectangle(self.small.drawMode, self.small.x, 
                            self.small.y, self.small.width, self.small.height)
    
    love.graphics.setColor(self.small.color.font)
    love.graphics.printf(self.small.textData.text, self.small.textData.font, self.small.textData.transform, 
                         self.small.textData.limit, self.small.textData.align)

    
    love.graphics.setColor(self.medium.color.filling)
    love.graphics.rectangle(self.medium.drawMode, self.medium.x, 
                            self.medium.y, self.medium.width, self.medium.height)

    love.graphics.setColor(self.medium.color.font)
    love.graphics.printf(self.medium.textData.text, self.medium.textData.font, self.medium.textData.transform, 
                         self.medium.textData.limit, self.medium.textData.align)
                         
    
    love.graphics.setColor(self.big.color.filling)
    love.graphics.rectangle(self.big.drawMode, self.big.x, 
                            self.big.y, self.big.width, self.big.height)
    
    love.graphics.setColor(self.big.color.font)
    love.graphics.printf(self.big.textData.text, self.big.textData.font, self.big.textData.transform, 
                        self.big.textData.limit, self.big.textData.align)
end 