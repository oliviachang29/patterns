--Patterns
--settings.lua

local composer = require( "composer" )
local scene = composer.newScene()
local json = require("json")
local globals = require("globals")
local widget = require("widget")
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here
local numFlashesText
---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )
    
    local sceneGroup = self.view
    local titleText = display.newText( sceneGroup, "SETTINGS", globals.centerX, display.contentHeight - 525, globals.font.regular, 32 )
    titleText:setFillColor(0,0,0)
    --Number of Dots
    local numDotsTitle = display.newText( sceneGroup, "number of dots", display.contentWidth - 220, display.contentHeight - 460, globals.font.regular, 24 )
    numDotsTitle:setFillColor(0,0,0)
    local fourDotsText = display.newText( sceneGroup, "4", display.contentWidth - 100, display.contentHeight - 460, globals.font.regular, 24 )
    fourDotsText:setFillColor(0,0,0)
    local nineDotsText = display.newText( sceneGroup, "9", display.contentWidth - 62, display.contentHeight - 460, globals.font.regular, 24 )
    nineDotsText:setFillColor(0,0,0)
    local sixteenDotsText = display.newText( sceneGroup, "16", display.contentWidth - 25, display.contentHeight - 460, globals.font.regular, 24 )
    sixteenDotsText:setFillColor(0,0,0)
    
    --SELECTED CIRCLE
    local selectedCircle = display.newImage( sceneGroup, "images/tealCircle.png", system.ResourceDirectory)
    if globals.numDots == 4 then
        selectedCircle.x, selectedCircle.y = display.contentWidth - 100, display.contentHeight - 460
    elseif globals.numDots == 9 then
        selectedCircle.x, selectedCircle.y = display.contentWidth - 62, display.contentHeight - 460
    end
--    local function moveCircle(event)
--        
--    end
--    
--    fourDotsText:addEventListener()
--    nineDotsText:addEventListener()
----    sixteenDotsText:addEventListener("tap", circleToSixteen)
--    --Number of Flashes
    local numFlashesTitle = display.newText( sceneGroup, "number of flashes", display.contentWidth - 210, display.contentHeight - 400, globals.font.regular, 24 )
    numFlashesTitle:setFillColor(0,0,0)
    numFlashesText = display.newText( sceneGroup, globals.numFlashes, display.contentWidth - 25, display.contentHeight - 400, globals.font.regular, 24 )
    numFlashesText:setFillColor(0,0,0)
    --Color
    local colorTitle = display.newText( sceneGroup, "color", display.contentWidth - 280, display.contentHeight - 300, globals.font.regular, 24 )
    colorTitle:setFillColor(0,0,0)
    
    --Sound
    local soundTitle = display.newText( sceneGroup, "sound", display.contentWidth - 274, display.contentHeight - 240, globals.font.regular, 24 )
    soundTitle:setFillColor(0,0,0)
    
    --Music
    local musicTitle = display.newText( sceneGroup, "music", display.contentWidth - 276, display.contentHeight - 180, globals.font.regular, 24 )
    musicTitle:setFillColor(0,0,0)
    
    local function gotoMenu()
        composer.gotoScene("menu", {effect = "slideRight"})
    end
    --Done button
    local donebg = display.newImage( sceneGroup, "images/smallTealButton.png", system.ResourceDirectory, globals.centerX, display.contentHeight - 90)
    local doneText = display.newText( sceneGroup, "done", globals.centerX, display.contentHeight - 90, globals.font.regular, 25 )
    donebg:addEventListener("tap", gotoMenu)
    
    local function gotoAbout()
        composer.gotoScene("about", {effect = "slideLeft"})
    end
    
    --Info button
    local infoButton = display.newImage( sceneGroup, "images/info.png", system.ResourceDirectory, display.contentWidth - 25, display.contentHeight - 25)
    infoButton:addEventListener("tap", gotoAbout)
end

-- "scene:show()"
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        
        -- Slider listener
        local function sliderListener( event )
-           print("Slider is at " .. event.value .. "%")
            sliderPercent = event.value
            if ( 81<= sliderPercent) then
                if (sliderPercent <= 100) then
                    globals.numFlashes = 7
                    numFlashesText.text = "7"
                end
            elseif ( 61<= sliderPercent) then
                if (sliderPercent <= 80) then
                    globals.numFlashes = 6
                    numFlashesText.text = "6"
                end
            elseif ( 41<= sliderPercent) then
                if (sliderPercent <= 60) then
                    globals.numFlashes = 5
                    numFlashesText.text = "5"
                end
            elseif ( 21<= sliderPercent) then
                if (sliderPercent <= 40) then
                    globals.numFlashes = 4
                    numFlashesText.text = "4"
                end
            elseif ( 0<= sliderPercent) then
                if (sliderPercent <= 20) then
                    globals.numFlashes = 3
                    numFlashesText.text = "3"
                end
            end
        end
        local sliderValue = 0
        if (globals.numFlashes == 4) then
            sliderValue = 21
        elseif (globals.numFlashes == 5) then
            sliderValue = 41
        elseif (globals.numFlashes == 6) then
            sliderValue = 61
        elseif (globals.numFlashes == 7) then
            sliderValue = 81
        end
        -- Create the widget
        local numFlashesSlider = widget.newSlider
        {
            top = display.contentHeight - 380, --up and down
            left = display.contentWidth - 305,--side to side
            width = 285,
            value = sliderValue,  -- Start slider at value
            listener = sliderListener
        }
        sceneGroup:insert(numFlashesSlider)
        --SOUND--
        -- Handle press events for the checkbox
        local function onSoundPress( event )
            local switch = event.target
            if switch.isOn == true then
                globals.soundSetting = true
            elseif switch.isOn== false then
                globals.soundSetting = false
            else
                print("Error: Sound switch.id is neither true or false.")
            end
            print("Sound on: " .. tostring(globals.soundSetting))
        end
        
        -- Create the widget
        local soundSwitch = widget.newSwitch
        {
            left = display.contentWidth - 70, --side to side
            top = display.contentHeight - 260,  --up and down
            id = "soundSwitch",
            onPress = onSoundPress
        }
        if globals.soundSetting == true then
            soundSwitch:setState( { isOn=true} )
        elseif globals.soundSetting == false then
            soundSwitch:setState( { isOn=false} )
        else
            print("Sound is neither off or on...")
        end
        sceneGroup:insert(soundSwitch)
        --MUSIC--
        -- Handle press events for the checkbox
        local function onMusicPress( event )
            local switch = event.target
            if switch.isOn== true then
                globals.musicSetting = true
            elseif switch.isOn == false then
                globals.musicSetting = false
            else
                print("Error: Music switch.id is neither true or false.")
            end
            print("Music on: " .. tostring(globals.musicSetting))
        end
        
        -- Create the widget
        local musicSwitch = widget.newSwitch
        {
            left = display.contentWidth - 70, --side to side
            top = display.contentHeight - 200,--up and down
            style = "onOff",
            id = "musicSwitch",
            onPress = onMusicPress
        }
        if globals.musicSetting == true then
            musicSwitch:setState( { isOn=true} )
        elseif globals.musicSetting == false then
            musicSwitch:setState( { isOn=false} )
        else
            print("Music is neither off or on...")
        end
        sceneGroup:insert(musicSwitch)
    end
end

-- "scene:hide()"
function scene:hide( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        
    end
end

-- "scene:destroy()"
function scene:destroy( event )
    
    local sceneGroup = self.view
    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
