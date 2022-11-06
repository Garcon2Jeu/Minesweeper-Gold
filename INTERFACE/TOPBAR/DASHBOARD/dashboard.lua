require "/INTERFACE/TOPBAR/DASHBOARD/minescounter"
require "/INTERFACE/TOPBAR/DASHBOARD/goldcounter"
require "/INTERFACE/TOPBAR/DASHBOARD/sweeperscounter"


DashBoard = Object:extend()

function DashBoard:new(topBar)
    self.minesCounter = MinesCounter(topBar, self)
    self.goldCounter = GoldCounter(topBar, self)
    self.sweepersCounter = SweepersCounter(topBar, self)
end

function DashBoard:draw(menuScreen)
    self.minesCounter:update()
end

function DashBoard:draw()
    self.minesCounter:draw()
    self.goldCounter:draw()
    self.sweepersCounter:draw()
end