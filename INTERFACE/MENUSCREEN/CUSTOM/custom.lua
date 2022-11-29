require "/INTERFACE/MENUSCREEN/CUSTOM/customsize"
--require "/INTERFACE/MENUSCREEN/CUSTOM/difficulty"
--require "/INTERFACE/MENUSCREEN/CUSTOM/gamemode"


Custom = Object:extend()

function Custom:new(menuScreen)
    self.customSize    = CustomSize(menuScreen)
end

function Custom:draw()
    self.customSize:draw()
end