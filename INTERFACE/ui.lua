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
    
    self.topBar.menuButton:update()
    self.topBar.dashBoard.sweepersCounter:update()
    self.topBar.newGameButton:update()
    
    self.leftBar.zoom:update()
    self.leftBar.sweepMode:update()
    
    self.mapDisplay:update(self.leftBar.zoom.zoomPercentage)

    self:highlightElements()
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
    --self.topBar.dashBoard.minesCounter:highlight()
    --self.topBar.dashBoard.goldCounter:highlight()
    --self.topBar.dashBoard.sweepersCounter:highlight()
    self.topBar.title:highlight()
    self:highlight(self.topBar.newGameButton)

    self.leftBar.zoom:highlight()
    self.leftBar.flagMode:highlight()
    self.leftBar.sweepMode:highlight()
    
    self.menuScreen:highlight(self.menuScreen.mapMode.presets)
    self.menuScreen:highlight(self.menuScreen.mapMode.custom)

    self.menuScreen:highlight(self.menuScreen.presets.presetsSize.small)
    self.menuScreen:highlight(self.menuScreen.presets.presetsSize.medium)
    self.menuScreen:highlight(self.menuScreen.presets.presetsSize.big)
    self.menuScreen:highlight(self.menuScreen.presets.difficulty.easy)
    self.menuScreen:highlight(self.menuScreen.presets.difficulty.normal)
    self.menuScreen:highlight(self.menuScreen.presets.difficulty.hard)
    self.menuScreen:highlight(self.menuScreen.presets.gameMode.gold)
    self.menuScreen:highlight(self.menuScreen.presets.gameMode.classic)
end


function Ui:highlight(container)
    if isMouseOver(container) then 
        container.drawMode      = "fill"
        container.color.font    = black
        container.color.filling = white
    else
        container.drawMode      = "line"
        container.color.font    = white
    end
end


function Ui:onClick(button)
    self.topBar.menuButton:onClick()
    --self.topBar.dashBoard.minesCounter:onClick()
    --self.topBar.dashBoard.goldCounter:onClick()
    --self.topBar.dashBoard.sweepersCounter:onClick()
    self.topBar.newGameButton:onClick()
    --self.topBar.title:onClick()

    --self.leftBar.zoom:onClick()
    self.leftBar.flagMode:onClick()
    self.leftBar.sweepMode:onClick()

    self.menuScreen:onClick(button)
end