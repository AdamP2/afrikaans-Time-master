local composer = require( "composer" )
local scene = composer.newScene( sceneName )
local functions = require ("functions")
local  V1i
local  V1j
local  V2i
local  V2j
local OrgX
local OrgY
local HandsGroup = display.newGroup()
local HandsGroupParent = display.newGroup()
local Rad_To_Deg = 180/math.pi
local DClock
local prevTime = -1
local Hours

local txtTime
local btnLBLAan
local btnLBLAf
local slideBar
local slideBtn
local TimeMode = "24 hour"
local hourChangeGroup = display.newGroup()
local txtGroup = display.newGroup()

local starAnimation
local starFallAnimation
local beadsParent = display.newGroup()

local minScale = 0.32
local hrScale   = 0.25

local XanderWave
local speechWaveGroup = display.newGroup()
local greenarm = false

local XanderGroup1 = display.newGroup()
local XanderGroup2 = display.newGroup()
local speechGroup = display.newGroup()
local count = 1
local tmrSpeechWave
local tmrPraise

local AniHourRotateAngle = 0
local AniHand
local AniAngleMatch
local rectLock
local tmrAniStart
local tmrAniEnd
local r 
local angleStepVal = 1
local aniPlaying = false
local playPraise = true
local tmrShowerPlay

local gameComplete = false

local numSound = {"Een.mp3","Twee.mp3","Drie.mp3","Vier.mp3","Vyf.mp3","Ses.mp3","Sewe.mp3","Agt.mp3","Nege.mp3","Tien.mp3","Elf.mp3","Twaalf.mp3"}
--local correctSound = audio.loadSound("Audio/beadCorrect.mp3")

local fntSize
if ( string.sub(system.getInfo( "model" ), 1, 4 ) == "iPad") then
fntSize = 20
else
fntSize = 15
end	
			
-- local sheetxanderbottomwaveInfo0 = require("Animations.xanderbottomwave2.xanderbottomwave-0")

-- local sheetxanderbottomwave0 = graphics.newImageSheet( "Animations/xanderbottomwave2/xanderbottomwave-0.png" ,sheetxanderbottomwaveInfo0:getSheet())

-- local sequencexanderbottomwave1 = {
				-- { name="xanderbottomwave0", sheet=sheetxanderbottomwave0, start=1, count=62, time= 4000, loopCount=1,loopDirection = "bounce" }
				-- }

				
local function showSpeechWave(Type,variation)

speechWaveGroup.alpha = 1
if grp ~= nil then
grp:removeSelf()
end
local grp = display.newGroup()
local speechStop = display.newImage("Graphics/Hours/hour_xanderspeechbubble.png")
	
		grp:insert(speechStop)
		 
		 
		 local playPraise = false
		  local txtBubble

		if (Type == "praise") then
			playPraise = true
			txtBubble = praiseText[variation]
		else
		txtBubble = "Kies die tyd\nwat pas."
		end
		 local options2 = 
	{
	
		-- text = "Daar is 12 ure\nin 'n dag, en nog 12\nure in 'n nag.",     
		text = txtBubble,   
		x = speechStop.x ,
		y = speechStop.y ,		
		font = teachersPetFont,   
		fontSize = fntSize,
		align = "center"  -- alignment parameter
	}

	local txtspeech = display.newText(options2)
	txtspeech:setFillColor(1)
	txtspeech.alpha = 0

	grp:insert(txtspeech)
	speechWaveGroup:insert(grp)
	
	speechStop.x	=  DClock.x + DClock.contentWidth/2 -  xInset*2.1
	speechStop.y = XanderWave.y - XanderWave.contentHeight - yInset*2
	speechWaveGroup:insert(txtspeech)		
	txtspeech.x = speechStop.x 
	txtspeech.y = speechStop.y  - yInset/3
		
	local sX,sY = (txtspeech.contentWidth+ xInset*2)/speechStop.contentWidth,(txtspeech.contentHeight+ yInset*2)/speechStop.contentHeight
	speechStop:scale(0,0)
	
		 if playPraise == true then
			--audio.stop()
		   audio.play(audio.loadSound(praiseSound[variation]))
		 end	
		 
transition.to(speechStop,{time = 500, xScale = sX, yScale =sY})
transition.to(txtspeech,{time = 500, alpha = 1,onComplete = function() timer.performWithDelay(3000,function()  grp:removeSelf()  end) end})
end


