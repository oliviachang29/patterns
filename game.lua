--Patterns
--game.lua

local composer = require( "composer" )
local scene = composer.newScene()
local globals = require("globals")
local tnt = require("tnt")
-- local forward references should go here
local score
local timeLeft
local timeText
-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    --Dots
    --Dot order:
    --1   2   3
    --4   5   6
    --7   8   9
    globals.dot = {}
    for i = 1, 9 do
        globals.dot[i] = display.newImage("images/dot.png")
        sceneGroup:insert(globals.dot[i])
        --Set the x coordinate
        if i == 1  or i == 4 or i == 7 then
            globals.dot[i].x = display.contentWidth - 280
        elseif i == 2 or i == 5 or i == 8 then
            globals.dot[i].x = display.contentWidth-160
        elseif i == 3 or i == 6 or i == 9 then
            globals.dot[i].x = display.contentWidth - 40
        end
        --Set the y coordinate
        if i == 1  or i == 2 or i == 3 then
            globals.dot[i].y = display.contentHeight - 380
        elseif i == 4 or i == 5 or i == 6 then
            globals.dot[i].y = display.contentHeight - 270
        elseif i == 7 or i == 8 or i == 9 then
            globals.dot[i].y = display.contentHeight - 160
        end
    end
    
    --Lives
    --Lives order: 1 2 3
    local livesText = display.newText(sceneGroup, "lives", display.contentWidth - 265, display.contentHeight - 500 , globals.font.regular, 25)
    livesText:setFillColor(0,0,0)
    globals.life = {}
    for i = 1, 3 do
        globals.life[i] = display.newImage("images/fullLife.png")
        sceneGroup:insert(globals.life[i])
        globals.life[i].x = display.contentWidth - (325 - (i * 30))
        globals.life[i].y = display.contentHeight - 465
    end
    
    --Time (A means above)
    local timeA = display.newText(sceneGroup, "time", display.contentWidth - 160, display.contentHeight - 500, globals.font.regular, 25)
    timeA:setFillColor(0,0,0)
    timeLeft = 10
    timeText = display.newText(sceneGroup, timeLeft, display.contentWidth - 160, display.contentHeight - 465, globals.font.regular, 25)
    timeText:setFillColor(0,0,0)
    
    --Score (A means above)
    local scoreA = display.newText(sceneGroup, "score", display.contentWidth - 55, display.contentHeight - 500, globals.font.regular, 25)
    scoreA:setFillColor(0,0,0)
    score = 0
    local scoreText = display.newText(sceneGroup, score, display.contentWidth - 55, display.contentHeight - 465, globals.font.regular, 25)
    scoreText:setFillColor(0,0,0)
end

-- "scene:show()"
function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then

    elseif ( phase == "did" ) then
        local function checkPattern()
            
        end
        --enterPattern isn't working because event.target is nil'
        local function enterPattern()
            if timeText == nil then
                print("ERROR: timeText is nil - User in userDotCopy about to select dots")
                return
            end
            local function timeCount()
                timeLeft = timeLeft -1
                timeText.text = timeLeft
                --                if time == 0 then
                --                    checkPattern()
                --                end
            end
--            if globals.userPattern[i] == globals.pattern[i] then
--                globals.isCorrectPattern[i] = true
--            else
--                globals.isCorrectPattern[i] = false
--            end
            timerHandler =  timer.performWithDelay(1000, timeCount, 10)
            
            local timesEntered = 0
            globals.userPattern = {}
            globals.isCorrectPattern = {}
            local function userEnter()
                timesEntered = timesEntered + 1
                i = timesEntered
                local function onTouch()
                    globals.userPattern[i] = event.target
                    print(event.target) -- event.target is nil
                    local function removeFlash()
                        local function checkIfEnteredTimes()
                            if i == globals.numFlashes then
                                checkPattern()
                            else
                                userEnter()
                            end
                        end
                        transition.to(event.target, {time = globals.flashSpeed, xScale = 1, yScale = 1, onComplete = checkIfEnteredTimes})
                    end
                    transition.to(event.target, {time = globals.flashSpeed, xScale = 2, yScale = 2, onComplete = removeFlash})
                    for i = 1, 9 do
                        globals.dot[i]:removeEventListener("tap", onTouch)
                    end
                end
                for i = 1, 9 do
                    globals.dot[i]:addEventListener("tap", onTouch)
                end
            end
            userEnter()
        end
        
        ---THE GREAT DIVIDE---
        
        
        function globals.findPattern()
            time = 10
            globals.flashSpeed = 280
            --audio.play(ding)
            --find the four random dots
            math.randomseed(os.time())
            globals.pattern = {}
            local timesFound = 0
            
            local function findPattern()
                timesFound = timesFound + 1
                local i = timesFound
                globals.pattern[i] = math.random(9)
                print ("Dot " .. i .. " in pattern is " .. globals.pattern[i]) --> print which dot patternDot1 is
                local function checkIfFoundFourTimes()
                    if i == globals.numFlashes then
                        enterPattern()
                    end
                end
                local function removeFlash()
                    transition.to(globals.dot[globals.pattern[i]], {time = globals.flashSpeed, xScale = 1, yScale = 1, onComplete = checkIfFoundFourTimes})
                end
                transition.to(globals.dot[globals.pattern[i]], {time = globals.flashSpeed, xScale = 2, yScale = 2, onComplete = removeFlash})
            end
            timer.performWithDelay( 500, findPattern, globals.numFlashes )
        end
        
        --Start sequence
        globals.findPattern()
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

