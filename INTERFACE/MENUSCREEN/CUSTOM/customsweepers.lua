CustomSweepers = Object:extend()

function CustomSweepers:new(menuScreen)
    self.x        = menuScreen.x
    self.y        = menuScreen.containers.y.bonus
    self.width    = menuScreen.width
    self.height   = menuScreen.containers.height.customGauges
    self.drawMode = "line"
    self.textData = centerText("BONUS SWEEPERS", FontBig, self)

    self.gauge = {}
    self.gauge.width      = menuScreen.containers.gauge
    self.gauge.min        = 1
    self.gauge.max        = 100
    self.gauge.number     = 1
    self.gauge.increments = {}
        self.gauge.increments.total = self.gauge.max - self.gauge.min +1
        self.gauge.increments.width = self.width / self.gauge.increments.total
end

