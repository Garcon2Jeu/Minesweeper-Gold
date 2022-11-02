Difficulty = Object:extend()

function Difficulty:new(menuScreen)
    self.easy = {}
        self.easy.x        = menuScreen.x
        self.easy.y        = menuScreen.containers.y.difficulty
        self.easy.width    = menuScreen.width /3
        self.easy.height   = menuScreen.containers.height.difficulty
        self.easy.drawMode = "line"
        self.easy.color    = {filling = white, font = white}
        self.easy.textData = centerText("EASY", FontBig, self.easy)

    self.normal = {}
        self.normal.x        = self.easy.x + self.easy.width
        self.normal.y        = self.easy.y
        self.normal.width    = self.easy.width
        self.normal.height   = self.easy.height
        self.normal.drawMode = "line"
        self.normal.color    = {filling = white, font = white}
        self.normal.textData = centerText("NORMAL", FontBig, self.normal)

    self.hard = {}
        self.hard.x        = self.normal.x + self.normal.width
        self.hard.y        = self.easy.y
        self.hard.width    = self.easy.width
        self.hard.height   = self.easy.height
        self.hard.drawMode = "line"
        self.hard.color    = {filling = white, font = white}
        self.hard.textData = centerText("HARD", FontBig, self.hard)
end


function Difficulty:draw()
    love.graphics.setColor(self.easy.color.filling)
    love.graphics.rectangle(self.easy.drawMode, self.easy.x, 
                            self.easy.y, self.easy.width, self.easy.height)
    
    love.graphics.setColor(self.easy.color.font)
    love.graphics.printf(self.easy.textData.text, self.easy.textData.font, self.easy.textData.transform, 
                         self.easy.textData.limit, self.easy.textData.align)

    
    love.graphics.setColor(self.normal.color.filling)
    love.graphics.rectangle(self.normal.drawMode, self.normal.x, 
                            self.normal.y, self.normal.width, self.normal.height)

    love.graphics.setColor(self.normal.color.font)
    love.graphics.printf(self.normal.textData.text, self.normal.textData.font, self.normal.textData.transform, 
                         self.normal.textData.limit, self.normal.textData.align)
                         
    
    love.graphics.setColor(self.hard.color.filling)
    love.graphics.rectangle(self.hard.drawMode, self.hard.x, 
                            self.hard.y, self.hard.width, self.hard.height)
    
    love.graphics.setColor(self.hard.color.font)
    love.graphics.printf(self.hard.textData.text, self.hard.textData.font, self.hard.textData.transform, 
                        self.hard.textData.limit, self.hard.textData.align)
end 