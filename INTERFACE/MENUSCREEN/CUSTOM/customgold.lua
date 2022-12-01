CustomGold = Object:extend()

function CustomGold:new(menuScreen)
        self.x        = menuScreen.x
        self.y        = menuScreen.containers.y.gold
        self.width    = menuScreen.width
        self.height   = menuScreen.containers.height.customGauges
        self.drawMode = "line"
        self.textData = centerText("GOLD", FontBig, self)
        self.gauge    = menuScreen.containers.gauge
        self.number   = 9
end

