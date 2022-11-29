GameMode = Object:extend()

function GameMode:new(menuScreen)
    self.gold = {}
        self.gold.x        = menuScreen.x
        self.gold.y        = menuScreen.containers.y.gameMode
        self.gold.width    = menuScreen.width /2
        self.gold.height   = menuScreen.containers.height.gameMode
        self.gold.drawMode = "line"
        self.gold.color    = {filling = white, font = white}
        self.gold.textData = centerText("GOLD", FontHuge, self.gold)

    self.classic = {}
        self.classic.x        = self.gold.x + self.gold.width
        self.classic.y        = self.gold.y
        self.classic.width    = self.gold.width
        self.classic.height   = self.gold.height
        self.classic.drawMode = "line"
        self.classic.color    = {filling = white, font = white}
        self.classic.textData = centerText("CLASSIC", FontHuge, self.classic)
end


function GameMode:draw()
    love.graphics.setColor(self.gold.color.filling)
    love.graphics.rectangle(self.gold.drawMode, self.gold.x, 
                            self.gold.y, self.gold.width, self.gold.height)
    
    love.graphics.setColor(self.gold.color.font)
    love.graphics.printf(self.gold.textData.text, self.gold.textData.font, self.gold.textData.transform, 
                         self.gold.textData.limit, self.gold.textData.align)
    
    love.graphics.setColor(self.classic.color.filling)
    love.graphics.rectangle(self.classic.drawMode, self.classic.x, 
                            self.classic.y, self.classic.width, self.classic.height)

    love.graphics.setColor(self.classic.color.font)
    love.graphics.printf(self.classic.textData.text, self.classic.textData.font, self.classic.textData.transform, 
                         self.classic.textData.limit, self.classic.textData.align)

    love.graphics.setColor(white)
end 