local function swapSheetXWave(event)
		if(event.phase=="bounce" )then


        elseif (event.phase=="ended" )then
		transition.to(speechWaveGroup,{time = 500,alpha = 0})
		 aniPlaying = false
		end
end
local function playNumSound(tag)
print("Hourtag: "..tag)
local audioPlay = audio.loadSound( "Audio/"..numSound[tag] )
local audioUur = audio.loadSound( "Audio/Uur.mp3")
local options =
{
    channel = 1,
	onComplete = 
	function()
	
	audio.play(audioUur)
	end
}
audio.play(audioPlay,options)
end
				
local function swapSheet2(event)
	if(event.phase=="ended" and count<=1)then
		myAnimation:setSequence( "xanderbottomwave"..count )

		myAnimation:play()
		count = count + 1
		print(count)
		if (count >=1) then
			count = 1
		end
	end
end
				
local function swapSheet1(event)
	if(event.phase=="ended" and count<=1)then
		myAnimation1:setSequence( "xanderbottomwave"..count )
	    XanderGroup1:removeSelf()
	--XanderGroup = display.newGroup()

		--myAnimation:play()
		--count = count + 1
		print(count)
		if (count ==1) then
		--count = 1
	 local myAnimation2 = display.newSprite( sheetxanderbottomwave1, sequenceDataxanderbottomwaveloop)
	  myAnimation2:scale(0.13*display.contentWidth/myAnimation2.contentWidth,0.13*display.contentWidth/myAnimation2.contentWidth)
	  myAnimation2.anchorX = 1
	  myAnimation2.anchorY = 1
	  myAnimation2.x = DClock.x-- shelf.contentWidth
	  myAnimation2.y = DClock.y - yInset
	 myAnimation2:play()
	 myAnimation2:addEventListener("sprite",swapSheet2)
	 XanderGroup2:insert(myAnimation2)
	 
	local Speech = display.newImage("Graphics/Hours/hour_xanderspeechbubble.png")


-- dialog:scale((speechtext.contentWidth+ xInset/2)/dialog.contentWidth,(speechtext.contentHeight+ xInset/2)/dialog.contentHeight)
-- dialog.x = display.contentWidth/2 - dialog.contentWidth/2 - imgx.contentWidth/2
-- dialog.y = display.contentHeight-imgx.contentHeight/2
-- speechtext.x = dialog.x
-- speechtext.y = dialog.y
	  
		local optionsSpeech =
	{
		text = "Daar is 12 ure\nin 'n dag, en nog 12\nure in 'n nag." ,
		font = teachersPetFont,
		fontSize = fntSize,
		align = "center"
	}
		  
	local txtSpeech = display.newText(optionsSpeech)
	txtSpeech.alpha = 0
	txtSpeech:setFillColor(1)

	
	
	  --Speech:scale((txtSpeech.contentWidth+ xInset/2)/Speech.contentWidth,(txtSpeech.contentHeight+ xInset/2)/Speech.contentHeight)
	  Speech.alpha = 0
	  Speech.x = DClock.x + DClock.contentWidth/2 -  xInset*2.1
	  Speech.y = myAnimation2.y - myAnimation2.contentHeight - yInset*2

	   txtSpeech.x = Speech.x
	   txtSpeech.y = Speech.y - yInset/3
	   
		speechGroup:insert(Speech)
		speechGroup:insert(txtSpeech)
		print(txtSpeech.contentWidth.."                  "..Speech.contentWidth)
	--speechGroup:scale(0,0)
	
	local sclX,sclY = (txtSpeech.contentWidth + xInset)/Speech.contentWidth,(txtSpeech.contentHeight+ yInset*3)/Speech.contentHeight
	Speech:scale(0,0)
	 transition.to(Speech	 , { time= 500,xScale = sclX, yScale = sclY, alpha = 1, onComplete = function()   transition.to(txtSpeech	 , { time= 1000,fontSize = fntSize, fontSize = fntSize, alpha = 1}) end})
	--myAnimation1:removeSelf()
XanderGroup2:insert(speechGroup)
 		print(txtSpeech.contentWidth.."                  "..Speech.contentWidth)   
		end
	end
end

local function playXander(Type,variation)
	 if aniPlaying == false then
		aniPlaying = true
		XanderWave:play()
		XanderWave:addEventListener("sprite",swapSheetXWave)
		tmrSpeechWave = timer.performWithDelay(1500,function() showSpeechWave(Type,variation)end)
		end
