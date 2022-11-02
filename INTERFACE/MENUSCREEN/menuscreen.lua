require "/INTERFACE/MENUSCREEN/presetscustom"
require "/INTERFACE/MENUSCREEN/mapsize"
require "/INTERFACE/MENUSCREEN/difficulty"
require "/INTERFACE/MENUSCREEN/gamemode"

MenuScreen = Object:extend()

function MenuScreen:new(windowBox, topBar)
    self.x      = windowBox.x
    self.y      = topBar.menuButton.y + topBar.menuButton.height
    self.width  = windowBox.width
    self.height = windowBox.height - topBar.height
    self.center = {x = self.width /2, y = self.height /2}
    self.canvas = love.graphics.newCanvas(self.width, self.height)

    self.containers = {}
        self.containers.width  = self.width
        self.containers.height = self:processContainersHeight()
        self.containers.x      = self.x
        self.containers.y      = self:processContainersY()

    self.presetsCustom = PresetsCustom(self)
    self.mapSize       = MapSize(self)
    self.difficulty    = Difficulty(self)
    self.gameMode      = GameMode(self)
end

function MenuScreen:draw(gamePlay, map)
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()

        --self:drawCenterLines()

        self.presetsCustom:draw()
        self.mapSize:draw()
        self.difficulty:draw()
        self.gameMode:draw()
        
    love.graphics.setCanvas()
    love.graphics.draw(self.canvas, self.x, self.y)
end




function MenuScreen:processContainersHeight()
    local height = {}
        height.presetsCustom = getNumberFromPercentage(self.height, 35)
        height.mapSize       = getNumberFromPercentage(self.height, 20)
        height.difficulty    = getNumberFromPercentage(self.height, 20)
        height.gameMode      = getNumberFromPercentage(self.height, 25)
    
    return height
end

function MenuScreen:processContainersY()
    local y = {}
    y.presetsCustom = 0
        y.mapSize       = y.presetsCustom + self.containers.height.presetsCustom
        y.difficulty    = y.mapSize + self.containers.height.mapSize
        y.gameMode      = y.difficulty + self.containers.height.difficulty
    
    return y
end


function MenuScreen:toggle()
    if gamePlay.paused then
        gamePlay.paused = false
    else
        gamePlay.paused = true
    end
end


function MenuScreen:highlight(container)
    if isMouseOverMenuScreen(container) then
        container.drawMode      = "fill"
        container.color.font    = black
        container.color.filling = white
    else
        container.drawMode      = "line"
        container.color.font    = white
    end
end



function MenuScreen:drawCenterLines()
    love.graphics.setColor(blue)
    love.graphics.line(self.center.x, 0, self.center.x, self.height)
    love.graphics.line(0, self.center.y, self.width, self.center.y)
end