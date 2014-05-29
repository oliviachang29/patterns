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

---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )
    
    local sceneGroup = self.view
    local titleText = display.newText( sceneGroup, "SETTINGS", globals.centerX, display.contentHeight - 450, globals.font.regular, 32 )
    titleText:setFillColor(0,0,0)
    
    --Number of Dots
    local numFlashesTitle = display.newText( sceneGroup, "number of flashes", display.contentWidth - 215, display.contentHeight - 325, globals.font.regular, 24 )
    numFlashesTitle:setFillColor(0,0,0)
    local numFlashesText = display.newText( sceneGroup, globals.numFlashes, display.contentWidth - 25, display.contentHeight - 325, globals.font.regular, 24 )
    numFlashesText:setFillColor(0,0,0)
    
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
            print( "Slider at " .. event.value .. "%" )
        end
        
        -- Create the widget
        local numFlashesSlider = widget.newSlider
        {
            top = display.contentHeight - 305, --up and down
            left = display.contentWidth - 300,--side to side
            width = 275,
            value = 20,  -- Start slider at 10% (optional)
            listener = sliderListener
        }
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
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
        -- Called immediately after scene goes off screen.
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
