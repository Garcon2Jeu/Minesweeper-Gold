Object = require "/LIBS/classic"





WINDOW = {}
WINDOW.width = love.graphics.getWidth()
WINDOW.height = love.graphics.getHeight()





FontHuge = love.graphics.newFont("/ASSETS/RetroGaming.ttf", 50)
FontHuge:setFilter( "nearest", "nearest" )
FontBig = love.graphics.newFont("/ASSETS/RetroGaming.ttf", 24)
FontBig:setFilter( "nearest", "nearest" )
FontMedium = love.graphics.newFont("/ASSETS/RetroGaming.ttf", 17)
FontMedium:setFilter( "nearest", "nearest" )
FontSmall= love.graphics.newFont("/ASSETS/RetroGaming.ttf", 12)
FontSmall:setFilter( "nearest", "nearest" )
FontTiny= love.graphics.newFont("/ASSETS/RetroGaming.ttf", 10)
FontTiny:setFilter( "nearest", "nearest" )


black  = {0, 0, 0}
white  = {1, 1, 1}
red    = {1, 0, 0}
green  = {0, 1, 0}
blue   = {0, 0, 1}
yellow = {255/255,255/255,0}
orange = {255/255, 128/255, 0}
grey   = {100/255, 100/255, 100/255}
purple = {191/255, 64/255, 191/255}


function centerText(text, font, container)
    textData = {}
        textData.text      = text
        textData.font      = font
        textData.transform = love.math.newTransform(container.x, 
                             container.y + container.height /2 - font:getHeight() /2)
        textData.limit     = container.width
        textData.align     = "center"

    return textData
end





function getNumberFromPercentage(value, targetPercent)
    return value / 100 * targetPercent
end

function getPercentageFromNumber(total, value)
    return 100 / total * value
end





function getMousePosition()
    local mouse = {}
    mouse.x, mouse.y = love.mouse.getPosition()

    return mouse
end


function isMouseOver(element)
    local mouse = getMousePosition()

    if  mouse.x > element.x 
    and mouse.x < element.x + element.width
    and mouse.y > element.y 
    and mouse.y < element.y + element.height then 
        return true
    end

    return false 
end


function isMouseOverMapDisplay()
    local mouse = getMousePosition()
    
    if  mouse.x > ui.mapDisplay.x 
    and mouse.x < ui.mapDisplay.x + ui.mapDisplay.width
    and mouse.y > ui.mapDisplay.y 
    and mouse.y < ui.mapDisplay.y + ui.mapDisplay.height then 
        return true
    end

    return false
end


function isMouseOverSquare(square)
    local mouse = getMousePosition()

    if  mouse.x - ui.mapDisplay.x > square.x 
    and mouse.x - ui.mapDisplay.x < square.x + square.width
    and mouse.y - ui.mapDisplay.y > square.y 
    and mouse.y - ui.mapDisplay.y < square.y + square.height then 
        return true
    end

    return false
end


function isMouseOverMenuScreen(container)
    local mouse = getMousePosition()

    -- Returns false if mouse is out of menu screen
    if  mouse.x < ui.menuScreen.x 
    and mouse.x > ui.menuScreen.x + ui.menuScreen.width
    and mouse.y < ui.menuScreen.y 
    and mouse.y > ui.menuScreen.y + ui.menuScreen.height then 
        return false
    end

    -- Returns true if mouse is over container
    if  mouse.x - ui.menuScreen.x > container.x 
    and mouse.x - ui.menuScreen.x < container.x + container.width
    and mouse.y - ui.menuScreen.y > container.y 
    and mouse.y - ui.menuScreen.y < container.y + container.height then 
        return true
    end

    return false
end





function isSquareReal(map, row, column)
    if  row    > 0
    and row    < map.rows +1
    and column > 0
    and column < map.columns +1 then
        return true
    end

    return false
end