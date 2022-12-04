CustomMines = Object:extend()

function CustomMines:new(menuScreen)
    self.x        = menuScreen.x
    self.y        = menuScreen.containers.y.mines
    self.width    = menuScreen.width
    self.height   = menuScreen.containers.height.customGauges
    self.drawMode = "line"
    self.textData = centerText("MINES", FontBig, self)

    self.gauge = {}
        self.gauge.min        = 1
        self.gauge.number     = 1
        self.gauge.increments = {}
end