end

local function loadXanderWave()

		XanderWave = display.newSprite(sheetxanderbottomwave0,sequencexanderbottomwave1)
		XanderWave:scale(0.003*display.contentHeight/XanderWave.contentHeight, 0.003*display.contentHeight/XanderWave.contentHeight)
		XanderWave.anchorY = 1
		XanderWave.anchorX = 0.5
		XanderWave.y = DClock.y - yInset
		XanderWave.x = DClock.x
		DClock:toFront()
		txtGroup:toFront()

end

local function drawhands(angle)
   
   if (HandsGroup~= nil)  then 
	HandsGroup:remove(minutehand)
		HandsGroup:remove(ClockCenter)
			HandsGroup:remove(hourhand)
			HandsGroupParent:remove(HandsGroup)
   end
    HandsGroup = display.newGroup()
			
	local ClockCenter = display.newImage("Graphics/StopTheClock/stoptheclock_centerclock.png")		  
	ClockCenter.x = Aclock.x
	ClockCenter.y = Aclock.y
	ClockCenter:scale(0.55*scaleAdjust,0.55*scaleAdjust)
	
    local minutehand = display.newImage("Graphics/StopTheClock/buildtheclock_bluearm@2x.png")	
    minutehand.anchorX = 0.5
    minutehand.anchorY = 0.9		  
	minutehand.x = ClockCenter.x
	minutehand.y = ClockCenter.y 
	minutehand.fill.effect = "filter.grayscale"
--minutehand:rotate(180)
	OrgX = ClockCenter.x
	OrgY = ClockCenter.y
	minutehand:scale(minScale*Aclock.contentWidth/minutehand.contentHeight,minScale*Aclock.contentWidth/minutehand.contentHeight )
	HandsGroup.minutehand = minutehand
	
	if greenarm == false then
	hourhand = display.newImage("Graphics/StopTheClock/buildtheclock_redarm@2x.png")	
	else
	hourhand = display.newImage("Graphics/QuarterHours/buildtheclock_greenhrarm.png")
	end
    hourhand.anchorX = 0.5
    hourhand.anchorY = 0.9	
	hourhand:scale(hrScale*Aclock.contentWidth/hourhand.contentHeight,hrScale*Aclock.contentWidth/hourhand.contentHeight)   	
	hourhand.x = ClockCenter.x
	hourhand.y = ClockCenter.y
	local hourRect = display.newRect( hourhand.x, hourhand.y , hourhand.contentWidth*4, hourhand.contentHeight*2 )
	hourRect.isVisible = false
	hourRect.isHitTestable = true
	hourRect:setFillColor(0)
	hourRect.anchorX = 0.5
    hourRect.anchorY = 1	
	HandsGroup.hourhandVisible= hourhand
	HandsGroup.hourhand = hourRect
	hourhand:rotate(angle)

	HandsGroup:insert(minutehand)		
	HandsGroup:insert(hourhand)
	HandsGroup:insert(hourRect)
	HandsGroup:insert(ClockCenter)
	HandsGroup:toFront()
	HandsGroupParent:insert(HandsGroup)

	
	return HandsGroup
end


local function getHourTwelveRange()
local hrReturn
	
	if Hours == 0 then
	hrReturn = 12
	
	
	elseif (Hours > 12) then
	hrReturn = Hours - 12
	else
	hrReturn = Hours
	end
	
	return hrReturn
end

local function getRandomHour()

		if (TimeMode == "12 hour" ) then
			Hours = math.random(1,12)
		else
			Hours = math.random(0,23)
		end
	print("")
	print("")
	print("Hour value generated: ".. Hours)
    local actualTimeVal = getHourTwelveRange()
	print("Hour value converted to 12h range: ".. actualTimeVal)
	print("Previous Time: ".. prevTime)
	if (prevTime == actualTimeVal) then -- make sure the player does not get the same hour value more than once consecutively
		getRandomHour()
		print("DUUUUUUUUUUUUUUUUUUUUPPPPPPPPLLLLLLLLLLLLLLLLLLLIIIIIIIIIIIIIIICCCCCCCCCCCCCCAAAAAAAAAAAAAAAAAAAAAAATTTTTTTTTTTTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE")
	end
prevTime = getHourTwelveRange()
return Hours
end



