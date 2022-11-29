CustomSweepers = Object:extend()

function CustomSweepers:new(menuScreen)
    self.color = {filling = white, font = white}

    self.sweepers = {}
        self.sweepers.x        = menuScreen.x
        self.sweepers.y        = menuScreen.containers.y.sweepers
        self.sweepers.width    = menuScreen.width
        self.sweepers.height   = menuScreen.containers.height.customGauges
        self.sweepers.drawMode = "line"
        self.sweepers.textData = centerText("SWEEPERS", FontBig, self.sweepers)

    self.perSquares = {}
        self.perSquares.x        = menuScreen.x
        self.perSquares.y        = menuScreen.containers.y.perSquares
        self.perSquares.width    = menuScreen.width
        self.perSquares.height   = menuScreen.containers.height.customGauges
        self.perSquares.drawMode = "line"
        self.perSquares.textData = centerText("SWEEPERS PER SQUARES", FontBig, self.perSquares)
end


function CustomSweepers:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(
        self.sweepers.drawMode, 
        self.sweepers.x, 
        self.sweepers.y, 
        self.sweepers.width, 
        self.sweepers.height
    )
    love.graphics.rectangle(
        self.perSquares.drawMode, 
        self.perSquares.x, 
        self.perSquares.y, 
        self.perSquares.width, 
        self.perSquares.height
    )
    
    
    love.graphics.setColor(self.color.font)
    love.graphics.printf(
        self.sweepers.textData.text, 
        self.sweepers.textData.font, 
        self.sweepers.textData.transform,      
        self.sweepers.textData.limit, 
        self.sweepers.textData.align
    )

    love.graphics.printf(
        self.perSquares.textData.text, 
        self.perSquares.textData.font, 
        self.perSquares.textData.transform,      
        self.perSquares.textData.limit, 
        self.perSquares.textData.align
    )
end 

