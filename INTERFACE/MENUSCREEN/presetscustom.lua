PresetsCustom = Object:extend()

function PresetsCustom:new(menuScreen)
    self.presets = {}
        self.presets.x        = menuScreen.x
        self.presets.y        = menuScreen.containers.y.presetsCustom
        self.presets.width    = menuScreen.width /2
        self.presets.height   = menuScreen.containers.height.presetsCustom
        self.presets.drawMode = "line"
        self.presets.color    = {filling = white, font = white}
        self.presets.textData = centerText("PRESETS", FontHuge, self.presets)

    self.custom = {}
        self.custom.x        = self.presets.x + self.presets.width
        self.custom.y        = self.presets.y
        self.custom.width    = self.presets.width
        self.custom.height   = self.presets.height
        self.custom.drawMode = "line"
        self.custom.color    = {filling = white, font = white}
        self.custom.textData = centerText("CUSTOM", FontHuge, self.custom)
end


function PresetsCustom:draw()
    love.graphics.setColor(self.presets.color.filling)
    love.graphics.rectangle(self.presets.drawMode, self.presets.x, 
                            self.presets.y, self.presets.width, self.presets.height)
    
    love.graphics.setColor(self.presets.color.font)
    love.graphics.printf(self.presets.textData.text, self.presets.textData.font, self.presets.textData.transform, 
                         self.presets.textData.limit, self.presets.textData.align)
    
    love.graphics.setColor(self.custom.color.filling)
    love.graphics.rectangle(self.custom.drawMode, self.custom.x, 
                            self.custom.y, self.custom.width, self.custom.height)

    love.graphics.setColor(self.custom.color.font)
    love.graphics.printf(self.custom.textData.text, self.custom.textData.font, self.custom.textData.transform, 
                         self.custom.textData.limit, self.custom.textData.align)
end 