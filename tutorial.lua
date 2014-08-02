--Patterns
--tutorial.lua
local composer = require( "composer" )
local scene = composer.newScene()
local globals = require("globals")


-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
end

-- "scene:show()"
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        -- local forward references should go here
        local pattern
        local userPattern
        local ding = {}
        local userEnter
        local userCorrect
        for i = 1, 9 do
            ding[i] = audio.loadSound("audio/ding/" .. i .. ".mp3")
        end
        local function scene4()
            local youGotIt = display.newText( sceneGroup, "Ready to play?", globals.centerX, 50, globals.font.regular, 23 )
            youGotIt:setFillColor(0,0,0)
            local rememberText = display.newText( sceneGroup, "Remember:", globals.centerX, 150, globals.font.regular, 23 )
            rememberText:setFillColor(0,0,0)
            local threeStrikes = display.newText( sceneGroup, "3 strikes and you're out.", globals.centerX, 180, globals.font.regular, 23 )
            threeStrikes:setFillColor(0,0,0)
            local yepbg = display.newImage( sceneGroup, "images/smallTealButton.png", system.ResourceDirectory, globals.centerX, 400)
            local yepText = display.newText( sceneGroup, "yep.", globals.centerX, 400, globals.font.regular, 23 )
            local thatsOk
            if userCorrect == false then
                youGotIt.text = "Wrong pattern,"
                thatsOk = display.newText( sceneGroup, "but that's ok.", globals.centerX, 80, globals.font.regular, 23 )
                thatsOk:setFillColor(0,0,0)
                yepText.text = "got it."
            end
            local function goto()
                transition.to(youGotIt, {time = 750, x = 1000})
                if thatsOk ~= nil then
                    transition.to(thatsOk, {time = 750, x = 1000})
                    thatsOk = nil
                end
                transition.to(rememberText, {time = 750, x = 1000})
                transition.to(threeStrikes, {time = 750, x = 1000, onComplete = scene1})
                transition.to(yepbg, {time = 750, x = 1000})
                transition.to(yepText, {time = 750, x = 1000})
                youGotIt, rememberText, threeStrikes, yepbg, yepText = nil, nil, nil, nil, nil
                if globals.settings.openedBefore == false then
                    composer.gotoScene("menu", {effect = "slideLeft"})
                    globals.settings.openedBefore = true
                    saveTable(globals.settings, "settings.json")
                elseif globals.settings.openedBefore == true then
                    composer.gotoScene("about", {effect = "slideRight"})
                end
            end
            yepbg:addEventListener("tap", goto)
        end
        
        local function scene3()
            local text = display.newText( sceneGroup, "Enter that same pattern.", globals.centerX, 90, globals.font.regular, 23 )
            text:setFillColor(0,0,0)
            
            local dot = {}
            for i = 1, 9 do
                dot[i] = display.newImage("images/smallDot/1.png")
                sceneGroup:insert(dot[i])
                --Set the x coordinate
                if i == 1  or i == 2 or i == 3 then
                    dot[i].x = 85
                elseif i == 4 or i == 5 or i == 6 then
                    dot[i].x = 160
                elseif i == 7 or i == 8 or i == 9 then
                    dot[i].x = 235
                end
                --Set the y coordinate
                if i == 1  or i == 4 or i == 7 then
                    dot[i].y = 150
                elseif i == 2 or i == 5 or i == 8 then
                    dot[i].y = 225
                elseif i == 3 or i == 6 or i == 9 then
                    dot[i].y = 300
                end
                dot[i].id = i
            end
            
            local function gotoScene4()
                for i = 1, 9 do
                    transition.to(dot[i], {time = 750, x = display.contentWidth - 1000})
                    dot[i] = nil
                end
                transition.to(text, {time = 750, x = display.contentWidth - 1000, onComplete = scene4})
                text = nil
            end
            local function checkPattern()
                local numCorrect = 0
                for i = 1, 4 do
                    if userPattern[i] == pattern[i] then
                        numCorrect = numCorrect + 1
                    end
                end
                if numCorrect == 4 then
                    userCorrect = true
                    print("user entered pattern correctly")
                else
                    userCorrect = false
                    print("user entered pattern incorrectly")
                end
                gotoScene4()
            end
            userPattern = {}
            local timesEntered = 0
            userEnter = function()
                timesEntered = timesEntered + 1
                i = timesEntered
                local function onTouch(event)
                    if globals.settings.sound == true then
                        audio.play(ding[event.target.id])
                    end
                    userPattern[i] = event.target.id
                    local function removeFlash(obj)
                        if i == 4 then
                            checkPattern()
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
            local memorizeText = display.newText( sceneGroup, "Memorize this pattern.", globals.centerX, 90, globals.font.regular, 23 )
            memorizeText:setFillColor(0,0,0)
            local dot = {}
            for i = 1, 9 do
                dot[i] = display.newImage("images/smallDot/1.png")
                sceneGroup:insert(dot[i])
                --Set the x coordinate
                if i == 1  or i == 2 or i == 3 then
                    dot[i].x = 85
                elseif i == 4 or i == 5 or i == 6 then
                    dot[i].x = 160
                elseif i == 7 or i == 8 or i == 9 then
                    dot[i].x = 235
                end
                --Set the y coordinate
                if i == 1  or i == 4 or i == 7 then
                    dot[i].y = 150
                elseif i == 2 or i == 5 or i == 8 then
                    dot[i].y = 225
                elseif i == 3 or i == 6 or i == 9 then
                    dot[i].y = 300
                end
            end
            pattern = {}
            local timesFound = 0
            local function findPattern()
                timesFound = timesFound + 1
                i = timesFound
                local currentDot = math.random(9)
                pattern[i] = currentDot
                if globals.settings.sound == true then
                    audio.play(ding[currentDot])
                end
                local function removeFlash()
                    transition.to(dot[pattern[i]], {time = 250, xScale = 1, yScale = 1})
                end
                transition.to(dot[pattern[i]], {time = 250, xScale = 2, yScale = 2, onComplete = removeFlash})
            end
            timer.performWithDelay( 750, findPattern, 4 )
            
            local okbg = display.newImage( sceneGroup, "images/smallTealButton.png", system.ResourceDirectory, globals.centerX, 400)
            local okText = display.newText( sceneGroup, "memorized.", globals.centerX, 400, globals.font.regular, 23 )
            local function gotoScene3()
                if timesFound == 4 then
                    for i = 1, 9 do
                        transition.to(dot[i], {time = 750, x = display.contentWidth - 1000})
                        dot[i] = nil
                    end
                    transition.to(okbg, {time = 750, x = display.contentWidth - 1000})
                    transition.to(okText, {time = 750, x = display.contentWidth - 1000})
                    transition.to(memorizeText, {time = 750, x = display.contentWidth - 1000, onComplete = scene3})
                    okbg, okText, memorizeText = nil, nil, nil
                end
            end
            okbg:addEventListener("tap", gotoScene3)
        end
        
        local function scene1()
            local helloThereText = display.newText( sceneGroup, "Hello there.", globals.centerX, 90, globals.font.regular, 23 )
            helloThereText:setFillColor(0,0,0)
            local hibg = display.newImage( sceneGroup, "images/smallTealButton.png", system.ResourceDirectory, globals.centerX, 400)
            local hiText = display.newText( sceneGroup, "hi.", globals.centerX, 400, globals.font.regular, 23 )
            local function gotoScene2()
                transition.to(helloThereText, {time = 750, x = display.contentWidth - 1000})
                transition.to(hibg, {time = 750, x = display.contentWidth - 1000})
                transition.to(hiText, {time = 750, x = display.contentWidth - 1000, onComplete = scene2})
                helloThereText, hibg, hiText = nil, nil, nil
            end
            hibg:addEventListener("tap", gotoScene2)
        end
        --Start
        scene1()
    elseif ( phase == "did" ) then
        if globals.openedBefore == false then
            composer.returnTo = "menu"
        elseif globals.openedBefore == true then
            composer.returnTo = "about"
        end
    end
end

-- "scene:hide()"
function scene:hide( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        
    elseif ( phase == "did" ) then
        
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