local function getHourAngle()
local hourangle 
 hourangle  =getHourTwelveRange()*30 
 if hourangle > 360 then 
	hourangle = hourangle - 360
end
 if hourangle == 360 then 
	hourangle = 0
end
 return hourangle
end


local function ShowTime(h,m)


 txtGroup:remove(txtTime)
 
 local options2 = 
{
    
    text = "",     
    x = DClock.x,
    y = DClock.y - yInset/4,
    
    font = native.systemFontBold,  
    fontSize = 30,
    align = "left"  -- alignment parameter
}

 txtTime = display.newText(options2)
txtTime:setFillColor(0)

if (h < 10) then
	h = "0"..h
end
if (m < 10) then
	m = "0"..m
end
txtTime.text = h.." : "..m
txtGroup:insert(txtTime)

end

local function ChangeHours()

	if (TimeMode == "12 hour") then
	TimeMode = "24 hour"
		btnLBLAf.alpha = 0
		transition.to(slideBtn	 , { time= 400,x =slideBar.x - slideBar.contentWidth/2 + slideBtn.contentWidth/2 + 4, onComplete = 
		function()
		btnLBLAan.alpha = 1
		btnLBLAf.alpha = 0
		end})
	else
	TimeMode = "12 hour"
		btnLBLAan.alpha = 0
		transition.to(slideBtn	 , { time= 400,x =slideBar.x + slideBar.contentWidth/2 - slideBtn.contentWidth/2 - 4,onComplete =
		function()
		btnLBLAan.alpha = 0
		btnLBLAf.alpha = 1
		end})
	end
	getRandomHour()
	--playNumSound(getHourTwelveRange())	
	ShowTime(Hours,0)
	print("Angle to match: "..getHourAngle())
end 


local function calcAngle(x,y)

			local r = math.sqrt(x^2 + y^2)
			local theta = math.asin(y/r)*Rad_To_Deg
			
			if ( x >= 0 and y >= 0) then
			theta = 90 - theta
			elseif ( x >= 0 and y < 0) then
			theta = 90 - theta			
			elseif ( x < 0 and y <0) then
			theta = 270 + theta
			elseif ( x < 0 and y >= 0) then
			theta = 270 + theta
			end

return theta
end


function removeAllListeners(obj)
  obj._functionListeners = nil
  obj._tableListeners = nil
end

local function rotatearm( event )
    if event.phase == "began" then
	    bMoved = true
        xStart,yStart = event.x,event.y   -- store x location of object
        target = event.target
        target.isFocus = true 		-- store y location of object
	    display.currentStage:setFocus( target )
		--print("xStart: ".. xStart .."  yStart:  "..yStart)
		V1i = xStart-OrgX
		V1j = -yStart+OrgY
		removeAllListeners(hourhand)
    elseif event.phase == "moved" then

		if (bMoved) then
			local x = event.x
			local y = event.y

			V2i = x - OrgX
			V2j = OrgY - y
			--print("V1i: ".. V1i .."  V1j:  "..V1j)
			--print("V2i: ".. V2i .."  V2j:  "..V2j)		
			drawhands(calcAngle(V2i,V2j))	
			V1i = V2i
			V1j = V2j				
         end		
				
	else	
		if (bMoved) then	
			display.currentStage:setFocus( nil )
			target.isFocus = false	
		
			local angleReleased = calcAngle(V2i,V2j)
			local dropTolerance = 30
			
			if math.abs(angleReleased - getHourAngle()) < dropTolerance or math.abs(angleReleased - getHourAngle()) > (360 -dropTolerance/2) then
			currentHour =12 - getHourTwelveRange()
				greenarm = true
				drawhands(getHourAngle())
				local currentAngle = getHourAngle()
				greenarm = false

				hoursBeadCount = hoursBeadCount + 1

				if (hoursBeadCount == 5 ) then
					hoursBeadCount = 0
					functions.resetBeads()
					hoursStarCount = hoursStarCount + 1
					functions.playStarAni(starAnimation,hoursStarCount,currentHour,true)
					if (hoursStarCount == 3) then
						gameComplete = true --local
						hrGameComplete = true -- global
					    playPraise = false
						hoursStarCount = 0
						--functions.playNumSound(currentHour)
						tmrShowerPlay = timer.performWithDelay(2100,function() functions.starShowerPlay("hours2") end)
					end

				end
				if (playPraise == true ) then
					local randomlyPraise = math.random(1,6)
					if (randomlyPraise == 1) then
					local rndm = math.random(1,3) 
					tmrPraise = timer.performWithDelay(xanderPraiseDelay,function() playXander("praise",rndm) end)
					end
				end
				if gameComplete == false then			    
					audio.play(correctSound, {onComplete =function() functions.moveBeads(hoursBeadCount,true)end	} )	
				end
					removeAllListeners(Aclock)
					timer.performWithDelay(2000,
					function()
					hourhand:addEventListener("touch",rotatearm)	
					drawhands(currentAngle)
					getRandomHour()
				    ShowTime(Hours,0)
					hourhand:addEventListener("touch",function()  Aclock:addEventListener("touch",rotatearm) hourhand:removeEventListener("touch",rotatearm) end)	
					if (gameExit == false and gameComplete == false) then
					end
					end)
			else
				system.vibrate()
				audio.play(incorrectSound)
				for i = 0,360,30 do
					if math.abs(i - angleReleased) < 15 then
					drawhands(i)
					end
				end
			end
			bMoved = false			
		end
    end  
    return false
