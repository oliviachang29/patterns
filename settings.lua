--Patterns
--settings.lua

local composer = require( "composer" )
local scene = composer.newScene()
local json = require("json")
local globals = require("globals")
local widget = require("widget")

-- local forward references should go here
local numFlashesText
local numFlashesSlider
local colorDot

-- "scene:create()"
function scene:create( event )
    
    local sceneGroup = self.view
    local titleText = display.newText( sceneGroup, "SETTINGS", globals.centerX, 45, globals.font.regular, 32 )
    titleText:setFillColor(0,0,0)
    --Number of Dots
    local numDotsTitle = display.newText( sceneGroup, "number of dots", 100, 90, globals.font.regular, 24 )
    numDotsTitle:setFillColor(0,0,0)
    
    local dotsText= {}
    dotsText[4] = display.newText( sceneGroup, "4", 220, 90, globals.font.regular, 24 )
    dotsText[4]:setFillColor(0,0,0)
    dotsText[9] = display.newText( sceneGroup, "9", 258, 90, globals.font.regular, 24 )
    dotsText[9]:setFillColor(0,0,0)
    dotsText[16] = display.newText( sceneGroup, "16", 295, 90, globals.font.regular, 24 )
    dotsText[16]:setFillColor(0,0,0)
    
    --SELECTED CIRCLE
    local selectedCircle = display.newImage( sceneGroup, "images/tealCircle.png", system.ResourceDirectory)
    selectedCircle.x, selectedCircle.y = dotsText[globals.settings.numDots].x, 90
    local function moveCircle(event)
        transition.to(selectedCircle, {time = 250, x = event.target.x})
        if event.target == dotsText[4] then
            globals.settings.numDots = 4
        elseif event.target == dotsText[9] then
            globals.settings.numDots = 9
        elseif event.target == dotsText[16] then
            globals.settings.numDots = 16
        end
        print("globals.settings.numDots is " .. globals.settings.numDots)
        saveTable(globals.settings, "settings.json")
    end
    dotsText[4]:addEventListener("tap", moveCircle)
    dotsText[9]:addEventListener("tap", moveCircle)
    dotsText[16]:addEventListener("tap", moveCircle)
    --    --Number of Flashes
    local numFlashesTitle = display.newText( sceneGroup, "number of flashes", 114, 140, globals.font.regular, 24 )
    numFlashesTitle:setFillColor(0,0,0)
    numFlashesText = display.newText( sceneGroup, globals.settings.numFlashes, 295, 140, globals.font.regular, 24 )
    numFlashesText:setFillColor(0,0,0)
    
    --Color
    local colorTitle = display.newText( sceneGroup, "color", 43, 220, globals.font.regular, 24 )
    colorTitle:setFillColor(0,0,0)
    
    --Sound
    local soundTitle = display.newText( sceneGroup, "sound", 49, 280, globals.font.regular, 24 )
    soundTitle:setFillColor(0,0,0)
    
    --Music
    local musicTitle = display.newText( sceneGroup, "music", 47, 340, globals.font.regular, 24 )
    musicTitle:setFillColor(0,0,0)
    
    local function gotoMenu()
        composer.gotoScene("menu", {effect = "slideRight"})
    end
    --Done button
    local donebg = display.newImage( sceneGroup, "images/smallTealButton.png", system.ResourceDirectory, globals.centerX, 400)
    local doneText = display.newText( sceneGroup, "done", globals.centerX, 400, globals.font.regular, 25 )
    donebg:addEventListener("tap", gotoMenu)
    
    local function gotoAbout()
        composer.gotoScene("about", {effect = "slideLeft"})
    end
    
    --Info button
    local infoButton = display.newImage( sceneGroup, "images/info.png", system.ResourceDirectory, 295, 455)
    infoButton:addEventListener("tap", gotoAbout)
end

