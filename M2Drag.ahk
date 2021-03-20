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
;ds 	Drag any Window under cursor = 	mouse2 drag on Window	(left click to abort during drag)
;ds	ruler on desktop = 		mouse1 drag on desktop	(cancels on selection of item with marquee)
;ds	Toggle Window Info detail = 		CTRL+WIN+MIDDLECLICK(MouseWheel)=	
;ds  once active, CTRL WIN + C to copy detail 
;ds 	fixed:  Disabled desktop drag ) 
;ds	Blacklist ini file Classnames (use Window Info above + CTRL C copies that)
;ds 	M Wolff - 2020
;ds
 */
	; sendlevel 1;#include ns.ahk ;gosub _Feed_ ;#WinActivateforce ;CoordMode, ToolTip, Screen;BLACKLIST-Window-ClassES
#NoEnv																																	
#SingleInstance force
#Persistent
#InstallMouseHook
#MaxThreadsPerHotkey 10
SendMode Input ;SetBatchLines -1 ;SetWinDelay -1
SetWorkingDir %A_ScriptDir% 

Menu, Tray, NoStandard
Menu, Tray, Add, Open script folder, Open_script_folder,
Menu, Tray, Standard

OnExit, Cleanup

Global PID, Global ControlhWnd, Global Cursor_int, Global CursorChange, Global EWD_OriginalWidth, Global EWD_OriginalHeight, Global ccc, Global ddd, Global Trigg4
Global Begin_X, Global Begin_Y, Global X, Global Y, Global ToolX, Global ToolY, Global TTX, Global TTY, Global ZWidth2, Global Zheight2, Global ZWidth, Global Zheight
Global X_Start_OLD, Global Y_Start_OLD, Global OriginalPosX, Global OriginalPosY, Global XOld, Global YOld, Global EWD_MidX, Global EWD_MidY

m1resize:=1
;loopme
IniRead Class1, M2BlackList.ini, Cla55, Class1
IniRead Class2, M2BlackList.ini, Cla55, Class2
IniRead Class3, M2BlackList.ini, Cla55, Class3
IniRead Class4, M2BlackList.ini, Cla55, Class4
IniRead Class5, M2BlackList.ini, Cla55, Class5
IniRead Class6, M2BlackList.ini, Cla55, Class6
IniRead Class7, M2BlackList.ini, Cla55, Class7
IniRead Class8, M2BlackList.ini, Cla55, Class8
IniRead Class9, M2BlackList.ini, Cla55, Class9
IniRead Class10, M2BlackList.ini, Cla55, Class10
;IniRead Win_Drag_State, M2DRAG.ini, Drag, Activate_Window
Menu, Tray, Icon, mouse24.ico
Menu, Tray, NoStandard
Menu, SubMenu1, Add, Activate moving Window rag, Toggle_Win_Drag_State
if Win_Drag_State=Active
	Menu, submenu1, Check, Activate moving Window rag,
Menu, Tray, Add, Settings, :SubMenu1
Menu, Tray, Standard
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
AlphaIncrement := 0.2

maggy:="C:\Program Files\AHK\AutoHotkey.exe C:\Script\AHK\Working\M2DRAG_MAG.AHK", Mag:=0, XX := 0, YY :=0 
;collection := [ Chrome_WidgetWin_2, MozillaDropShadowWindowClass ]

#M:: 
	if (!Mag) {
		run % ahkizzle maggy
		Mag:=1
		}
	Else Mag:=0
	Return
	
^+RButton:: 									;REGULAR RCLICK	     ;     CTRL  +   SHIFT  +   RIGHTCLICK
SendInput, { RButton } 			
Return

^+LButton:: 	 								;REGULAR RCLICK	     ;     CTRL  +   SHIFT  +   LCLICK
SendInput, {LButton} 				
Return

^#Mbutton::  		;    CTRL    +     WIN    +     MIDDLE=MOUSE     (aka WHEELBUTTON)
	UnderCursorToggle := ! UnderCursorToggle  ;            TOGGLE     INFO     DISPLAY
	If (UnderCursorToggle) {
		SetTimer CursorTip, 30
		^#c::  ; 															CTRL     WIN     C 
		clipboard:=WindowUnderCursorInfo 		;      copy     Window     info     
		Return
	} Else {
	sleep 100
	SetTimer CursorTip, off
	sleep 300
	^#c::^#c  ;none of this is working. ~Remove
	Return
	}



^NumpadDot::exit 	;>=====CTRL=NUMPAD=DOT====>(NORMAL=RIGHT=CLICK=INCASE=OF=BUGS)=====<
Return
 
