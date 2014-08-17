--Patterns
--game.lua
local composer = require( "composer" )
local scene = composer.newScene()
local globals = require("globals")

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
local pauseButton
local pausedText
local resumebg
local resumetext
local restartbg
local restarttext
local exitbg
local exittext
local createDot
local isRunning

function scene:create( event )
    local sceneGroup = self.view
    --Pausing
    pauseButton = display.newImage( sceneGroup, "images/pauseButton.png", system.ResourceDirectory, 40, 20)
    --PAUSED text
    pausedText = display.newText( sceneGroup, "PAUSED", display.contentWidth + 500, 140, globals.font.regular, 32 )
    pausedText:setFillColor(0,0,0)
    --Resume button
    resumebg = display.newImage( sceneGroup, "images/largeTealButton.png", system.ResourceDirectory, 1000, 200)
    resumetext = display.newText( sceneGroup, "resume", 1000, 200, globals.font.regular, 25 )
    
    --Restart button
    restartbg = display.newImage( sceneGroup, "images/largePinkButton.png", system.ResourceDirectory, display.contentWidth + 500, 270)
    restarttext = display.newText( sceneGroup, "restart", display.contentWidth + 500, 270, globals.font.regular, 25 )
    --Exit button
    exitbg = display.newImage( sceneGroup, "images/largeGreenButton.png", system.ResourceDirectory, display.contentWidth + 500, 340)
    exittext = display.newText( sceneGroup, "exit", display.contentWidth + 500, 340, globals.font.regular, 25 )
    
    --Dots
    createDot = function()
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
    
    --Load Sounds
    ding = {}
    for i = 1, globals.settings.numDots do
        ding[i] = audio.loadSound("audio/ding/" .. i .. ".mp3")
    end
end


