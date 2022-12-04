CustomSize = Object:extend()

function CustomSize:new(menuScreen)
    self.rows = {}
        self.rows.x          = menuScreen.x
        self.rows.y          = menuScreen.containers.y.rows
        self.rows.width      = menuScreen.width
        self.rows.height     = menuScreen.containers.height.customGauges
        self.rows.drawMode   = "line"
        self.rows.textData   = centerText("ROWS", FontBig, self.rows)

        self.rows.gauge = {}
            self.rows.gauge.width      = menuScreen.containers.gauge
            self.rows.gauge.min        = 9
            self.rows.gauge.max        = 30
            self.rows.gauge.number     = mapData.rows
            self.rows.gauge.increments = {}
                self.rows.gauge.increments.total = self.rows.gauge.max - self.rows.gauge.min +1
                self.rows.gauge.increments.width = self.rows.width / self.rows.gauge.increments.total
            
            

    self.columns = {}
        self.columns.x          = menuScreen.x
        self.columns.y          = menuScreen.containers.y.columns
        self.columns.width      = menuScreen.width
        self.columns.height     = menuScreen.containers.height.customGauges
        self.columns.drawMode   = "line"
        self.columns.color      = {filling = white, font = white}
        self.columns.textData   = centerText("COLUMNS", FontBig, self.columns)

        self.columns.gauge = {}
            self.columns.gauge.width      = menuScreen.containers.gauge
            self.columns.gauge.min        = 9
            self.columns.gauge.max        = 30
            self.columns.gauge.number     = mapData.columns
            self.columns.gauge.increments = {}
                self.columns.gauge.increments.total = self.columns.gauge.max - self.columns.gauge.min +1
                self.columns.gauge.increments.width = self.columns.width / self.columns.gauge.increments.total
end


function CustomSize:update()
end