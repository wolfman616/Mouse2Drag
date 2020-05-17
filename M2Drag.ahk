 /* 
;
; 	Warning:only run with  autohotkey 1.1.3.2+ 32bit with UI Access ( AutoHotkeyA32_UIA.exe
;	* This is due to detection of context menus
;
; 	KEYS:
;
;	Original right mouse button =  		CTRL + SHIFT + RIGHTCLICK  Incase bug
;	Quit application hotkey =  		CTRL + SHIFT + WIN + RIGHTCLICK (MouseWheelButton) 
;
; 	Drag any window under cursor = 	mouse2 drag on window	(left click to abort during drag)
;	ruler on desktop = 		mouse1 drag on desktop	(cancels on item highlight AKA selecting files with marquee)
;	Toggle Window Info Tooltip = 		CTRL+W+MIDDLECLICK(MouseWheel)=	
;
; 	fixed:  Disabled desktop drag ((WorkerWin) or ProgMan if MMC is running) 
;	Blacklist ini file classnames (use Window Info above + CTRL C copies that)
; 	Matthew Wolff - 2020
;
 */

SendMode input
#WinActivateforce
#singleinstance force
#persistent
Menu, Tray, Icon, mouse24.ico
setbatchlines -1
CoordMode, Mouse 		;coordmode, mouse, screen ; previously set

IniRead Class1, M2BlackList.ini, class, class1 		;BLACKLIST-WINDOW-CLASSES
IniRead Class2, M2BlackList.ini, class, class2 		;BLACKLIST-WINDOW-CLASSES
IniRead Class3, M2BlackList.ini, class, class3 		;BLACKLIST-WINDOW-CLASSES
global twit=1
global begin_x:=
global begin_Y:=
global x
global y
global toolx
global tooly
xx:=
yy:=
BrkLoop = 0

^+#RButton:: 			;-===CTRL+SHIFT+WIN+RIGHTCLICK=----
ExitApp 						;  -===========GOODBYE============-


^#Mbutton::  ;>==============CTRL=+=WIN=+=MIDDLE=MOUSE=(WHEEL)=BUTTON=to=TOGGLE=WINDOW=INFO=DISPLAY=TOOLTIP=============<
   UnderCursorToggle := (! UnderCursorToggle)
   If (UnderCursorToggle)
      SetTimer ToolTipUnderCursor, 50
   Else
   {
      SetTimer ToolTipUnderCursor, Off
      ToolTip,% GetUnderCursorInfo
	^#c:: ;?====================copy=window=info===CTRL=+=WIN=+=C=========?
		clipboard:=WindowUnderCursorInfo
		return
   }
Return

brkcheck() {
	MouseGetPos new1x, new1y, Window
	if(new1x != Begin_X) or (new1y != Begin_Y)
	BrkLoop = 1
	Return
	}

^NumpadDot::Rbutton ;>=====CTRL=NUMPAD=DOT====>(NORMAL=RIGHT=CLICK=INCASE=OF=BUGS)=====<

Rbutton::
CLICK_COMMANDER:
{
MouseGetPos, begin_x, begin_y, Window
WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %Window%
WinGet, EWD_WinState, MinMax, ahk_id %Window% 	
WinGetClass Class, ahk_id %Window%
EWD_MouseStartX_old=%EWD_MouseStartX%
EWD_MouseStartY_old=%EWD_MouseStartY%
If (DetectContextMenu() = 1)
	{
	Click, escape   					;close contextmenu  	; ((((WinActivate, ahk_id %Window%))))
	Tooltip,
	Goto CLICK_COMMANDER
	}
;
;WinGetClass aclass, ahk_id %Window%
;WinActivate, ahk_id %Window%
;
if (Class=class1) or (Class=Class2) or (Class=Class3)
	{
	while GetKeyState("rbutton" , "P") 
		{
		GetKeyState, EWD_RbuttonState, RButton, P
	if EWD_RbuttonState = U  ; Button released, drag carried out.
			{
			click, right
			exit
			}}
	exit
	}
else while GetKeyState("rbutton" , "P") 
	{
	;tooltip, ahk_id %ahk_id%
	SetWinDelay -1
	CoordMode, Mouse  ; Switch to screen/absolute coordinates.
	MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
	WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
	WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin% 
	;tooltip, window drag activated' n - Mouse 1 to Cancel
	SetTimer, EWD_WatchMouse, 1 ; Track cursor vector differential
	return
	EWD_WatchMouse:
	if (x!=EWD_MouseStartX)
		gosub MICRO_PEEN
	GetKeyState, EWD_RbuttonState, RButton, P
	if EWD_RbuttonState = U  ; Button released, drag carried out.
		{
		;click, right
		SetTimer, EWD_WatchMouse, Off
		SetTimer, tooloff, -2000
		;tooltip up
		CoordMode, Mouse
		mousegetpos xxxx, yyyy
		;if  xxxx!=% begin_x
		if  (xxxx>begin_x -25) && (xxxx<begin_x +25) 
			{
			click, right
			exit
			}
		else
			{
			return
			}
		return
		}
	GetKeyState, EWD_EscapeState, LButton, P
	if EWD_EscapeState = D  
		{
		SetTimer, EWD_WatchMouse, Off
		SetWinDelay -1
		WinMove, ahk_id %Window%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
		click, up
		;ToolTip, Aborting Drag
		return
		}
	if class=WorkerW
		{
		while GetKeyState("rbutton" , "P") 
			{
			;click {right}
			if EWD_RbuttonState = U  ; Button released, drag carried out.
				{
				click, right
			}	}
		exit
		}
	else { 	 	;reposition
		CoordMode, Mouse,
		MouseGetPos, EWD_MouseX, EWD_MouseY
		WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %Window%
		SetWinDelay, -1   
		WinMove, ahk_id %Window%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
		EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
		EWD_MouseStartY := EWD_MouseY
		;if WinActive("ahk_class WorkerW")	||   WinActive("ahk_class Progman")
		;Tooltip, m2drag activated' n - Mouse 1 to Cancel
		return
	}	}
	; settimer, tooloff, -2000 
	; tooltip slow click
}
Return

