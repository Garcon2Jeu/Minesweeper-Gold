WindowBox = Object:extend()

function WindowBox:new()
    self.x        = 2
    self.y        = 2
    self.width    = WINDOW.width -2
    self.height   = WINDOW.height -10
    self.drawMode = "line"
end

function WindowBox:draw()
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
end