-- "scene:show()"
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        --Color dot
        local function gotoColor()
            composer.gotoScene("color", {effect = "slideLeft"})
        end
        
        colorDot = display.newImage( sceneGroup, "images/smallDot/" .. globals.settings.color .. ".png", system.ResourceDirectory, 295, 220)
        colorDot:addEventListener("tap", gotoColor)
        
        --WIDGETS
        -- Slider listener
        local function flashesSliderListener( event )
            sliderPercent = event.value
            if ( 81<= sliderPercent) then
                if (sliderPercent <= 100) then
                    globals.settings.numFlashes = 7
                    numFlashesText.text = "7"
                end
            elseif ( 61<= sliderPercent) then
                if (sliderPercent <= 80) then
                    globals.settings.numFlashes = 6
                    numFlashesText.text = "6"
                end
            elseif ( 41<= sliderPercent) then
                if (sliderPercent <= 60) then
                    globals.settings.numFlashes = 5
                    numFlashesText.text = "5"
                end
            elseif ( 21<= sliderPercent) then
                if (sliderPercent <= 40) then
                    globals.settings.numFlashes = 4
                    numFlashesText.text = "4"
                end
            elseif ( 0<= sliderPercent) then
                if (sliderPercent <= 20) then
                    globals.settings.numFlashes = 3
                    numFlashesText.text = "3"
                end
            end
            print("globals.settings.numFlashes = " .. globals.settings.numFlashes)
            saveTable(globals.settings, "settings.json")
        end
        local flashesSliderValue = 0
        if (globals.settings.numFlashes == 4) then
            flashesSliderValue = 21
        elseif (globals.settings.numFlashes == 5) then
            flashesSliderValue = 41
        elseif (globals.settings.numFlashes == 6) then
            flashesSliderValue = 61
        elseif (globals.settings.numFlashes == 7) then
            flashesSliderValue = 81
        end
        -- Create the widget
        numFlashesSlider = widget.newSlider
        {
            top = 155, --up and down
            left = 20,--side to side
            width = 285,
            value = flashesSliderValue,  -- Start slider at value
            listener = flashesSliderListener
        }
        sceneGroup:insert(numFlashesSlider)
        
        --SOUND--
        -- Handle press events for the checkbox
        local function onSoundPress( event )
            local switch = event.target
            if switch.isOn == false then
                globals.settings.sound = true
            elseif switch.isOn== true then
                globals.settings.sound = false
            else
                print("Error: Sound switch.id is neither true or false.")
            end
            saveTable(globals.settings, "settings.json")
            print("Sound on: " .. tostring(globals.settings.sound))
        end
        
        -- Create the widget
        local soundSwitch = widget.newSwitch
        {
            left = 180, --side to side
            top = 260,  --up and down
            id = "soundSwitch",
            onPress = onSoundPress
        }
        if globals.settings.sound == true then
            soundSwitch:setState( { isOn=true} )
        elseif globals.settings.sound == false then
            soundSwitch:setState( { isOn=false} )
        else
            print("Sound is neither off or on...")
        end
        sceneGroup:insert(soundSwitch)
        
        --MUSIC--
        -- Handle press events for the checkbox
        local function onMusicPress( event )
            local soundtrack = require("soundtrack")
            local switch = event.target
            if switch.isOn == false then
                globals.settings.music = true
                soundtrack:start()
            elseif switch.isOn == true then
                globals.settings.music = false
                soundtrack:stop()
            else
                print("Error: Music switch.id is neither true or false.")
            end
            saveTable(globals.settings, "settings.json")
            print("Music on: " .. tostring(globals.settings.music))
        end
        
        -- Create the widget
        local musicSwitch = widget.newSwitch
        {
            left = 180, --side to side
            top = 320,--up and down
            style = "onOff",
            id = "musicSwitch",
            onPress = onMusicPress
        }
        if globals.settings.music == true then
            musicSwitch:setState( { isOn=true} )
        elseif globals.settings.music == false then
            musicSwitch:setState( { isOn=false} )
        else
            print("Music is neither off or on...")
        end
        sceneGroup:insert(musicSwitch)
    elseif ( phase == "did" ) then
        composer.returnTo = "menu"
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
        display.remove(numFlashesSlider)
        numFlashesSlider = nil
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