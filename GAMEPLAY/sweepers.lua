Sweepers = Object:extend()

function Sweepers:new(mapData)
    self.activated = false
    self.inventory = {max = mapData.sweepers.max,      current = 0}
    self.required  = {max = mapData.sweepers.required, current = 0}
    self.limit     = {limit = mapData.sweepers.limit,  current = 0}
end


function Sweepers:update()
    self.limit.current = self.limit.current +1
    self:countRequired()
    self:addToInventory()
end






function Sweepers:toggle()
    ui.leftBar.flagMode.activated = false

    if self.activated then 
        self.activated = false
    else
        self.activated = true
    end
end


function Sweepers:countRequired()
    if gamePlay.sweepers.limit.current > gamePlay.sweepers.limit.limit then
        return
    end

    self.required.current = self.required.current +1
end


function Sweepers:addToInventory()
    if self.required.max < 1 then
        return
    end

    if self.required.current >= self.required.max then 
        self.inventory.current = self.inventory.current +1
        self.required.current = 0
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

    if not square.flagged 
    and square.isMine then
        ui.topBar.dashBoard.minesCounter.remaining = 
            ui.topBar.dashBoard.minesCounter.remaining -1
    end

    if square.flagged then
        square.flagged = false
    end


    self:toggle()
end