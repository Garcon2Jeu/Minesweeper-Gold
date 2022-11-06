ScoreBoard = Object:extend()

function ScoreBoard:new(topBar)
    self.x        = topBar.x.scoreBoard
    self.y        = topBar.y
    self.width    = topBar.width.scoreBoard
    self.height   = topBar.height
    self.drawMode = "fill"
    self.color     = {filling = white, font = black}
    self.textData = centerText("SCOREBOARD", FontHuge, self)

    -- exploration rate
    -- golden squares swept
    -- white squares cleared
    -- mines flagged
    -- mines swept
    -- overall score
end

function ScoreBoard:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(self.drawMode, self.x, self.y, self.width, self.height)
    
    love.graphics.setColor(self.color.font)
    love.graphics.printf(self.textData.text, self.textData.font, self.textData.transform, 
                         self.textData.limit, self.textData.align)
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