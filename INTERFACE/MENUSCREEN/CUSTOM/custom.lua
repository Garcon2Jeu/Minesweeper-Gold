require "/INTERFACE/MENUSCREEN/CUSTOM/customsize"
require "/INTERFACE/MENUSCREEN/CUSTOM/custommines"
require "/INTERFACE/MENUSCREEN/CUSTOM/customgold"
require "/INTERFACE/MENUSCREEN/CUSTOM/customsweepers"
--require "/INTERFACE/MENUSCREEN/CUSTOM/difficulty"
--require "/INTERFACE/MENUSCREEN/CUSTOM/gamemode"


Custom = Object:extend()

function Custom:new(menuScreen)
    self.customSize      = CustomSize(menuScreen)
    self.customMines     = CustomMines(menuScreen)
    self.customGold      = CustomGold(menuScreen)
    self.customSweepers  = CustomSweepers(menuScreen)
end

function Custom:draw()
    self.customSize:draw()
    self.customMines:draw()
    self.customGold:draw()
    self.customSweepers:draw()
end