
local composer = require( "composer" )
local functions = require ("functions")
local physics = require( "physics" )
local scene = composer.newScene( sceneName )
local OrgX
local OrgY
local minutehand
local V1i,V1j = 0
local V2i,V2j, V2jTemp = 0
local AngleM = 0
local AngleMWithSign = 0
local AngleH = 0
local Theta_Degrees_H = 0
local Theta_Degrees_M = 0
local prevHour = 0
local Revs_Update = 0
local bMoved = false
local bMatched = false
local revCount = 0
local FullRev = 2*math.pi
local Rad_To_Deg = 180/math.pi
local Deg_To_Rad = 1/Rad_To_Deg
local Minute_Hour_Ratio = 1/12
local DispGroup = display.newGroup()
local ClockGroup = display.newGroup()
local txtGroup = display.newGroup()
local beadsParent = display.newGroup()
local beads
local Numbers = {}
local AniNums = {}
local Rects = {}
local dclock
local animationGroup = display.newGroup()
local runtime = 0
local AngleTrack = 0
local Hands
local starAnimation
local trackTurns_Deg = 0
local GameComplete = false
local NumsDragged = 0
local starFallAnimation
local txtTime
local DClock 
local txtTimeVisible = false
local ClockCenter
local aniPlaying = false
local ArrowDemoGroup = display.newGroup()
local hourhand
local minutehand
local theta = 0
local backGroundGroup = display.newGroup()
local blockHome

local backGroup 
local backGroupParent = display.newGroup()
local HandsGroupParent = display.newGroup()

 local count = 1
 local XanderThumbs = display.newGroup() 
 local myAnimationThumbs
 local tmrPraise
 local tmrRemoveBlock

local XanderWave
local speechWaveGroup = display.newGroup()

local shelfScale = 0.7
local clockScale = 0.65
local minScale = 0.18
local hrScale   = 0.038
local numsScaleonClock = 0.05

if ( string.sub(system.getInfo( "model" ), 1, 4 ) == "iPad") then
fntSize = 20


else
fntSize = 14


end	

local function blockAcitivity()

local blockRect = functions.lockScreen()
ArrowDemoGroup:insert(blockRect)
tmrRemoveBlock = timer.performWithDelay(1500,function() blockRect:removeSelf() end)

end			
-- local sheetthumbssideInfo0 = require("Animations.thumbsside.thumbsside-0")
-- local sheetthumbssideInfo1 = require("Animations.thumbsside.thumbsside-1")



-- local sheetthumbsside0 = graphics.newImageSheet( "Animations/thumbsside/thumbsside-0.png" ,sheetthumbssideInfo0:getSheet())
-- local sheetthumbsside1 = graphics.newImageSheet( "Animations/thumbsside/thumbsside-1.png" ,sheetthumbssideInfo1:getSheet())


-- local sequenceDatathumbssideinit = {
				-- { name="thumbsside0", sheet=sheetthumbsside0, start=1, count=83, time=3000, loopCount=1 },
                -- { name="thumbsside1", sheet=sheetthumbsside1, start=1, count=72, time=3000, loopCount=1}
			
                -- }
				
-- local sheetxanderbottomwaveInfo0 = require("Animations.xanderbottomwave2.xanderbottomwave-0")

-- local sheetxanderbottomwave0 = graphics.newImageSheet( "Animations/xanderbottomwave2/xanderbottomwave-0.png" ,sheetxanderbottomwaveInfo0:getSheet())

