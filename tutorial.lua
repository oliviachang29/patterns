--Patterns
--tutorial.lua
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
    local ding = audio.loadSound("audio/ding.wav")
    local function scene4()
        local helloThereText = display.newText( sceneGroup, "Hello there.", globals.centerX, display.contentHeight - 450, globals.font.regular, 23 )
        helloThereText:setFillColor(0,0,0)
        local hibg = display.newImage( sceneGroup, "images/smallTealButton.png", system.ResourceDirectory, globals.centerX, display.contentHeight - 90)
        local hiText = display.newText( sceneGroup, "hi.", globals.centerX, display.contentHeight - 90, globals.font.regular, 23 )
        local function gotoScene2()
            transition.to(helloThereText, {time = 750, x = display.contentWidth - 1000})
            transition.to(hibg, {time = 750, x = display.contentWidth - 1000})
            transition.to(hiText, {time = 750, x = display.contentWidth - 1000, onComplete = scene2})
            --Make them nil
            helloThereText, hibg, hiText = nil, nil, nil
        end
        hibg:addEventListener("tap", gotoScene2)
    end
    
    local function scene3()
        local yourTurn = display.newText( sceneGroup, "Your turn:", globals.centerX, display.contentHeight - 475, globals.font.regular, 23 )
        local pressThoseDots = display.newText( sceneGroup, "Press those dots.", globals.centerX, display.contentHeight - 450, globals.font.regular, 23 )
        local sameOrder = display.newText( sceneGroup, "in that same order.", globals.centerX, display.contentHeight - 425, globals.font.regular, 23 )
        yourTurn:setFillColor(0,0,0)
        pressThoseDots:setFillColor(0,0,0)
        sameOrder:setFillColor(0,0,0)
        
        local dot = {}
        for i = 1, 9 do
            dot[i] = display.newImage("images/smallDot/1.png")
            sceneGroup:insert(dot[i])
            if i == 1  or i == 2 or i == 3 then
                dot[i].x = display.contentWidth - 235
            elseif i == 4 or i == 5 or i == 6 then
                dot[i].x = display.contentWidth- 160
            elseif i == 7 or i == 8 or i == 9 then
                dot[i].x = display.contentWidth - 85
            end
            --Set the y coordinate
            if i == 1  or i == 4 or i == 7 then
                dot[i].y = display.contentHeight - 350
            elseif i == 2 or i == 5 or i == 8 then
                dot[i].y = display.contentHeight - 275
            elseif i == 3 or i == 6 or i == 9 then
                dot[i].y = display.contentHeight - 200
            end
        end
        
        local function gotoScene4()
            for i = 1, 9 do
                transition.to(dot[i], {time = 750, x = display.contentWidth - 1000})
                dot[i] = nil
            end
            transition.to(yourTurn, {time = 750, x = display.contentWidth - 1000})
            transition.to(pressThoseDots, {time = 750, x = display.contentWidth - 1000})
            transition.to(sameOrder, {time = 750, x = display.contentWidth - 1000, onComplete = scene4})
            --Make them nil
            yourTurn, pressThoseDots, sameOrder = nil, nil, nil
        end
        
        local timesEntered = 0
        local function userEnter()
            timesEntered = timesEntered + 1
            i = timesEntered
            local function onTouch(event)
                audio.play(ding)
                local function removeFlash(obj)
                    if i == 4 then
                        gotoScene4()
                    else
                        userEnter()
                    end
                    transition.to(obj, {time = 250, xScale = 1, yScale = 1})
                end
                transition.to(event.target, {time = 250, xScale = 2, yScale = 2, onComplete = removeFlash})
                for i = 1, 9 do
                    dot[i]:removeEventListener("touch", onTouch)
                end
            end
            for i = 1, 9 do
                dot[i]:addEventListener("touch", onTouch)
            end
        end
        userEnter()
    end
    
    local function scene2()
        local memorizeText = display.newText( sceneGroup, "Memorize this pattern.", globals.centerX, display.contentHeight - 450, globals.font.regular, 23 )
        memorizeText:setFillColor(0,0,0)
        local dot = {}
        for i = 1, 9 do
            dot[i] = display.newImage("images/smallDot/1.png")
            sceneGroup:insert(dot[i])
            if i == 1  or i == 2 or i == 3 then
                dot[i].x = display.contentWidth - 235
            elseif i == 4 or i == 5 or i == 6 then
                dot[i].x = display.contentWidth- 160
            elseif i == 7 or i == 8 or i == 9 then
                dot[i].x = display.contentWidth - 85
            end
            --Set the y coordinate
            if i == 1  or i == 4 or i == 7 then
                dot[i].y = display.contentHeight - 350
            elseif i == 2 or i == 5 or i == 8 then
                dot[i].y = display.contentHeight - 275
            elseif i == 3 or i == 6 or i == 9 then
                dot[i].y = display.contentHeight - 200
            end
        end
        
        local pattern = {}
        local timesFound = 0
        local function findPattern()
            audio.play(ding)
            timesFound = timesFound + 1
            local i = timesFound
            print("Finding dot " .. i .." in pattern")
            pattern[i] = dot[math.random(9)]
            local function removeFlash()
                transition.to(pattern[i], {time = 250, xScale = 1, yScale = 1})
            end
            transition.to(pattern[i], {time = 250, xScale = 2, yScale = 2, onComplete = removeFlash})
        end
        timer.performWithDelay( 750, findPattern, 4 )
        
        local okbg = display.newImage( sceneGroup, "images/smallTealButton.png", system.ResourceDirectory, globals.centerX, display.contentHeight - 90)
        local okText = display.newText( sceneGroup, "ok.", globals.centerX, display.contentHeight - 90, globals.font.regular, 23 )
        local function gotoScene3()
            if timesFound == 4 then
                for i = 1, 9 do
                    transition.to(dot[i], {time = 750, x = display.contentWidth - 1000})
                    dot[i] = nil
                end
                transition.to(okbg, {time = 750, x = display.contentWidth - 1000})
                transition.to(okText, {time = 750, x = display.contentWidth - 1000})
                transition.to(memorizeText, {time = 750, x = display.contentWidth - 1000, onComplete = scene3})
                --Make them nil
                okbg, okText, memorizeText = nil, nil, nil
            end
        end
        okbg:addEventListener("tap", gotoScene3)
    end
    
    local function scene1()
        local helloThereText = display.newText( sceneGroup, "Hello there.", globals.centerX, display.contentHeight - 450, globals.font.regular, 23 )
        helloThereText:setFillColor(0,0,0)
        local hibg = display.newImage( sceneGroup, "images/smallTealButton.png", system.ResourceDirectory, globals.centerX, display.contentHeight - 90)
        local hiText = display.newText( sceneGroup, "hi.", globals.centerX, display.contentHeight - 90, globals.font.regular, 23 )
        local function gotoScene2()
            transition.to(helloThereText, {time = 750, x = display.contentWidth - 1000})
            transition.to(hibg, {time = 750, x = display.contentWidth - 1000})
            transition.to(hiText, {time = 750, x = display.contentWidth - 1000, onComplete = scene2})
            --Make them nil
            helloThereText, hibg, hiText = nil, nil, nil
        end
        hibg:addEventListener("tap", gotoScene2)
    end
    --Start
    scene1()
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
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