end


local function frameUpdate(event)


AniHourRotateAngle = AniHourRotateAngle + angleStepVal
if (AniHourRotateAngle == 360) then
	AniHourRotateAngle = 0
end

local x = r*math.cos(AniHourRotateAngle/180*math.pi - math.pi/2) + Aclock.x
local y = r*math.sin( AniHourRotateAngle/180*math.pi - math.pi/2 ) + Aclock.y

hourhand:rotate(angleStepVal)
AniHand.x = x
AniHand.y = y
AniAngleMatch = getHourAngle()

if AniHourRotateAngle == AniAngleMatch then
	Runtime:removeEventListener( "enterFrame", frameUpdate )
	transition.to(AniHand, {time = 1000, alpha = 0})
	audio.play(correctSound)
	greenarm = true
	drawhands(AniAngleMatch,0)
	greenarm = false
	functions.playNumSound(12- getHourTwelveRange()) 
	tmrAniEnd = timer.performWithDelay(2000,
		 function()
			 drawhands(AniAngleMatch,0)
			 hourhand:addEventListener("touch",function()  Aclock:addEventListener("touch",rotatearm) hourhand:removeEventListener("touch",rotatearm) end)	
			 getRandomHour()
			ShowTime(Hours,0)
			rectLock:removeSelf()
			hrGameComplete = false

		 end)

end

end