function scene:show( event )
    
    local sceneGroup = self.view
    local phase = event.phase
    local sceneGroup = display.newGroup()
    
    if ( phase == "will" ) then
        createDot()
        globals.score = 0
        scoreText.text = globals.score
        isRunning = true
        numLife = 3
        for i = 1, 3 do
            life[i].alpha = 1
        end
        timeLeft = 10
        timeText.text = timeLeft
        
        success = audio.loadSound("audio/success.wav")
        fail = audio.loadSound("audio/fail.wav")
        audio.setVolume(0.8)
        timeLeft = 10
    elseif ( phase == "did" ) then
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
            print("currentFunction  = " .. currentFunction)
            if isRunning == true then
                if flashSpeed >= 30 then
                    flashSpeed = flashSpeed - 5
                end
                if timerHandler ~= nil then timer.cancel(timerHandler) end
                timeLeft = 10
                timeText.text = timeLeft
                for i = 1, globals.settings.numDots do
                    globals.removeAllListeners(dot[i])
                end
                --Check Pattern
                local numCorrect = 0
                if userPattern ~= nil then
                    for i = 1, #userPattern do
                        if userPattern[i] == pattern[i] then
                            numCorrect = numCorrect + 1
                        end
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
                    end
                    system.vibrate()
                    numLife = numLife - 1
                    if numLife == 2 or numLife == 1  then
                        transition.to(life[numLife + 1], {time = 250, alpha = 0})
                        timer.performWithDelay(750, findPattern)
                        print("numLife = " .. numLife)
                    elseif numLife == 0 then
                        transition.to(life[1], {time = 250, alpha = 0, onComplete = composer.gotoScene("lost", {effect = "slideLeft"})})
                        timer.cancel(timerHandler)
                        timerHandler = nil
                        print("numLife = " .. numLife)
                    end
                end
                if pattern ~= nil then pattern = nil end
                if userPattern ~= nil then userPattern = nil end
                numCorrect = nil
                timerHandler = nil
            end
        end
        
        local function enterPattern()
            currentFunction = "enterPattern"
            print("currentFunction  = " .. currentFunction)
            if isRunning == true then
                if timeText == nil then
                    print("ERROR: timeText is nil.")
                    return
                end
                local function timeCount()
                    timeLeft = timeLeft -1
                    timeText.text = timeLeft
                    if timeLeft == 0 then
                        checkPattern()
                    end
                end
                timerHandler =  timer.performWithDelay(1000, timeCount, 10)
                
                local timesEntered = 0
                userPattern = {}
                local function userEnter()
                    timesEntered = timesEntered + 1
                    i = timesEntered
                    local function onTouch(event)
                        currentFunction = "enterDot"
                        print("currentFunction = " .. currentFunction)
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
                            transition.to(obj, {time = flashSpeed, tag = dot, xScale = 1, yScale = 1})
                        end
                        transition.to(event.target, {time = flashSpeed, tag = dot, xScale = 2, yScale = 2, onComplete = removeFlash})
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
        
        findPattern = function()
            currentFunction = "findPattern"
            print("currentFunction  = " .. currentFunction)
            if isRunning == true then
                time = 10
                math.randomseed(os.time())
                pattern = {}
                local timesFound = 0
                
                local function findDot()
                    currentFunction = "findDot"
                    print("currentFunction  = " .. currentFunction)
                    if isRunning == true then
                        timesFound = timesFound + 1
                        local i = timesFound
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
                            transition.to(pattern[i], {time = flashSpeed, tag = dot, xScale = 1, yScale = 1, onComplete = checkIfFoundTimes})
                        end
                        transition.to(pattern[i], {time = flashSpeed, tag = dot, xScale = 2, yScale = 2, onComplete = removeFlash})
                    end
                end
                findDot()
            end
        end
        findPattern()
        
        local function pauseGame()
            local function transitionPauseGroup(inOut)
                transition.to(pausedText, {time = 250, transition = easing.inQuad, x = inOut})
                transition.to(resumebg, {time = 350, transition = easing.inQuad, x = inOut})
                transition.to(resumetext, {time = 350, transition = easing.inQuad, x = inOut})
                transition.to(restartbg, {time = 450, transition = easing.inQuad, x = inOut})
                transition.to(restarttext, {time = 450, transition = easing.inQuad, x = inOut})
                transition.to(exitbg, {time = 550, transition = easing.inQuad, x = inOut})
                transition.to(exittext, {time = 550, transition = easing.inQuad, x = inOut})
            end
            local function transitionOthers()
                transition.to(pauseButton, {time = 200, alpha = 1})
                for i = 1, globals.settings.numDots do
                    transition.to(dot[i], {time = 200, alpha = 1})
                end
            end
            local function makeNil()
                if pattern ~= nil then pattern = nil end
                if userPattern ~= nil then userPattern = nil end
            end
            local function removeButtonListeners(bool)
                globals.removeAllListeners(resumebg)
                globals.removeAllListeners(restartbg)
                globals.removeAllListeners(exitbg)
                if bool == true then globals.removeAllListeners(pauseButton) end
            end
            isRunning = false
            transition.pause(dot)
            if timerHandler ~= nil then
                timer.pause(timerHandler)
            end
            transition.to(pauseButton, {time = 150, alpha = 0})
            for i = 1, globals.settings.numDots do
                transition.to(dot[i], {time = 150, alpha = 0})
            end
            transitionPauseGroup(globals.centerX)
            local function resumeGame()
                print("Resuming game")
                makeNil()
                removeButtonListeners(false)
                isRunning = true
                if timerHandler ~= nil then
                    timer.resume(timerHandler)
                end
                transitionOthers()
                transitionPauseGroup(1000)
                
                if currentFunction == "findPattern" or currentFunction == "findDot" then
                    transition.cancel(dot)
                    timer.performWithDelay(200, findPattern)
                elseif currentFunction == "checkPattern" then
                    timer.performWithDelay(200, findPattern)
                else
                    transition.resume(dot)
                end
            end
            local function restartGame()
                print("Restarting game")
                removeButtonListeners(false)
                makeNil()
                transition.cancel(dot)
                for i = 1, globals.settings.numDots do
                    display.remove(dot[i])
                    dot[i] = nil
                end
                timer.performWithDelay(200, createDot)
                isRunning = true
                if timerHandler ~= nil then
                    timer.cancel(timerHandler)
                end
                transitionPauseGroup(1000)
                transitionOthers()
                globals.score = 0
                scoreText.text = globals.score
                timeLeft = 10
                timeText.text = timeLeft
                for i = 1, 3 do
                    life[i].alpha = 1
                end
                numLife = 3
                timer.performWithDelay(200, findPattern)
            end
            local function exitGame()
                print("Exiting game")
                removeButtonListeners(true)
                makeNil()
                transition.cancel(dot)
                transitionPauseGroup(1000)
                timer.performWithDelay(400, transitionOthers)
                if timerHandler ~= nil then
                    timer.cancel(timerHandler) 
                    timerHandler = nil
                end
                composer.gotoScene("menu", {effect = "slideRight"})
            end
            resumebg:addEventListener("tap", resumeGame)
            restartbg:addEventListener("tap", restartGame)
            exitbg:addEventListener("tap", exitGame)
            print("Paused game")
        end
        pauseButton:addEventListener("tap", pauseGame)
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
    elseif ( phase == "did" ) then
        for i = 1, globals.settings.numDots do
            if dot[i].xScale == 2 and dot[i].yScale == 2 then
                transition.to(dot[i], {time = flashSpeed, xScale = 1, yScale = 1})
            end
        end
        for i = 1, globals.settings.numDots do
            display.remove(dot[i])
            dot[i] = nil
        end
    end
end


function scene:destroy( event )
    local sceneGroup = self.view
    for i = 1, globals.settings.numDots do
        audio.dispose(ding[i])
        ding[i] = nil
    end
end

---------------------------------------------------------------------------------
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------
return scene