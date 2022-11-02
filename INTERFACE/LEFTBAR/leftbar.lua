require "/INTERFACE/LEFTBAR/zoom"
require "/INTERFACE/LEFTBAR/flagmode"
require "/INTERFACE/LEFTBAR/sweepmode"

LeftBar = Object:extend()


function LeftBar:new(windowBox, topBar)
    self.width  = topBar.menuButton.width
    self.height = self:processLeftBarElementsHeights(windowBox, topBar)
    self.x      = topBar.menuButton.x
    self.y      = self:processLeftBarElementsY(topBar)

    self.zoom      = Zoom(self)
    self.flagMode  = FlagMode(self)
    self.sweepMode = SweepMode(self)
end


function LeftBar:draw()
    self.zoom:draw()
    self.flagMode:draw()
    self.sweepMode:draw()
end





function LeftBar:processLeftBarElementsHeights(windowBox, topBar)
    local height = {}
        height.leftBar   = windowBox.height - topBar.menuButton.height
        height.zoom      = getNumberFromPercentage(height.leftBar, 60)
        height.flagMode  = getNumberFromPercentage(height.leftBar, 20)
        height.sweepMode = getNumberFromPercentage(height.leftBar, 20)

    return height
end

function LeftBar:processLeftBarElementsY(topBar)
    local y = {}  
        y.leftBar    = topBar.menuButton.y + topBar.menuButton.height
        y.zoom       = y.leftBar
        y.flagMode   = y.zoom + self.height.zoom
        y.sweepMode  = y.flagMode + self.height.flagMode

    return y
end