--Patterns
--game.lua
local composer = require( "composer" )
local scene = composer.newScene()
local globals = require("globals")
local tnt = require("tnt")

-- local forward references should go here
local dot
local scoreText
local timeLeft
local timeText
local life
local numLife
local ding
local success
local fail
local resumebg
local resumetext
local pauseGroup = display.newGroup()

function scene:create( event )
    local sceneGroup = self.view
    sceneGroup:insert(pauseGroup)
--    pauseButton = display.newImage( pauseGroup, "images/pauseButton.png", system.ResourceDirectory, 40, 20)
--    --Resume button
--    resumebg = display.newImage( pauseGroup, "images/largeTealButton.png", system.ResourceDirectory, 1000, 175)
--    resumetext = display.newText( pauseGroup, "resume", 1000, 175, globals.font.regular, 25 )
    
    --    --PAUSED text
    --    pausedText = display.newText( pauseGroup, "PAUSED", display.contentWidth + 500, 400, globals.font.regular, 32 )
    --    pausedText:setFillColor(0,0,0)
    --    --Restart button
    --    restartbg = display.newImage( pauseGroup, "images/largePinkButton.png", system.ResourceDirectory, display.contentWidth + 500, 250)
    --    restarttext = display.newText( pauseGroup, "restart", display.contentWidth + 500, 250, globals.font.regular, 25 )
    --    --Restart button
    --    exitbg = display.newImage( pauseGroup, "images/largeGreenButton.png", system.ResourceDirectory, display.contentWidth + 500, 175)
    --    exittext = display.newText( pauseGroup, "exit", display.contentWidth + 500, 175, globals.font.regular, 25 )
    
    --Dots
    -- Dot order: 
    -- Top left starts as 1, moves horizontally then to the next line.
    -- Bottom right is the number of dots
    dot = {}
    for i = 1, globals.settings.numDots do
        if globals.settings.numDots == 9 then
            dot[i] = display.newImage("images/dot/" .. globals.settings.color .. ".png")
            --Set the x coordinate
            if i == 1  or i == 4 or i == 7 then
                dot[i].x = 40
            elseif i == 2 or i == 5 or i == 8 then
                dot[i].x = 160
            elseif i == 3 or i == 6 or i == 9 then
                dot[i].x = 280
            end
            --Set the y coordinate
            if i == 1  or i == 2 or i == 3 then
                dot[i].y = 180
            elseif i == 4 or i == 5 or i == 6 then
                dot[i].y = 290
            elseif i == 7 or i == 8 or i == 9 then
                dot[i].y = 400
            end
        elseif globals.settings.numDots == 4 then
            dot[i] = display.newImage("images/dot/" .. globals.settings.color .. ".png")
            --Set the x coordinate
            if i == 1 or i == 3 then
                dot[i].x = 100
            elseif i == 2 or i == 4 then
                dot[i].x = 200
            end
            --Set the y coordinate
            if i == 1 or i == 2 then
                dot[i].y = 220
            elseif i == 3 or i == 4 then
                dot[i].y = 320
            end
        elseif globals.settings.numDots == 16 then
            dot[i] = display.newImage("images/smallDot/" .. globals.settings.color .. ".png")
            --Set the x coordinate
            if i == 1 or i == 5 or i == 9 or i == 13 then
                dot[i].x = 40
            elseif i == 2 or i == 6 or i == 10 or i == 14 then
                dot[i].x = 120
            elseif i == 3 or i == 7 or i == 11 or i == 15 then
                dot[i].x = 200
            elseif i == 4 or i == 8 or i == 12 or i == 16 then
                dot[i].x = 280
            end
            --Set the y coordinate
            if i == 1 or i == 2 or i == 3 or i == 4 then
                dot[i].y = 160
            elseif i == 5 or i == 6 or i == 7 or i == 8 then
                dot[i].y = 240
            elseif i == 9 or i == 10 or i == 11 or i == 12 then
                dot[i].y = 320
            elseif i == 13 or i == 14 or i == 15 or i == 16 then
                dot[i].y = 400
            end
        end
        sceneGroup:insert(dot[i])
        dot[i].id = i
    end
    
    --Lives
    --Lives order: 1 2 3
    local livesText = display.newText(sceneGroup, "lives", 55, 60 , globals.font.regular, 25)
    livesText:setFillColor(0,0,0)
    life = {}
    numLife = 3
    for i = 1, 3 do
        life[i] = display.newImage("images/fullLife.png")
        sceneGroup:insert(life[i])
        life[i].x = i * 30
        life[i].y = 90
    end
    
    --Time (A means above)
    local timeA = display.newText(sceneGroup, "time", 160, 60, globals.font.regular, 25)
    timeA:setFillColor(0,0,0)
    timeLeft = 10
    timeText = display.newText(sceneGroup, timeLeft, 160, 90, globals.font.regular, 25)
    timeText:setFillColor(0,0,0)
    
    --Score (A means above)
    local scoreA = display.newText(sceneGroup, "score", 265, 60, globals.font.regular, 25)
    scoreA:setFillColor(0,0,0)
    globals.score = 0
    scoreText = display.newText(sceneGroup, globals.score, 265, 90, globals.font.regular, 25)
    scoreText:setFillColor(0,0,0)
