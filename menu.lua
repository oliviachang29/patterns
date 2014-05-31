--Patterns
--menu.lua

local composer = require( "composer" )
local scene = composer.newScene()
local globals = require("globals")

-- local forward references should go here

-- "scene:create()"
function scene:create( event )
    
    local sceneGroup = self.view
    
    --display game title
    local gameTitle = display.newText( sceneGroup, "patterns", globals.centerX, display.contentHeight - 500, globals.font.regular, 65 )
    gameTitle.alpha = 0
    gameTitle:setFillColor(0,0,0)
    
    --display playbutton
    local playbutton = display.newGroup()
    sceneGroup:insert(playbutton)
    
    local playbg = display.newImage( sceneGroup, "images/largeTealButton.png", system.ResourceDirectory, globals.centerX, display.contentHeight - 115)
    playbg.alpha = 0
    local playtext = display.newText( sceneGroup, "play", globals.centerX, display.contentHeight - 115, globals.font.regular, 25 )
    playtext.alpha = 0

    --display settingsbutton
    local settingsbutton = display.newImage( sceneGroup, "images/settingsbutton.png", system.ResourceDirectory, globals.centerX, display.contentHeight - 45)
    settingsbutton.alpha = 0
    sceneGroup:insert(settingsbutton)
    
    --Appear into screen
    transition.to(gameTitle,{time = 1000 , alpha = 1 })
    transition.to(playbg, {time = 1200, alpha = 1})
    transition.to(playtext, {time = 1200, alpha = 1})
    transition.to(settingsbutton, {time = 1400, alpha = 1})
    
    local function gotoGame()
        composer.gotoScene("game", {effect = "slideLeft"})
    end
    local function gotoSettings()
        composer.gotoScene("settings", {effect = "slideLeft"})
    end
    --Add listeners
    playbg:addEventListener("tap", gotoGame)
    settingsbutton:addEventListener("tap", gotoSettings)
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