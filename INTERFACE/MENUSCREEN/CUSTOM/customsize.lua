CustomSize = Object:extend()

function CustomSize:new(menuScreen)
    self.rows = {}
        self.rows.x        = menuScreen.x
        self.rows.y        = menuScreen.containers.y.rows
        self.rows.width    = menuScreen.width
        self.rows.height   = menuScreen.containers.height.customGauges
        self.rows.drawMode = "line"
        self.rows.textData = centerText("ROWS", FontBig, self.rows)
        self.rows.gauge    = menuScreen.containers.gauge
        self.rows.number   = 9
        self.rows.increments    = self.rows.width /22

    self.columns = {}
        self.columns.x        = menuScreen.x
        self.columns.y        = menuScreen.containers.y.columns
        self.columns.width    = menuScreen.width
        self.columns.height   = menuScreen.containers.height.customGauges
        self.columns.drawMode = "line"
        self.columns.color    = {filling = white, font = white}
        self.columns.textData = centerText("COLUMNS", FontBig, self.columns)
        self.columns.gauge    = menuScreen.containers.gauge
        self.columns.number   = 9
        self.columns.increments    = self.columns.width /22
end