EWD_Watch2: 
	GetKeyState, EWD_RbuttonState, RButton, P
	if EWD_RbuttonState = U  ; Button released, drag carried out.
		{
		CoordMode, Mouse
		mousegetpos xxx, yyy
		sleep 100
		if  xxx=% EWD_MouseStartX_old
		click, right
		SetTimer, EWD_WatchMouse, Off
		SetTimer, tooloff, -2000
		}
	Else
Return


MICRO_PEEN: 	;	<---===MAXIMIZED=CHECK=AND=PULL=WINDOW=TO=CURSOR=(NEEDS=FIX=TO=REALIGN=WITH=CURSOR=AESTHETICALLY)===--->
	if EWD_WinState = 1
		{
		EWD_WinState = 2
		WinRestore,  ahk_id %Window%
		MouseGetPos, EWD_OriginalPosX, EWD_OriginalPosY
		;sleep 500
		WinMove, ahk_id %Window%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
		ToolTip,
		}
	Else 
Return


 ~LButton::
	MouseGetPos, begin_x, begin_y, Window
	WinGetClass Class, ahk_id %Window%
	If WinActive("ahk_class Basebar")
	tooltip,
	If (DetectContextMenu() = 1)
		{
		if class=WorkerW
			{
			;msgbox, sfdsfdsfdfsfs
			;WinActivate, ahk_id %Window%
			click, escape
			;MouseGetPos, begin_x, begin_y
			click, down   
			ruler()
			}
		if class=#32768
		;tooltip, menu
		return
		}
	if aax
		{
		aax:=
		ruler()
		}
	else
		{
		WinGetTitle aTitle, aclass %Window%
		WinGetClass aclass, ahk_id %Window%
		MouseGetPos, begin_x, begin_y
		;tooltip, clicked
		settimer, tooloff, 750
		;WinActivate, ahk_id %Window%
		if class=WorkerW
		Ruler()
		if (If WinActive("ahk_class WorkerW"))  ||  (If WinActive("ahk_class Progman")) 
		aax:= % Explorer_GetSelection()
		else
		return
		if !aax
		Ruler()
		else return

	Ruler() 	{
	WinGetActiveTitle, Atitle
	WinGetClass, aclass, %atitle%,,
	LongAnswer3:
	KeyWait, Lbutton, t0.500
	If (ErrorLevel) && ((If WinActive("ahk_class WorkerW"))  ||  (If WinActive("ahk_class Progman")))
		{
		MouseGetPos, x, y
		if (x != begin_x)  ||  (y != begin_y)
			{
			while GetKeyState("LButton", "P")
				{
				aax:= % Explorer_GetSelection()
				WinGetActiveTitle, Atitle
				WinGetClass, aclass, %atitle%,,
				MouseGetPos, x, y
				if (x > begin_x) 
					toolx:= begin_x - 103
				if (x < begin_x)
					toolx:= begin_x
				if (y > begin_y) 
					tooly:= begin_y -57
				if (y < begin_y)
					tooly:= begin_y+ 4
				ToolTip, % begin_x ", " begin_y "`n" "X:" Abs(begin_x-x) " Y:" Abs(begin_y-y), toolx, tooly 
				Sleep, %twit% 				;SetWinDelay, 100 -==Ruler tooltip refresh==-
				if aax
					{
					;tooltip, touching files stop ruler, toolx, tooly
					;sleep 1000
					ToolTip,
					exit
					}
				}
			;SetWinDelay -1
			;tooltip, mouse 1 released ,,,2 
			SetTimer, tooloff, -5000
			return 
			} 
		else while GetKeyState("lbutton", "P")
			{						;tooltip, no change x y  mouse 1 held ;(waiting decision)

			if aax   			;tooltip %aax%,,,5
				return
			if x!=begin_x !! y!=begin_y
				ruler()
			return
			}
		}
	}	}
return


#If (DetectContextMenu() = 1)  	 ;<=======MOUSE=WHEEL=NAVIGATE=IN=(CONTEXT)=MENU=======>
	{		 	
	WheelUp::
		Send, { up }
		Return

	WheelDown::
		Send, { down }
		Return

	PgDn::    ;  Razer_WheelRight
		Send, { right }
		Return

	PgUp::    ;  Razer_WheelLeft
		Send, { left }
		Return

	MButton:: 	;  WheelButton
		Send, { enter }
		return
	}

ToolOff:
	{
	tooltip,
	return
	}


HexToDec(HexVal)  {
   Old_A_FormatInteger := A_FormatInteger
   SetFormat IntegerFast, D
   DecVal := HexVal + 0
   SetFormat IntegerFast, %Old_A_FormatInteger%
   Return DecVal
	}


Explorer_GetSelection(hwnd="")  {
    WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")
    WinGetClass class, ahk_id %hwnd%
    if (process = "explorer.exe")
        if (class ~= "Progman|WorkerW") {
            ControlGet, files, List, Selected Col1, SysListView321, ahk_class %class%
            Loop, Parse, files, `n, `r
                ToReturn .= A_Desktop "\" A_LoopField "`n"
        } else if (class ~= "(Cabinet|Explore)WClass") {
            for window in ComObjCreate("Shell.Application").Windows
			try
				{
				if (window.hwnd==hwnd)
					sel := window.Document.SelectedItems
				}
            catch
				return
	for item in sel
		ToReturn .= item.path "`n"
        }
    return Trim(ToReturn,"`n")
}


GetUnderCursorInfo(ByRef CursorX, ByRef CursorY)  {
	CoordMode Mouse, Screen
	CoordMode Pixel, Screen
	MouseGetPos, CursorX, CursorY, Window, Control
	WinGetTitle Title, ahk_id %Window%
	WinGetClass Class, ahk_id %Window%
	WinGetPos WindowX, WindowY, Width, Height, ahk_id %Window%
	WinGet PName, ProcessName, ahk_id %Window%
	WinGet PID, PID, ahk_id %Window%
	ControlGet, sel, Selected, ,ahk_id %Window%
	WindowUnderCursorInfo := "ahk_id " Window "`n"
	. "ahk_class " Class "`n"
	. "title: " Title "`n"
	. "control: " Control "`n"
	. "control selected: " sel "`n"
	. "PID: " PID "`n"
	. "process name: " PName "`n"
	. "top left (" WindowX ", " WindowY ")`n"
	. "(width x height) (" Width " x " Height ")`n"
	. "cursor's window position (" CursorX-WindowX ", " CursorY-WindowY ")`n"
	. "cursor's screen position (" CursorX ", " CursorY ")`n"
	. "`n"
	. "CTRL+ WIN+C TO COPY DETAIL`n"
	. HexToDec("0x" SubStr(BGR_Color, 5, 2)) ", "
	. HexToDec("0x" SubStr(BGR_Color, 7, 2)) ")`n"
	Return WindowUnderCursorInfo
	}


ToolTipUnderCursor:
	{
	WindowUnderCursorInfo := GetUnderCursorInfo(CursorX, CursorY)
	coordmode mouse, pixel
	MouseGetPos, x1, y1
	coordmode tooltip, mouse
	ToolTip %WindowUnderCursorInfo%, x1 + 200,  y1
	Sleep, %twit%	;SetWinDelay, 100

	return
	}

DetectContextMenu()  {
   GuiThreadInfoSize = 48
   VarSetCapacity(GuiThreadInfo, 48)
   NumPut(GuiThreadInfoSize, GuiThreadInfo, 0)
   if not DllCall("GetGUIThreadInfo", uint, 0, str, GuiThreadInfo)
		{
		MsgBox GetGUIThreadInfo() indicated a failure.
		return
		}
   if (NumGet(GuiThreadInfo, 4) & 0x4)
		Return 1 
   Else
	Return 0
}


f8:: 			; 				_-========TESTING=/=TIMING=DEBUG========-_
twit:=twit +1
return


numpadclear::
	{
	WINID := WinExist("A")
	sleep 200
	tooltip % WINID
	return
	}


/* 

ToolTipUnderCursor:    ;GAHBAGE 
   WindowUnderCursorInfo := GetUnderCursorInfo(CursorX, CursorY)
   CoordMode ToolTip, Screen
   ; place tooltip in quadrant opposite of cursor
   If ( CursorX < (A_ScreenWidth // 2) )
      TTXOffset = 150
   Else
      TTXOffset = -150
   If ( CursorY < (A_ScreenHeight // 2) )
      TTYOffset = 150
   Else
      TTYOffset = -150
   ToolTip %WindowUnderCursorInfo%
      , ( (A_ScreenWidth // 2) + TTXOffset )
      , ( (A_ScreenHeight // 2) + TTYOffset )
Return

 */