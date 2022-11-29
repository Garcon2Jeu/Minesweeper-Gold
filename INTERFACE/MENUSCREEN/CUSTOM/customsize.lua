CustomSize = Object:extend()

function CustomSize:new(menuScreen)
    self.color = {filling = white, font = white}

    self.rows = {}
        self.rows.x        = menuScreen.x
        self.rows.y        = menuScreen.containers.y.rows
        self.rows.width    = menuScreen.width
        self.rows.height   = menuScreen.containers.height.customGauges
        self.rows.drawMode = "line"
        self.rows.textData = centerText("ROWS", FontBig, self.rows)

    self.columns = {}
        self.columns.x        = menuScreen.x
        self.columns.y        = menuScreen.containers.y.columns
        self.columns.width    = menuScreen.width
        self.columns.height   = menuScreen.containers.height.customGauges
        self.columns.drawMode = "line"
        self.columns.color    = {filling = white, font = white}
        self.columns.textData = centerText("COLUMNS", FontBig, self.columns)
end


function CustomSize:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(
        self.rows.drawMode, 
        self.rows.x, 
        self.rows.y, 
        self.rows.width, 
        self.rows.height
    )
    love.graphics.rectangle(
        self.columns.drawMode, 
        self.columns.x, 
        self.columns.y, 
        self.columns.width, 
        self.columns.height
    )
    
    
    love.graphics.setColor(self.color.font)
    love.graphics.printf(
        self.rows.textData.text, 
        self.rows.textData.font, 
        self.rows.textData.transform,      
        self.rows.textData.limit, 
        self.rows.textData.align
    )

    love.graphics.printf(
        self.columns.textData.text, 
        self.columns.textData.font, 
        self.columns.textData.transform,      
        self.columns.textData.limit, 
        self.columns.textData.align
    )
end 

