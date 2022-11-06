Sweepers = Object:extend()

function Sweepers:new(mapData)

    self.activated = false
    self.inventory = {max = mapData.sweepers.inventoryMax, current = 0}
    self.progress  = {max = mapData.sweepers.progressMax, current = 0}
end


function Sweepers:update()
    self:countProgress()
    self:addToInventory()
end






function Sweepers:toggle()
    if ui.leftBar.flagMode.activated then
        ui.leftBar.flagMode.activated = false
    end

    if self.activated then 
        self.activated = false
    else
        self.activated = true
    end
end


function Sweepers:countProgress()
    if self.inventory.current < self.inventory.max then
        self.progress.current = self.progress.current +1
    end
end


function Sweepers:addToInventory()
    if self.progress.current >= self.progress.max then 
        self.inventory.current = self.inventory.current +1
        self.progress.current = 0
    end
end


function Sweepers:onClick(square)
    if not self.activated 
    or self.inventory.current == 0 
    or square.cleared then
        return
    end

    self.inventory.current = self.inventory.current -1
    square.swept           = true

    if square.clue == 0 then 
        square:clearEmptySquares(map, row, column)
    end

    if square.isGolden then
        ui.topBar.dashBoard.goldCounter:update()
    end

    ui.topBar.dashBoard.minesCounter:update(square)

    self:toggle()
end