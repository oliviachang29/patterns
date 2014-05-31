--Patterns
--about.lua

local composer = require( "composer" )
local scene = composer.newScene()
local globals = require("globals")
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )
    
    local sceneGroup = self.view
    local titleText = display.newText( sceneGroup, "ABOUT", globals.centerX, display.contentHeight - 525, globals.font.regular, 32 )
    titleText:setFillColor(0,0,0)
    local function gotoSettings()
        composer.gotoScene("settings", {effect = "slideRight"})
    end
    --credits text
    local madeByText = display.newText( sceneGroup, "made by", globals.centerX, display.contentHeight - 425, globals.font.regular, 23)
    madeByText:setFillColor(0,0,0)
    local smallTealButtonText = display.newText( sceneGroup, "Small Teal Button", globals.centerX, display.contentHeight - 400, globals.font.regular, 23)
    smallTealButtonText:setFillColor(0,0,0)
    local musicText = display.newText( sceneGroup, "music © Russell ", globals.centerX, display.contentHeight - 350, globals.font.regular, 23)
    musicText:setFillColor(0,0,0)
    local stedmanText = display.newText( sceneGroup, "Stedman 2013", globals.centerX, display.contentHeight - 325, globals.font.regular, 23)
    stedmanText:setFillColor(0,0,0)
    local madeByText = display.newText( sceneGroup, "Settings icon designed", globals.centerX, display.contentHeight - 275, globals.font.regular, 23)
    madeByText:setFillColor(0,0,0)
    local madeByText = display.newText( sceneGroup, "by Joe Mortell", globals.centerX, display.contentHeight - 250, globals.font.regular, 23)
    madeByText:setFillColor(0,0,0)

    --tutorial button
    local tutorialbg = display.newImage( sceneGroup, "images/smallPinkButton.png", system.ResourceDirectory, globals.centerX, display.contentHeight - 150)
    local tutorialText = display.newText( sceneGroup, "tutorial", globals.centerX, display.contentHeight - 150, globals.font.regular, 25 )
    --back button
    local backbg = display.newImage( sceneGroup, "images/smallTealButton.png", system.ResourceDirectory, globals.centerX, display.contentHeight - 90)
    local backText = display.newText( sceneGroup, "back", globals.centerX, display.contentHeight - 90, globals.font.regular, 25 )
    backbg:addEventListener("tap", gotoSettings)
    
end

-- "scene:show()"
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
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

