--Patterns
--globals.lua

local globals = {}
--Constants
globals.centerX = display.contentCenterX
globals.centerY = display.contentCenterY

--Fonts
globals.font = 
{
    regular = "Museo Sans 300",
}

--Saving data
-- Code comes from: http://omnigeek.robmiracle.com/2012/02/23/need-to-save-your-game-data-in-corona-sdk-check-out-this-little-bit-of-code/
local json = require("json")

function saveTable(t,filename)
    --print("Saving table into file " .. filename)
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

--Determine x/y
--function globals.dS(placing)
--    if string.sub(system.getInfo("model"),1,4) == "iPad" or string.sub(system.getInfo("model"),1,2) == "iP" then
--
--    end
--end
function globals.dS(placing)
    placing = placing - 50
    return display.contentHeight - placing
end

return globals