RButton::
CoordMode, Mouse, screen
MouseGetPos, Begin_X, Begin_Y, Window
;CoordMode, Mouse,
WinGetClass Class, ahk_id %Window%
WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY, EWD_OriginalWidth, EWD_OriginalHeight, ahk_id %Window%
WinGet, EWD_WinState, MinMax, ahk_id %Window% 	
trigg4:=
X_Start_OLD=%Begin_X%
Y_Start_OLD=%Begin_Y%
;Bypass Classes
if (Class=Class1) or (Class=Class2) or (Class=Class3) or (Class=Class4)  or (Class="Shell_TrayWnd") or (Class=Class8) or (Class=Class9) or (Class=Class10) or (Class="BlackDesertWindowClass") or (Class="LaunchUnrealUWindowsClient")  or (Class="AlienShooter") { ;Bypass Classes
	SendInput, {RButton Down} 
	Loop {
		GetKeyState, KSRB, RButton, P
		if (KSRB = "U") {	; Button released, drag carried out.
			SendInput, {RButton Up} 	
			Break
	}	}
	Exit
}
;Desktop 
if (Class=Class5) or (Class=Class6) {
	SendInput, {RButton Down} 
	While GetKeyState("RButton" , "P") {
		sleep 10
		GetKeyState, KSRB, RButton, P
		if (KSRB = "U") {	; Button released, drag carried out.
			SendInput, {RButton Up} 	
			sleep 10
			Exit
			}
		}
	Exit
	}

 /* 
if (Class=Class7) ;Context menus (most) {
	if EWD_MouseX != %X_Start_OLD%
		If (DetectContextMenu() = 1)
			{			;send escape ;WaitMove:=WinExist("AHK_Class #32768")
			;WinClose, AHK_Class #32768
			tooltip menu INCEPT,,,4
			;Context_killed()
			}
	;contextmenRclicked()
	}
 */ /* 
Else if (Class="BaseBar") || (Class=Class7) {
While GetKeyState("RButton" , "U") 
	{
	tooltip menu INCEPT,,,4
	send {RButton}
	Return
	}
Return
}
 */

Else SetTimer Win_Activate, -1
insight:=""

if (Class="#32770")
WinSet, Style, +0x00040000, ahk_id %window%


While (GetKeyState("RButton" , "P") ) {
	MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
	if !insight {
		WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
		WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin%
		CursorChange=1
		insight=1
		}
	mdrag_active()
	SetTimer, EWD_WatchMouse, 1
	Return

EWD_WatchMouse:
GetKeyState, EWD_RButtonState, RButton, P
if (EWD_RButtonState = "U") { ; Button released, drag carried out.
	SetTimer, EWD_WatchMouse, Off
	m2_released() ; normally click, up right
	CoordMode, Mouse
	mousegetpos XXXX, YYYY
	CursorChange=1
	if !trigg4 {
		click right
		Exit
		} Else {
		Trigg4:=
		Return
		}
	Return
	}

if M1DragReset {
	GetKeyState, EWD_EscapeState, LButton, P
	if (EWD_EscapeState = "D") {
		SetTimer, EWD_WatchMouse, Off
		SetWinDelay -1	;click, up, left
		WinMove, ahk_id %Window%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
		abort_Mdrag()
		Return
		} 
} Else {
if (EWD_WinState = "1") {
	MouseGetPos, EWD_MouseX, EWD_MouseY
	if (EWD_MouseX<begin_x -25) || (EWD_Mousex>begin_x +25) || (EWD_MouseY<begin_Y -25) || (EWD_MouseY>begin_Y +25) {
		WinRestore, ahk_id %Window%
		WinGetActiveStats, EWD_WinTitle, EWD_WinWidth, EWD_WinHeight, EWD_WinX, EWD_WinY
		EWD_MidWidth:= (A_ScreenWidth/2)-(EWD_WinWidth/2)
		EWD_MidX:=x1-(EWD_WinWidth/2)
		EWD_MidY:=y1-(EWD_WinHeight/2)
		EWD_MidHeight:=(A_ScreenHeight/2)-(EWD_WinHeight/2)
		winset region,W%EWD_MidWidth% H%EWD_MidHeight%
		WinMove, ahk_id %Window%,, %EWD_MidX% , %EWD_MidY%
	}	}
else {
	SetWinDelay, -1
	;CoordMode, Mouse,
	MouseGetPos, EWD_MouseX, EWD_MouseY
	WinGetPos, EWD_WinX, EWD_WinY,ZWidth,Zheight, ahk_id %Window%
	WinMove, ahk_id %Window%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY, %ZWidth2%, %Zheight2%
	if !trigg4
		if (EWD_MouseX<begin_x -25) || (EWD_Mousex>begin_x +25) || (EWD_MouseY<begin_Y -25) || (EWD_MouseY>begin_Y +25)
			trigg4=1		
	EWD_MouseStartX = %EWD_MouseX%  ; Update for the next timer-call.
	EWD_MouseStartY = %EWD_MouseY%
	}
}
	Return
}
Return

LButton::
if trigg4 {
	While (GetKeyState("LButton" , "P") ) { ;	CoordMode, Mouse  ; Switch to screen/absolute coordinates.
		SetTimer, bumfuck, 1 ; Track cursor vector differential
		Return
	}
bumfuck:
GetKeyState, M1State, LButton, P
MouseGetPos, niggx, niggy
WinGetPos,,,ZWidth,Zheight, ahk_id %Window%
m1resize_X2 := niggx - EWD_MouseStartX
m1resize_Y2 := niggy - EWD_MouseStartY
ZWidth2 := EWD_OriginalWidth + m1resize_X2
Zheight2 := EWD_OriginalHeight + m1resize_Y2
WinMove, ahk_id %Window%,,EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY,%ZWidth2%,%Zheight2%
SetWinDelay, -1
;tooltip % trigg4 "nn " Window "nn " Window "nn "  EWD_MouseStartY "nn " m1resize_Y
if (M1State = "U") {	; Button released, drag carried out.
	settimer bumfuck, off
	ZWidth2:= 
	Zheight2:=
	}	
	Return
}	
	CoordMode mouse, screen
	MouseGetPos, Begin_X, Begin_Y, Window
	WinGetClass, aClass, ahk_id %Window%	
	;SendInput, {LButton Down}
	click left, down
	clicked()
	While a_LB:=GetKeyState("LButton" , "P")  
		{ 	
		CoordMode, Mouse  ; Switch to screen/absolute coordinates.
		sleep 10
		}
	;If WinActive("AHK_Class Basebar") ;cant rememeber why this was here
	;	Return 
	if (aClass="WorkerW") || (aClass="Progman") {
		L_clicked_Desktop()
		R_Wait:
		LButton_Held()
		FailState:=0
		KeyWait, Lbutton, t0.75
		If (ErrorLevel) {
			MouseGetPos, x, y
			(x1:=Begin_X + 5, x2:=Begin_X - 5, y1:=Begin_Y + 5, y2:=Begin_Y - 5)
			if x > %x1%
				FailState=999
			if x < %x2%
				FailState=999
			if y > %y1%
				FailState=999
			if y < %y2%
				FailState=999
			If FailState {
				ToolTip, %Message_Moved%,,,2
				goto Ruler
			} Else goto R_Wait
		} Else {
			;SendInput, {LButton Up} 
			Click, up, left	
			Quick_L_click()
			Return
		}
	} else {
		;SendInput, {LButton Up} 		
			Click, up, left	
		;RestoreCursors()
		;Clicked_Somewhere()
		Return		
	}
Return

Ruler: 	
Selected_Item_Check := % Explorer_GetSelection()

Cursor_int := 32651
SetSystemCursor() 
WaitMove:
MouseGetPos, x, y
While GetKeyState("LButton", "P")
{
	MouseGetPos, x, y
	if (XOld!=X) or (YOld!=y) {
		ToolTipbycursor:=r00la(X,Y)
		if (X > Begin_X) 
			toolX:= Begin_X - 103
		if (X < Begin_X)
			toolX:= Begin_X
		if (y > Begin_Y) 
			tooly:= Begin_Y -57
		if (y < Begin_Y)
			tooly:= Begin_Y+ 4
		ToolTip, %ToolTipbycursor%, %toolX% , %tooly% , 5
		XOld:=X
		YOld:=y
		Selected_Item_Check:= % Explorer_GetSelection()
		sleep 20
		if Selected_Item_Check {
			SetSystemCursor()
			gosub tool5off
			touching_file()
			Return
		}
	}	
	Else sleep 20
}

SetTimer tool5off, -2000
RestoreCursors()
L_Released()
Return

^1::  	; Press ctl 1 to make the color under the mouse cursor invisible.
MouseGetPos, MouseX, MouseY, MouseWin
PixelGetColor, MouseRGB, %MouseX%, %MouseY%, RGB
WinSet, TransColor, Off, ahk_id %MouseWin%
sleep 100
;WinSet, TransColor, %MouseRGB%, ahk_id %MouseWin%
WinSet, TransColor, 0x000000, ahk_id %MouseWin%
Return

#lbutton:: 	; Press Win+y to turn off transparency for the Window under the mouse.
MouseGetPos,,, MouseWin
WinSet, TransColor, Off, ahk_id %MouseWin%
Return