end


function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    local pauseGroup = display.newGroup()
    sceneGroup:insert(pauseGroup)

    if ( phase == "will" ) then
        globals.score = 0
        scoreText.text = globals.score
        isRunning = true
        numLife = 3
        for i = 1, 3 do
            life[i].alpha = 1
        end
        timeLeft = 10
        --Load Sounds
        ding = {}
        for i = 1, 16 do
            ding[i] = audio.loadSound("audio/ding/" .. i .. ".mp3")
        end
        success = audio.loadSound("audio/success.wav")
        fail = audio.loadSound("audio/fail.wav")
        audio.setVolume(0.8)
        timeLeft = 10
    elseif ( phase == "did" ) then
--        composer.returnTo = "menu"
        composer.returnTo = nil
        local findPattern
        local pattern
        local userPattern
        local timerHandler
        local isRunning = true
        local currentFunction
        local flashSpeed = 280
        
        local function checkPattern()
            currentFunction = "checkPattern"
            if isRunning == true then
                if flashSpeed >= 30 then
                    flashSpeed = flashSpeed - 5
                end
                print("flashSpeed = " .. flashSpeed)
                timer.cancel(timerHandler)
                timeLeft = 10
                timeText.text = timeLeft
                --Check Pattern
                local numCorrect = 0
                for i = 1, #userPattern do
                    if userPattern[i] == pattern[i] then
                        numCorrect = numCorrect + 1
                    end
                end
                if numCorrect == globals.settings.numFlashes then
                    if globals.settings.sound == true then
                        audio.play(success)
                    end
                    globals.score = globals.score + 1
                    scoreText.text = globals.score
                    timer.performWithDelay(750, findPattern)
                else
                    if globals.settings.sound == true then
                        audio.play(fail)
                        system.vibrate()
                    end
                    numLife = numLife - 1
                    if numLife == 2 or numLife == 1  then
                        transition.to(life[numLife + 1], {time = 250, alpha = 0})
                        timer.performWithDelay(750, findPattern)
                    elseif numLife == 0 then
                        transition.to(life[1], {time = 250, alpha = 0, onComplete = composer.gotoScene("lost", {effect = "slideLeft"})})
                        timer.cancel(timerHandler)
                    end
                    print("User lost a life. Current number of lives: " .. numLife)
                end
                pattern = nil
                userPattern = nil
                numCorrect = nil
                timerHandler = nil
            end
        end
        
        local function enterPattern()
            currentFunction = "enterPattern"
            if isRunning == true then
                if timeText == nil then
                    print("ERROR: timeText is nil - User in userDotCopy about to select dots")
                    return
                end
                local function timeCount()
                    timeLeft = timeLeft -1
                    timeText.text = timeLeft
                    if timeLeft == 0 then
                        checkPattern()
                        print("Time is 0. Checking pattern.")
                    end
                end
                timerHandler =  timer.performWithDelay(1000, timeCount, 10)
                
                local timesEntered = 0
                userPattern = {}
                local function userEnter()
                    timesEntered = timesEntered + 1
                    i = timesEntered
                    local function onTouch(event)
                        if globals.settings.sound == true then
                            audio.play(ding[event.target.id])
                        end
                        userPattern[i] = event.target
                        local function removeFlash(obj)
                            if i == globals.settings.numFlashes then
                                checkPattern()
                            else
                                userEnter()
                            end
                            tnt:newTransition(obj, {time = 280, xScale = 1, yScale = 1})
                        end
                        tnt:newTransition(event.target, {time = 280, xScale = 2, yScale = 2, onComplete = removeFlash})
                        for i = 1, globals.settings.numDots do
                            dot[i]:removeEventListener("touch", onTouch)
                        end
                    end
                    for i = 1, globals.settings.numDots do
                        dot[i]:addEventListener("touch", onTouch)
                    end
                end
                userEnter()
            end
        end
        
        --Find pattern
        findPattern = function()
            if isRunning == true then
                time = 10
                math.randomseed(os.time())
                pattern = {}
                local timesFound = 0
                
                local function findDot()
                    if isRunning == true then
                        timesFound = timesFound + 1
                        local i = timesFound
                        print(tostring(i))
                        local currentDot = math.random(globals.settings.numDots)
                        pattern[i] = dot[currentDot]
                        if globals.settings.sound == true then
                            audio.play(ding[currentDot])
                        end
                        local function checkIfFoundTimes()
                            if i == globals.settings.numFlashes then
                                enterPattern()
                            else
                                findDot()
                            end
                        end
                        local function removeFlash()
                            tnt:newTransition(pattern[i], {time = flashSpeed, xScale = 1, yScale = 1, onComplete = checkIfFoundTimes})
                        end
                        currentFunction = "findPattern"
                        tnt:newTransition(pattern[i], {time = flashSpeed, xScale = 2, yScale = 2, onComplete = removeFlash})
                    end
                end
                findDot()
            end
        end
        
        --Start sequence
        findPattern()
        
        local function pauseGame()
            isRunning = false
            tnt:pauseAllTransitions()
