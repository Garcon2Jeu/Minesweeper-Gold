require "/INTERFACE/windowbox"
require "/INTERFACE/TOPBAR/topbar"
require "/INTERFACE/LEFTBAR/leftbar"
require "/INTERFACE/mapdisplay"
require "/INTERFACE/MENUSCREEN/menuscreen"

Ui = Object:extend()

function Ui:new()
    self.windowBox = WindowBox()
    self.topBar     = TopBar(self.windowBox)
    self.leftBar    = LeftBar(self.windowBox, self.topBar)
    self.mapDisplay = MapDisplay(self.windowBox, self.topBar, self.leftBar)
    self.menuScreen = MenuScreen(self.windowBox, self.topBar)
end


function Ui:update()
    self:highlightElements()

    self.topBar.menuButton:update()
    self.topBar.newGameButton:update()

    self.leftBar.zoom:update()
    self.leftBar.sweepMode:update()

    self.mapDisplay:update(self.leftBar.zoom.zoomPercentage)
end


function Ui:draw(gamePlay, map)
    self.windowBox:draw()
    self.topBar:draw(self.menuScreen)

    if gamePlay.paused then
        self.menuScreen:draw()
    else
        self.leftBar:draw()
        self.mapDisplay:draw(gamePlay, map)
    end

end





function Ui:highlightElements()
    self:highlight(self.topBar.menuButton)
    self.topBar.middleSection.minesCounter:highlight()
    self.topBar.middleSection.goldCounter:highlight()
    self.topBar.middleSection.sweepersCounter:highlight()
    self.topBar.title:highlight()
    self:highlight(self.topBar.newGameButton)

    self.leftBar.zoom:highlight()
    self.leftBar.flagMode:highlight()
    self.leftBar.sweepMode:highlight()
    
    self.menuScreen:highlight(self.menuScreen.presetsCustom.presets)
    self.menuScreen:highlight(self.menuScreen.presetsCustom.custom)
    self.menuScreen:highlight(self.menuScreen.mapSize.small)
    self.menuScreen:highlight(self.menuScreen.mapSize.medium)
    self.menuScreen:highlight(self.menuScreen.mapSize.big)
    self.menuScreen:highlight(self.menuScreen.difficulty.easy)
    self.menuScreen:highlight(self.menuScreen.difficulty.normal)
    self.menuScreen:highlight(self.menuScreen.difficulty.hard)
    self.menuScreen:highlight(self.menuScreen.gameMode.gold)
    self.menuScreen:highlight(self.menuScreen.gameMode.classic)
end


function Ui:highlight(element)
    if isMouseOver(element) then 
        element.drawMode      = "fill"
        element.color.font    = black
        element.color.filling = white
    else
        element.drawMode      = "line"
        element.color.font    = white
    end
end


function Ui:onClick()
    self.topBar.menuButton:onClick()
    --self.topBar.middleSection.minesCounter:onClick()
    --self.topBar.middleSection.goldCounter:onClick()
    --self.topBar.middleSection.sweepersCounter:onClick()
    self.topBar.newGameButton:onClick()
    --self.topBar.title:onClick()

    --self.leftBar.zoom:onClick()
    self.leftBar.flagMode:onClick()
    self.leftBar.sweepMode:onClick()
end