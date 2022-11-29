CustomSize = Object:extend()

function CustomSize:new(menuScreen)
    self.rows = {}
        self.rows.x        = menuScreen.x
        self.rows.y        = menuScreen.containers.y.mapSize
        self.rows.width    = menuScreen.width /2
        self.rows.height   = menuScreen.containers.height.mapSize
        self.rows.drawMode = "line"
        self.rows.color    = {filling = white, font = white}
        self.rows.textData = centerText("ROWS", FontBig, self.rows)

    self.columns = {}
        self.columns.x        = self.rows.x + self.rows.width
        self.columns.y        = menuScreen.containers.y.mapSize
        self.columns.width    = menuScreen.width /2
        self.columns.height   = menuScreen.containers.height.mapSize
        self.columns.drawMode = "line"
        self.columns.color    = {filling = white, font = white}
        self.columns.textData = centerText("COLUMNS", FontBig, self.columns)

end


function CustomSize:draw()
    love.graphics.setColor(self.rows.color.filling)
    love.graphics.rectangle(
        self.rows.drawMode, 
        self.rows.x, 
        self.rows.y, 
        self.rows.width, 
        self.rows.height
    )
    
    love.graphics.setColor(self.rows.color.font)
    love.graphics.printf(
        self.rows.textData.text, 
        self.rows.textData.font, 
        self.rows.textData.transform,      
        self.rows.textData.limit, 
        self.rows.textData.align
    )
end 

