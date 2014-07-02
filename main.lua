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
    globals.music:add( "audio/music/track1.mp3" )
    globals.music:add( "audio/music/track2.mp3" )
    globals.music:setVolume( 0.6 )
    globals.music:play()
    globals.music.random = true
end

local function onKeyEvent( event )

   local phase = event.phase
   local keyName = event.keyName
   print( event.phase, event.keyName )

   if ( "back" == keyName and phase == "up" ) then
      if ( composer.currentScene == "splash" ) then
         native.requestExit()
      else
         if ( composer.isOverlay ) then
            composer.hideOverlay()
         else
            local lastScene = composer.returnTo
            print( "previous scene", lastScene )
            if ( lastScene ) then
               composer.gotoScene( lastScene, { effect="crossFade", time=500 } )
            else
               native.requestExit()
            end
         end
      end
   end

   if ( keyName == "volumeUp" and phase == "down" ) then
      local masterVolume = audio.getVolume()
      print( "volume:", masterVolume )
      if ( masterVolume < 1.0 ) then
         masterVolume = masterVolume + 0.1
         audio.setVolume( masterVolume )
      end
      return true
   elseif ( keyName == "volumeDown" and phase == "down" ) then
      local masterVolume = audio.getVolume()
      print( "volume:", masterVolume )
      if ( masterVolume > 0.0 ) then
         masterVolume = masterVolume - 0.1
         audio.setVolume( masterVolume )
      end
      return true
   end
   return false  --SEE NOTE BELOW
end

--add the key callback
Runtime:addEventListener( "key", onKeyEvent )


if globals.settings.openedBefore == false then
    composer.gotoScene("tutorial")
    
elseif globals.settings.openedBefore == true then
    composer.gotoScene("menu")
end
