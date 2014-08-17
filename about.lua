--Patterns
--about.lua

local composer = require( "composer" )
local scene = composer.newScene()
local globals = require("globals")

-- local forward references 

-- "scene:create()"
function scene:create( event )
    
    local sceneGroup = self.view
    local titleText = display.newText( sceneGroup, "ABOUT", globals.centerX, 45, globals.font.regular, 32 )
    titleText:setFillColor(0,0,0)
    --credits text
    local versionNameText = display.newText( sceneGroup, "Version: 1.0.3", globals.centerX, 80, globals.font.regular, 17)
    versionNameText:setFillColor(0,0,0)
    local copyrightText = display.newText( sceneGroup, "© 2014 Sixtuitive", globals.centerX, 120, globals.font.regular, 23)
    copyrightText:setFillColor(0,0,0)
    local musicText = display.newText( sceneGroup, "music: © 2014 ", globals.centerX, 170, globals.font.regular, 23)
    musicText:setFillColor(0,0,0)
    local stedmanText = display.newText( sceneGroup, "Russell Stedman", globals.centerX, 195, globals.font.regular, 23)
    stedmanText:setFillColor(0,0,0)
    local settingsIcon = display.newText( sceneGroup, "Settings icon designed", globals.centerX, 245, globals.font.regular, 23)
    settingsIcon:setFillColor(0,0,0)
    local joeMortellText = display.newText( sceneGroup, "by Joe Mortell", globals.centerX, 270, globals.font.regular, 23)
    joeMortellText:setFillColor(0,0,0)

    --tutorial button
    local function gotoTutorial()
        composer.gotoScene("tutorial", {effect = "slideLeft"})
    end
    local tutorialbg = display.newImage( sceneGroup, "images/smallPinkButton.png", system.ResourceDirectory, globals.centerX, 345)
    local tutorialText = display.newText( sceneGroup, "tutorial", globals.centerX, 345, globals.font.regular, 25 )
    tutorialbg:addEventListener("tap", gotoTutorial)
    --back button
    local function gotoSettings()
        composer.gotoScene("settings", {effect = "slideRight"})
    end
    local backbg = display.newImage( sceneGroup, "images/smallTealButton.png", system.ResourceDirectory, globals.centerX, 400)
    local backText = display.newText( sceneGroup, "back", globals.centerX, 400, globals.font.regular, 25 )
    backbg:addEventListener("tap", gotoSettings)
    
end

-- "scene:show()"
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        composer.returnTo = "settings"
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

