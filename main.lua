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


local globals = require("globals")
globals.settings = loadTable("settings.json")
if globals.settings == nil then
    globals.settings = {}
    globals.settings.highScore = 0
    --Settings
    globals.settings.numDots =  9 --Number of Dots, default 9
    globals.settings.numFlashes = 4 --Number of Flashes in a Pattern, default 4
    globals.settings.music = true --Music on/off, default true
    globals.settings.sound = true --Sound on/off, default true
    globals.settings.color = 1
    globals.settings.openedBefore = false
end

--Music
if globals.settings.music == true then
    local GGMusic = require( "GGMusic" )
    globals.music = GGMusic:new()
    globals.music:add( "audio/track1.mp3" )
    globals.music:add( "audio/track1.mp3" )
    globals.music:setVolume( 0.6 )
    globals.music:play()
    globals.music.random = true
end

if globals.settings.openedBefore == false then
    composer.gotoScene("tutorial")
    
elseif globals.settings.openedBefore == true then
    composer.gotoScene("menu")
end