#!g::  ; Press Win+G to show the current settings of the Window under the mouse.
MouseGetPos,,, MouseWin
WinGet, Transparent, Transparent, ahk_id %MouseWin%
WinGet, TransColor, TransColor, ahk_id %MouseWin%
ToolTip Translucency:`n%Transparent%`nTransColor:`t%TransColor%
Return

;>====FIX icons on desktop as zooming====>
+^WheelDown::
	MouseGetPos, Begin_X, Begin_Y, ahk_id_CHECK
	WinGetClass, AHK_Class_CHECK, ahk_id %ahk_id_CHECK%,,
	if (AHK_Class_CHECK= "WorkerW") || (AHK_Class_CHECK="Progman")
		Dtop_icons_Restore()
	Return

+^WheelUp::
	MouseGetPos, Begin_X, Begin_Y, ahk_id_CHECK
	WinGetClass, AHK_Class_CHECK, ahk_id %ahk_id_CHECK%,,
	if(AHK_Class_CHECK= "WorkerW") || (AHK_Class_CHECK="Progman")
		Dtop_icons_Restore()
	Return
	

+PgDn:: 	;Wheel Right = page down without interfering with selection
WinGetClass, Active_WinClass , A
MouseGetPos, , , Mouse_hWnd, Mouse_ClassNN
WinGetClass, Mouse_WinClass , ahk_id %Mouse_hWnd%
if Active_WinClass != % Mouse_WinClass ;unfocused
{
	if Mouse_WinClass in MozillaWindowClass,Chrome_WidgetWin_1
	{
		controlsend, %Mouse_ClassNN%, { PgDn }, ahk_id %Mouse_hWnd%
	} Else 
		if Mouse_WinClass in CabinetWClass,Notepad++,RegEdit_RegEdit,#32770,MainWindowClassName,TMainForm
		{
			if Mouse_ClassNN in DirectUIHWND2,DirectUIHWND3
				SendMessage, 0x115, 3, 2, ScrollBar2, ahk_id %Mouse_hWnd%
			Else	
				SendMessage, 0x115, 3, 2, %Mouse_ClassNN%, ahk_id %Mouse_hWnd%
		} Else 
			if Mouse_ClassNN=WindowsForms10.Window.8.app.0.34f5582_r6_ad1
				ControlSend, %Mouse_ClassNN%, { Right } , ahk_id %Mouse_hWnd%
			Else 
				ControlSend, , { PgDn }, ahk_id %Mouse_hWnd%
		} Else 
			if Mouse_WinClass in CabinetWClass,Notepad++,RegEdit_RegEdit,#32770,MainWindowClassName,TMainForm
			{
				if Mouse_ClassNN in DirectUIHWND2,DirectUIHWND3 
					SendMessage, 0x115, 3, 2, ScrollBar2, ahk_id %Mouse_hWnd%
				Else	
					SendMessage, 0x115, 3, 2, %Mouse_ClassNN%, ahk_id %Mouse_hWnd%
			} Else 
				Send, { PgDn }
				Return

+PgUp:: 	;Wheel Right = page down without interfering with selection
WinGetClass, Active_WinClass , A
MouseGetPos, , , Mouse_hWnd, Mouse_ClassNN
WinGetClass, Mouse_WinClass , ahk_id %Mouse_hWnd%
if Active_WinClass != % Mouse_WinClass ; unfocused
{
	if Mouse_WinClass in MozillaWindowClass,Chrome_WidgetWin_1,Windows.UI.Core.CoreWindow
	{
		controlsend, %Mouse_ClassNN%, { PgUp }, ahk_id %Mouse_hWnd%
	} Else 
		if Mouse_WinClass in CabinetWClass,Notepad++,RegEdit_RegEdit,#32770,MainWindowClassName,TMainForm
		{
			if Mouse_ClassNN in DirectUIHWND2,DirectUIHWND3
			{
				SendMessage, 0x115, 2, 2, ScrollBar2, ahk_id %Mouse_hWnd%
			} Else {
				SendMessage, 0x115, 2, 2, %Mouse_ClassNN%, ahk_id %Mouse_hWnd%
			}
		} Else 
			if Mouse_ClassNN=WindowsForms10.Window.8.app.0.34f5582_r6_ad1
				ControlSend, %Mouse_ClassNN%, { Left } , ahk_id %Mouse_hWnd%
			Else 
				ControlSend, , { PgUp }, ahk_id %Mouse_hWnd%
		} Else 
			if Mouse_WinClass in CabinetWClass,Notepad++,RegEdit_RegEdit,#32770,MainWindowClassName,TMainForm,Windows.UI.Core.CoreWindow
			{
				if Mouse_ClassNN in DirectUIHWND2,DirectUIHWND3,Windows.UI.Core.CoreWindow 
					SendMessage, 0x115, 2, 2, ScrollBar2, ahk_id %Mouse_hWnd%
				Else	
					SendMessage, 0x115, 2, 2, %Mouse_ClassNN%, ahk_id %Mouse_hWnd%
			} Else 
				Send, { PgUp }
				Return

#+LButton::PostMessage_2CursorWin(0x111, 41504, 0)
if (ErrorLevel) {
	ToolTip, %ErrorLevel% Error
	SetTimer, ToolOff, -1000
	}
Return

#+RButton::PostMessage_2CursorCTL(0x111, 41504, 0)
if (ErrorLevel) {
	ToolTip, %ErrorLevel% Error
	SetTimer, ToolOff, -1000
}
Return

#MButton::
	Gosub, WinGetTransparency
	Gosub, WinSetTransparency
	Gosub, ToolTipCreate
	Return

^2::
	Gosub, WinGetTransparency
	Trans0 -= 10
	Gosub, WinSetTransparency
	Gosub, ToolTipCreate
	Return

^3::
	Gosub, WinGetTransparency
	Trans0 += 10
	Gosub, WinSetTransparency
	Gosub, ToolTipCreate
	Return

f7:: 			; 				_-========set dwm blur Window========-_
mousegetpos, , , swindow, control2
if !(swindow || control2)
tooltip no handle to window or cunt
SetAcrylicGlassEffect(bgrColor, 17, ahk_id swindow)
tooltip bellend not %swindow%
Return

; f8:: 			; 				_-========set dwm blur Control handle========-_
; mousegetpos, , , swindow, control2
; if !(swindow || control2)
; tooltip no handle to window or cunt
; ControlGet, cunt, Hwnd ,,%control2% , ahk_id %swindow%
; SetAcrylicGlassEffect(bgrColor, 17, ahk_id %cunt%)
; tooltip bellend not %cunt%
; Return

numpadclear::
WINID := WinExist("A")
sleep 200
ToolTip % WINID
Return
	
CursorTip:
coordmode ToolTip, Screen
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
	WinGetClass, aClass, %atitle%,,
	krabx:= Abs(Begin_X-x)
	Kraby := Abs(Begin_Y-y)
	R_Return := " "Begin_X ", " Begin_Y "`n"
.  "X:" krabx " Y:" kraby ""
	Return R_Return
}

Explorer_GetSelection(hwnd="") {
	WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")
	WinGetClass Class, ahk_id %hwnd%
	if (process = "explorer.exe")
		if (Class ~= "Progman|WorkerW") {
			ControlGet, files, List, Selected Col1, SysListView321, AHK_Class %Class%
			Loop, Parse, files, `n, `r
				ToReturn .= A_Desktop "\" A_LoopField "`n"
		} Else if (Class ~= "(Cabinet|Explore)WClass") {
			for Window in ComObjCreate("Shell.Application").Windows
				try
					{
					if (Window.hwnd==hwnd)
					Selected_Item := Window.Document.SelectedItems
					}
				catch
			Return
			for item in Selected_Item
		ToReturn .= item.path "`n"
		}
	Return Trim(ToReturn,"`n")
}

GetUnderCursorInfo(ByRef CursorX, ByRef CursorY) {
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
	ControlGet, ControlhWnd, Hwnd ,, %Control%, ahk_id %Window%
	PixelGetColor, colour, CursorX, CursorYControlhWnd
	if (length:=StrLen(Title))>35
		{
		TitleT:= SubStr(Title, 1 , 36)
		Title=%TitleT%...
		}
	WindowUnderCursorInfo := "ahk_id " Window "                               PID: " PID "`n"
 	. "process name " PName "`n"
	. "Title " Title "`n"
 	. "AHK_Class " Class "`n"
	. "Style / ExStyle  " Style " - " ExStyle "`n"
	. "Control "Control             "      C_hWnd: " ControlhWnd " `n"
	. "Style / ExStyle  " ContStyle " - " ContExStyle "`n"
;	. "control selected: " Selected_Item "`n"
	. "Top Left Px (" WindowX ", " WindowY ")`n"
	. "Dimensions                                 (" Width " x " Height ")`n"
	. "cursor Window position                    (" CursorX-WindowX ", " CursorY-WindowY ")`n"
;	. "Colour under cursor                        " Colour  "`n"
	. "cursor's screen position                (" CursorX ", " CursorY ")`n"
	. "`n"
	. "          CTRL+ WIN+C TO COPY DETAIL          `n"
	CoordMode Mouse
		GetKeyState, p00, Space, P
if p00 = D 	; Button released, drag carried out.
	SetBk(ControlhWnd, Window, 0x0000FF, 0xFF0000)
GetKeyState, kik, f8, P
if kik = D 	; Button released, drag carried out.
	SetAcrylicGlassEffect(bgrColor, 17, ahk_id window)
Return WindowUnderCursorInfo ; . HexToDec("0x" SubStr(BGR_Color, 5, 2)) ", "; . HexToDec("0x" SubStr(BGR_Color, 7, 2)) ")`n"
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

In(x,a,b) { 
	IfLess x,%a%, Return a
	IfLess b,%x%, Return b
	Return x
}

HexToDec(HexVal) {
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
	MouseGetPos X, Y, , hwnd , 2 ;hWnd := DllCall("WindowFromPoint", "int", X , "int", Y)
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
	ToolTip, % Message_Click
	SetTimer, tool1off, -1000
	Return
}

contextmenRclicked() {
	ToolTip, % Message_Menu_Clicked
	SetTimer, tool1off, -1000
	Return
}

abort_Mdrag() {
	ToolTip, % Message_M2drag_Abort
	SetTimer, tool1off, -1000
	Return
}

m2_released() {
	ToolTip % Message_M2_Released
	SetTimer, tool1off, -1000
	Return
}

mdrag_active() {
	ToolTip, % Message_Drag_Active
	Return
}

ThreadFail() {
	ToolTip, %Message_Thread_Fail%, (A_ScreenWidth // 2), (A_ScreenWidth // 2)
	SetTimer, tool1off, -3000
	Return
}

Context_killed() {
	ToolTip, %Message_Menu_Killed%,,,4
	SetTimer, tool4off, -1000
	Return
}

Quick_L_click() {
	ToolTip % Message_Click_Fast
	SetTimer, tool1off, -1000
	Return
}

L_Released() {
	ToolTip, %Message_Click_Release%,,,4
	SetTimer, tool4off, -1000
	Return
}

L_clicked_Desktop() {
	ToolTip, %Message_Click_DTop%, (Begin_X+100), (Begin_Y+20)
	SetTimer, Tool1Off, -750
	Return
}

Clicked_Somewhere() {
	ToolTip, %Message_Click_Other%
	SetTimer, Tool1Off, -750
	Return
}

LButton_Held() {
	ToolTip %Message_held_DTop%
	SetTimer, Tool1Off, -750
	Return
}

touching_file() {
	ToolTip, %Message_Touching% , toolx, tooly,4
	SetTimer, Tool4Off, -750
	Return
}

ToolOff:
	ToolTip,
	Return
Tool1Off:
	ToolTip,,,,1
	Return
Tool2Off:
	ToolTip,,,,2
	Return
Tool3Off:
	ToolTip,,,,3
	Return
Tool4Off:
	ToolTip,,,,4
	Return
Tool5Off:
	ToolTip,,,,5
	Return

Toggle_Win_Drag_State:
if Win_Drag_State=Active
	{
	Win_Drag_State=Inactive
	Menu, submenu1, UnCheck, Activate moving Window rag,
} Else {
	Win_Drag_State=Active
	Menu, submenu1, Check, Activate moving Window rag,
}
Return


; f7::
; Gui, Add, Edit, w320 h50 HwndMyTextHwnd, Here is some text that is given`na custom background color.
; Gui, Add, Edit, w320 h50 HwndMyTextHwnd2, Here is some text that is given`na custom background color.
; Gui, Add, Edit, w320 h50 HwndMyTextHwnd3, Here is some text that is given`na custom background color.
; Gui +LastFound
; GuiHwnd := WinExist()
; Gui Show
; run "C:\Users\ninj\DESKTOP\setbkcolor.ahk"
; Return
#^p::
goto cooon
Return
cooon:
sleep 50
CColor(ControlhWnd, Background="0x000000", Foreground="0x000000") {
	Return CColor_(Background, Foreground, "", Hwnd+0)
}

CColor_(Wp, Lp, Msg, Hwnd) {
	static 
	static WM_CTLCOLOREDIT=0x0133, WM_CTLCOLORLISTBOX=0x134, WM_CTLCOLORSTATIC=0x0138
		  ,LVM_SETBKCOLOR=0x1001, LVM_SETTEXTCOLOR=0x1024, LVM_SETTEXTBKCOLOR=0x1026, TVM_SETTEXTCOLOR=0x111E, TVM_SETBKCOLOR=0x111D
		  ,BS_CHECKBOX=2, BS_RADIOBUTTON=8, ES_READONLY=0x800
		  ,CLR_NONE=-1, CSILVER=0xC0C0C0, CGRAY=0x808080, CWHITE=0xFFFFFF, CMAROON=0x80, CRED=0x0FF, CPURPLE=0x800080, CFUCHSIA=0xFF00FF, CGREEN=0x8000, CLIME=0xFF00, COLIVE=0x8080, CYELLOW=0xFFFF, CNAVY=0x800000, CBLUE=0xFF0000, CTEAL=0x808000, CAQUA=0xFFFF00
 		  ,CLASSES := "Button,ComboBox,Edit,ListBox,Static,RICHEDIT50W,SysListView32,SysTreeView32"
	
	If (Msg = "") {      
		if !adrSetTextColor
			adrSetTextColor	:= DllCall("GetProcAddress", "uint", DllCall("GetModuleHandle", "str", "Gdi32.dll"), "str", "SetTextColor")
		   ,adrSetBkColor	:= DllCall("GetProcAddress", "uint", DllCall("GetModuleHandle", "str", "Gdi32.dll"), "str", "SetBkColor")
		   ,adrSetBkMode	:= DllCall("GetProcAddress", "uint", DllCall("GetModuleHandle", "str", "Gdi32.dll"), "str", "SetBkMode")
	
      ;Set the colors (RGB -> BGR)
		BG := !Wp ? "" : C%Wp% != "" ? C%Wp% : "0x" SubStr(WP,5,2) SubStr(WP,3,2) SubStr(WP,1,2) 
		FG := !Lp ? "" : C%Lp% != "" ? C%Lp% : "0x" SubStr(LP,5,2) SubStr(LP,3,2) SubStr(LP,1,2)

	  ;Activate message handling with OnMessage() on the first call for a class 
		WinGetClass, class, ahk_id %Hwnd% 
		If class not in %CLASSES% 
			Return A_ThisFunc "> Unsupported control class: " class

		ControlGet, style, Style, , , ahk_id %Hwnd% 
		if (class = "Edit") && (Style & ES_READONLY) 
			class := "Static"
	
		if (class = "Button")
			if (style & BS_RADIOBUTTON) || (style & BS_CHECKBOX) 
				 class := "Static" 
			else Return A_ThisFunc "> Unsupported control class: " class
		
		if (class = "ComboBox") { 
			VarSetCapacity(CBBINFO, 52, 0), NumPut(52, CBBINFO), DllCall("GetComboBoxInfo", "UInt", Hwnd, "UInt", &CBBINFO) 
			hwnd := NumGet(CBBINFO, 48)		;hwndList
			%hwnd%BG := BG, %hwnd%FG := FG, %hwnd% := BG ? DllCall("CreateSolidBrush", "UInt", BG) : -1

			IfEqual, CTLCOLORLISTBOX,,SetEnv, CTLCOLORLISTBOX, % OnMessage(WM_CTLCOLORLISTBOX, A_ThisFunc) 

			If NumGet(CBBINFO,44)	;hwndEdit
				Hwnd :=  Numget(CBBINFO,44), class := "Edit"
		} 

		if class in SysListView32,SysTreeView32
		{
			m := class="SysListView32" ? "LVM" : "TVM" 
			SendMessage, %m%_SETBKCOLOR, ,BG, ,ahk_id %Hwnd%
			SendMessage, %m%_SETTEXTCOLOR, ,FG, ,ahk_id %Hwnd%
			SendMessage, %m%_SETTEXTBKCOLOR, ,CLR_NONE, ,ahk_id %Hwnd%
			Return
		}

		if (class = "RICHEDIT50W")
			Return f := "RichEdit_SetBgColor", %f%(Hwnd, -BG)

		if (!CTLCOLOR%Class%)
			CTLCOLOR%Class% := OnMessage(WM_CTLCOLOR%Class%, A_ThisFunc) 

		Return %Hwnd% := BG ? DllCall("CreateSolidBrush", "UInt", BG) : CLR_NONE,  %Hwnd%BG := BG,  %Hwnd%FG := FG
   } 
 
 ; Message handler 
	critical					;its OK, always in new thread.

	Hwnd := Lp + 0, hDC := Wp + 0
	If (%Hwnd%) { 
		DllCall(adrSetBkMode, "uint", hDC, "int", 1)
		if (%Hwnd%FG)
			DllCall(adrSetTextColor, "UInt", hDC, "UInt", %Hwnd%FG)
		if (%Hwnd%BG)
			DllCall(adrSetBkColor, "UInt", hDC, "UInt", %Hwnd%BG)
		Return (%Hwnd%)
	}
}

SetBk(hWnd, ghwnd, bc, tc=0xff0000) {
	a := {}
	a["ch"] := hWnd
	a["gh"] := ghwnd
	a["bc"] := ((bc&255)<<16)+(((bc>>8)&255)<<8)+(bc>>16)
	a["tc"] := ((tc&255)<<16)+(((tc>>8)&255)<<8)+(tc>>16)
	WindowProc("Set", a, "", "")
}

WindowProc(hwnd, uMsg, wParam, lParam) {
	Static Win := {}
	Critical
	If (uMsg = 0x133) and Win[hwnd].HasKey(lparam)
		{
		DllCall("SetTextColor", "UInt", wParam, "UInt", Win[hwnd, lparam, "tc"] )
		DllCall("SetBkColor", "UInt", wParam, "UInt", Win[hwnd, lparam, "bc"] )
		Return Win[hwnd, lparam, "Brush"]  ; Return the HBRUSH to notify the OS that we altered the HDC.
		}
	If (hwnd = "Set") {
		a := uMsg
		Win[a.gh, a.ch] := a
		If not Win[a.gh, "WindowProcOld"]
			Win[a.gh,"WindowProcOld"] := DllCall("SetWindowLong", "Ptr", a.gh, "Int", -4, "Int", RegisterCallback("WindowProc", "", 4), "UInt")
		If Win[a.gh, a.ch, "Brush"]
			DllCall("DeleteObject", "Ptr", Brush)
		Win[a.gh, a.ch, "Brush"] := DllCall("CreateSolidBrush", "UInt", a.bc)
		; array_list(Win)
		Return
	}
	Return DllCall("CallWindowProcA", "UInt", Win[hwnd, "WindowProcOld"], "UInt", hwnd, "UInt", uMsg, "UInt", wParam, "UInt", lParam)
}

SetAcrylicGlassEffect(thisColor, thisAlpha, hWnd) {
    Static init, accent_state := 4,
    Static pad := A_PtrSize = 8 ? 4 : 0, WCA_ACCENT_POLICY := 19
    NumPut(accent_state, ACCENT_POLICY, 0, "int")
    NumPut(0x11402200, ACCENT_POLICY, 8, "int")
    VarSetCapacity(WINCOMPATTRDATA, 4 + pad + A_PtrSize + 4 + pad, 0)
    && NumPut(WCA_ACCENT_POLICY, WINCOMPATTRDATA, 0, "int")
    && NumPut(&ACCENT_POLICY, WINCOMPATTRDATA, 4 + pad, "ptr")
    && NumPut(64, WINCOMPATTRDATA, 4 + pad + A_PtrSize, "uint")
    If !(DllCall("user32\SetWindowCompositionAttribute", "ptr", hWnd, "ptr", &WINCOMPATTRDATA))
       Return
    accent_size := VarSetCapacity(ACCENT_POLICY, 16, 0)
    Return
}

Win_Activate:
winactivate, ahk_id %Window%
Return

_Feed_:
Global Message_Click:="::Clicked::", Global Message_Menu_Clicked:="Context Menu Clicked", Global Message_M2drag_Abort:="Aborting Drag", Global Message_M2_Released:="released mouse2", Global Message_Drag_Active:="Window drag activated' n - Mouse 1 to Cancel", Global Message_Thread_Fail:="GetGUIThreadInfo failure", Global Message_Menu_Killed:="menu killed", Global Message_Click_Fast:="Quick click::", Global Message_Click_Release:="mouse 1 released", Global Message_Click_DTop:="Left Clicked Desktop", Global Message_Click_Other:="clicked Elsewhere", Global Message_held_DTop:="clickheld on desktop", Global Message_Touching:="touching file", Global Message_Moved :="%FailState% ...`n %X% %Begin_X% %y% %Begin_Y%`n Movement detected `n %x1% %x2% %y1% %y2%, %x%, %75%"
Return

WinGetTransparency:
   MouseGetPos, , , hWnd
   If (Trans_%hWnd% = "")
      Trans_%hWnd% := 100
   Trans := Trans_%hWnd%
   Trans0 := Trans
Return

WinSetTransparency:
	WinGetClass, WindowClass, ahk_id %hWnd%
	If (WindowClass = "Progman") {
		Return
		}
	Trans0 := (Trans0 < 10) ? 10 : (Trans0 > 100) ? 100 : Trans0
	Alpha0 := Trans * 2.55		; Init. Alpha
	Alpha := Round(Trans0 * 2.55)	; Final Alpha
	Trans := Trans0
	Trans_%hWnd% := Trans
	a := Alpha - Alpha0
	b := AlphaIncrement
	b *= (a < 0) ? -1 : 1	; Signed increment
	a := Abs(a)				; Abs. iteration range
	Loop {
		Alpha0 := Round(Alpha0)
		WinSet, Trans, %Alpha0%, ahk_id %hWnd%
		If (Alpha0 = Alpha) {
			If (Alpha = 255) {
				If hWnd Not In %CleanupList%
					{
					CleanupList = %CleanupList%%hWnd%`,
					SetTimer, Cleanup, 10000
					}
			} Else {
				StringReplace, CleanupList, CleanupList, %hWnd%`,, , 1
				}
			Break
		}
      Else If (a >= AlphaIncrement) {
         Alpha0 += b
         a -= AlphaIncrement
		} Else {
			Alpha0 := Alpha
			}
		}
Return

ToolTipCreate:
   c := Floor(Trans / 4)
   d := 25 - c
   ToolTipText := "Opacity: "
   Loop, %c%
   {
      ToolTipText .= "|"
   }
	If (c > 0)
		{
		ToolTipText .= " "
		}
	ToolTipText .= Trans . "%"
	If (d > 0)
		{
		ToolTipText .= " "
		}
	Loop, %d%
		{
		ToolTipText .= "|"
		}
	ToolTip, %ToolTipText%
	MouseGetPos, MouseX0, MouseY0
	SetTimer, ToolTipDestroy
	Return

ToolTipDestroy:
	If (A_TimeIdle < 1000) {
		MouseGetPos, MouseX, MouseY
		If (MouseX = MouseX0 && MouseY = MouseY0)
			{
			Return
			}
	}
	SetTimer, ToolTipDestroy, Off
	ToolTip,
	Return

Cleanup:
	;iniWrite, %Win_Drag_State% , M2DRAG.ini, Drag, Activate_Window
	Loop, Parse, CleanupList, `,
		{
		StringReplace, CleanupList, CleanupList, %A_LoopField%`,, , 1
		If (A_LoopField != "")
			{
			WinSet, Trans, Off, ahk_id %A_LoopField%
			}
		}
	If (A_ExitReason = "")
		{
		SetTimer, Cleanup, Off
		}
	Else
		{
		ExitApp
		}
	Return

Open_script_folder:
Run %A_ScriptDir%
Return
