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

	; sendlevel 1;#include ns.ahk ;gosub _Feed_

#noenv																																	
SendMode input
;#WinActivateforce
#singleinstance force
#persistent
Menu, Tray, Icon, mouse24.ico
setbatchlines -1
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
;CoordMode, ToolTip, Screen;BLACKLIST-WINDOW-CLASSES
IniRead Class1, M2BlackList.ini, Cla55, class1
IniRead Class2, M2BlackList.ini, Cla55, class2
IniRead Class3, M2BlackList.ini, Cla55, class3
IniRead Class4, M2BlackList.ini, Cla55, class4
IniRead Class5, M2BlackList.ini, Cla55, class5
IniRead Class6, M2BlackList.ini, Cla55, class6
IniRead Class7, M2BlackList.ini, Cla55, class7
Global begin_x, Global begin_Y, Global Cursor_int, Global cursorchange, Global EWD_MouseStartX_old, Global EWD_MouseStartY_old, Global x
Global y, Global toolx, Global xold, Global yold, Global tooly, Global TTX, Global TTY, Global PID, Global controlhwnd,Global colour, xx := 0, yy :=0
global cock

collection := [ Chrome_WidgetWin_2, MozillaDropShadowWindowClass ]

#M:: 
if (!Mag) {
	run M2DRAG_MAG.AHK
	Mag:=1
	}
Else Mag:=0
Return
	
^+#RButton:: ExitApp 					;-===CTRL+SHIFT+WIN+RIGHTCLICK=----

^#Mbutton::  		;>==============CTRL=+=WIN=+=MIDDLE=MOUSE=(WHEEL)=BUTTON=to=TOGGLE==INFO=DISPLAY==============<
UnderCursorToggle := ! UnderCursorToggle
	If (UnderCursorToggle) {
		SetTimer CursorTip, 30
		^#c:: 
		clipboard:=WindowUnderCursorInfo 		; ?====================copy=window=info===CTRL=+=WIN=+=C=========?
		Return
	}	Else {   
	sleep 100
	SetTimer CursorTip, off
sleep 300
^#c::^#c
	Return
	}

^NumpadDot::Rbutton 	;>=====CTRL=NUMPAD=DOT====>(NORMAL=RIGHT=CLICK=INCASE=OF=BUGS)=====<

Rbutton::
CoordMode, Mouse, screen
MouseGetPos, begin_x, begin_y, Window
WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %Window%
WinGet, EWD_WinState, MinMax, ahk_id %Window% 	
WinGetClass Class, ahk_id %Window%
EWD_MouseStartX_old=%begin_x%
EWD_MouseStartY_old=%begin_y%

;Bypass classes
;
if (Class=class1) or (Class=Class2) or (Class=Class3) or (Class=Class4) or (Class=Class5) or (Class=Class6) or (class=Shell_TrayWnd)
	{
	click, down, right
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
	Return

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
		Return
		}
	Return
	}
GetKeyState, EWD_EscapeState, LButton, P
	if EWD_EscapeState = D  
		{
		SetTimer, EWD_WatchMouse, Off
		SetWinDelay -1	;click, up, left
		WinMove, ahk_id %Window%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
		abort_Mdrag()
		Return
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
	;	Return 
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
			Return
		}
	else 
		Clicked_somewhere()
	Return		

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
SetTimer tool5off, -2000
RestoreCursors()
L_Released()
exit

#!t::  
; Press Win+T to make the color under the mouse cursor invisible.
MouseGetPos, MouseX, MouseY, MouseWin
PixelGetColor, MouseRGB, %MouseX%, %MouseY%, RGB
; It seems necessary to turn off any existing transparency first:
WinSet, TransColor, Off, ahk_id %MouseWin%
sleep 100
WinSet, TransColor, %MouseRGB%, ahk_id %MouseWin%
Return

#!y::  ; Press Win+y to turn off transparency for the window under the mouse.
MouseGetPos,,, MouseWin
WinSet, TransColor, Off, ahk_id %MouseWin%
Return

#!g::  ; Press Win+G to show the current settings of the window under the mouse.
MouseGetPos,,, MouseWin
WinGet, Transparent, Transparent, ahk_id %MouseWin%
WinGet, TransColor, TransColor, ahk_id %MouseWin%
ToolTip Translucency:`n%Transparent%`nTransColor:`t%TransColor%
Return

;>====Restoreicons on desktop as zooming====>
~^WheelDown::
	MouseGetPos, begin_x, begin_y, aaaaasss
	WinGetClass, cla555, ahk_id %aaaaasss%,,
	if (cla555= "WorkerW") ||  (cla555="Progman")
		Dtop_icons_Restore()
	Return

~^WheelUp::
	MouseGetPos, begin_x, begin_y, aaaaasss
	WinGetClass, cla555, ahk_id %aaaaasss%,,
	if (cla555= "WorkerW") ||  (cla555="Progman")
		Dtop_icons_Restore()
	Return

+PgDn::    ;Wheel Right = page down without interfering with selection
	WinGetClass, Active_WinClass , A
	MouseGetPos, , , Mouse_hWnd, Mouse_ClassNN
	WinGetClass, Mouse_WinClass , ahk_id %Mouse_hWnd%
	;WinGetTitle Mouse_WinTitle, ahk_id %Mouse_hWnd%	;ControlGet, Mouse_ControLhWnd, Hwnd ,, %Mouse_ClassNN%, ahk_id %Mouse_hWnd%
	if Active_WinClass != % Mouse_WinClass
		{
	if Mouse_WinClass in MozillaWindowClass,Chrome_WidgetWin_1
		{
		controlsend, %Mouse_ClassNN%, { PgDn }, ahk_id %Mouse_hWnd%
		} else if Mouse_WinClass in CabinetWClass,Notepad++
		{
		if Mouse_ClassNN=DirectUIHWND2
			SendMessage, 0x115, 3, 2, ScrollBar2,  ahk_id %Mouse_hWnd%
		else	
			SendMessage, 0x115, 3, 2, %Mouse_ClassNN%,  ahk_id %Mouse_hWnd%
		} else 
if Mouse_ClassNN=WindowsForms10.Window.8.app.0.34f5582_r6_ad1
			controlsend, %Mouse_ClassNN%, { Right } , ahk_id %Mouse_hWnd%
		
	else {
			ControlSend, , { PgDn }, ahk_id %Mouse_hWnd%
		}
	}
	else
	if Mouse_WinClass in CabinetWClass,Notepad++
		{
		if Mouse_ClassNN=DirectUIHWND2
			SendMessage, 0x115, 3, 2, ScrollBar2,  ahk_id %Mouse_hWnd%
		else	
			SendMessage, 0x115, 3, 2, %Mouse_ClassNN%,  ahk_id %Mouse_hWnd%
		} else 
			send, { pgdn }
	Return    

+PgUp::    ;Wheel Left = page up without interfering with selection
	WinGetClass, Active_WinClass , A
	MouseGetPos, , , Mouse_hWnd, Mouse_ClassNN
	WinGetClass, Mouse_WinClass , ahk_id %Mouse_hWnd%
	;ControlGet, Mouse_ControLhWnd, Hwnd ,, %Mouse_ClassNN%, ahk_id %Mouse_hWnd%
	if Active_WinClass != % Mouse_WinClass
		{
	if Mouse_WinClass in MozillaWindowClass
		controlsend, %Mouse_ClassNN%, { PgUp }, ahk_id %Mouse_hWnd%
	else 
		if Mouse_WinClass in Chrome_WidgetWin_1
			controlsendraw, %Mouse_ClassNN%, { PgUp }, ahk_id %Mouse_hWnd%
	else
		if Mouse_WinClass in CabinetWClass,Notepad++
			{
			if Mouse_ClassNN=DirectUIHWND2
				SendMessage, 0x115, 2, 2, ScrollBar2,  ahk_id %Mouse_hWnd%
			else	
				SendMessage, 0x115, 2, 2, %Mouse_ClassNN%,  ahk_id %Mouse_hWnd%
			} else
		if Mouse_ClassNN=WindowsForms10.Window.8.app.0.34f5582_r6_ad1
			controlsend, %Mouse_ClassNN%, { Left } , ahk_id %Mouse_hWnd%
		else {
		ControlSend, %Mouse_ClassNN%, { PgUp }, ahk_id %Mouse_hWnd%
	}	} else
		if Mouse_WinClass in CabinetWClass,Notepad++
			{
			if Mouse_ClassNN=DirectUIHWND2
				SendMessage, 0x115, 2, 2, ScrollBar2,  ahk_id %Mouse_hWnd%
			else	
				SendMessage, 0x115, 2, 2, %Mouse_ClassNN%,  ahk_id %Mouse_hWnd%
			} else send, { pgup }
	Return    

#LButton::PostMessage_2CursorWin(0x111, 41504, 0)
if (ErrorLevel) {
	ToolTip, %ErrorLevel% Error
	SetTimer, ToolOff, -1000
	}
Return

#RButton::PostMessage_2CursorCTL(0x111, 41504, 0)
if (ErrorLevel) {
	ToolTip, %ErrorLevel% Error
	SetTimer, ToolOff, -1000
	}
Return

#If (DetectContextMenu() = 1)  	 ;<=======MOUSE=WHEEL=NAVIGATE=IN=(CONTEXT)=MENU=======>
	{		 	
	WheelUp::
		Send, { up }
		Return

	WheelDown::
		Send, { down }
		Return

	PgUp::    ;  Razer_WheelLeft
		Send, { left }
		Return

	MButton:: 	;  WheelButton
		Send, { enter }
		Return
	}

f8:: 			; 				_-========TESTING=/=TIMING=DEBUG========-_
	twit:=twit +1
	Return

numpadclear::
	WINID := WinExist("A")
	sleep 200
	tooltip % WINID
	Return
	
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
	Return R_Return
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
				Return
	for item in sel
		ToReturn .= item.path "`n"
        }
    Return Trim(ToReturn,"`n")
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
	Return
	}

RestoreCursors() {
	SPI_SETCURSORS := 0x57
	DllCall( "SystemParametersInfo", UInt,SPI_SETCURSORS, UInt,0, UInt,0, UInt,0 )
	Return
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

PostMessage_2CursorWin(Message, wParam = 0, lParam=0) {	
	OldCoordMode:= A_CoordModeMouse
	CoordMode, Mouse, Screen
	MouseGetPos X, Y, , , 2
	hWnd := DllCall("WindowFromPoint", "int", X , "int", Y)
	PostMessage %Message%, %wParam%, %lParam%, , ahk_id %hWnd%
	CoordMode, Mouse, %OldCoordMode%
  } ;</23.01.000004>

PostMessage_2CursorCTL(Message, wParam = 0, lParam=0) {	
	OldCoordMode:= A_CoordModeMouse
	CoordMode, Mouse, Screen
	MouseGetPos X, Y, , hwnd , 2
	;hWnd := DllCall("WindowFromPoint", "int", X , "int", Y)
	PostMessage %Message%, %wParam%, %lParam%, , ahk_id %hWnd%
	CoordMode, Mouse, %OldCoordMode%
  } ;</23.01.000004>

Dtop_icons_Get() {
	RunWait, Dicons_write.ahk 
	Return
	}

Dtop_icons_Restore() {
	RunWait, Dicons_recover.ahk 
	Return
	}

clicked() {
	tooltip, % Message_Click
	SetTimer, tool1off, -1000
	Return
	}

contextmenRclicked() {
	tooltip, % Message_Menu_Clicked
	SetTimer, tool1off, -1000
	Return
	}

abort_Mdrag() {
	ToolTip, % Message_M2drag_Abort
	SetTimer, tool1off, -1000
	Return
	}

m2_released() {
	tooltip % Message_M2_Released
	SetTimer, tool1off, -1000
	Return
	}

mdrag_active() {
	tooltip, % Message_Drag_Active
	Return
	}

ThreadFail() {
	tooltip, %Message_Thread_Fail%, (A_ScreenWidth // 2), (A_ScreenWidth // 2)
	SetTimer, tool1off, -3000
	Return
	}

Context_killed() {
	tooltip, %Message_Menu_Killed%,,,4
	SetTimer, tool4off, -1000
	Return
	}

Quick_L_click() {
	Tooltip % Message_Click_Fast
	SetTimer, tool1off, -1000
	Return
	}

L_Released() {
	tooltip, %Message_Click_Release%,,,4
	SetTimer, tool4off, -1000
	Return
	}

L_clicked_Desktop() {
	tooltip, %Message_Click_DTop%, (begin_x+100), (begin_Y+20)
	SetTimer, Tool1Off, -750
	Return
	}

Clicked_somewhere() {
	tooltip, %Message_Click_Other%
	SetTimer, Tool1Off, -750
	Return
	}

Lclick_held() {
		tooltip %Message_held_DTop%
		SetTimer, Tool1Off, -750
	Return
	}

touching_file() {
	tooltip, %Message_Touching% , toolx, tooly,4
	SetTimer, Tool4Off, -750
	Return
	}

ToolOff:
	tooltip,
Return

Tool1Off:
	tooltip,,,,1
Return

Tool2Off:
	tooltip,,,,2
Return

Tool3Off:
	tooltip,,,,3
Return

Tool4Off:
	tooltip,,,,4
Return

Tool5Off:
	tooltip,,,,5
Return

_Feed_:
Global Message_Click:="::Clicked::"
Global Message_Menu_Clicked:="Context Menu Clicked"
Global Message_M2drag_Abort:="Aborting Drag"
Global Message_M2_Released:="released mouse2"
Global Message_Drag_Active:="window drag activated' n - Mouse 1 to Cancel"
Global Message_Thread_Fail:="GetGUIThreadInfo failure"
Global Message_Menu_Killed:="menu killed"
Global Message_Click_Fast:="Quick click::"
Global Message_Click_Release:="mouse 1 released"
Global Message_Click_DTop:="Left Clicked Desktop"
Global Message_Click_Other:="clicked elsewhere"
Global Message_held_DTop:="clickheld on desktop"
Global Message_Touching:="touching file"
Global Message_Moved :="%FailState% ...`n %X% %begin_X% %y% %begin_y%`n Movement detected `n %x1% %x2% %y1% %y2%, %x%, %75%"
Return