--            audio.pause(0)
            if timerHandler ~= nil then
                timer.pause(timerHandler)
            end
            transition.to(pauseButton, {time = 150, alpha = 0})
            for i = 1, globals.settings.numDots do
                transition.to(dot[i], {time = 150, alpha = 0})
            end
            transition.to(resumebg, {time = 250, transition = easing.inQuad, x = globals.centerX})
            transition.to(resumetext, {time = 250, transition = easing.inQuad, x = globals.centerX})
            local function resumeGame()
                isRunning = true    
--                audio.resume(0)
                if timerHandler ~= nil then
                    timer.resume(timerHandler)
                end
                transition.to(pauseButton, {time = 150, alpha = 1})
                for i = 1, globals.settings.numDots do
                    transition.to(dot[i], {time = 150, alpha = 1})
                end
                transition.to(resumebg, {time = 250, transition = easing.inQuad, x = 1000})
                transition.to(resumetext, {time = 250, transition = easing.inQuad, x = 1000})
                tnt:resumeAllTransitions()
--                if currentFunction == "checkPattern" then
--                    findPattern()
--                end
            end
            resumebg:addEventListener("tap", resumeGame)
        end
        --pauseButton:addEventListener("tap", pauseGame)
    end
end


function scene:hide( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        if globals.score > globals.settings.highScore then
            globals.settings.highScore = globals.score
        end
        saveTable(globals.settings, "settings.json")
        isRunning = true
        timeLeft = 10
    elseif ( phase == "did" ) then
        for i = 1, globals.settings.numDots do
            if dot[i].xScale == 2 and dot[i].yScale == 2 then
                transition.to(dot[i], {time = flashSpeed, xScale = 1, yScale = 1})
            end
        end
    end
end


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