CustomMines = Object:extend()

function CustomMines:new(menuScreen)
        self.x        = menuScreen.x
        self.y        = menuScreen.containers.y.mines
        self.width    = menuScreen.width
        self.height   = menuScreen.containers.height.customGauges
        self.drawMode = "line"
        self.color    = {filling = white, font = white}
        self.textData = centerText("MINES", FontBig, self)
end


function CustomMines:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(
        self.drawMode, 
        self.x, 
        self.y, 
        self.width, 
        self.height
    )
    
    
    love.graphics.setColor(self.color.font)
    love.graphics.printf(
        self.textData.text, 
        self.textData.font, 
        self.textData.transform,      
        self.textData.limit, 
        self.textData.align
    )
end 

