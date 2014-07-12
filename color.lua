--Patterns
--color.lua
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
    --Color order
    --1. Teal
    --2. Pink
    --3. Dark Green
    --4. Orange
    --5. Red
    --6. Dark Blue
    --7. Blue
    --8. Purple
    --9. Green
    local sceneGroup = self.view
    local titleText = display.newText( sceneGroup, "COLOR", globals.centerX, 45, globals.font.regular, 32 )
    titleText:setFillColor(0,0,0)
    local colorDot = {}
    for i = 1, 9 do
        colorDot[i] = display.newImage( sceneGroup, "images/smallDot/" .. i .. ".png")
        colorDot[i].alpha = 0.35
        colorDot[i].id = i
--        colorDot[i].r = i
--        colorDot[i].g = i
--        colorDot[i].b = i
        if i == globals.settings.color then
            transition.to(colorDot[i], {time = 200, alpha = 1})
        end
        --Set the x coordinate
        if i == 1  or i == 2 or i == 3 then
            colorDot[i].x = 85
        elseif i == 4 or i == 5 or i == 6 then
            colorDot[i].x = 160
        elseif i == 7 or i == 8 or i == 9 then
            colorDot[i].x = 235
        end
        --Set the y coordinate
        if i == 1  or i == 4 or i == 7 then
            colorDot[i].y = 150
        elseif i == 2 or i == 5 or i == 8 then
            colorDot[i].y = 225
        elseif i == 3 or i == 6 or i == 9 then
            colorDot[i].y = 300
        end
    end
    
    local function switchColor(event)
        for i = 1, 9 do
            colorDot[i].alpha = 0.35
        end
        transition.to(event.target, {time = 225, alpha = 1})
        globals.settings.color = event.target.id
        print("globals.settings.color is " .. globals.settings.color)
        saveTable(globals.settings, "settings.json")
    end
    for i = 1, 9 do
        colorDot[i]:addEventListener("touch", switchColor)
    end
    
    local function gotoSettings()
        composer.gotoScene("settings", {effect = "slideRight"})
    end
    --Done button
    local savebg = display.newImage( sceneGroup, "images/smallTealButton.png", system.ResourceDirectory, globals.centerX, 400)
    local saveText = display.newText( sceneGroup, "save", globals.centerX, 400, globals.font.regular, 25 )
    savebg:addEventListener("tap", gotoSettings)
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

