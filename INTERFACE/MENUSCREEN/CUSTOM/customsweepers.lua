CustomSweepers = Object:extend()

function CustomSweepers:new(menuScreen)
    self.color = {filling = white, font = white}

    self.perSquares = {}
        self.perSquares.x        = menuScreen.x
        self.perSquares.y        = menuScreen.containers.y.perSquares
        self.perSquares.width    = menuScreen.width
        self.perSquares.height   = menuScreen.containers.height.customGauges
        self.perSquares.drawMode = "line"
        self.perSquares.textData = centerText("SWEEPERS PER SQUARES", FontBig, self.perSquares)
        self.perSquares.gauge    = menuScreen.containers.gauge
        self.perSquares.number   = 9

    self.bonus = {}
        self.bonus.x        = menuScreen.x
        self.bonus.y        = menuScreen.containers.y.bonus
        self.bonus.width    = menuScreen.width
        self.bonus.height   = menuScreen.containers.height.customGauges
        self.bonus.drawMode = "line"
        self.bonus.textData = centerText("BONUS SWEEPERS", FontBig, self.bonus)
        self.bonus.gauge    = menuScreen.containers.gauge
        self.bonus.number   = 9
end