-- local sequencexanderbottomwave1 = {
				-- { name="xanderbottomwave0", sheet=sheetxanderbottomwave0, start=1, count=62, time= 2000, loopCount=1,loopDirection = "bounce" }
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
			txtBubble = "Bou die\nhorlosie."
		end
		 local options2 = 
	{
	
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

	 speechStop.x	=  display.contentWidth/7
	speechStop.y = display.contentHeight/2.5
	txtspeech.x = speechStop.x 
	txtspeech.y = speechStop.y  - yInset/3
		
	local sX,sY = (txtspeech.contentWidth+ xInset*2)/speechStop.contentWidth,(txtspeech.contentHeight+ yInset*2)/speechStop.contentHeight
	speechStop:scale(0,0)
	
		 if playPraise == true then
		 --audio.stop()
		   audio.play(audio.loadSound(praiseSound[variation]),{onComplete = function() functions.starShowerPlay("buildClock") end})
		 end	
		 
transition.to(speechStop,{time = 500, xScale = sX, yScale =sY})
transition.to(txtspeech,{time = 500, alpha = 1,onComplete = function() timer.performWithDelay(3000,
function()  
	grp:removeSelf()
 end) 
 end})
end

local function swapSheetXWave(event)
		if(event.phase=="bounce" )then


        elseif (event.phase=="ended" )then
		transition.to(speechWaveGroup,{time = 500,alpha = 0})
		 aniPlaying = false
		end
end

local function PlayXanderInit(Type,variation)
	 if aniPlaying == false then
		aniPlaying = true
		XanderWave:play()
		tmrSpeechWave = timer.performWithDelay(1500,function() showSpeechWave(Type,variation)end)
		end
end			


 local function DisplayDigital()
	timer.performWithDelay(1000, function()
	txtTimeVisible = true
DClock.alpha = 1

	end)

 end

local function swapSheetThumb(event)
	if(event.phase=="ended" and count<=1)then
		count = count + 1
		myAnimationThumbs:setSequence( "xanderthumb"..count )
        if count < 1 then
		myAnimationThumbs:play()
		end
		count = count + 1
		print(count)
		if (count >=1) then
			 transition.to(XanderThumbs , { time= 1000, alpha = 0, onComplete = DisplayDigital()})
		end
	end
end
	

 local function setupXanderInit()
		XanderWave = display.newSprite(sheetxanderbottomwave0,sequencexanderbottomwave1)
		XanderWave:scale(0.003*display.contentHeight/XanderWave.contentHeight, 0.003*display.contentHeight/XanderWave.contentHeight)
		XanderWave.anchorY = 0.5
		XanderWave.anchorX = 1
		XanderWave.y = display.contentHeight/1.7
		XanderWave.x = shelf.x - xInset*4-- shelf.contentWidth

		XanderWave:addEventListener("sprite",swapSheetXWave)

 end





local function movebackGround()	
local h = functions.getTimeH(Theta_Degrees_H)
local m = functions.getTimeM(Theta_Degrees_H)
if (m == 0) then
m = 1
end
local trackTime = h*60 + m
print("trackTime: "..trackTime)
  if ( backGroupParent ~= nil ) then
	backGroupParent:remove(backGroup)
 end
 backGroup = functions.drawBackground(trackTime)

 backGroupParent:insert(backGroup)

end 

local function playArrowDemo()
	local arrowDemo = display.newImage("Graphics/BuildTheClock/arrow2.png")
	arrowDemo:rotate(180)
	arrowDemo .x = ClockCenter.x
	arrowDemo .y = ClockCenter.y
	arrowDemo:scale(0.1*display.contentWidth/arrowDemo.contentWidth,0.1*display.contentWidth/arrowDemo.contentWidth)
    transition.to( arrowDemo, { time=1000,alpha=0 ,iterations = 4} )
    transition.to( arrowDemo, {  delay=1000, time=1000, alpha=1,iterations = 4, onComplete = function() arrowDemo:removeSelf() end} )
	ArrowDemoGroup:insert(arrowDemo)
end


local function playXanderThumbs()

playArrowDemo()
	movebackGround()
	myAnimationThumbs = display.newSprite( sheetthumbsside0, sequenceDatathumbssideinit  )
	  myAnimationThumbs:scale(0.003*display.contentWidth/myAnimationThumbs.contentWidth,0.003*display.contentWidth/myAnimationThumbs.contentWidth)
	  myAnimationThumbs.anchorX = 1
	  myAnimationThumbs.anchorY = 1
	  myAnimationThumbs.x = display.contentWidth/4-- shelf.contentWidth
	  myAnimationThumbs.y = display.contentHeight
	 myAnimationThumbs:play()
	 myAnimationThumbs:addEventListener("sprite",swapSheetThumb)
	 XanderThumbs:insert(myAnimationThumbs)
	 		local optionsSpeech =
	{
		text = "Goeie werk, draai die horlosie!" ,
		y = display.contentHeight - yInset*3,
		x = display.contentWidth/2,
		font = teachersPetFont,
		fontSize = math.floor(display.contentWidth/25),
		
		align = "left"
	}
	local txtSpeech = display.newText(optionsSpeech)
	txtSpeech:setFillColor(0)
    XanderThumbs:insert(txtSpeech)

end

 function gotoHome(event)
	 if event.phase == "began" then
	    print("HelOooooooO")
		--transition image to shrink with a small delay then gotoScene				
		timer.performWithDelay(300, function() composer.gotoScene("menu", "fade", 500); end)
		return true
	end
end
 
 
 
 local function drawhands()
   if (HandsGroup~= nil)  then 
		HandsGroup:remove(minutehand)
		HandsGroup:remove(ClockCenter)
		HandsGroup:remove(hourhand)
		HandsGroupParent:remove(HandsGroup)
	end
	HandsGroup = display.newGroup()
			
	ClockCenter = display.newImage("Graphics/BuildTheClock/buildtheclock_center.png")		  
	ClockCenter.x = display.contentWidth/2
	ClockCenter.y = dclock.y + dclock.contentHeight/16
	ClockCenter:scale(0.55*scaleAdjust ,0.55*scaleAdjust )
	
	minutehand = display.newImage("Graphics/StopTheClock/buildtheclock_bluearm@2x.png")	
    minutehand.anchorX = 0.5
    minutehand.anchorY = 0.9		  
	minutehand.x = ClockCenter.x
	minutehand.y = ClockCenter.y 
	OrgX = ClockCenter.x
	OrgY = ClockCenter.y
	minutehand:scale(minScale*display.contentHeight/minutehand.contentHeight,minScale*display.contentHeight/minutehand.contentHeight )
	minutehand:rotate(theta)
	minutehand:toFront()
	
	hourhand = display.newImage("Graphics/BuildTheClock/buildtheclock_redarm.png")	
    hourhand.anchorX = 0.85
    hourhand.anchorY = 0.5	
	hourhand:scale(hrScale*display.contentHeight/hourhand.contentHeight,hrScale*display.contentHeight/hourhand.contentHeight)    	
	hourhand.x = ClockCenter.x
	hourhand.y = ClockCenter.y
	hourhand:rotate(90 + functions.getHourAngle(Theta_Degrees_H))
	hourhand:toFront()

	HandsGroup:insert(minutehand)		
	HandsGroup:insert(hourhand)
	HandsGroup:insert(ClockCenter)
	HandsGroup:toFront()
	HandsGroup.minutehand = minutehand
	HandsGroup.hourhand = hourhand
	HandsGroup.clockCenter = ClockCenter
	HandsGroupParent:insert(HandsGroup)
	
	return HandsGroup
end
 
 local function trackTurns()
 print("buildBeadCount : "..buildBeadCount )
 if (buildStarCount >=2) then
	if (trackTurns_Deg >= 240) then
		trackTurns_Deg = 0
		print("buildBeadCount : "..buildBeadCount )
		buildBeadCount  = buildBeadCount  + 1
		functions.moveBeads(buildBeadCount )
		if (buildBeadCount  == 5) then
			buildBeadCount  = 0
			buildStarCount = buildStarCount + 1
			functions.playStarAni(starAnimation,buildStarCount)
			if ( buildStarCount == 3) then
			buildStarCount = 0
			 GameComplete = true		  
			end
		end
	end
 end
 end
 

 
 local function DisplayInfo()

  txtGroup:remove(txtTheta)
 txtGroup:remove(txtTime)
	local options = 
{
    
    text = "",     
    x = display.contentWidth- xInset*3,
    y = xInset*2,
    
    font = native.systemFontBold,   
    fontSize = 10,
    align = "left"  -- alignment parameter
}

txtTheta = display.newText(options)
txtTheta.text = ""

txtTheta:setFillColor(0)

local options2 = 
{
    
    text = "",     
    x = DClock.x,
    y = DClock.y, - yInset/2,
    
    font = native.systemFontBold,   
    fontSize = 30,
    align = "left"  -- alignment parameter
}

txtTime = display.newText(options2)
txtTime:setFillColor(0)

local h = functions.getTimeH(Theta_Degrees_H)
local m = functions.getTimeM(Theta_Degrees_H)
if (h < 10) then
	h = "0"..h
end
if (m < 10) then
	m = "0"..m
end
txtTime.text = h..":"..m
txtGroup:insert(txtTime)
txtGroup:insert(txtTheta)
if txtTimeVisible == false then
txtTime.alpha = 0
else
txtTime.alpha = 1
end
end
 
 -- local function rotatearm( event )
    -- if event.phase == "began" then
	    
        -- xStart,yStart = event.x,event.y   -- store x location of object
        -- targetc = event.target
        -- targetc.isFocus = true 		-- store y location of object
		-- print("xStart: ".. xStart .."  yStart:  "..yStart)
		
		-- V1i = xStart-OrgX
		-- V1j = -yStart+OrgY
        -- bMoved = true
    -- elseif event.phase == "moved" then
	    
		-- if (bMoved) then
			-- display.currentStage:setFocus( targetc )
			-- local x = event.x
			-- local y = event.y

			-- V2i = x - OrgX
			-- V2j = OrgY - y
			
		-- local Rotation_Direction = functions.getRotationDirection(V1i,V1j,V2i,V2j)
													
		-- local dTheta = 	functions.getAngleChange(V1i,V1j,V2i,V2j)
							
		-- AngleM = AngleM + Rotation_Direction*dTheta
		-- AngleH = AngleH + Rotation_Direction*dTheta*Minute_Hour_Ratio
		
		-- Theta_Degrees_M = AngleM*Rad_To_Deg
		-- Theta_Degrees_H = AngleH*Rad_To_Deg 
		-- trackTurns_Deg = trackTurns_Deg+ dTheta*Minute_Hour_Ratio*Rad_To_Deg 
		-- trackTurns()
						
		-- Hands.minutehand:rotate(Rotation_Direction*dTheta*Rad_To_Deg)
		-- Hands.hourhand:rotate(Rotation_Direction*dTheta*Rad_To_Deg*Minute_Hour_Ratio)
				
		-- if (math.abs(AngleMWithSign) >= 360  ) then		  
		  -- AngleMWithSign = 0
		-- end
		
		-- if (AngleMWithSign <= -360) then
		  -- AngleMWithSign = 0
		-- end
		
		-- print("AngleMWithSign:  "..AngleMWithSign)
		
		-- if (Theta_Degrees_H <= 0) then
			 -- AngleH = 2*FullRev+AngleH
		 -- elseif
			 -- (AngleH >= 2*FullRev) then
			-- AngleH = 0
		-- end
		
		-- if (AngleH >= 2*FullRev) then
			-- AngleH = 0
		-- end
				
		-- if (Theta_Degrees_M <= 0 and Rotation_Direction < 0) then
			 -- AngleM = FullRev+AngleM

		 -- elseif
			 -- (AngleM >= FullRev) then
			-- AngleM = AngleM - FullRev

		-- end
        -- local HourTime = functions.getTimeH(Theta_Degrees_H)
		-- local MinutesTime = functions.getTimeM(Theta_Degrees_H)
		-- if MinutesTime < 10 then
		-- MinutesTime = "0"..MinutesTime
		-- end
        		
	
		-- V1i = V2i
		-- V1j = V2j
				
			-- if (BackGroup ~= nil) then
	
	        -- BackGroup:removeSelf()
	         -- end
		   -- movebackGround()
		   -- DisplayInfo()    
        -- end		
	

		
	-- else	
		-- if (bMoved) then
			-- if (GameComplete == true) then
			-- functions.starShowerPlay("buildClock")
			-- Hands.minutehand:removeEventListener("touch",rotatearm)
			-- end
			
			-- display.currentStage:setFocus( nil )
			
			-- if targetc ~= nil then
			-- targetc.isFocus = false
			-- end
		
			-- if (Hands ~= nil) then
				-- Hands:removeSelf()
			-- end
			   
			   -- Hands = drawhands(true)
				-- ClockGroup:insert(Hands)

			-- if (GameComplete == false) then
				-- Hands.minutehand:addEventListener("touch",rotatearm)

			-- end
			
					
		-- end
		-- bMoved = false	
    -- end
    
    -- return false
-- end
 
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
    elseif event.phase == "moved" then
		print("Just Checking")
		if (bMoved) then
			local x = event.x
			local y = event.y

			V2i = x - OrgX
			V2j = OrgY - y
			--print("V1i: ".. V1i .."  V1j:  "..V1j)
			--print("V2i: ".. V2i .."  V2j:  "..V2j)		
			theta = calcAngle(V2i,V2j)
			local deltaTheta = theta -prevHour
			if math.abs(deltaTheta) >= 20 then
			deltaTheta = 0
			end
			prevHour = theta	
			print("WHAAAAAAAATTTTTTTTTT:         "..prevHour.."DELLLTAAAAA:        "..deltaTheta)
			Theta_Degrees_H = Theta_Degrees_H + deltaTheta/12

			if (Theta_Degrees_H <= 0) then
							 print("WHAAAAAAAATTTTTTTTTT")
				 Theta_Degrees_H=  2*360+Theta_Degrees_H
			 elseif
				 (Theta_Degrees_H >= 2*360) then

				Theta_Degrees_H = 0
			end
			
			drawhands()
			print(Theta_Degrees_H)
			V1i = V2i
			V1j = V2j		
		    movebackGround()
		    DisplayInfo()    
         end		
				
	else	
		if (bMoved) then	
		
			if (GameComplete == true) then
				local rndm = math.random(1,3) 
				tmrPraise = timer.performWithDelay(xanderPraiseDelay,function() PlayXanderInit("praise",rndm) end)
				minutehand:removeEventListener("touch",rotatearm)
				blockHome = functions.lockHomeBtn()
				removeAllListeners(minutehand)
				removeAllListeners(dclock)
			end
			display.currentStage:setFocus( nil )
			target.isFocus = false	
			removeAllListeners(minutehand)
			--minutehand:addEventListener("touch",rotatearm)	
			--minutehand:addEventListener("touch",function()  dclock:addEventListener("touch",rotatearm) minutehand:removeEventListener("touch",rotatearm) end)	
			bMoved = false			
		end
    end  
    return false
end

function move( event )
    if event.phase == "began" then
	    bMoved = true
		bMatched = false
		target = event.target
        xStart,yStart = target.x,target.y   -- store x location of object      
        target.isFocus = true 		-- store y location of object
		target:toFront()
		
    elseif event.phase == "moved" then      
		if (bMoved) then
			if (bMatched == false) then		
				display.currentStage:setFocus( target )
				local x = (event.x - event.xStart) + xStart
				local y = (event.y - event.yStart) + yStart				
				target.x, target.y = x, y 
			end
		end	
	elseif event.phase == "ended" or event.phase == "cancelled"  then	
		if (bMoved) then	 
			 for i=1,12,1 do
				 if (functions.hasCollidedCircle(target ,  Rects[i])) then								 
					 print(i.."-target tag: ".. target.tag)

					 if (target.tag == Rects[i].tag ) then	
					  if (bMatched == false) then
						print("Tag of dropped: "..Rects[i].tag)
							local randomlyPraise = math.random(1,6)
							if (randomlyPraise == 7) then
							local rndm = math.random(1,3) 
							tmrPraise = timer.performWithDelay(xanderPraiseDelay,function() PlayXanderInit("praise",rndm) end)
							end
					     buildBeadCount  = buildBeadCount  + 1
						 NumsDragged = NumsDragged + 1
						 					 print("Rect tag ".. Rects[i].tag)
						  if buildBeadCount ~= 4 then
						  blockAcitivity()
						    audio.stop()
							 audio.play(correctSound, {onComplete = function()  functions.playNumSound(target.tag) end} )
						 end
						 if (NumsDragged == 12) then
							
							minutehand:addEventListener("touch",function()  dclock:addEventListener("touch",rotatearm) minutehand:removeEventListener("touch",rotatearm) end)	
							audio.stop()
							audio.play(correctSound, {onComplete = function()  functions.playNumSound(12) end} )
							 transition.to(XanderGroup2 , { time= 300,alpha = 0})
							 playXanderThumbs()
						 end
						 if (buildBeadCount  == 4) then
						     blockAcitivity()
							 buildBeadCount  = 0
							 buildStarCount = buildStarCount + 1
							 local bPlayNumNar
							 if buildStarCount < 3 then 
							 bPlayNumNar = true
							 else
							 bPlayNumNar = false
							 end
							 functions.playStarAni(starAnimation,buildStarCount,(target.tag),bPlayNumNar)
							 if ( buildStarCount == 3) then
								buildStarCount = 0
								 GameComplete = true		  
							 end
						 end

						 print("buildBeadCount : "..buildBeadCount )
						 bMatched = true					 
						 target:scale(0.6,0.6)
						 target.x = Rects[i].x
						 target.y = Rects[i].y	
						 target:toFront()
						 target.isFocus = false
						 display.getCurrentStage():setFocus( nil )	
						 target:removeEventListener( "touch", move )						 
						return
						end
					 end					 
				end
			end			
			if (bMatched == false) then			    
				target.x = xStart
				target.y = yStart
			end
			audio.play(incorrectSound)
			target.isFocus = false
			target = nil
			display.currentStage:setFocus( nil )
			bMoved = false			
		end 
    end		
    return false
end

local function playPop()
audio.play(popSound)

end

local function buildClockSetup()

	if (animationGroup ~= nil ) then
    animationGroup:toFront()
	end

shelf.alpha = 1
	dclock.alpha= 1
   ClockGroup:insert(shelf)
	ClockGroup:insert(dclock)
	Hands = drawhands(true)
	
    ClockGroup:insert(Hands)	 
   
     for i=1,12,1 do
		 print(i)	
		 Numbers[i] = display.newImage("Graphics/BuildTheClock/"..i..".png")
		 Numbers[i]:scale(0.01*display.contentWidth/ Numbers[i].contentWidth,0.01*display.contentWidth/ Numbers[i].contentWidth)
		 Numbers[i].x = display.contentWidth/2
		 Numbers[i].y = display.contentHeight + Numbers[i].contentHeight + yInset
		 if (i == 12) then
			Numbers[i].tag = 12
		 else
			Numbers[i].tag = 12 - i 
		 end
	 end

	 r = dclock.contentWidth/2*0.64
	 for i = 30,360,30 do
		 local x = r*math.cos(math.pi/2 - i/180*math.pi)
		 local y = r*math.sin(math.pi/2 - i/180*math.pi)
		 Rects[i/30] = display.newRect( display.contentWidth/2 - x, dclock.y + dclock.contentHeight/16 - y , 50, 50 )
		 Rects[i/30]:setFillColor(0)
		 Rects[i/30].alpha = 0.5
		 Rects[i/30].tag =  i/30
		 print("i: "..i/30)
		 Rects[i/30].isVisible = false
		 Rects[i/30].isHitTestable = true
		 ClockGroup:insert(Rects[i/30])	 
	 end
	 
	functions.shuffleTable( Numbers )
	 
    local Spacing = display.contentWidth/12*0.9
	 
	for i=1,12,1 do
		 print(Numbers[i].tag)		 	 	 
		 ClockGroup:insert(Numbers[i])
		 local n = math.random(1,3)
		 local adjustNumHeight
		 if (n == 1 ) then
			adjustNumHeight = 1.12
		elseif (n == 2 ) then
			adjustNumHeight = 1.14
		else
			adjustNumHeight = 1.16
		end

		 local nX,nY
		 nX = Spacing*(i-1)  + xInset*1.6	
		 nY = display.contentHeight/adjustNumHeight

		 	 timer.performWithDelay(1500, 
	 function() 	
	 	d = math.random(0,2000)
	    timer.performWithDelay(1000, transition.to(Numbers[i],{time = d, x = nX,y=nY, xScale = 0.0035*scaleAdjust*display.contentWidth/ Numbers[10].contentWidth,yScale = 0.0035*scaleAdjust*display.contentWidth/ Numbers[10].contentWidth,transition = easing.InOutCubic,onComplete = 
		 function()
		 if gameExit == false then
		 playPop()
		 end
		 end
		 }))
		 Numbers[i]:addEventListener( "touch", move ) 
	end
	 )

	 end
	 PlayXanderInit()
end



local function ScatterNums(event)
audio.stop()
physics.setGravity( )
	 for i=1,12,1 do
		 physics.addBody( AniNums[i])
		 AniNums[i]:setLinearVelocity( math.random(-200,200), math.random(-200,200))
		 local r = math.random(5,20)/15
		  transition.to(AniNums[i]	 , { time= 1000,xScale = r , yScale = r})
		  
	 end
	 animationGroup:remove(dclock)
	 animationGroup:remove(Chands)
	 animationGroup.minutehand.isVisible = false
	 animationGroup.clockCenter.isVisible = false
	 animationGroup.hourhand:removeSelf()
	 buildClockSetup()

end

local function vibrateClock(Clock)
	audio.play(alarmRing)
    transition.to( Clock, { time=50,rotation=-1, transition=easing.inOutCubic,iterations = 30} )
    transition.to( Clock, {  delay=50, time=50, rotation=1, transition = easing.inOutCubic,iterations = 30, onComplete = ScatterNums} )
end

 
local function playStartAnimation()
	audio.play(clockTick)
	physics.start()
	dclock = display.newImage("Graphics/BuildTheClock/buildtheclock_clockwithoutnumbers.png")		
	dclock.x = display.contentWidth/2
	dclock:scale(clockScale*display.contentHeight/dclock.contentHeight,clockScale*display.contentHeight/dclock.contentHeight )
	dclock.y = shelf.y - dclock.contentHeight/2 - yInset/3
	animationGroup:insert(dclock)
	
	local Chands = drawhands(false)
	animationGroup.minutehand = Chands.minutehand
	animationGroup.hourhand = Chands.hourhand
	animationGroup.clockCenter = Chands.clockCenter
	
	animationGroup:insert(Chands)
	
	 for i=1,12,1 do
		 print(i)	
		 AniNums[i] = display.newImage("Graphics/BuildTheClock/"..i..".png")
		 AniNums[i]:scale(numsScaleonClock*display.contentHeight/AniNums[i].contentHeight,numsScaleonClock*display.contentHeight/AniNums[i].contentHeight)
		 if (i == 12) then
			AniNums[i].tag = 12
		 else
			AniNums[i].tag = i
		 end
	 end
	 
	  r = dclock.contentWidth/2*0.64
	 for i = -360,-30,30 do
		 local x = r*math.cos(math.pi/2 - i/180*math.pi)
		 local y = r*math.sin(math.pi/2 - i/180*math.pi)
		 AniNums[-i/30].x = display.contentWidth/2 - x 
		 AniNums[-i/30].y =  dclock.y + dclock.contentHeight/16 - y 
		 animationGroup:insert(AniNums[-i/30])	 
	 end
	 animationGroup.anchorX = 0.5
	 animationGroup.anchorY = 0.5
end

local function frameUpdate(event)

AngleTrack = AngleTrack +3 
animationGroup.minutehand:rotate(3*12)
animationGroup.hourhand:rotate(3)
if AngleTrack >= 360 then
	Runtime:removeEventListener( "enterFrame", frameUpdate )
	vibrateClock(animationGroup)
end
animationGroup:toFront()
end


function scene:create( event )
    local sceneGroup = self.view
	local phase = event.phase	
	 print("Build the clock scene started")
	gotoHomeCnt = 0
	gameExit = false  
	audio.stop()
	backGroundGroup =  functions.setBackground()
	sceneGroup:insert(backGroundGroup)
	sceneGroup:insert(beadsParent)
	starAnimation = functions.starsCount()
	functions.removeSceneName = "buildClock"
	gameEntered = true

	shelf = display.newImage("Graphics/BuildTheClock/buildtheclock_shelf.png")		
	shelf:scale(1.3*shelfScale *display.contentWidth/shelf.contentWidth ,shelfScale *display.contentWidth/shelf.contentWidth )
	shelf.x = display.contentWidth/2
	shelf.y = display.contentHeight/1.35
	shelf.alpha = 0
	dclock = display.newImage("Graphics/BuildTheClock/buildtheclock_clockwithoutnumbers.png")		
	dclock.x = shelf.x
	dclock.y = shelf.y - dclock.contentHeight/3 
	dclock:scale(clockScale*display.contentWidth/dclock.contentWidth,clockScale*display.contentWidth/dclock.contentWidth )
	dclock.alpha = 0
	
    DClock = display.newImage("Graphics/Hours/hour_analogueclockcorrect.png")
	DClock:scale(0.35*display.contentHeight/DClock.contentWidth ,0.35*display.contentHeight/DClock.contentWidth )
	DClock.x = display.contentWidth/2
	DClock.y = shelf.y + shelf.contentHeight/2 + DClock.contentHeight/2 + yInset/2
	DClock.alpha = 0
	ClockGroup:insert(DClock)
	sceneGroup:insert(ArrowDemoGroup)
    
	 math.randomseed( os.time() )
	setupXanderInit()

	sceneGroup:insert(animationGroup)
	sceneGroup:insert(backGroupParent)
	sceneGroup:insert(speechWaveGroup )
	sceneGroup:insert(XanderWave)
	sceneGroup:insert(ClockGroup)
	sceneGroup:insert(beadsParent)	
	sceneGroup:insert(starAnimation)
	sceneGroup:insert(XanderThumbs)
	sceneGroup:insert(txtGroup)
	sceneGroup:insert(HandsGroupParent)
	sceneGroup:insert(ArrowDemoGroup)
	
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase


    if phase == "will" then

    elseif phase == "did" then
	audio.stop()
	playStartAnimation()
	 Runtime:addEventListener( "enterFrame", frameUpdate )


		
 print("Build the clock scene started2")
   		     
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
	if blockHome ~= nil then
	blockHome:removeSelf()
	end
	if (tmrPraise ~= nil) then
		timer.cancel(tmrPraise)
	end
	if (tmrSpeechWave~= nil) then
		timer.cancel(tmrSpeechWave)
	end
	Runtime:removeEventListener( "enterFrame", frameUpdate )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene