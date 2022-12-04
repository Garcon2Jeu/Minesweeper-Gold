CustomGold = Object:extend()

function CustomGold:new(menuScreen)
    self.x        = menuScreen.x
    self.y        = menuScreen.containers.y.gold
    self.width    = menuScreen.width
    self.height   = menuScreen.containers.height.customGauges
    self.drawMode = "line"
    self.textData = centerText("GOLD", FontBig, self)

    self.gauge = {}
        self.gauge.min        = 1
        self.gauge.number     = 1
        self.gauge.increments = {}
end