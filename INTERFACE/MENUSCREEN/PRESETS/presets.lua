require "/INTERFACE/MENUSCREEN/PRESETS/mapsize"
require "/INTERFACE/MENUSCREEN/PRESETS/difficulty"
require "/INTERFACE/MENUSCREEN/PRESETS/gamemode"


Presets = Object:extend()

function Presets:new(menuScreen)
    self.mapSize    = MapSize(menuScreen)
    self.difficulty = Difficulty(menuScreen)
    self.gameMode   = GameMode(menuScreen)
end

function Presets:draw()
    self.mapSize:draw()
    self.difficulty:draw()
    self.gameMode:draw()
end





