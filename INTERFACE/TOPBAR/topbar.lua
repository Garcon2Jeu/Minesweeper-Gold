require "/INTERFACE/TOPBAR/menubutton"
require "/INTERFACE/TOPBAR/DASHBOARD/dashboard"
require "/INTERFACE/TOPBAR/title"
require "/INTERFACE/TOPBAR/scoreboard"
require "/INTERFACE/TOPBAR/newgamebutton"

TopBar = Object:extend()

function TopBar:new(windowBox)
    self.width  = self:processTopBarElementsWidths(windowBox)
    self.height = getNumberFromPercentage(windowBox.height, 8)
    self.x      = self:processTopBarElementsX(windowBox)
    self.y      = windowBox.y
    
    self.menuButton    = MenuButton(self)
    self.title         = Title(self)
    self.dashBoard     = DashBoard(self)
    self.scoreBoard    = ScoreBoard(self)
    self.newGameButton = NewGameButton(self)
end


function TopBar:draw(menuScreen)
    self.menuButton:draw()

    if gamePlay.start 
    or gamePlay.paused then
        self.title:draw()
    elseif gamePlay.over then 
        self.scoreBoard:draw()
    else
        self.dashBoard:draw()
    end

    self.newGameButton:draw()
end





function TopBar:processTopBarElementsWidths(windowBox)
    local width = {}

    width.menuButton      = getNumberFromPercentage(windowBox.width, 10)
    width.minesCounter    = getNumberFromPercentage(windowBox.width, 10)
    width.goldCounter     = getNumberFromPercentage(windowBox.width, 10)
    width.sweepersCounter = getNumberFromPercentage(windowBox.width, 60)
    width.newGameButton   = getNumberFromPercentage(windowBox.width, 10)
    width.title           = getNumberFromPercentage(windowBox.width, 80)
    width.scoreBoard      = getNumberFromPercentage(windowBox.width, 80)

    return width
end

function TopBar:processTopBarElementsX(windowBox)
    local x = {}

    x.menuButton      = windowBox.x
    x.minesCounter    = x.menuButton + self.width.menuButton
    x.goldCounter     = x.minesCounter + self.width.minesCounter
    x.sweepersCounter = x.goldCounter + self.width.goldCounter
    x.newGameButton   = x.sweepersCounter + self.width.sweepersCounter
    x.title           = x.menuButton + self.width.menuButton
    x.scoreBoard      = x.menuButton + self.width.menuButton

    return x
end
