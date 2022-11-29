require "/INTERFACE/MENUSCREEN/mapmode"
require "/INTERFACE/MENUSCREEN/PRESETS/presets"
require "/INTERFACE/MENUSCREEN/CUSTOM/custom"


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

    self.mapMode = MapMode(self)
    self.presets = Presets(self)
    self.custom  = Custom(self)
end


function MenuScreen:draw(gamePlay, map)
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()

        --self:drawCenterLines()

        self.mapMode:draw()

        if seed.mapMode == "presets" then
            self.presets:draw()
        elseif seed.mapMode == "custom" then
            self.custom:draw()
        end
        
    love.graphics.setCanvas()
    love.graphics.draw(self.canvas, self.x, self.y)
end




function MenuScreen:processContainersHeight()
    local height = {}
        height.mapMode    = getNumberFromPercentage(self.height, 35)
        height.presetsSize    = getNumberFromPercentage(self.height, 20)
        height.difficulty = getNumberFromPercentage(self.height, 20)
        height.gameMode   = getNumberFromPercentage(self.height, 25)
    
    return height
end

function MenuScreen:processContainersY()
    local y = {}
        y.mapMode    = 0
        y.presetsSize    = y.mapMode + self.containers.height.mapMode
        y.difficulty = y.presetsSize + self.containers.height.presetsSize
        y.gameMode   = y.difficulty + self.containers.height.difficulty
    
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

    self:select()
end


function MenuScreen:select()
    if seed.mapMode == "presets" then
        self.mapMode.presets.color.font = purple
    end

    if seed.mapMode == "custom" then
        self.mapMode.custom.color.font = purple
    end


    if seed.presetsSize == "small" then
        self.presets.presetsSize.small.color.font = purple
    end

    if seed.presetsSize == "medium" then
        self.presets.presetsSize.medium.color.font = purple
    end

    if seed.presetsSize == "big" then
        self.presets.presetsSize.big.color.font = purple
    end


    if seed.difficulty == "easy" then
        self.presets.difficulty.easy.color.font = purple
    end

    if seed.difficulty == "normal" then
        self.presets.difficulty.normal.color.font = purple
    end

    if seed.difficulty == "hard" then
        self.presets.difficulty.hard.color.font = purple
    end


    if seed.gameMode == "gold" then
        self.presets.gameMode.gold.color.font = purple
    end

    if seed.gameMode == "classic" then
        self.presets.gameMode.classic.color.font = purple
    end
end


function MenuScreen:onClick(button)
    if not gamePlay.paused 
    or button ~= 1 then
        return
    end

    if isMouseOverMenuScreen(self.mapMode.presets) then
        seed.mapMode = "presets"
    end

    if isMouseOverMenuScreen(self.mapMode.custom) then
        seed.mapMode = "custom"
    end


    if isMouseOverMenuScreen(self.presets.presetsSize.small) then
        seed.presetsSize = "small"
    end

    if isMouseOverMenuScreen(self.presets.presetsSize.medium) then
        seed.presetsSize = "medium"
    end

    if isMouseOverMenuScreen(self.presets.presetsSize.big) then
        seed.presetsSize = "big"
    end


    if isMouseOverMenuScreen(self.presets.difficulty.easy) then
        seed.difficulty = "easy"
    end

    if isMouseOverMenuScreen(self.presets.difficulty.normal) then
        seed.difficulty = "normal"
    end

    if isMouseOverMenuScreen(self.presets.difficulty.hard) then
        seed.difficulty = "hard"
    end


    if isMouseOverMenuScreen(self.presets.gameMode.gold) then
        seed.gameMode = "gold"
    end

    if isMouseOverMenuScreen(self.presets.gameMode.classic) then
        seed.gameMode = "classic"
    end
end





function MenuScreen:drawCenterLines()
    love.graphics.setColor(purple)
    love.graphics.line(self.center.x, 0, self.center.x, self.height)
    love.graphics.line(0, self.center.y, self.width, self.center.y)
end