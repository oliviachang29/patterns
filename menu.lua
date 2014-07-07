--Patterns
--menu.lua

local composer = require( "composer" )
local scene = composer.newScene()
local globals = require("globals")
--local ads = require "ads" --Corona's ads library

-- local forward references should go here
local playbg

-- "scene:create()"
function scene:create( event )
    
    local sceneGroup = self.view
    
    --display game title
    local gameTitle = display.newText( sceneGroup, "patterns", globals.centerX, -300, globals.font.regular, 65 )
    gameTitle:setFillColor(0,0,0)
    
    --display playbutton
    playbg = display.newImage( sceneGroup, "images/largeTealButton.png", system.ResourceDirectory, globals.centerX, 800)
    local playtext = display.newText( sceneGroup, "play", globals.centerX, 850, globals.font.regular, 25 )
    
    --display settingsbutton
    local settingsbutton = display.newImage( sceneGroup, "images/settingsbutton.png", system.ResourceDirectory, globals.centerX, 900)
    sceneGroup:insert(settingsbutton)
    
    --Appear into screen
    transition.to(gameTitle,{time = 1000 , y = 50 })
    transition.to(playbg, {time = 1200, y = 365})
    transition.to(playtext, {time = 1200, y = 365})
    transition.to(settingsbutton, {time = 1400, y = 435})
    local function gotoSettings()
        composer.gotoScene("settings", {effect = "slideLeft"})
    end
    local function gotoGame()
        composer.gotoScene("game", {effect = "slideLeft"})
        playbg:removeEventListener("tap", gotoGame)
    end
    --Add listeners
    settingsbutton:addEventListener("tap", gotoSettings)
    playbg:addEventListener("tap", gotoGame)
end

-- "scene:show()"
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
--        --Ads
--        local function adListener(event)
--            print("event.isError = " .. tostring(event.isError))
--        end
--        
--        ads.init( "admob", "Patterns", adListener ) --Initialize the ads
--        
--        -- start with banner ad
--        ads.show( "banner", { x=0, y=0, interval = 50} ) --Show ads
    elseif ( phase == "did" ) then
        composer.returnTo = nil
        
    end
end

-- "scene:hide()"
function scene:hide( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        
    elseif ( phase == "did" ) then
--        ads.hide()
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