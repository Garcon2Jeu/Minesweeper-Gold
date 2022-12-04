require "/INTERFACE/MENUSCREEN/CUSTOM/customsize"
require "/INTERFACE/MENUSCREEN/CUSTOM/custommines"
require "/INTERFACE/MENUSCREEN/CUSTOM/customgold"
require "/INTERFACE/MENUSCREEN/CUSTOM/customsweepers"
--require "/INTERFACE/MENUSCREEN/CUSTOM/difficulty"
--require "/INTERFACE/MENUSCREEN/CUSTOM/gamemode"


Custom = Object:extend()

function Custom:new(menuScreen)
    self.color = {filling = white, font = white, gauge = purple}
    self.gauge = "fill"
    self.customSize      = CustomSize(menuScreen)
    self.customMines     = CustomMines(menuScreen, self.customSize)
    self.customGold      = CustomGold(menuScreen)
    self.customSweepers  = CustomSweepers(menuScreen)
end

function Custom:update()
    self:editMetric(self.customSize.rows)
    self:editMetric(self.customSize.columns)

    self:updateMetric(self.customMines)
    self:editMetric(self.customMines)

    self:updateMetric(self.customGold)
    self:editMetric(self.customGold)

    --self:editMetric(self.customSweepers.perSquares)
    --self:editMetric(self.customSweepers.bonus)
end






function Custom:editMetric(container)
    if not isMouseOverMenuScreen(container) 
    or not love.mouse.isDown(1) then
        return
    end

    local mouse = getMousePosition()
    
    for i = 1, container.gauge.increments.total do 
        if  mouse.x > container.gauge.increments.width * (i -1)
        and mouse.x < container.gauge.increments.width * i then
            container.gauge.width  = container.gauge.increments.width * i
            container.gauge.number = container.gauge.min + (i -1)
        end
    end
end


function Custom:updateMetric(container)
    container.gauge.increments.total = self.customSize.rows.gauge.number * 
                                        self.customSize.columns.gauge.number -10
    container.gauge.increments.width = container.width / container.gauge.increments.total
    container.gauge.width            = container.gauge.increments.width * 
                                        container.gauge.number

    if container.gauge.number > container.gauge.increments.total then
        container.gauge.number = container.gauge.increments.total
    end
end





function Custom:draw()
    love.graphics.setColor(self.color.filling)
    love.graphics.rectangle(
        self.customSize.rows.drawMode, 
        self.customSize.rows.x, 
        self.customSize.rows.y, 
        self.customSize.rows.width, 
        self.customSize.rows.height
    )

    love.graphics.rectangle(
        self.customSize.columns.drawMode, 
        self.customSize.columns.x, 
        self.customSize.columns.y, 
        self.customSize.columns.width, 
        self.customSize.columns.height
    )

    love.graphics.rectangle(
        self.customMines.drawMode, 
        self.customMines.x, 
        self.customMines.y, 
        self.customMines.width, 
        self.customMines.height
    )

    love.graphics.rectangle(
        self.customGold.drawMode, 
        self.customGold.x, 
        self.customGold.y, 
        self.customGold.width, 
        self.customGold.height
    )

    love.graphics.rectangle(
        self.customSweepers.perSquares.drawMode, 
        self.customSweepers.perSquares.x, 
        self.customSweepers.perSquares.y, 
        self.customSweepers.perSquares.width, 
        self.customSweepers.perSquares.height
    )

    love.graphics.rectangle(
        self.customSweepers.bonus.drawMode, 
        self.customSweepers.bonus.x, 
        self.customSweepers.bonus.y, 
        self.customSweepers.bonus.width, 
        self.customSweepers.bonus.height
    )
    



    love.graphics.setColor(self.color.gauge)
    love.graphics.rectangle(
        self.gauge, 
        self.customSize.rows.x, 
        self.customSize.rows.y, 
        self.customSize.rows.gauge.width, 
        self.customSize.rows.height
    )

    love.graphics.rectangle(
        self.gauge, 
        self.customSize.columns.x, 
        self.customSize.columns.y, 
        self.customSize.columns.gauge.width, 
        self.customSize.columns.height
    )

    love.graphics.rectangle(
        self.gauge, 
        self.customMines.x, 
        self.customMines.y, 
        self.customMines.gauge.width, 
        self.customMines.height
    )

    love.graphics.rectangle(
        self.gauge, 
        self.customGold.x, 
        self.customGold.y, 
        self.customGold.gauge.width, 
        self.customGold.height
    )

    love.graphics.rectangle(
        self.gauge, 
        self.customSweepers.perSquares.x, 
        self.customSweepers.perSquares.y, 
        self.customSweepers.perSquares.gauge, 
        self.customSweepers.perSquares.height
    )

    love.graphics.rectangle(
        self.gauge, 
        self.customSweepers.bonus.x, 
        self.customSweepers.bonus.y, 
        self.customSweepers.bonus.gauge, 
        self.customSweepers.bonus.height
    )



    love.graphics.setColor(self.color.font)
    love.graphics.printf(
        self.customSize.rows.gauge.number .." " ..self.customSize.rows.textData.text, 
        self.customSize.rows.textData.font, 
        self.customSize.rows.textData.transform,      
        self.customSize.rows.textData.limit, 
        self.customSize.rows.textData.align
    )

    love.graphics.printf(
        self.customSize.columns.gauge.number .." " ..self.customSize.columns.textData.text, 
        self.customSize.columns.textData.font, 
        self.customSize.columns.textData.transform,      
        self.customSize.columns.textData.limit, 
        self.customSize.columns.textData.align
    )

    love.graphics.printf(
        self.customMines.gauge.number .." " ..self.customMines.textData.text, 
        self.customMines.textData.font, 
        self.customMines.textData.transform,      
        self.customMines.textData.limit, 
        self.customMines.textData.align
    )

    love.graphics.printf(
        self.customGold.gauge.number .." " .. self.customGold.textData.text, 
        self.customGold.textData.font, 
        self.customGold.textData.transform,      
        self.customGold.textData.limit, 
        self.customGold.textData.align
    )

    love.graphics.printf(
        self.customSweepers.perSquares.number .." " ..self.customSweepers.perSquares.textData.text, 
        self.customSweepers.perSquares.textData.font, 
        self.customSweepers.perSquares.textData.transform,      
        self.customSweepers.perSquares.textData.limit, 
        self.customSweepers.perSquares.textData.align
    )

    love.graphics.printf(
        self.customSweepers.bonus.number .." " ..self.customSweepers.bonus.textData.text, 
        self.customSweepers.bonus.textData.font, 
        self.customSweepers.bonus.textData.transform,      
        self.customSweepers.bonus.textData.limit, 
        self.customSweepers.bonus.textData.align
    )
end