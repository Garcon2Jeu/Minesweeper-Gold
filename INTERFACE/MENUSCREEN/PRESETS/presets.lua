require "/INTERFACE/MENUSCREEN/PRESETS/presetssize"
require "/INTERFACE/MENUSCREEN/PRESETS/difficulty"
require "/INTERFACE/MENUSCREEN/PRESETS/gamemode"


Presets = Object:extend()

function Presets:new(menuScreen)
    self.presetsSize = PresetsSize(menuScreen)
    self.difficulty  = Difficulty(menuScreen)
    self.gameMode    = GameMode(menuScreen)
end

function Presets:draw()
    self.presetsSize:draw()
    self.difficulty:draw()
    self.gameMode:draw()
end