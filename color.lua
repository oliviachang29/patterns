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
    local titleText = display.newText( sceneGroup, "COLOR", globals.centerX, display.contentHeight - 525, globals.font.regular, 32 )
    titleText:setFillColor(0,0,0)
    local colorDot = {}
    for i = 1, 9 do
        colorDot[i] = display.newImage( sceneGroup, "images/smallDot/" .. i .. ".png")
        colorDot[i].alpha = 0.35
        if i == globals.settings.color then
            transition.to(colorDot[i], {time = 200, alpha = 1})
        end
        --Set the x coordinate
        if i == 1  or i == 2 or i == 3 then
            colorDot[i].x = display.contentWidth - 235
        elseif i == 4 or i == 5 or i == 6 then
            colorDot[i].x = display.contentWidth- 160
        elseif i == 7 or i == 8 or i == 9 then
            colorDot[i].x = display.contentWidth - 85
        end
        --Set the y coordinate
        if i == 1  or i == 4 or i == 7 then
            colorDot[i].y = display.contentHeight - 375
        elseif i == 2 or i == 5 or i == 8 then
            colorDot[i].y = display.contentHeight - 300
        elseif i == 3 or i == 6 or i == 9 then
            colorDot[i].y = display.contentHeight - 225
        end
    end
--    for i = 1, 9 do
--        colorDot[i]:addEventListener("tap", switchColor)
--    end
    local function switchColor(event)
        for i = 1, 9 do
            colorDot[i].alpha = 0.35
        end
        transition.to(event.target, {time = 200, alpha = 1})
        if event.target == colorDot[1] then
            globals.settings.color = 1
        elseif event.target == colorDot[2] then
            globals.settings.color = 2
        elseif event.target == colorDot[3] then
            globals.settings.color = 3
        elseif event.target == colorDot[4] then
            globals.settings.color = 4
        elseif event.target == colorDot[5] then
            globals.settings.color = 5
        elseif event.target == colorDot[6] then
            globals.settings.color = 6
        elseif event.target == colorDot[7] then
            globals.settings.color = 7
        elseif event.target == colorDot[8] then
            globals.settings.color = 8
        elseif event.target == colorDot[9] then
            globals.settings.color = 9
        end
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
    local savebg = display.newImage( sceneGroup, "images/smallTealButton.png", system.ResourceDirectory, globals.centerX, display.contentHeight - 90)
    local saveText = display.newText( sceneGroup, "save", globals.centerX, display.contentHeight - 90, globals.font.regular, 25 )
    savebg:addEventListener("tap", gotoSettings)
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

