--Patterns
--main.lua

--Set status bar
display.setStatusBar(display.HiddenStatusBar)

--set background
local background = display.newRect( display.screenOriginX,
display.screenOriginY, 
display.pixelWidth, 
display.pixelHeight)
background.x, background.y = display.contentCenterX,  display.contentCenterY
background:setFillColor(250/255, 250/255, 250/255) --238/255
background:toBack()
--local background = display.newImage("background.png")
--background.x, background.y = display.contentCenterX,  display.contentCenterY
--background:toBack()

--Require
local json = require("json")
local composer = require("composer")
--local GGMusic = require ("GGMusic")
--
------Play background music
--local music = GGMusic:new()
--music:add( "audio/track1.mp3" )
--music:add("audio/track2.mp3")
--music:setVolume( 0.6)

--globals.settings = loadTable("settings.json")
--if globals.settings == nil then
--    globals.settings = {}
--    globals.settings.highScore = 0
--end

composer.gotoScene("menu")
