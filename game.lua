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
local pauseButton
local ding
local ding2
local success
local fail
local pausedText
local resumebg
local resumetext
local restartbg
local restarttext
local exitbg
local exittext

--local pauseGroup = display.newGroup()

function scene:create( event )
    local sceneGroup = self.view
    --Not functional while code at line 29, starting at line 265 and line 32 is commented out
    pauseButton = display.newImage( pauseGroup, "images/pauseButton.png", system.ResourceDirectory, display.contentWidth - 280, display.contentHeight - 540)
    --    --PAUSED text
    --    pausedText = display.newText( pauseGroup, "PAUSED", display.contentWidth + 500, display.contentHeight - 400, globals.font.regular, 32 )
    --    pausedText:setFillColor(0,0,0)
    --    --Resume button
    --    resumebg = display.newImage( pauseGroup, "images/largeTealButton.png", system.ResourceDirectory, display.contentWidth + 500, display.contentHeight - 325)
    --    resumetext = display.newText( pauseGroup, "resume", display.contentWidth + 500, display.contentHeight - 325, globals.font.regular, 25 )
    --    --Restart button
    --    restartbg = display.newImage( pauseGroup, "images/largePinkButton.png", system.ResourceDirectory, display.contentWidth + 500, display.contentHeight - 250)
    --    restarttext = display.newText( pauseGroup, "restart", display.contentWidth + 500, display.contentHeight - 250, globals.font.regular, 25 )
    --    --Restart button
    --    exitbg = display.newImage( pauseGroup, "images/largeGreenButton.png", system.ResourceDirectory, display.contentWidth + 500, display.contentHeight - 175)
    --    exittext = display.newText( pauseGroup, "exit", display.contentWidth + 500, display.contentHeight - 175, globals.font.regular, 25 )
    --    sceneGroup:insert(pauseGroup)
    
    --Dots
    -- Dot order: 
    -- Top left starts as 1, moves horizontally then to the next line.
    -- Bottom right is the number of dots
    dot = {}
    for i = 1, globals.settings.numDots do
        if globals.settings.numDots == 9 or globals.settings.numDots == 4 then
            dot[i] = display.newImage("images/dot/" .. globals.settings.color .. ".png")
        elseif globals.settings.numDots == 16 then
            dot[i] = display.newImage("images/smallDot/" .. globals.settings.color .. ".png")
        end
        sceneGroup:insert(dot[i])
    end
    if globals.settings.numDots == 9 then
        for i = 1, 9 do
            --Set the x coordinate
            if i == 1  or i == 4 or i == 7 then
                dot[i].x = display.contentWidth - 280
            elseif i == 2 or i == 5 or i == 8 then
                dot[i].x = display.contentWidth-160
            elseif i == 3 or i == 6 or i == 9 then
                dot[i].x = display.contentWidth - 40
            end
            --Set the y coordinate
            if i == 1  or i == 2 or i == 3 then
                dot[i].y = display.contentHeight - 380
            elseif i == 4 or i == 5 or i == 6 then
                dot[i].y = display.contentHeight - 270
            elseif i == 7 or i == 8 or i == 9 then
                dot[i].y = display.contentHeight - 160
            end
        end
    elseif globals.settings.numDots == 4 then
        for i = 1, 4 do
            --Set the x coordinate
            if i == 1 or i == 3 then
                dot[i].x = display.contentWidth - 200
            elseif i == 2 or i == 4 then
                dot[i].x = display.contentWidth - 100
            end
            --Set the y coordinate
            if i == 1 or i == 2 then
                dot[i].y = display.contentHeight - 300
            elseif i == 3 or i == 4 then
                dot[i].y = display.contentHeight - 200
            end
        end
    elseif globals.settings.numDots == 16 then
        for i = 1, 16 do
            --Set the x coordinate
            if i == 1 or i == 5 or i == 9 or i == 13 then
                dot[i].x = display.contentWidth - 280
            elseif i == 2 or i == 6 or i == 10 or i == 14 then
                dot[i].x = display.contentWidth - 200
            elseif i == 3 or i == 7 or i == 11 or i == 15 then
                dot[i].x = display.contentWidth - 120
            elseif i == 4 or i == 8 or i == 12 or i == 16 then
                dot[i].x = display.contentWidth - 40
            end
            --Set the y coordinate
            if i == 1 or i == 2 or i == 3 or i == 4 then
                dot[i].y = display.contentHeight - 380
            elseif i == 5 or i == 6 or i == 7 or i == 8 then
                dot[i].y = display.contentHeight - 300
            elseif i == 9 or i == 10 or i == 11 or i == 12 then
                dot[i].y = display.contentHeight - 220
            elseif i == 13 or i == 14 or i == 15 or i == 16 then
                dot[i].y = display.contentHeight - 140
            end
        end
    end
    
    --Lives
    --Lives order: 1 2 3
    local livesText = display.newText(sceneGroup, "lives", display.contentWidth - 265, display.contentHeight - 500 , globals.font.regular, 25)
    livesText:setFillColor(0,0,0)
    life = {}
    numLife = 3
    for i = 1, 3 do
        life[i] = display.newImage("images/fullLife.png")
        sceneGroup:insert(life[i])
        life[i].x = display.contentWidth - (325 - (i * 30))
        life[i].y = display.contentHeight - 465
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
    globals.score = 0
    scoreText = display.newText(sceneGroup, globals.score, display.contentWidth - 55, display.contentHeight - 465, globals.font.regular, 25)
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
        
        --        pauseButton.alpha = 1
        --        --Set x to display.contentHeight + 500 for all paused Screen objects
        --        pausedText.x = display.contentHeight + 500
        --        resumebg.x = display.contentHeight + 500
        --        resumetext.x = display.contentHeight + 500
        --        restartbg.x = display.contentHeight + 500
        --        restarttext.x = display.contentHeight + 500
        --        exitbg.x = display.contentHeight + 500
        --        exittext.x = display.contentHeight + 500
--        for i = 1, globals.settings.numDots do
--            dot[i].alpha = 1
--        end
        timeLeft = 10
        ding = audio.loadSound("audio/ding.wav")
        ding2 = audio.loadSound("audio/ding2.wav")
        success = audio.loadSound("audio/success.wav")
        fail = audio.loadSound("audio/fail.wav")
        audio.setVolume(0.8)
        timeLeft = 10
    elseif ( phase == "did" ) then
        local findPattern
        local pattern
        local userPattern
        local timerHandler
        local isRunning = true
        
        local function checkPattern()
            if isRunning == true then
                if globals.flashSpeed >= 40 then
                    globals.flashSpeed = globals.flashSpeed - 4
                end
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
                    timer.performWithDelay(250, findPattern)
                else
                    if globals.settings.sound == true then
                        audio.play(fail)
                    end
                    numLife = numLife - 1
                    if numLife == 2 or numLife == 1  then
                        transition.to(life[numLife + 1], {time = 250, alpha = 0})
                        --                        life[numLife + 1] = nil
                        timer.performWithDelay(250, findPattern)
                    elseif numLife == 0 then
                        transition.to(life[1], {time = 250, alpha = 0, onComplete = composer.gotoScene("lost", {effect = "slideLeft"})})
                        timer.cancel(timerHandler)
                    end
                    print("User lost a life. Current number of lives: " .. numLife)
                end
                pattern = nil
                userPattern = nil
                numCorrect = nil
            end
        end
        
        local function enterPattern()
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
                            audio.play(ding)
                        end
                        userPattern[i] = event.target
                        local function removeFlash(obj)
                            if i == globals.settings.numFlashes then
                                checkPattern()
                            else
                                userEnter()
                            end
                            transition.to(obj, {time = globals.flashSpeed, xScale = 1, yScale = 1, onComplete = checkIfEnteredTimes})
                        end
                        transition.to(event.target, {time = globals.flashSpeed, xScale = 2, yScale = 2, onComplete = removeFlash})
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
                globals.flashSpeed = 280
                --find the four random dots
                math.randomseed(os.time())
                pattern = {}
                local timesFound = 0
                
                local function findPattern()
                    if isRunning == true then
                        if globals.settings.sound == true then
                            audio.play(ding)
                        end
                        timesFound = timesFound + 1
                        local i = timesFound
                        pattern[i] = dot[math.random(globals.settings.numDots)]
                        local function checkIfFoundTimes()
                            if i == globals.settings.numFlashes then
                                enterPattern()
                            end
                        end
                        local function removeFlash()
                            transition.to(pattern[i], {time = globals.flashSpeed, xScale = 1, yScale = 1, onComplete = checkIfFoundTimes})
                        end
                        transition.to(pattern[i], {time = globals.flashSpeed, xScale = 2, yScale = 2, onComplete = removeFlash})
                    end
                    
                end
                timer.performWithDelay( 500, findPattern, globals.settings.numFlashes )
            end
        end
        
        --Start sequence
        findPattern()
        
        local function pauseGame()
            isRunning = false
            transition.pause()
            audio.pause(0)
            if timerHandler ~= nil then
                timer.pause(timerHandler)
            end
            transition.to(pauseButton, {time = 150, alpha = 0})
            for i = 1, globals.settings.numDots do
                transition.to(dot[i], {time = 150, alpha = 0})
            end
            local function gotoMenu()
                transition:cancel()
                audio:stop()
                pauseGroup = nil
                composer.gotoScene("menu", {effect = "slideRight"})
            end
            exitbg:addEventListener("tap", gotoMenu)
            --Transition
            local function transitionResume()
                local function transitionRestart()
                    local function transitionExit()
                        transition.to(exitbg, {time = 250, transition = easing.inQuad, x = globals.centerX})
                        transition.to(exittext, {time = 250, transition = easing.inQuad, x = globals.centerX, onComplete = transitionExit})
                    end
                    transition.to(restartbg, {time = 250, transition = easing.inQuad, x = globals.centerX})
                    transition.to(restarttext, {time = 250, transition = easing.inQuad, x = globals.centerX, onComplete = transitionExit})
                end
                transition.to(resumebg, {time = 250, transition = easing.inQuad, x = globals.centerX})
                transition.to(resumetext, {time = 250, transition = easing.inQuad, x = globals.centerX, onComplete = transitionRestart})
            end
            transition.to(pausedText, {time = 250, transition = easing.inQuad, x = globals.centerX, onComplete = transitionResume})
        end
        --        pauseButton:addEventListener("tap", pauseGame)
        
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
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        for i = 1, globals.settings.numDots do
            if dot[i].xScale == 2 and dot[i].yScale == 2 then
                transition.to(dot[i], {time = globals.flashSpeed, xScale = 1, yScale = 1})
            end
        end
        
        -- Called immediately after scene goes off screen.
    end
end


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