--LÖVE2D V11.4.0 - Mysterious Mysteries

require "/LIBS/helpers"
require "/INTERFACE/ui"
require "/GAMEPLAY/gameplay"
require "/MAP/map"
require "/DEBUG/debug"


seed = {presetsCustom = "presets", mapSize = "small", difficulty = "easy", gameMode = "gold"}

function love.load()
    gamePlay = GamePlay(seed)
    map      = Map(gamePlay)
    ui       = Ui()

    debug = Debug(ui, true)
end

function love.update()
    map:update(gamePlay, sweepers)
    ui:update()
end

function love.draw()
    ui:draw(gamePlay, map)
    debug:draw()
end






function love.wheelmoved(x, y)
    zoom = ui.leftBar.zoom
    zoom.cursor.y = zoom.cursor.y + y *20
    zoom:limitCursorPostition()
end


function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if key == "space"
    and gamePlay.play 
    and gamePlay.sweepers.inventory.current > 0 then 
        gamePlay.sweepers:toggle()
        return
    end

    if key == "d" then 
        debug:toggle(map)
        return
    end

    if key == "n" then 
        gamePlay:update("new")
        return
    end

    if key == "m" then
        ui.menuScreen:toggle()
    end

    if key == "f" then
        ui.leftBar.flagMode:toggle()
    end

    ui.mapDisplay:moveGrid(key)
end


function love.mousepressed(x, y, button, isTouch)
    ui:onClick(button)
    gamePlay:onClick(map, button)

    debug:onClick()
end


function love.mousemoved(x, y, dx, dy, istouch)
    ui.mapDisplay:dragGrid(dx, dy)
end
