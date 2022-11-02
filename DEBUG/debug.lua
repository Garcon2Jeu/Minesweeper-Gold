Debug = Object:extend()

function Debug:new(ui, state)
    self.width  = 100
    self.height = 50
    self.x      = ui.windowBox.width - self.width
    self.y      = ui.windowBox.height - self.height
    self.reveal = false
    self.color  = white
    self.active = state
end

function Debug:draw()
    if self.active then
        love.graphics.setColor(self.color)
        love.graphics.rectangle("line", self.x, self.y , self.width , self.height)
        love.graphics.print("Debug", self.x + self.width /4, self.y + self.height /2, 0, 1, 1, 3, 7)
    end
end






function Debug:onClick()
    if isMouseOver(self) then
        self:toggle(map)
    end
end


function Debug:toggle(map)
    if self.active then
        if debug.reveal == false then 
            debug.reveal = true 
        else
            debug.reveal = false 
        end
            
        for i = 1, map.rows do
            for j = 1, map.columns do 
                local square = map.grid[i][j]

                if debug.reveal == false then
                    square.drawMode = "fill"
                else 
                    square.drawMode = "line"
                end
            end
        end
    end
end
