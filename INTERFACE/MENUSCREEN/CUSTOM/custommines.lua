CustomMines = Object:extend()

function CustomMines:new(menuScreen, size)
        self.x        = menuScreen.x
        self.y        = menuScreen.containers.y.mines
        self.width    = menuScreen.width
        self.height   = menuScreen.containers.height.customGauges
        self.drawMode = "line"
        self.textData = centerText("MINES", FontBig, self)
        self.gauge    = menuScreen.containers.gauge
        self.number   = 1
end

function CustomMines:update(size)
    self.increments = size.rows.number * size.columns.number -1
end


