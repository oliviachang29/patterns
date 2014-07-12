--Patterns
--lost.lua
local composer = require( "composer" )
local scene = composer.newScene()
local globals = require("globals")
local ads = require "ads"

-- local forward references should go here
local scoreText

-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    --Score
    local scoreTitle = display.newText( sceneGroup, "score", globals.centerX, 60, globals.font.regular, 40 )
    scoreTitle:setFillColor(0,0,0)
    scoreText = display.newText( sceneGroup, globals.score, globals.centerX, 135, globals.font.regular, 40 )
    scoreText:setFillColor(0,0,0)
    local bestScoreTitle = display.newText( sceneGroup, "best score", globals.centerX, 210, globals.font.regular, 40)
    bestScoreTitle:setFillColor(0,0,0)
    local bestScoreText = display.newText( sceneGroup, globals.settings.highScore, globals.centerX, 285, globals.font.regular, 40 )
    bestScoreText:setFillColor(0,0,0)
    --Buttons
    local playAgainbg = display.newImage( sceneGroup, "images/largeTealButton.png", system.ResourceDirectory, globals.centerX, 365)
    sceneGroup:insert(playAgainbg)
    local playAgainText = display.newText( sceneGroup, "play again", globals.centerX, 365, globals.font.regular, 25 )
    local exitbg = display.newImage( sceneGroup, "images/largeGreenButton.png", system.ResourceDirectory, globals.centerX, 435)
    sceneGroup:insert(exitbg)
    local exitText = display.newText( sceneGroup, "exit", globals.centerX, 435, globals.font.regular, 25 )
    local function goto(event)
        if event.target == playAgainbg then composer.gotoScene("game", {effect = "slideRight"}) else composer.gotoScene("menu", {effect = "slideRight"}) end
        globals.score = 0
    end
    playAgainbg:addEventListener("tap", goto)
    exitbg:addEventListener("tap", goto)
end

-- "scene:show()"
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        scoreText.text = globals.score
        -- if on simulator, let user know they must build for device
        if system.getInfo("environment") == "simulator" then
            print( "Please build for device or Xcode simulator to test this sample.")
        else
            -- start with banner ad
            ads.show( "banner", { x=0, y=-23} ) --Show ads
        end
    elseif ( phase == "did" ) then
        composer.returnTo = "menu"

    end
end

-- "scene:hide()"
function scene:hide( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then

    elseif ( phase == "did" ) then
        ads.hide()
    end
end

-- "scene:destroy()"
function scene:destroy( event )
    
    local sceneGroup = self.view
    
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene

