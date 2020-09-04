local composer = require( "composer" )
local scene = composer.newScene( sceneName )
local functions = require ("functions")
local clocks = {"matchthetime_clockblue.png","matchthetime_clockcyan.png","matchthetime_clockgreen.png","matchthetime_clockorange.png","matchthetime_clockpurple.png","matchthetime_clockyellow.png"}
local scenes = {"6","8","10","2","4","6b","8b","11"}
local hours = {6,8,10,2,4,6,8,11}
local times = {"6","8","10","2","4","6b","8b","11"}
local AClocks ={"6","8","10","2","4","11"}
--local times = {"6","8","10","2","4","6","8","11"}
local txtTimes = {}

local beadnames = {"purplebeads.png","orangebeads.png","greenbeads.png","yellowbeads.png","bluebeads.png"}

local beadsParent = display.newGroup()
local beads = {}
local images = {}
local MatchGroupParent = display.newGroup()
local prevMatch
local tapCount = 0
local count = 1
local myAnimation
local gameComplete = false
local MatchGroup = display.newGroup()
local starFallAnimation
local sheetAmount
local sheetName
local correctSound = audio.loadSound("Audio/beadCorrect.mp3")
local jingleChoose
local audioMusic1 =   audio.loadStream( "Audio/music1.mp3" )
local audioMusic2 =   audio.loadStream( "Audio/music2.mp3" )
local tmrMusicPlay
local aniPlaying = false
local playPraise = true
local tmrPraise
local tmrShowerPlay


local aniScale
local fntSize
local strAdjust
if ( string.sub(system.getInfo( "model" ), 1, 4 ) == "iPad") then
aniScale = 0.5
fntSize = 25
strAdjust = "@2x"

else
aniScale = 0.65
fntSize = 20
strAdjust = "@2x"

end	


local countx = 1
local XanderGroup = display.newGroup()
local XAnimation
local speechGroup = display.newGroup()
				
local function swapSheetX(event)
	if(event.phase=="ended" and count<=1)then
		XAnimation:setSequence( "thinkingside"..count )
        if countx <= 1 then
		XAnimation:play()
		end
		print(count)
	
	end
end

local musicIconGroup = display.newGroup()
local musicIconOff
local musicIconOn
local function toggleMusic(event)

if bPlayMusic == true then
musicIconOff:toFront()
musicIconOff.alpha = 1
musicIconOn.alpha = 0
--musicIconOff:addEventListener("tap", functions.toggleMusic )
audio.setVolume( 0, { channel=1 } )
bPlayMusic = false
else
musicIconOn:toFront()
musicIconOn.alpha = 1
musicIconOff.alpha = 0
--musicIconOn:addEventListener("tap", functions.toggleMusic)
audio.setVolume( 1, { channel=1 } )
bPlayMusic = true
end
end

local function setupMusicIcon()
musicIconOn = display.newImage("Graphics/Music_on.png")
musicIconOff = display.newImage("Graphics/Music_off.png")

musicIconOn:scale(0.1*display.contentHeight/musicIconOn.contentHeight,0.1*display.contentHeight/musicIconOn.contentHeight)
musicIconOff:scale(0.1*display.contentHeight/musicIconOff.contentHeight,0.1*display.contentHeight/musicIconOff.contentHeight)
musicIconOn.x = musicIconOn.contentWidth/2 +xInset/2.3
musicIconOn.y = display.contentHeight - musicIconOn.contentHeight/2 - yInset/2
musicIconOff.x = musicIconOn.contentWidth/2+xInset/2.3
musicIconOff.y = display.contentHeight - musicIconOn.contentHeight/2 - yInset/2
musicIconOff.isHitTestable =true
musicIconOn.isHitTestable =true
musicIconGroup:insert(musicIconOff)
musicIconGroup:insert(musicIconOn)
musicIconOn:addEventListener("tap",  toggleMusic)
return musicIconGroup
end

local function playXander(Type,variation)
	 if aniPlaying == false then
		aniPlaying = true
		speechGroup.alpha = 1
		  XAnimation = display.newSprite( sheetthinkingside0, sequenceDatathinkingsideinit )
		  XAnimation:scale(0.55*scaleAdjust,0.55*scaleAdjust)
		  XAnimation.anchorX = 0
		  XAnimation.anchorY = 0.5
		  XAnimation.x = 0
		  XAnimation.y = display.contentHeight/2
		 XAnimation:play()
		 XAnimation:addEventListener("sprite",swapSheetX)
		 XanderGroup:insert(XAnimation)  
			 local Speech = display.newImage("Graphics/MatchTheTime/matchthetime_speechbubble.png")
		  Speech:scale(0.4*scaleAdjust,0.4*scaleAdjust)
		  Speech.alpha = 0
		  Speech.x =   Speech.contentWidth
		  Speech.y = display.contentHeight/2 - Speech.contentHeight
		  speechGroup:insert(Speech)
		  
		  local playPraise = false
		  local txtBubble

		if (Type == "praise") then
			playPraise = true
			txtBubble = praiseText[variation]
		else
		txtBubble = "Hoe laat\n is dit?"
		end
		 local optionsSpeech =
		{
			text = txtBubble ,
			y = Speech.y - yInset/2,
			x = Speech.x + xInset/5,
			font = teachersPetFont,
			fontSize = fntSize,
			align = "left"
		}

		local txtSpeech = display.newText(optionsSpeech)
		txtSpeech.alpha = 0
		txtSpeech:setFillColor(1)
		speechGroup:insert(txtSpeech)
		 Speech:scale(0,0)
		 transition.to(Speech	 , { time= 500,xScale = 0.4*scaleAdjust , yScale = 0.4*scaleAdjust, alpha = 1, onComplete = function() 	
		  if playPraise == true then

		 timer.performWithDelay(1500, function() audio.play(audio.loadSound(praiseSound[variation])) end)
		 end
		 
		 transition.to(txtSpeech	 , { time= 1000,fontSize = fntSize, fontSize = fntSize, alpha = 1}) end})		 
		 timer.performWithDelay(3000, function() 
		 transition.to(speechGroup	 , { time= 1000,alpha = 0})
		 transition.to(xAnimation , { time= 100,alpha = 0})
		 XAnimation:removeSelf()
		 Speech:removeSelf()
		 aniPlaying = false
		 end)
	 end
end


				
local function loadTimes()
for j= 1,#AClocks,1 do
	local options = 
		{			
			text = AClocks[j],     
			x = -20,
			y = -20,			
			font = native.systemFontBold,   
			fontSize = 20,
			align = "left"  -- alignment parameter
		}
		   txtTimes[j] = display.newText(options)
		    if AClocks[j] == "6" or AClocks[j] == "8" then		
				local randomChoose = math.random(1,2)
				if (randomChoose == 1) then
					txtTimes[j].tag = AClocks[j].."b"
				else
					txtTimes[j].tag = AClocks[j]
				end
			else
					txtTimes[j].tag = AClocks[j]
			end
			txtTimes[j].hour = hours[j]
			print("txtTimes[j].tag:  "..txtTimes[j].tag )
			print("AClocks[j]: "..AClocks[j])
	end
	return txtTimes
end

local function swapSheet(event)
		if(event.phase=="ended" and count<=sheetAmount)then
        	myAnimation:setSequence( sheetName..count )
			
        	myAnimation:play()
        	count = count + 1
			--print(count)
			if (count ==sheetAmount) then
			count = 0
			end
        end
end


local function loadSprite(tag)
if (tag == scenes[6]) then
	sheetAmount = 1
	sheetName = "bath"	
	local sheetbathInfo0 = require("Animations.bath.bath-0"..strAdjust)
	

	local sheetbath0 = graphics.newImageSheet( "Animations/bath/bath-0"..strAdjust..".png" ,sheetbathInfo0:getSheet())
	

	local sequenceDataBath = {
					{ name="bath0", sheet=sheetbath0, start=1, count=25, time=3000, loopCount=0 }
									
					}
	
	myAnimation = display.newSprite( sheetbath0, sequenceDataBath )
	myAnimation.anchorX = 0.5
	myAnimation.anchorY = 0.5
	myAnimation.x = display.contentWidth/2 ; myAnimation.y = display.contentHeight/2.5
	--myAnimation:scale(display.contentWidth*aniScale,display.contentWidth*aniScale)	
	myAnimation:scale(aniScale*display.contentHeight/myAnimation.contentHeight,aniScale*display.contentHeight/myAnimation.contentHeight)
	myAnimation:play()
	myAnimation:addEventListener("sprite",swapSheet)
	MatchGroup:insert(myAnimation)
	myAnimation.tag = txtTimes[n].tag
elseif (tag == scenes[1]) then
sheetAmount = 1
sheetName = "wakeup"

 local sheetwakeInfo0 = require("Animations.wakeup.wake-up-0"..strAdjust)

local sheetwake0 = graphics.newImageSheet( "Animations/wakeup/wake-up-0"..strAdjust..".png" ,sheetwakeInfo0:getSheet())


 local sequenceDatawake = {
				 { name="wakeup0", sheet=sheetwake0, start=1, count=25, time=3000, loopCount=0}
               			
                 }
				
myAnimation = display.newSprite( sheetwake0, sequenceDatawake )
myAnimation.anchorX = 0.5
myAnimation.anchorY = 0.5
myAnimation.x = display.contentWidth/2 ; myAnimation.y = display.contentHeight/2.5
--myAnimation:scale(display.contentWidth*aniScale,display.contentWidth*aniScale)
myAnimation:scale(aniScale*display.contentHeight/myAnimation.contentHeight,aniScale*display.contentHeight/myAnimation.contentHeight)
myAnimation:play()
myAnimation:addEventListener("sprite",swapSheet)
MatchGroup:insert(myAnimation)
myAnimation.tag = txtTimes[n].tag

elseif (tag == scenes[4]) then
sheetAmount = 1
sheetName = "Tennis"
local sheettennisInfo0 = require("Animations.tennis.tennis-0"..strAdjust)


local sheettennis0 = graphics.newImageSheet( "Animations/tennis/tennis-0"..strAdjust..".png" ,sheettennisInfo0:getSheet())

local sequenceDataTennis = {
				{ name="Tennis0", sheet=sheettennis0, start=1, count=21, time=3000, loopCount=0 }
         			
                }
myAnimation = display.newSprite( sheettennis0, sequenceDataTennis )
myAnimation.anchorX = 0.5
myAnimation.anchorY = 0.5
myAnimation.x = display.contentWidth/2 ; myAnimation.y = display.contentHeight/2.5
--myAnimation:scale(display.contentWidth*aniScale,display.contentWidth*aniScale)
myAnimation:scale(aniScale*display.contentHeight/myAnimation.contentHeight,aniScale*display.contentHeight/myAnimation.contentHeight)
myAnimation:play()
myAnimation:addEventListener("sprite",swapSheet)
MatchGroup:insert(myAnimation)
myAnimation.tag = txtTimes[n].tag
elseif (tag == scenes[3]) then
sheetAmount = 2
sheetName = "Lunch"

local sheetlunchInfo0 = require("Animations.lunch.lunch-0"..strAdjust)


local sheetlunch0 = graphics.newImageSheet( "Animations/lunch/lunch-0"..strAdjust..".png" ,sheetlunchInfo0:getSheet())


local sequenceDataLunch = {
				{ name="Lunch0", sheet=sheetlunch0, start=1, count=25, time=3000, loopCount=0 },
                			
                }
								
myAnimation = display.newSprite( sheetlunch0, sequenceDataLunch )
myAnimation.anchorX = 0.5
myAnimation.anchorY = 0.5
myAnimation.x = display.contentWidth/2 ; myAnimation.y = display.contentHeight/2.5
--myAnimation:scale(display.contentWidth*aniScale,display.contentWidth*aniScale)
myAnimation:scale(aniScale*display.contentHeight/myAnimation.contentHeight,aniScale*display.contentHeight/myAnimation.contentHeight)
myAnimation:play()
myAnimation:addEventListener("sprite",swapSheet)
MatchGroup:insert(myAnimation)
myAnimation.tag = txtTimes[n].tag
elseif (tag == scenes[5]) then
sheetAmount = 1
sheetName = "homework"

local sheethomeworkInfo0 = require("Animations.homework.homework-0"..strAdjust)


local sheethomework0 = graphics.newImageSheet( "Animations/homework/homework-0"..strAdjust..".png" ,sheethomeworkInfo0:getSheet())




local sequenceDataHomework = {
				{ name="homework0", sheet=sheethomework0, start=1, count=25, time=3000, loopCount=0 }
               		
                }
				
myAnimation = display.newSprite( sheethomework0, sequenceDataHomework )
myAnimation.anchorX = 0.5
myAnimation.anchorY = 0.5
myAnimation.x = display.contentWidth/2 ; myAnimation.y = display.contentHeight/2.5
--myAnimation:scale(display.contentWidth*aniScale,display.contentWidth*aniScale)
myAnimation:scale(aniScale*display.contentHeight/myAnimation.contentHeight,aniScale*display.contentHeight/myAnimation.contentHeight)
myAnimation:play()
myAnimation:addEventListener("sprite",swapSheet)
MatchGroup:insert(myAnimation)
myAnimation.tag = txtTimes[n].tag
elseif (tag == scenes[2]) then
sheetAmount = 1
sheetName = "school"
local sheetschoolInfo0 = require("Animations.school.school-0"..strAdjust)


local sheetschool0 = graphics.newImageSheet( "Animations/school/school-0"..strAdjust..".png",sheetschoolInfo0:getSheet())



local sequenceDataSchool = {
				{ name="school0", sheet=sheetschool0, start=1, count=25, time=3000, loopCount=0 }
               				
                }

myAnimation = display.newSprite( sheetschool0, sequenceDataSchool  )
myAnimation.anchorX = 0.5
myAnimation.anchorY = 0.5
myAnimation.x = display.contentWidth/2 ; myAnimation.y = display.contentHeight/2.5
--myAnimation:scale(display.contentWidth*aniScale,display.contentWidth*aniScale)
myAnimation:scale(aniScale*display.contentHeight/myAnimation.contentHeight,aniScale*display.contentHeight/myAnimation.contentHeight)
myAnimation:play()
myAnimation:addEventListener("sprite",swapSheet)
MatchGroup:insert(myAnimation)
myAnimation.tag = txtTimes[n].tag
elseif (tag == scenes[7]) then
sheetAmount = 4
sheetName = "reading"

local sheetreadingInfo0 = require("Animations.reading.reading-0"..strAdjust)



local sheetreading0 = graphics.newImageSheet( "Animations/reading/reading-0"..strAdjust..".png" ,sheetreadingInfo0:getSheet())

local sequenceDataReading = {
				{ name="reading0", sheet=sheetreading0, start=1, count=25, time=3000, loopCount=0 }
                
                }
				
				
myAnimation = display.newSprite( sheetreading0, sequenceDataReading )
myAnimation.anchorX = 0.5
myAnimation.anchorY = 0.5
myAnimation.x = display.contentWidth/2 ; myAnimation.y = display.contentHeight/2.5
--myAnimation:scale(display.contentWidth*aniScale,display.contentWidth*aniScale)
myAnimation:scale(aniScale*display.contentHeight/myAnimation.contentHeight,aniScale*display.contentHeight/myAnimation.contentHeight)
myAnimation:play()
myAnimation:addEventListener("sprite",swapSheet)
MatchGroup:insert(myAnimation)
myAnimation.tag = txtTimes[n].tag
elseif (tag == scenes[8]) then
sheetAmount = 4
sheetName = "sleeping"

local sheetsleepingInfo0 = require("Animations.sleeping.sleeping-0"..strAdjust)

local sheetsleeping0 = graphics.newImageSheet( "Animations/sleeping/sleeping-0"..strAdjust..".png" ,sheetsleepingInfo0:getSheet())

local sequenceDataSleeping = {
				{ name="sleeping0", sheet=sheetsleeping0, start=1, count=25, time=3000, loopCount=0 }
               			
                }				
myAnimation = display.newSprite( sheetsleeping0, sequenceDataSleeping )
myAnimation.anchorX = 0.5
myAnimation.anchorY = 0.5
myAnimation.x = display.contentWidth/2 ; myAnimation.y = display.contentHeight/2.5
--myAnimation:scale(display.contentWidth*aniScale,display.contentWidth*aniScale)
myAnimation:scale(aniScale*display.contentHeight/myAnimation.contentHeight,aniScale*display.contentHeight/myAnimation.contentHeight)
myAnimation:play()
myAnimation:addEventListener("sprite",swapSheet)
MatchGroup:insert(myAnimation)
myAnimation.tag = txtTimes[n].tag
end
end

function removeAllListeners(obj)
  obj._functionListeners = nil
  obj._tableListeners = nil
end

local function loadToMatch()
	if (MatchGroupParent ~=nil) then
		MatchGroupParent:remove(MatchGroup)
	end
	count = 1

	MatchGroup = display.newGroup()
	functions.shuffleTable( txtTimes )
	functions.shuffleTable( clocks )
	functions.shuffleTable(AClocks)
	txtTimes = loadTimes()
	local Spacing = display.contentWidth/4*0.9

    n = math.random(1,4)

	print("random: "..n)
	loadSprite(txtTimes[n].tag)
	print("loadTag"..txtTimes[n].tag)

	for i = 1,4,1 do
		images[i] = display.newImage("Graphics/MatchTheTime/"..AClocks[i]..".png")
		MatchGroup:insert(images[i] )
		images[i].tag = txtTimes[i].tag
		images[i]:scale (0.2*display.contentHeight/images[i].contentHeight,0.2*display.contentHeight/images[i].contentWidth)
		images[i].x = Spacing*(i-1)  + xInset*3.1
		images[i].y = display.contentHeight/1.2
		images[i]:addEventListener("tap",
			function()
				if (myAnimation.tag == images[i].tag ) then				
					tapCount = tapCount + 1
					if (tapCount == 1) then
					if (gameComplete == false) then
							currentHour = 12 - AClocks[i]
							matchBeadCount = matchBeadCount + 1
							if matchBeadCount ~= 5 then
							   audio.stop({channel = 2})
							 	audio.play(correctSound, {channel = 2, onComplete =function() functions.moveBeads(matchBeadCount,true)end	} )	
							end

						end
						if (matchBeadCount == 5) then
							functions.resetBeads() -- Hello Stefan, hier reset ek die beads <3
							matchBeadCount =0 													
							matchStarCount = matchStarCount + 1
							functions.playStarAni(Animation,matchStarCount,currentHour,true)
							if (matchStarCount ==3) then
								gameComplete = true
								playPraise = false
								tmrShowerPlay = timer.performWithDelay(2000,function() functions.starShowerPlay("matchTime") end)
								matchStarCount = 0
							end
						end
						if (playPraise == true) then
							local randomlyPraise = math.random(1,6)
							if (randomlyPraise == 1) then
							local rndm = math.random(1,3) 
							tmrPraise = timer.performWithDelay(xanderPraiseDelay, playXander("praise",rndm) )
							end
						end
							
						for i = 1,4,1 do
							if (myAnimation.tag ~= images[i].tag ) then
								images[i].fill.effect = "filter.grayscale"
								removeAllListeners(images[i])
								transition.to( images[i].fill.effect, { time=1000, intensity=1} )
							else
								transition.to( images[i], { time=1500, xScale =0.08, yScale=0.08,delta = true, onComplete = 
									function() 
										if (gameComplete == false) then
											prevMatch =myAnimation.tag
											loadToMatch() 
											while (prevMatch == myAnimation.tag) do
												loadToMatch() 
											end
										end
									end})
							end
						end
					end						
				else
					system.vibrate()
					audio.play(incorrectSound)
				end
			end)
		tapCount = 0
	end
	MatchGroupParent:insert(MatchGroup)
end


function scene:create( event )
    local sceneGroup = self.view
	local phase = event.phase
	print(#times)
	gotoHomeCnt = 0
	audio.stop()
    sceneGroup:insert(functions.setBackground())	
	loadToMatch()
	Animation = functions.starsCount()
	functions.playStarAni(Animation,matchStarCount)
	sceneGroup:insert(MatchGroupParent)
	sceneGroup:insert(Animation)
	sceneGroup:insert(XanderGroup)
	functions.removeSceneName = "matchTime"
	gameEntered = true
		sceneGroup:insert(setupMusicIcon())
	
end



function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
	
	
    if phase == "will" then
	beadsParent = functions.drawbeads(matchBeadCount)
	sceneGroup:insert(beadsParent)	
    elseif phase == "did" then
	audio.stop()
	math.randomseed( os.time() )
	jingleChoose = math.random(1,2)
	tmrMusicPlay = timer.performWithDelay(500, 
	function() 
		audio.reserveChannels( 1 )
		audio.setVolume( 0.3, { channel=1 } )
		if jingleChoose == 1 then 
			audio.play( audioMusic1, { channel=1, loops=-1, fadein=3000 } )
		else
			audio.play( audioMusic2, { channel=1, loops=-1, fadein=3000 } )
		end
	end)

  
playXander("",0)
sceneGroup:insert(speechGroup)
	 

    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
	
	
    end 
end

function scene:destroy( event )
audio.dispose( audioMusic1  )
audio.dispose( audioMusic2  )
if (trmMusicPlay ~= nil ) then
timer.cancel(tmrMusicPlay)
end

if (tmrShowerPlay ~= nil) then
timer.cancel(tmrShowerPlay)
end
    local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene