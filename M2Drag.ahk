 /* 
;
; 	Warning:only run with  autohotkey 1.1.3.2+ 32bit with UI Access ( AutoHotkeyA32_UIA.exe
;	* This is due to detection of context menus
;
; 	KEYS:
;ds
;ds	Original right mouse button =  		CTRL + SHIFT + RIGHTCLICK  Incase bug
;ds	Quit application hotkey =  		CTRL + SHIFT + WIN + RIGHTCLICK (MouseWheelButton) 
;ds
;ds 	Drag any window under cursor = 	mouse2 drag on window	(left click to abort during drag)
;ds	ruler on desktop = 		mouse1 drag on desktop	(cancels on selection of item with marquee)
;ds	Toggle Window Info detail = 		CTRL+WIN+MIDDLECLICK(MouseWheel)=	
;ds  once active, CTRL WIN + C to copy detail 
;ds 	fixed:  Disabled desktop drag ) 
;ds	Blacklist ini file classnames (use Window Info above + CTRL C copies that)
;ds 	M Wolff - 2020
;ds
 */
;sendlevel 1
;#include ns.ahk
#noenv																																	
SendMode input
#WinActivateforce
#singleinstance force
#persistent
Menu, Tray, Icon, mouse24.ico
setbatchlines -1
CoordMode, Mouse, Screen
	CoordMode Pixel, Screen
;CoordMode, ToolTip, Screen;BLACKLIST-WINDOW-CLASSES
IniRead Class1, M2BlackList.ini, Cla55, class1
IniRead Class2, M2BlackList.ini, Cla55, class2
IniRead Class3, M2BlackList.ini, Cla55, class3
IniRead Class4, M2BlackList.ini, Cla55, class4
IniRead Class5, M2BlackList.ini, Cla55, class5
IniRead Class6, M2BlackList.ini, Cla55, class6
IniRead Class7, M2BlackList.ini, Cla55, class7
global begin_x
global begin_Y
global Cursor_int
global cursorchange
global EWD_MouseStartX_old
global EWD_MouseStartY_old
global x
global y 
global toolx
global xold
global yold
global tooly
global TTX
Global TTY 
global PID
global controlhwnd
global colour
;gosub Clean_Feed  ; lol
collection := [ Chrome_WidgetWin_2, MozillaDropShadowWindowClass ]
xx := 0, yy :=0

^+#RButton:: 			;-===CTRL+SHIFT+WIN+RIGHTCLICK=----
	ExitApp 						;  -===========GOODBYE============-

^#Mbutton::  		;>==============CTRL=+=WIN=+=MIDDLE=MOUSE=(WHEEL)=BUTTON=to=TOGGLE==INFO=DISPLAY==============<
UnderCursorToggle := ! UnderCursorToggle
	If (UnderCursorToggle) {
		SetTimer CursorTip, 30
		^#c:: 
		clipboard:=WindowUnderCursorInfo 		; ?====================copy=window=info===CTRL=+=WIN=+=C=========?
		return
	}	Else {   
	sleep 100
	SetTimer CursorTip, off
sleep 300
^#c::^#c
	return
	}

^NumpadDot::Rbutton ;>=====CTRL=NUMPAD=DOT====>(NORMAL=RIGHT=CLICK=INCASE=OF=BUGS)=====<

Rbutton::
CoordMode, Mouse, screen
MouseGetPos, begin_x, begin_y, Window
WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %Window%
WinGet, EWD_WinState, MinMax, ahk_id %Window% 	
WinGetClass Class, ahk_id %Window%
EWD_MouseStartX_old=%begin_x%
EWD_MouseStartY_old=%begin_y%
;winactivate ahk_id %window%
;
;WinGetClass aclass, ahk_id %Window%
;Bypass classes
;
if (Class=class1) or (Class=Class2) or (Class=Class3) or (Class=Class4) or (Class=Class5) or (Class=Class6) or (class=Shell_TrayWnd)
	{
	click, down, right
	{
	loop
		{
		GetKeyState, KSRB, RButton, P
		if KSRB = U  ; Button released, drag carried out.
			{
			send {rbutton}
			break
			}
		}
	exit
	}
/* 
;desktop 
if (Class=Class5) or (Class=Class6)
	{
click, down, left
	while GetKeyState("rbutton" , "P") 
		{
sleep 10
		tooltip,
		GetKeyState, KSRB, RButton, P
		if KSRB = U  ; Button released, drag carried out.
			{
			tooltip,
			sleep 10
			click, up, left
			sleep 10
			exit
			}
		}
	exit
	}
 */
}

if (Class=Class7) ;Context menus (most)
{
contextmenRclicked()
}

else 
;winactivate, ahk_id %window%

insight:=

while GetKeyState("rbutton" , "P") 
	{
;	CoordMode, Mouse  ; Switch to screen/absolute coordinates.
	MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
	 if !insight
		{
		WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
		WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin%
		cursorchange=1
		insight=1
		}
	mdrag_active()
	SetTimer, EWD_WatchMouse, 1 ; Track cursor vector differential
	return

EWD_WatchMouse:
if (x!=EWD_MouseStartX)
	gosub MaxedWindow
GetKeyState, EWD_RbuttonState, RButton, P
if EWD_RbuttonState = U  ; Button released, drag carried out.
	{
	;click, right ; normally click, up right
	SetTimer, EWD_WatchMouse, Off
	m2_released()
	CoordMode, Mouse
	mousegetpos xxxx, yyyy
	;if  xxxx!=% begin_x
	cursorchange=7
	if  (xxxx>begin_x -25) && (xxxx<begin_x +25) 
		{
		send {rbutton}
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
		SetWinDelay -1	;click, up, left
		WinMove, ahk_id %Window%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
		abort_Mdrag()
		return
		}
else   ;reposition
	{
	CoordMode, Mouse,
	MouseGetPos, EWD_MouseX, EWD_MouseY
	WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %Window%
	SetWinDelay, -1   
	WinMove, ahk_id %Window%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
	EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call.
	EWD_MouseStartY := EWD_MouseY
	if EWD_MouseX != %EWD_MouseStartX_old%
		If (DetectContextMenu() = 1)
			{
			;send escape
			;WaitMove:=WinExist("ahk_class #32768")
			winclose, ahk_class #32768
			Context_killed()
			}
		;for all in collection winclose, ahk_class %collection%	;EWD_MouseStartY_old=%begin_y%
		;if WinActive("ahk_class WorkerW")	||   WinActive("ahk_class Progman")
		mdrag_active()
	}
Return
}

MaxedWindow: 	;	<---===MAXIMIZED=CHECK=AND=PULL=WINDOW=TO=CURSOR=(NEEDS=FIX=TO=REALIGN=WITH=CURSOR=AESTHETICALLY)===--->
if EWD_WinState = 1
	{
	MouseGetPos, x1, y1
	WinRestore,  ahk_id %Window%
	wingetactivestats, titties, wind0w, hard, xamine, yeastinfections
	xaxax:= (A_ScreenWidth/2)-(wind0w/2)
	x2:=x1-(wind0w/2)
	y2:=y1-(hard/2)
	y0l0:=(A_ScreenHeight/2)-(hard/2)
	winset region,W%xaxax% H%xaxax%
	WinMove, ahk_id %Window%,, %x2% , %y2%
	}
Else, 
Return

 ~LButton::
	CoordMode mouse, screen
	MouseGetPos, begin_x, begin_y, Window
	WinGetClass, aClass, ahk_id %Window%	
	clicked()
	RestoreCursors()
	;If WinActive("ahk_class Basebar") ;cant rememeber why this was here
	;	return 
	if (aclass="WorkerW")  or  (aclass="Progman")
		{
		L_clicked_Desktop()
		R_wait:
Lclick_held()
		FailState:=0
		KeyWait, Lbutton, t0.75
		If ErrorLevel
			{
			MouseGetPos, x, y
			(x1:=begin_x + 5, x2:=begin_x - 5, y1:=begin_y + 5, y2:=begin_y - 5)
			if x > %x1%
				FailState=999
			if x < %x2%
				FailState=999
			if y > %y1%
				FailState=999
			if y < %y2%
				FailState=999
			If FailState
				{

				tooltip, %Message_Moved%,,,2
				goto Ruler
				}
			else goto R_wait
			}
		else 
			Quick_L_click()
			return
		}
	else 
		Clicked_somewhere()
	return		

Ruler: 	
aax := % Explorer_GetSelection()
If (DetectContextMenu() = 1)		
winclose, ahk_class #32768
Cursor_int := 32651
SetSystemCursor() 
WaitMove:
MouseGetPos, x, y
while GetKeyState("LButton", "P")
	{
	MouseGetPos, x, y
	if (xold!=x) or (yold!=y)
		{
		tooltipbycursor:=r00la(x,Y)
			if (x > begin_x) 
				toolx:= begin_x - 103
			if (x < begin_x)
				toolx:= begin_x
			if (y > begin_y) 
				tooly:= begin_y -57
			if (y < begin_y)
				tooly:= begin_y+ 4
			tooltip, %tooltipbycursor%, %toolx% , %tooly% , 5
			xold:=x
			yold:=y
			aax:= % Explorer_GetSelection()
			sleep 20
			if aax
				{
				SetSystemCursor()
				gosub tool5off
				touching_file()
				exit
				}
		}	
	else, sleep 20
	}
settimer tool5off, -2000
RestoreCursors()
L_Released()
exit



;>====Restoreicons on desktop as zooming====>
~^WheelDown::
	MouseGetPos, begin_x, begin_y, aaaaasss
	WinGetClass, cla555, ahk_id %aaaaasss%,,
	if (cla555= "WorkerW") ||  (cla555="Progman")
		Dtop_icons_Restore()
	return

~^WheelUp::
	MouseGetPos, begin_x, begin_y, aaaaasss
	WinGetClass, cla555, ahk_id %aaaaasss%,,
	if (cla555= "WorkerW") ||  (cla555="Progman")
		Dtop_icons_Restore()
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

f8:: 			; 				_-========TESTING=/=TIMING=DEBUG========-_
	twit:=twit +1
	return

numpadclear::
	WINID := WinExist("A")
	sleep 200
	tooltip % WINID
	return
	
CursorTip:     
	coordmode tooltip, screen
	WindowUnderCursorInfo := GetUnderCursorInfo(CursorX, CursorY)
	If ( CursorX < (A_ScreenWidth // 2) )
		TTX := (A_ScreenWidth // 2) + 100
	Else
		TTX := (A_ScreenWidth // 2) - 400
	If ( CursorY < (A_ScreenHeight // 2) )
		TTY := (A_ScreenHeight // 2) + 100
	Else
		TTY := (A_ScreenHeight // 2)-300
	if WindowUnderCursorInfo != %WindowUnderCursorInfoOld%
		{	;fixes flicker
	   ToolTip %WindowUnderCursorInfo%, %TTX% , %TTY%
		WindowUnderCursorInfoOld=% WindowUnderCursorInfo
		}
	Return

r00la(byref x, byref y) {
	WinGetActiveTitle, Atitle
	WinGetClass, aclass, %atitle%,,
	;MouseGetPos, x, y
	krabx:= Abs(begin_x-x)
	Kraby := Abs(begin_y-y)
	R_Return := "  "begin_x ", " begin_y "`n"
.  "X:" krabx " Y:" kraby ""
	return R_Return
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
	WinGet, Style, Style, ahk_id %Window%
	WinGet, ExStyle, ExStyle, ahk_id %Window%
	ControlGet, ContStyle, Style ,,%control%, ahk_id %Window%
	ControlGet, ContExStyle, ExStyle ,,%control%, ahk_id %Window%
	ControlGet, controlhwnd, Hwnd ,, %Control%, ahk_id %Window%
	PixelGetColor, colour, CursorX, CursorY
	if (length:=StrLen(Title))>35
		{
		TitleT:= SubStr(Title, 1 , 36)
		Title=%TitleT%...
		}
	WindowUnderCursorInfo := "ahk_id " Window "                               PID: " PID "`n"
 	. "process name " PName "`n"
	. "Title " Title "`n"
 	. "ahk_class " Class "`n"
	. "Style / ExStyle  " Style " - " ExStyle "`n"
	. "Control "Control             "      C_hWnd: " controlhwnd " `n"
	. "Style / ExStyle  " ContStyle " - " ContExStyle "`n"
;	. "control selected: " sel "`n"
	. "Top Left Px (" WindowX ", " WindowY ")`n"
	. "Dimensions                                 (" Width " x " Height ")`n"
	. "cursor window position                    (" CursorX-WindowX ", " CursorY-WindowY ")`n"
	. "Colour under cursor                        " Colour  "`n"
	. "cursor's screen position                (" CursorX ", " CursorY ")`n"
	. "`n"
	. "          CTRL+ WIN+C TO COPY DETAIL          `n"
	CoordMode Mouse
	Return WindowUnderCursorInfo
	}	; . HexToDec("0x" SubStr(BGR_Color, 5, 2)) ", "; . HexToDec("0x" SubStr(BGR_Color, 7, 2)) ")`n"

DetectContextMenu()  {
   GuiThreadInfoSize = 48
   VarSetCapacity(GuiThreadInfo, 48)
   NumPut(GuiThreadInfoSize, GuiThreadInfo, 0)
   if not DllCall("GetGUIThreadInfo", uint, 0, str, GuiThreadInfo)
		ThreadFail()
   if (NumGet(GuiThreadInfo, 4) & 0x4)
		Return 1 
   Else
		Return 0
	}

SetSystemCursor() {
	CursorHandle := DllCall( "LoadCursor", Uint,0, Int,Cursor_int )
	Cursors = %Cursor_int%,32512
	Loop , Parse, Cursors, `,
		DllCall( "SetSystemCursor", Uint,CursorHandle, Int,A_Loopfield )
	return
	}

RestoreCursors() {
	SPI_SETCURSORS := 0x57
	DllCall( "SystemParametersInfo", UInt,SPI_SETCURSORS, UInt,0, UInt,0, UInt,0 )
	return
	}

In(x,a,b)  { 
	IfLess x,%a%, Return a
	IfLess b,%x%, Return b
	Return x
	}

HexToDec(HexVal)  {
   Old_A_FormatInteger := A_FormatInteger
   SetFormat IntegerFast, D
   DecVal := HexVal + 0
   SetFormat IntegerFast, %Old_A_FormatInteger%
   Return DecVal
	}

Dtop_icons_Get() {
	RunWait, Dicons_write.ahk 
	return
	}

Dtop_icons_Restore() {
	RunWait, Dicons_recover.ahk 
	return
	}

clicked() {
	tooltip, % Message_Click
	settimer, tool1off, -1000
	return
	}

contextmenRclicked() {
	tooltip, % Message_Menu_Clicked
	settimer, tool1off, -1000
	return
	}

abort_Mdrag() {
	ToolTip, % Message_M2drag_Abort
	settimer, tool1off, -1000
	return
	}

m2_released() {
	tooltip % Message_M2_Released
	settimer, tool1off, -1000
	return
	}

mdrag_active() {
	tooltip, % Message_Drag_Active
	return
	}

ThreadFail() {
	tooltip, %Message_Thread_Fail%, (A_ScreenWidth // 2), (A_ScreenWidth // 2)
	settimer, tool1off, -3000
	return
	}

Context_killed() {
	tooltip, %Message_Menu_Killed%,,,4
	settimer, tool4off, -1000
	return
	}

Quick_L_click() {
	Tooltip % Message_Click_Fast
	settimer, tool1off, -1000
	return
	}

L_Released() {
	tooltip, %Message_Click_Release%,,,4
	settimer, tool4off, -1000
	return
	}

L_clicked_Desktop() {
	tooltip, %Message_Click_DTop%, (begin_x+100), (begin_Y+20)
	settimer, Tool1Off, -750
	return
	}

Clicked_somewhere() {
	tooltip, %Message_Click_Other%
	settimer, Tool1Off, -750
	return
	}

Lclick_held() {
		tooltip %Message_held_DTop%
		settimer, Tool1Off, -750
	return
	}

touching_file() {
	tooltip, %Message_Touching% , toolx, tooly,4
	settimer, Tool4Off, -750
	return
	}

ToolOff:
	tooltip,
return

Tool1Off:
	tooltip,,,,1
return

Tool2Off:
	tooltip,,,,2
return

Tool3Off:
	tooltip,,,,3
return

Tool4Off:
	tooltip,,,,4
return

Tool5Off:
	tooltip,,,,5
return

Clean_Feed:
global Message_Click:="::Clicked::"
global Message_Menu_Clicked:="Context Menu Clicked"
global Message_M2drag_Abort:="Aborting Drag"
global Message_M2_Released:="released mouse2"
global Message_Drag_Active:="window drag activated' n - Mouse 1 to Cancel"
global Message_Thread_Fail:="GetGUIThreadInfo failure"
global Message_Menu_Killed:="menu killed"
global Message_Click_Fast:="Quick click::"
global Message_Click_Release:="mouse 1 released"
global Message_Click_DTop:="Left Clicked Desktop"
global Message_Click_Other:="clicked elsewhere"
global Message_held_DTop:="clickheld on desktop"
global Message_Touching:="touching file"
global Message_Moved :="%FailState% ...`n %X% %begin_X% %y% %begin_y%`n Movement detected `n %x1% %x2% %y1% %y2%, %x%, %75%"
return
