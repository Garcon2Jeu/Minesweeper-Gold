require "/INTERFACE/TOPBAR/menubutton"
require "/INTERFACE/TOPBAR/MIDDLESECTION/middlesection"
require "/INTERFACE/TOPBAR/newgamebutton"
require "/INTERFACE/TOPBAR/title"

TopBar = Object:extend()

function TopBar:new(windowBox)
    self.width  = self:processTopBarElementsWidths(windowBox)
    self.height = getNumberFromPercentage(windowBox.height, 8)
    self.x      = self:processTopBarElementsX(windowBox)
    self.y      = windowBox.y
    
    self.menuButton    = MenuButton(self)
    self.middleSection = MiddleSection(self)
    self.title         = Title(self)
    self.newGameButton = NewGameButton(self)
end


function TopBar:draw(menuScreen)
    self.menuButton:draw()

    if gamePlay.start 
    or gamePlay.paused then
        self.title:draw()
    else
        self.middleSection:draw()
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

    return x
end
