--Patterns
--globals.lua

local globals = {}
--Constants
globals.centerX = display.contentCenterX

--Settings
globals.numDots =  9 --Number of Dots, default 9
globals.numFlashes = 4 --Number of Flashes in a Pattern, default 4
globals.musicSetting = true --Music on/off, default true
globals.soundSetting = true --Sound on/off, default true
--Fonts
globals.font = 
{
    regular = "Museo Sans 300",
    bold = "Museo Sans 500"
}

return globals
