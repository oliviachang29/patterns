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

-- Code comes from: http://omnigeek.robmiracle.com/2012/02/23/need-to-save-your-game-data-in-corona-sdk-check-out-this-little-bit-of-code/

local json = require("json")

function saveTable(t,filename)
    local path = system.pathForFile(filename,system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local contents = json.encode(t)
        file:write(contents)
        io.close(file)
        return true
    else 
        return false
    end
end

function loadTable(filename)
    local path = system.pathForFile(filename,system.DocumentsDirectory)
    local content = ""
    local myTable = {}
    local file = io.open(path,"r")
    if file then
        local contents = file:read("*a")
        myTable = json.decode(contents);
        io.close(file)
        return myTable
    end
    return nil
end


return globals
