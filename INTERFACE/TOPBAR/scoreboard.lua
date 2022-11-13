ScoreBoard = Object:extend()

function ScoreBoard:new(topBar)
    self.x        = topBar.x.scoreBoard
    self.y        = topBar.y
    self.width    = topBar.width.scoreBoard
    self.height   = topBar.height
    self.drawMode = "line"
    self.color     = {filling = white, font = white}
    self.textData = centerText("SCOREBOARD", FontHuge, self)

    --Squares
        --cleared
        --missed
    --mines
        --flagged
        --swept
        --missed
    --Gold
        --Swept
        --missed
    --Final Score
        --Exploration rate
        --time
        --Final Score 
end

function ScoreBoard:update(score)
end

function ScoreBoard:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
    

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