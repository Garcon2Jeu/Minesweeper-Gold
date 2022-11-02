require "/INTERFACE/TOPBAR/MIDDLESECTION/minescounter"
require "/INTERFACE/TOPBAR/MIDDLESECTION/goldcounter"
require "/INTERFACE/TOPBAR/MIDDLESECTION/sweeperscounter"


MiddleSection = Object:extend()

function MiddleSection:new(topBar)
    self.separatorTitle_Y    = topBar.y + getNumberFromPercentage(topBar.height, 30)
    self.separatorSweepers_Y = topBar.y + getNumberFromPercentage(topBar.height, 50)

    self.minesCounter = MinesCounter(topBar, self)
    self.goldCounter = GoldCounter(topBar, self)
    self.sweepersCounter = SweepersCounter(topBar, self)
end

function MiddleSection:draw(menuScreen)
    self.minesCounter:update()
end

function MiddleSection:draw()
    self.minesCounter:draw()
    self.goldCounter:draw()
    self.sweepersCounter:draw()
end