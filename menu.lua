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
    local gameTitle = display.newText( sceneGroup, "patterns", globals.centerX, display.contentHeight - 425, globals.font.regular, 65 )
    gameTitle.alpha = 0
    gameTitle:setFillColor(0,0,0)
    --display playbutton
    local playbutton = display.newImage("images/playbutton.png")
    playbutton.alpha = 0
    playbutton.x, playbutton.y = globals.centerX, display.contentHeight - 175
    sceneGroup:insert(playbutton)
    
    --display settingsbutton
    local settingsbutton = display.newImage("images/settingsbutton.png")
    settingsbutton.alpha = 0
    settingsbutton.x, settingsbutton.y =  globals.centerX, display.contentHeight - 50
    sceneGroup:insert(settingsbutton)
    
    local function gotoGame()
        composer.gotoScene("game", {effect = "slideLeft"})
    end
    
    --1. appear into screen
    transition.to(gameTitle,{time = 1000 , alpha = 1 })
    transition.to(playbutton, {time = 1200, alpha = 1})
    transition.to(settingsbutton, {time = 1400, alpha = 1})
    playbutton:addEventListener("tap", gotoGame)
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