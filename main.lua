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
background:setFillColor(55/2555, 56/255, 71/255)
background:toBack()

--Require
local json = require("json")
local composer = require("composer")
local globals = require("globals")

globals.settings = loadTable("settings.json")
if globals.settings == nil then
    globals.settings = {}
    globals.settings.highScore = 0
    --Settings
    globals.settings.numDots =  9
    globals.settings.numFlashes = 4
    globals.settings.music = true
    globals.settings.sound = true 
    globals.settings.color = 1
    globals.settings.openedBefore = false
end

--Music
if globals.settings.music == true then
    local soundtrack = require("soundtrack")
    soundtrack:start()
end

local function onKeyEvent( event )
    local keyName = event.keyName
    local phase = event.phase
    
    if (keyName == "back" and phase == "up") then
        print( "Back pressed" )
        if ( composer.currentScene == "menu" ) then
            native.requestExit()
        else
            if ( composer.isOverlay ) then
                composer.hideOverlay()
            else
                if (composer.currentScene == "game") then
                    globals.score = 0
                    timeLeft = 10
                    numLife = 3
                    isRunning = false
                    if timerHandler ~= nil then
                        timer.cancel(timerHandler)
                    end
                end
                local lastScene = composer.returnTo
                if ( lastScene ) then
                    composer.gotoScene( lastScene, { effect="slideRight"} )
                else
                    native.requestExit()
                end
            end
        end
        return true
    end
    return false
end

Runtime:addEventListener( "key", onKeyEvent )

--Ads
local ads = require "ads"
local function adListener(event)
    print("event.isError = " .. tostring(event.isError))
    globals.adsError = event.isError
end

ads.init( "admob", "ca-app-pub-2716288033999131/6851992402", adListener ) --Initialize the ads

--Splash Screen
local function splashScreen()
    local companyText = display.newText( "Sixtuitive", globals.centerX, globals.centerY, globals.font.regular, 35 )
    local function removeSplashScreen()
        transition.to(companyText, {time = 500, alpha = 0})
        local function gotoScene()
            companyText = nil
            background:setFillColor(250/255, 250/255, 250/255)
            if globals.settings.openedBefore == false then
                composer.gotoScene("tutorial")
            elseif globals.settings.openedBefore == true then
                composer.gotoScene("menu")
            end
        end
        timer.performWithDelay( 500, gotoScene)
    end
    timer.performWithDelay( 1500, removeSplashScreen)
end

splashScreen()