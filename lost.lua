--Patterns
--lost.lua
local composer = require( "composer" )
local scene = composer.newScene()
local globals = require("globals")
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here
local scoreText
---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )
    print(globals.score)
    local sceneGroup = self.view
    --Fix placement + spacing
    local scoreTitle = display.newText( sceneGroup, "score", globals.centerX, 40, globals.font.regular, 50 )
    scoreTitle:setFillColor(0,0,0)
    scoreText = display.newText( sceneGroup, globals.score, globals.centerX, 115, globals.font.regular, 50 )
    scoreText:setFillColor(0,0,0)
    local bestScoreTitle = display.newText( sceneGroup, "best score", globals.centerX, 190, globals.font.regular, 50)
    bestScoreTitle:setFillColor(0,0,0)
    local bestScoreText = display.newText( sceneGroup, globals.settings.highScore, globals.centerX, 265, globals.font.regular, 50 )
    bestScoreText:setFillColor(0,0,0)
    
    local playAgainbg = display.newImage( sceneGroup, "images/largeTealButton.png", system.ResourceDirectory, globals.centerX, 365)
    sceneGroup:insert(playAgainbg)
    local playAgainText = display.newText( sceneGroup, "play again", globals.centerX, 365, globals.font.regular, 25 )
    local function gotoGame()
        composer.gotoScene("game", {effect = "slideRight"})
        globals.score = 0
    end
    playAgainbg:addEventListener("tap", gotoGame)
    
    local exitbg = display.newImage( sceneGroup, "images/largeGreenButton.png", system.ResourceDirectory, globals.centerX, 435)
    sceneGroup:insert(exitbg)
    local exitText = display.newText( sceneGroup, "exit", globals.centerX, 435, globals.font.regular, 25 )
    local function gotoMenu()
        composer.gotoScene("menu", {effect = "slideRight"})
        globals.score = 0
    end
    exitbg:addEventListener("tap", gotoMenu)
end

-- "scene:show()"
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        scoreText.text = globals.score
--        --Ads
--        local ads = require "ads" --Corona's ads library
--        
--        local function adListener(event)
--            print("event.isError = " .. tostring(event.isError))
--        end
--        
--        ads.init( "admob", "Patterns", adListener ) --Initialize the ads
--        
--        -- initial variables
--        local sysModel = system.getInfo("model")
--        local sysEnv = system.getInfo("environment")
--        
--        -- if on simulator, let user know they must build for device
--        if sysEnv == "simulator" then
--            print( "Please build for device or Xcode simulator to test this sample.")
--        else
--            -- start with banner ad
--            ads.show( "banner", { x=0, y=0, interval = 50} ) --Show ads
--        end
        
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        composer.returnTo = "menu"
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

