ScoreBoard = Object:extend()

function ScoreBoard:new(topBar)
    self.x          = topBar.x.scoreBoard
    self.y          = topBar.y
    self.width      = topBar.width.scoreBoard
    self.height     = topBar.height
    self.drawMode   = "line"
    self.color      = {filling = white, font = white}
    self.textData   = centerText("SCOREBOARD", FontHuge, self)
    self.containers = self:processContainers()

    self.mines = {}
        self.mines.x       = self.containers.x.mines
        self.mines.y       = self.containers.y
        self.mines.width   = self.containers.width
        self.mines.height  = self.containers.height
        self.mines.title   = self:processTextData("MINES", self.mines, 1, "center")
        self.mines.flagged = self:processTextData(" Flagged: ", self.mines, 2, "left")
        self.mines.swept   = self:processTextData(" Swept: ", self.mines, 3, "left")
        self.mines.missed  = self:processTextData(" Missed: ", self.mines, 4, "left")

    self.gold = {}
        self.gold.x       = self.containers.x.gold
        self.gold.y       = self.containers.y
        self.gold.width   = self.containers.width
        self.gold.height  = self.containers.height
        self.gold.title   = self:processTextData("GOLD", self.gold, 1, "center")
        self.gold.swept   = self:processTextData(" Swept: ", self.gold, 2, "left")
        self.gold.missed  = self:processTextData(" Missed: ", self.gold, 3, "left")
   
    self.squares = {}
        self.squares.x       = self.containers.x.squares
        self.squares.y       = self.containers.y
        self.squares.width   = self.containers.width
        self.squares.height  = self.containers.height
        self.squares.title   = self:processTextData("SQUARES", self.squares, 1, "center")
        self.squares.cleared = self:processTextData(" Cleared: ", self.squares, 2, "left")
        self.squares.missed  = self:processTextData(" Missed: ", self.squares, 3, "left")

    self.final = {}
        self.final.x      = self.containers.x.final
        self.final.y      = self.containers.y
        self.final.width  = self.containers.width
        self.final.height = self.containers.height
        self.final.title  = self:processTextData("FINAL SCORE", self.final, 1, "center")
        self.final.time   = self:processTextData(" Time: ", self.final, 2, "left")
        self.final.explo  = self:processTextData(" Exploration: ", self.final, 3, "left")
        self.final.final  = self:processTextData(" Final: ", self.final, 4, "left")
end


function ScoreBoard:update(score)
    self.score = {}
    self.score.mines   = {flagged = score.mines.flagged, swept = score.mines.swept, missed = score.mines.missed}
    self.score.gold    = {swept = score.gold.swept, missed = score.gold.missed}
    self.score.squares = {cleared = score.squares.cleared, missed = score.squares.missed}
    self.score.explo   = score.exploration
    self.score.time    = score.time 
    self.score.final   = score.final 
end


function ScoreBoard:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
    love.graphics.rectangle(self.drawMode, self.containers.x.mines, self.containers.y,
                            self.containers.width, self.containers.height)
    love.graphics.rectangle(self.drawMode, self.containers.x.gold, self.containers.y,
                            self.containers.width, self.containers.height)
    love.graphics.rectangle(self.drawMode, self.containers.x.squares, self.containers.y,
                            self.containers.width, self.containers.height)
    love.graphics.rectangle(self.drawMode, self.containers.x.final, self.containers.y,
                            self.containers.width, self.containers.height)


    love.graphics.setColor(self.color.font)
    love.graphics.printf(
        self.mines.title.text,
        self.mines.title.font,
        self.mines.title.transform,
        self.mines.title.limit,
        self.mines.title.align
    )
    love.graphics.printf(
        self.mines.flagged.text ..self.score.mines.flagged,
        self.mines.flagged.font,
        self.mines.flagged.transform,
        self.mines.flagged.limit,
        self.mines.flagged.align
    )
    love.graphics.printf(
        self.mines.swept.text ..self.score.mines.swept,
        self.mines.swept.font,
        self.mines.swept.transform,
        self.mines.swept.limit,
        self.mines.swept.align
    )
    love.graphics.printf(
        self.mines.missed.text ..self.score.mines.missed .."/" ..gamePlay.mapData.mines,
        self.mines.missed.font, 
        self.mines.missed.transform,
        self.mines.missed.limit,
        self.mines.missed.align
    )


    love.graphics.printf(
        self.gold.title.text, 
        self.gold.title.font, 
        self.gold.title.transform, 
        self.gold.title.limit,
        self.gold.title.align
    )
    love.graphics.printf(
        self.gold.swept.text ..self.score.gold.swept, 
        self.gold.swept.font,
        self.gold.swept.transform, 
        self.gold.swept.limit, 
        self.gold.swept.align
    )
    love.graphics.printf(
        self.gold.missed.text ..self.score.gold.missed .."/" ..gamePlay.mapData.mines, 
        self.gold.missed.font, 
        self.gold.missed.transform, 
        self.gold.missed.limit, 
        self.gold.missed.align
    )


    love.graphics.printf(
        self.squares.title.text, 
        self.squares.title.font, 
        self.squares.title.transform, 
        self.squares.title.limit, 
        self.squares.title.align
    )
    love.graphics.printf(
        self.squares.cleared.text ..self.score.squares.cleared,
        self.squares.cleared.font,
        self.squares.cleared.transform, 
        self.squares.cleared.limit,
        self.squares.cleared.align
    )
    love.graphics.printf(
        self.squares.missed.text ..self.score.squares.missed .."/" ..gamePlay.mapData.totalSquares,
        self.squares.missed.font, 
        self.squares.missed.transform, 
        self.squares.missed.limit,
        self.squares.missed.align
    )


    love.graphics.printf(
        self.final.title.text, 
        self.final.title.font, 
        self.final.title.transform, 
        self.final.title.limit, 
        self.final.title.align
    )
    love.graphics.printf(
        self.final.time.text .. self.score.time, 
        self.final.time.font, 
        self.final.time.transform, 
        self.final.time.limit, 
        self.final.time.align
    )
    love.graphics.printf(
        self.final.explo.text ..self.score.explo,
        self.final.explo.font, 
        self.final.explo.transform, 
        self.final.explo.limit, 
        self.final.explo.align
    )

    love.graphics.setColor(yellow)
    love.graphics.printf(
        self.final.final.text ..self.score.final,
        self.final.final.font,
        self.final.final.transform, 
        self.final.final.limit, 
        self.final.final.align
    )
end





function ScoreBoard:processContainers()
    containers = {}

    containers.width  = self.width /4
    containers.height = self.height
    containers.y      = self.y

    containers.x = {}
        containers.x.mines   = self.x
        containers.x.gold    = containers.x.mines + containers.width
        containers.x.squares = containers.x.gold + containers.width
        containers.x.final   = containers.x.squares + containers.width

    return containers
end
    

function ScoreBoard:highlight()
    if isMouseOver(self) then 
        self.drawMode = "fill"
        self.color.font = black
        self.color.filling = yellow
    else
        self.drawMode = "line"
        self.color.font = yellow
        self.color.filling = white
    end
end


function ScoreBoard:processTextData(text, container, order, align)
    titleData = {}
        titleData.text      = text
        titleData.font      = FontSmall
        titleData.transform = love.math.newTransform(container.x, 
                            container.y + (container.height /5) * order- titleData.font:getHeight() /2)
        titleData.limit     = container.width
        titleData.align     = align

    return titleData
end