function scene:create( event )
    local sceneGroup = self.view
	local phase = event.phase
	gameEntered = true
	gotoHomeCnt = 0
	audio.stop()
	sceneGroup:insert(functions.setBackground())
	Aclock = display.newImage("Graphics/Hours/hour-clock.png")
	Aclock:scale(0.43*display.contentWidth/Aclock.contentWidth,0.43*display.contentWidth/Aclock.contentWidth)
	Aclock.x = display.contentWidth/2 + xInset*1.5
	Aclock.y = display.contentHeight/2
	sceneGroup:insert(Aclock)
	HandsGroup = drawhands(0)
	hourhand:addEventListener("touch",function()  Aclock:addEventListener("touch",rotatearm) end)	
	sceneGroup:insert(HandsGroup)
	
	DClock = display.newImage("Graphics/Hours/hour_analogueclockcorrect.png")
	DClock:scale(0.3*display.contentWidth/DClock.contentWidth,0.3*display.contentWidth/DClock.contentWidth)
	DClock.y = display.contentHeight/1.5
	DClock.x = display.contentWidth/5

	
	        slideBar = display.newImage("Graphics/24uur/24uur-backbar.png")
			slideBar:scale(0.3*scaleAdjust,0.3*scaleAdjust)
			slideBar.x = display.contentWidth - slideBar.contentWidth
	        slideBar.y = display.contentHeight - slideBar.contentHeight
			--backbar.alpha = 0
		slideBar:addEventListener("tap",function()
	ChangeHours()
	end)		
			slideBtn =  display.newImage("Graphics/24uur/24uur-circle.png") 
			slideBtn:scale(0.3*scaleAdjust,0.3*scaleAdjust)
			slideBtn.x = slideBar.x - slideBar.contentWidth/2 + slideBtn.contentWidth/2 + 2
			slideBtn.y =  slideBar.y
			
	local lblAF = display.newImage("Graphics/24uur/24uur-afgrey.png") 
			lblAF:scale(0.3*scaleAdjust,0.3*scaleAdjust)
			lblAF.x = slideBar.x + slideBar.contentWidth/2 - slideBtn.contentWidth/2 - 2
			lblAF.y =  slideBar.y
			
	local lblAan = display.newImage("Graphics/24uur/24uur-aangrey.png") 
			lblAan:scale(0.3*scaleAdjust,0.3*scaleAdjust)
			lblAan.x = slideBar.x - slideBar.contentWidth/2 + slideBtn.contentWidth/2 + 2
			lblAan.y =  slideBar.y
			
			btnLBLAan = display.newImage("Graphics/24uur/24uur-aan.png")
			btnLBLAan:scale(0.3*scaleAdjust,0.3*scaleAdjust)
			btnLBLAan.x = lblAan.x
			btnLBLAan.y = lblAan.y	
			btnLBLAan.alpha = 0
				
			btnLBLAf = display.newImage("Graphics/24uur/24uur-af.png")
			btnLBLAf:scale(0.3*scaleAdjust,0.3*scaleAdjust)
			btnLBLAf.x = lblAF.x
			btnLBLAf.y = lblAF.y	
			btnLBLAf.alpha = 0

		   	local lbl24 = display.newImage("Graphics/24uur/24uur-text.png")
			lbl24:scale(0.35,0.35)
			lbl24.x = slideBar.x
			lbl24.y = slideBar.y - slideBar.contentHeight + xInset/3

			hourChangeGroup:insert(slideBar)
			hourChangeGroup:insert(lblAan)
			hourChangeGroup:insert(lblAF)
			hourChangeGroup:insert(slideBtn)
			hourChangeGroup:insert(lblAF)	
			hourChangeGroup:insert(btnLBLAan)	
			hourChangeGroup:insert(btnLBLAf)	
			hourChangeGroup:insert(lbl24)	
			
			sceneGroup:insert(hourChangeGroup)
			
			starAnimation = functions.starsCount()
			functions.playStarAni(starAnimation,hoursStarCount)
			sceneGroup:insert(starAnimation)
				

			
			math.randomseed( os.time() )
			functions.removeSceneName = "hours2"
			
			prevTime = 12
			getRandomHour()

			
			ShowTime(Hours,0)
			sceneGroup:insert(HandsGroupParent)
			sceneGroup:insert(XanderGroup1)
			sceneGroup:insert(XanderGroup2)

			sceneGroup:insert(DClock)
			sceneGroup:insert(txtGroup)
			if hrGameComplete == true then
				rectLock = functions.lockScreen()
				sceneGroup:insert(rectLock)
			    tmrAniStart = timer.performWithDelay(3000, function()
				AniHand = display.newImage("Graphics/hand.png")
				sceneGroup:insert(AniHand)
				AniHand.anchorY = 0
				AniHand:scale(0.1*display.contentHeight/AniHand.contentHeight,0.1*display.contentHeight/AniHand.contentHeight)
				AniHand.y = Aclock.y - hourhand.contentHeight + AniHand.contentHeight/4
				AniHand.x = Aclock.x
				r = hourhand.contentHeight - AniHand.contentHeight/4

				Runtime:addEventListener( "enterFrame", frameUpdate )
				end)
			end


end



function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

	
    if phase == "will" then
			beadsParent = functions.drawbeads(hoursBeadCount)
			print("hoursBeadCount  "..hoursBeadCount)
			sceneGroup:insert(beadsParent)
    elseif phase == "did" then
				audio.stop()
				 loadXanderWave()
				 playXander()
				sceneGroup:insert(XanderWave)
				sceneGroup:insert(speechWaveGroup)
				DClock:toFront()
				txtGroup:toFront()
	 
	 ChangeHours()
	 prevTime = getHourTwelveRange()
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
    elseif phase == "did" then

	
    end 
end

function scene:destroy( event )
    local sceneGroup = self.view
	timer.cancel(tmrSpeechWave)
	if tmrAniStart ~= nil then
		timer.cancel(tmrAniStart)
	end
	
	if tmrAniEnd ~= nil then
	timer.cancel(tmrAniEnd)
	end
	if tmrShowerPlay~= nil then
	timer.cancel(tmrShowerPlay)
	end
	Runtime:removeEventListener( "enterFrame", frameUpdate )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene