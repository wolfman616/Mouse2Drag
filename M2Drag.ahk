 /* 
; 	only run with autohotkey 1.1.3.2+ 32/64bit UI Access 
;	
; 	KEYS:
;ds
;ds	Original right mouse button = 		CTRL + SHIFT + RIGHTCLICK Incase bug
;ds	Quit application hotkey = 		CTRL + SHIFT + WIN + RIGHTCLICK (MouseWheelButton) 
;ds
;ds 	Drag any Window under cursor = 	mouse2 drag on Window	(left click to abort during drag)
;ds	ruler on desktop = 		mouse1 drag on desktop	(cancels on selection of item with marquee)
;ds	Toggle Window Info detail = 		CTRL+WIN+MIDDLECLICK(MouseWheel)=	
;ds once active, CTRL WIN + C to copy detail 
;ds 	fixed: Disabled desktop drag ) 
;ds	Blacklist ini file Classnames (use Window Info above + CTRL C copies that)
;ds 	M Wolff - 2020-2021
;ds	; sendlevel 1;#include ns.ahk ;gosub _Feed_ ;#WinActivateforce ;coordMode, tooltip, screen;BLACKLIST-Window-ClassES
 */

#NoEnv			
#SingleInstance force
#Persistent
#InstallMouseHook
#MaxThreadsPerhotkey 10
SendMode Input
ListLines, Off
coordMode, mouse, screen
coordMode, pixel, screen
setBatchLines -1 		;		setWinDelay -1
setWorkingDir %A_ScriptDir% 

gosub Menu_Init
gosub Get_Globals
gosub Blacklist_RegRead
gosub BlacklistParse

onExit, CleanUp
return

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;																				Binds
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^NumpadDot::exit 	;>=====CTRL=NUMPAD=DOT====>(NORMAL=RIGHT=CLICK)=====<
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^+rButton:: 									;REGULAR RCLICK	 ; CTRL + SHIFT + RIGHTCLICK
sendInput, { rButton } 			
if !Pube_count
	Pube_count := 1
else
	pube_count := Pube_count + 1
tooltip % pube_count
settimer tooloff, -1000
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^+LButton:: 	 								;REGULAR RCLICK	 ; CTRL + SHIFT + LCLICK
sendInput, {LButton} 				
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~Esc::
if winactive(ImageGlassClass)
	winClose, % ImageGlassClass
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#M:: 
; if !Mag {
	 run % ahk_path mag_path
	; Mag = 1
; } else 
	; Mag :=
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^#Mbutton:: 		; CTRL + WIN + MIDDLE=MOUSE ( aKa MOUSEWHEEL BUTTON )
Handle_Handler_Toggle:
Handle_Handler_Active := !Handle_Handler_Active 	; TOGGLE - INFO - DISPLAY
if Handle_Handler_Active { 			;		 
	menu, submenu1, check, Handle Handler,
	setTimer CursorTip, 30

	~^#c:: 				; 								CTRL WIN C 
	if WindowUnderCursorInfo
	clipboard:=WindowUnderCursorInfo 	; 	copy Window info 
	return
} else {													;	gosub Handle_Handler_Toggle
	menu, submenu1, uncheck, Handle Handler, 		
	sleep 100
	setTimer CursorTip, off
	setTimer, tooltipdestroy, -1750
	WindowUnderCursorInfo := 
	return
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
rButton::
	mousegetpos, , , hWnd
	mousegetpos, X_CursorS, Y_CursorS
	winGetpos, WindowX, WindowY, WindowWidth, WindowHeight, ahk_id %hWnd%
	xoff := (X_CursorS - WindowX), Yoff := (Y_CursorS - WindowY)
	setWinDelay, -1
	BypassClassList_Default="#32768","AutoHotkey","BaseBar","tooltips_class32","Windows.UI.Core.CoreWindow"

if ( EvaluateBypass_Class(hWnd) ) {
	Bypass_Class_True :=1
	settimer tooloff, -1000
	goto BypassDrag
} else
if ( EvaluateBypass_Proc(hWnd) ) {
 	Bypass_pname_True :=1
	settimer tooloff, -1000
	goto BypassDrag
} else
if ( EvaluateBypass_Title(hWnd) ) {
	Bypass_title_True :=1
	settimer tooloff, -1000
	goto BypassDrag
} else
	gosub M2_Drag_Ready
return

M2_Drag_Ready:
mouseGetPos, X_Cursor, Y_Cursor
X_Old := X_Cursor, Y_Old := Y_Cursor
while (getKeyState("rButton" , "P") ) {
	mouseGetPos, X_Cursor, Y_Cursor
	if ( X_Cursor != X_Old ) and ( Y_Cursor != Y_Old ) {
		Win_Move(Hwnd, x0x:=X_Cursor-xoff, y0y:=Y_Cursor-Yoff, WindowWidth, WindowHeight, "")
		if Win_Drag_State_Active
			winactivate, ahk_id %hWnd% 
		if !DZThresh { ; threshold for movement afterwhich no longer being considered a normal single click
			if (X_Cursor<X_CursorS-25) || (X_Cursor>X_CursorS+25) || (Y_Cursor<Y_CursorS-25) || (Y_Cursor>Y_CursorS +25) {
				DZThresh := True	
				DragbypassClass_new_possible =ahk_id %hWnd%
				menu, tray, add, Bypass the last Dragged window, Bypass_Last_Dragged_GUI,
				Dragbypassmenu_enabled := true
			}
		} else { ; mouse 2 drag beings in ernest
			if winexist("AHK_Class MozillaDropShadowWindowClass") 	;	 Firefox menu
				winClose
			if winexist("AHK_Class #32768") 	;	 normal menus
				winClose
			getKeyState, KSLB, LButton, P
			if (getKeyState("LButton" , "P") ) {
				Dragging := True
				settimer Watch_Lb, -1
			} else Dragging := False
		}
	} else sleep 2
	if !insight {
		winGet, EWD_WinState, MinMax, ahk_id %hWnd%
		CursorChange := 1, insight := 1
		if (EWD_WinState = 1) { ; maximized
			while (getKeyState("rButton" , "P") ) {
				if !DZThresh
					if (X_Cursor<X_CursorS -25) || (X_Cursor>X_CursorS +25) || (Y_Cursor<Y_CursorS -25) || (Y_Cursor>Y_CursorS +25) {
						DZThresh := True		
						DragbypassClass_new_possible =ahk_id %hWnd%
					} else
				mouseGetPos, X_Cursor, Y_Cursor
				if (X_Cursor<(X_CursorS-25)) || (X_Cursor>(X_CursorS+25)) || (Y_Cursor<(Y_CursorS-25)) || (Y_Cursor>(Y_CursorS+25)) {	
					EWD_MidWidth := A_ScreenWidth/3, EWD_MidX := X_Cursor-(WindowWidth/2)
					EWD_MidY := Y_Cursor-(WindowHeight/3), EWD_MidHeight := A_ScreenHeight/2
					winRestore, ahk_id %hWnd%
					winGetpos, , , WindowWidth, WindowHeight, ahk_id %hWnd%
					Win_Move(Hwnd, EWD_MidX, EWD_MidY, EWD_MidWidth, EWD_MidHeight, 22) 
				}	
			}
			if DZThresh
				DragbypassClass_new_possible =ahk_id %hWnd%
		}
	}
}
if !DZThresh 		;	 mouse released without moving past thresh
	sendInput, {rButton}
if ( Dragging = True )
	settimer m1_resizeGO, 1
insight := "", DZThresh := False
return

BypassDrag:	
click, down right
mousegetpos, X_CursorS, Y_CursorS
while (getKeyState("rButton" , "P") ) {
	if !DZThresh { ; not reached threshold of xy movement, afterwhich would be no longer considered a standard right click
		if (X_Cursor<X_CursorS-25) || (X_Cursor>X_CursorS+25) || (Y_Cursor<Y_CursorS-25) || (Y_Cursor>Y_CursorS+25) {
			DZThresh := True, DragAllowMenu_enabled := True
			DragAllowClass_new_possible =ahk_id %hWnd%
				menu, tray, NoStandard
				menu, tray, add, Add last attempted window drag to whitelist, Open_Options_GUI,
				menu, tray, standard
		}
		sleep 5 
	}
}
click, up right
insight := "", DZThresh := False
return

BypassDrag2:
sendInput, {rButton down} 
while (getKeyState("rButton" , "P") ) {
	sleep 5 					;	tooltip asd %DZThresh%
}
sendInput, {rButton up}
insight := "", DZThresh := False
return

m1_resizeGO:
if !Old_call 
	Y_CursorS2:=Y_Cursor, X_CursorS2:=X_Cursor,	Old_call_1 := True
while (getKeyState("LButton" , "P") ) {
	mouseGetPos, X_Cursor, Y_Cursor
	Win_Move(Hwnd, "", "", WindowWidth, WindowHeight, "")
	mouseGetPos, X_Cursor, Y_Cursor
	x_NET := X_CursorS2 - X_Cursor
	if ( x_NET != x_NETold ) {
		WindowWidth := WindowWidth - x_NET
		X_CursorS2 := X_Cursor
	}
	y_NET := Y_CursorS2 - Y_Cursor 
	if (y_NET != y_NETold) {
		WindowHeight := WindowHeight - y_NET
		Y_CursorS2 := Y_Cursor	
	}
	x_NETold := x_NET, y_NETold := y_NET
}
settimer m1_resizeGO, off
return 

Watch_Lb:
if !Old_call_1 {
	Y_CursorS2 := Y_Cursor, X_CursorS2 := X_Cursor
	Old_call_1 := True
}
getKeyState, KSRB, LButton, P
if (KSrB = "U") {
	;SETTIMER m1_resizeGO, 1
	TWATFACE := True
} else 
x_NET := X_CursorS2 - X_Cursor
if ( x_NET != x_NETold ) {
	WindowWidth := WindowWidth + x_NET
	X_CursorS2 := X_Cursor
}
y_NET := Y_CursorS2 - Y_Cursor 
if (y_NET != y_NETold) {
	WindowHeight := WindowHeight + y_NET
	Y_CursorS2 := Y_Cursor	
}
x_NETold := x_NET, y_NETold := y_NET
if TWATFACE {
	getKeyState, KSLB, rButton, P
	if (KSrB = "U") {
		SETTIMER m1_resizeGO, off
		TWATFACE := False
	}
}
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~LButton::
mousegetpos,X ,Y , hWnd
aaaa=ahk_id %hWnd% 	
winGetClass, Class, ahk_id %hWnd%
;Cursor_int := 32651, SetSystemCursor() 
if (class = "WorkerW" ) or (class = "ProgMan") {	; WaitMove
	mouseGetPos, X_Cursor, Y_Cursor
	while (getKeyState("LButton", "P")) {
		mouseGetPos, x, y
		if (X_Old!=X) or (Y_Old!=y) {
			if (X > X_Cursor) {
				toolX := X_Cursor - 103
				tooltipbycursor:=r00la(X,Y)
				Thresh_Breach := true
			}
			else if (X < X_Cursor) {
				toolX := X_Cursor
				tooltipbycursor:=r00la(X,Y)
				Thresh_Breach := true
			}
			else if (y > Y_Cursor) {
				tooly := Y_Cursor -57
				tooltipbycursor:=r00la(X,Y)
				Thresh_Breach := true
			}
			else if (y < Y_Cursor) {
				tooly := Y_Cursor + 4
				tooltipbycursor:=r00la(X,Y)
				Thresh_Breach := true
			}
			if Thresh_Breach {
				tooltip, %tooltipbycursor%, %toolX% , %tooly% , 5
				X_Old:=X, Y_Old:=Y,	Selected_Item_Check:= Explorer_GetSelection()
				sleep 20
				if Selected_Item_Check {
					SetSystemCursor()
					;gosub tool5off
					setTimer tool5off, -1
					touching_file()
					return
				}
			}
		}	
		else sleep 50
	}
	setTimer XY_INIT, -1
	setTimer tool5off, -2000
	RestoreCursors()
	L_Released()
}
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^1:: 	; Press ctl 1 to make the color under the mouse cursor invisible.
mouseGetPos, MouseX, MouseY, MouseWin
pixelGetColor, MouseRGB, %MouseX%, %MouseY%, RGB
WinSet, TransColor, Off, ahk_id %MouseWin%
sleep 100
WinSet, TransColor, %MouseRGB%, ahk_id %MouseWin% 	;	 WinSet, TransColor, 0xFFFFFF, ahk_id %MouseWin%
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#lbutton:: 	; Press Win+y to turn off transparency for the Window under the mouse.
mouseGetPos,,, MouseWin
WinSet, TransColor, Off, ahk_id %MouseWin%
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#!g:: ; Press Win+G to show the current settings of the Window under the mouse.
mouseGetPos,,, MouseWin
winGet, Transparent, Transparent, ahk_id %MouseWin%
winGet, TransColor, TransColor, ahk_id %MouseWin%
tooltip Translucency:`n%Transparent%`nTransColor:`t%TransColor%
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;>====FIX icons on desktop as zooming====>
+^WheelDown::
	mouseGetPos, X_Cursor, Y_Cursor, ahk_id_CHECK
	winGetClass, AHK_Class_check, ahk_id %ahk_id_CHECK%,,
	if (AHK_Class_CHECK= "WorkerW") || (AHK_Class_CHECK="Progman")
		Dtop_icons_Restore()
	return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+^WheelUp::
	mouseGetPos, X_Cursor, Y_Cursor, ahk_id_CHECK
	winGetClass, AHK_Class_check, ahk_id %ahk_id_CHECK%,,
	if(AHK_Class_CHECK= "WorkerW") || (AHK_Class_CHECK="Progman")
		Dtop_icons_Restore()
	return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+PgDn:: 		; 	Wheel r = page down without interfering with selection
^+PgDn:: 	; 	Ctrl + Wheel r = "end" without interfering with selection 
winGetClass, Active_WinClass , A
mouseGetPos, , , Mouse_hWnd, Mouse_ClassNN
winGetClass, Mouse_WinClass , ahk_id %Mouse_hWnd%

if ( Active_WinClass != Mouse_WinClass ) { 	; 	unfocused
	if Mouse_WinClass in MozillaWindowClass,Chrome_WidgetWin_1
	{
		controlsend, %Mouse_ClassNN%, { PgDn }, ahk_id %Mouse_hWnd%
	} else 
	if Mouse_WinClass in CabinetWClass,Notepad++,RegEdit_RegEdit,#32770,MainWindowClassName,TMainForm
	{
		if Mouse_ClassNN in DirectUIhWnd2,DirectUIhWnd3
			SendMessage, 0x115, 3, 2, ScrollBar2, ahk_id %Mouse_hWnd%
		else	
			SendMessage, 0x115, 3, 2, %Mouse_ClassNN%, ahk_id %Mouse_hWnd%
	} else 
	if Mouse_ClassNN=WindowsForms10.Window.8.app.0.34f5582_r6_ad1
		ControlSend, %Mouse_ClassNN%, { Right } , ahk_id %Mouse_hWnd%
	else 
		ControlSend, , { PgDn }, ahk_id %Mouse_hWnd%
} else 
if Mouse_WinClass in CabinetWClass,Notepad++,RegEdit_RegEdit,#32770,MainWindowClassName,TMainForm
{
	if ( A_Thishotkey = "^+PgDn" ) {
		if Mouse_WinClass = Notepad++
			send { ^end }
		else
			send { end }
	} else {
		if Mouse_ClassNN in DirectUIhWnd2,DirectUIhWnd3 
			SendMessage, 0x115, 3, 2, ScrollBar2, ahk_id %Mouse_hWnd%
		else	
			SendMessage, 0x115, 3, 2, %Mouse_ClassNN%, ahk_id %Mouse_hWnd%
	}
} else 
	Send, { PgDn }
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+PgUp:: 		; 	Wheel L = "page down" without interfering with selection
^+PgUp:: 	; 	Ctrl + Wheel L = "home" without interfering with selection 
winGetClass, Active_WinClass , A
mouseGetPos, , , Mouse_hWnd, Mouse_ClassNN
winGetClass, Mouse_WinClass , ahk_id %Mouse_hWnd%
if ( Active_WinClass != Mouse_WinClass ) { 	; 	unfocused
	if Mouse_WinClass in MozillaWindowClass,Chrome_WidgetWin_1,Windows.UI.Core.CoreWindow
	{
		controlsend, %Mouse_ClassNN%, { PgUp }, ahk_id %Mouse_hWnd%
	} else 
	if Mouse_WinClass in CabinetWClass,Notepad++,RegEdit_RegEdit,#32770,MainWindowClassName,TMainForm
	{
		if Mouse_ClassNN in DirectUIhWnd2,DirectUIhWnd3
		{
			SendMessage, 0x115, 2, 2, ScrollBar2, ahk_id %Mouse_hWnd%
	 } else {
			SendMessage, 0x115, 2, 2, %Mouse_ClassNN%, ahk_id %Mouse_hWnd%
		}
	} else 
			if Mouse_ClassNN=WindowsForms10.Window.8.app.0.34f5582_r6_ad1
				ControlSend, %Mouse_ClassNN%, { Left } , ahk_id %Mouse_hWnd%
			else 
				ControlSend, , { PgUp }, ahk_id %Mouse_hWnd%
} else 
if Mouse_WinClass in CabinetWClass,Notepad++,RegEdit_RegEdit,#32770,MainWindowClassName,TMainForm,Windows.UI.Core.CoreWindow
	if ( A_Thishotkey = "^+PgUp" ) {
		if Mouse_WinClass = Notepad++
			send { ^home }
		else
			send { home }
	} else {
	if Mouse_ClassNN in DirectUIhWnd2,DirectUIhWnd3,Windows.UI.Core.CoreWindow 
		SendMessage, 0x115, 2, 2, ScrollBar2, ahk_id %Mouse_hWnd%
	else	
		SendMessage, 0x115, 2, 2, %Mouse_ClassNN%, ahk_id %Mouse_hWnd%
} else 
	Send, { PgUp }
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#+LButton::PostMessage_2CursorWin(0x111, 41504, 0)
if (ErrorLevel) {
	tooltip, %ErrorLevel% Error
	setTimer, ToolOff, -1000
}
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#+rButton::PostMessage_2CursorCTL(0x111, 41504, 0)
if (ErrorLevel) {
	tooltip, %ErrorLevel% Error
	setTimer, ToolOff, -1000
}
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#MButton::
gosub, winGetTransparency
gosub, WinSetTransparency
gosub, tooltipCreate
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^2::
gosub, winGetTransparency
Trans0 -= 10
gosub, WinSetTransparency
gosub, tooltipCreate
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^3::
gosub, winGetTransparency
Trans0 += 10
gosub, WinSetTransparency
gosub, tooltipCreate
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^f7:: 			; 		_-========set dwm blur Window========-_
mouseGetPos, , , swindow, control2
if !(swindow || control2)
	tooltip no handle to window or Old_call
SetAcrylicGlassEffect(bgrColor, 17, ahk_id swindow)
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^+f7:: 		;	 _-========set dwm blur Control handle========-_
mouseGetPos, , , swindow, control2
if !(swindow || control2)
tooltip no handle to window or Old_call
ControlGet, Old_call, hWnd ,,%control2% , ahk_id %swindow%
SetAcrylicGlassEffect(bgrColor, 17, ahk_id %Old_call%)
SetAcrylicGlassEffect(bgrColor, 17, ahk_id %control2%)
tooltip %Old_call%
settimer tooloff, -3000
return

; numpadclear::
; WINID := WinExist("A")
; sleep 200
; tooltip % WINID
; return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#^p::
goto ctrl_hwnd_bg
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;																 	DIx
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ctrl_hwnd_bg:
sleep 50
CColor(ControlhWnd, Background="0x000000", Foreground="0x000000") {
	return CColor_(Background, Foreground, "", hWnd+0)
}
return
	
CursorTip:
coordMode tooltip, screen
WindowUnderCursorInfo := GetUnderCursorInfo(X_Cursor, Y_Cursor)
if ( X_Cursor < (A_ScreenWidth // 2) )
	TTX := (A_ScreenWidth // 2) + 100
else
	TTX := (A_ScreenWidth // 2) - 400
if ( Y_Cursor < (A_ScreenHeight // 2) )
	TTY := (A_ScreenHeight // 2) + 100
else
	TTY := (A_ScreenHeight // 2)-300
if ( WindowUnderCursorInfo != WindowUnderCursorInfoOld )	{	;fixes flicker
	tooltip %WindowUnderCursorInfo%, %TTX% , %TTY%
	WindowUnderCursorInfoOld=% WindowUnderCursorInfo
}
return

r00la(byref x, byref y) {
	winGetActiveTitle, Atitle
	winGetClass, aClass, %atitle%,,
	krabx:= Abs(X_Cursor-x)
	Kraby := Abs(Y_Cursor-y)
	R_return := " "X_Cursor ", " Y_Cursor "`n"
. "X:" krabx " Y:" kraby ""
	return R_return
}

Explorer_GetSelection(hWnd="") {
	winGet, process, processName, % "ahk_id" hWnd := hWnd? hWnd:WinExist("A")
	winGetClass Class, ahk_id %hWnd%
	if (process = "explorer.exe")
		if (Class ~= "Progman|WorkerW") {
			loop, Parse, files, `n, `r
			ControlGet, files, List, Selected Col1, SysListView321, AHK_Class %Class%
				Toreturn .= A_Desktop "\" A_LoopField "`n"
		} else if (Class ~= "(Cabinet|Explore)WClass") {
			for Window in ComObjCreate("Shell.Application").Windows
				try
					{
					if (Window.hWnd==hWnd)
					Selected_Item := Window.Document.SelectedItems
					}
				catch
			return
			for item in Selected_Item
		Toreturn .= item.path "`n"
		}
	return Trim(Toreturn,"`n")
}

GetUnderCursorInfo(ByRef X_Cursor, ByRef Y_Cursor) {
	coordMode mouse, screen
	coordMode Pixel, screen
	mouseGetPos, X_Cursor, Y_Cursor, Window, Control
	winGetTitle Title, ahk_id %Window%
	winGetClass Class, ahk_id %Window%
	winGetPos WindowX, WindowY, Width, Height, ahk_id %Window%
	winGet ProcName, ProcessName, ahk_id %Window%
	winGet PID, PID, ahk_id %Window%
	winGet, Style, Style, ahk_id %Window%
	winGet, ExStyle, ExStyle, ahk_id %Window%
	ControlGet, ContStyle, Style ,,%control%, ahk_id %Window%
	ControlGet, ContExStyle, ExStyle ,,%control%, ahk_id %Window%
	ControlGet, ControlhWnd, hWnd ,, %Control%, ahk_id %Window%
	PixelGetColor, colour, X_Cursor, Y_CursorzControlhWnd
	if ((length:=StrLen(Title))>35) {
		TitleT:= SubStr(Title, 1 , 36)
		Title=%TitleT%...
	}
	WindowUnderCursorInfo := "ahk_id " Window " PID: " PID "`n"
 	. "process name " ProcName "`n"
	. "Title " Title "`n"
 	. "AHK_Class " Class "`n"
	. "Style / ExStyle " Style " - " ExStyle "`n"
	. "Control "Control " C_hWnd: " ControlhWnd " `n"
	. "Style / ExStyle " ContStyle " - " ContExStyle "`n"
;	. "control selected: " Selected_Item "`n"
	. "Top Left Px (" WindowX ", " WindowY ")`n"
	. "Dimensions (" Width " x " Height ")`n"
	. "cursor Window position (" X_Cursor-WindowX ", " Y_Cursor-WindowY ")`n"
	. "Colour under cursor " Colour "`n"
	. "cursor's screen position (" X_Cursor ", " Y_Cursor ")`n"
	. "`n"
	. " CTRL+ WIN+C TO COPY DETAIL `n"
	coordMode Mouse
		getKeyState, p00, Space, P
	if p00 = D 	; Button released, drag carried out.
		SetBk(ControlhWnd, Window, 0x0000FF, 0xFF0000)
	getKeyState, kik, f9, P
	if kik = D 	; Button released, drag carried out.
		SetAcrylicGlassEffect(bgrColor, 17, ahk_id window)
	return WindowUnderCursorInfo ; . HexToDec("0x" SubStr(BGR_Color, 5, 2)) ", "; . HexToDec("0x" SubStr(BGR_Color, 7, 2)) ")`n"
}	

Win_Move(Hwnd, X="", Y="", W="", H="", Flags="") {
	;	static bitmask SWP_NOMOVE=2, SWP_NOREDRAW=8, SWP_NOSIZE=1, SWP_NOZORDER=4, SWP_NOACTIVATE = 0x10, SWP_ASYNCWINDOWPOS=0x4000, HWND_BOTTOM=1, HWND_TOPMOST=-1, HWND_NOTOPMOST = -2
	static SWP_NOMOVE=2, SWP_NOSIZE=1, SWP_NOZORDER=4, SWP_NOACTIVATE = 0x10, SWP_R=8, SWP_A=0x4000
	hFlags := SWP_NOZORDER | SWP_NOACTIVATE
	loop, parse, Flags
		hFlags |= SWP_%A_LoopField%
	if (x y != "") {
		p := DllCall("GetParent", "uint", hwnd), Win_Get(p, "Lxy", px, py), Win_GetRect(hwnd, "xywh", cx, cy, cw, ch)
		if x=
			x := cx - px
		if y=
			y := cy - py
	} else hFlags |= SWP_NOMOVE
	if (h w != "") {
		if !cx
			Win_GetRect(hwnd, "wh", cw, ch)
		if w=
			w := cw
		if h=
			h := ch
	} else hFlags |= SWP_NOSIZE
	return DllCall("SetWindowPos", "uint", Hwnd, "uint", 0, "int", x, "int", y, "int", w, "int", h, "uint", hFlags)
}

Win_Get(Hwnd, pQ="", ByRef o1="", ByRef o2="", ByRef o3="", ByRef o4="", ByRef o5="", ByRef o6="", ByRef o7="", ByRef o8="", ByRef o9="") {
	if pQ contains R,B,L
		VarSetCapacity(WI, 60, 0), NumPut(60, WI), DllCall("GetWindowInfo", "uint", Hwnd, "uint", &WI)
	k := i := 0
	loop {
		i++, k++
		if (_ := SubStr(pQ, k, 1)) = ""
			break
		if !IsLabel("Win_Get_" _ )
			return A_ThisFunc "> Invalid query parameter: " _
		Goto %A_ThisFunc%_%_%
		Win_Get_C:
				winGetClass, o%i%, ahk_id %hwnd%		
		continue
		Win_Get_I:
				winGet, o%i%, PID, ahk_id20/08/2009 %hwnd%		
		continue
		Win_Get_N:
				rect := "title"
				VarSetCapacity(TBI, 44, 0), NumPut(44, TBI, 0), DllCall("GetTitleBarInfo", "uint", hwnd, "str", TBI)
				title_x := NumGet(TBI, 4, "Int"), title_y := NumGet(TBI, 8, "Int"), title_w := NumGet(TBI, 12) - title_x, title_h := NumGet(TBI, 16) - title_y 
				goto Win_Get_Rect
		Win_Get_B:
				rect := "border"
				border_x := NumGet(WI, 48, "UInt"), border_y := NumGet(WI, 52, "UInt")	
				goto Win_Get_Rect
		Win_Get_R:
				rect := "window"
				window_x := NumGet(WI, 4, "Int"), window_y := NumGet(WI, 8, "Int"), window_w := NumGet(WI, 12, "Int") - window_x, window_h := NumGet(WI, 16, "Int") - window_y
				goto Win_Get_Rect
		Win_Get_L: 
				client_x := NumGet(WI, 20, "Int"), client_y := NumGet(WI, 24, "Int"), client_w := NumGet(WI, 28, "Int") - client_x, client_h := NumGet(WI, 32, "Int") - client_y
				rect := "client"
		Win_Get_Rect:
				k++, arg := SubStr(pQ, k, 1)
				if arg in x,y,w,h
				{
					o%i% := %rect%_%arg%, j := i++
					goto Win_Get_Rect
				} else 
				if !j
					o%i% := %rect%_x " " %rect%_y (_ = "B" ? "" : " " %rect%_w " " %rect%_h)
		rect := "", k--, i--, j := 0
		continue
		Win_Get_S:
			winGet, o%i%, Style, ahk_id %Hwnd%
		continue
		Win_Get_E: 
			winGet, o%i%, ExStyle, ahk_id %Hwnd%
		continue
		Win_Get_P: 
			o%i% := DllCall("GetParent", "uint", Hwnd)
		continue
		Win_Get_A: 
			o%i% := DllCall("GetAncestor", "uint", Hwnd, "uint", 2) ; GA_ROOT
		continue
		Win_Get_O: 
			o%i% := DllCall("GetWindowLong", "uint", Hwnd, "int", -8) ; GWL_HWNDPARENT
		continue
		Win_Get_T:
		if DllCall("IsChild", "uint", hwnd)
			winGetText, o%i%, ahk_id %hwnd%
		else winGetTitle, o%i%, ahk_id %hwnd%
			continue
		Win_Get_M: 
		winGet, _, PID, ahk_id %hwnd%
		hp := DllCall( "OpenProcess", "uint", 0x10|0x400, "int", false, "uint", _ ) 
		if (ErrorLevel or !hp) 
			continue
		VarSetCapacity(buf, 512, 0), DllCall( "psapi.dll\GetModuleFileNameExA", "uint", hp, "uint", 0, "str", buf, "uint", 512), DllCall( "CloseHandle", hp ) 
		o%i% := buf 
		continue
	}	
	return o1
}

Win_GetRect(hwnd, pQ="", ByRef o1="", ByRef o2="", ByRef o3="", ByRef o4="") {
	VarSetCapacity(RECT, 16), r := DllCall("GetWindowRect", "uint", hwnd, "uint", &RECT)
	ifEqual, r, 0, return
		if (pQ = "") or pQ = ("*")
			retAll := true, pQ .= "xywh"
	xx := NumGet(RECT, 0, "Int"), yy := NumGet(RECT, 4, "Int")
	if ( SubStr(pQ, 1, 1) = "*" ) {
		Win_Get(DllCall("GetParent", "uint", hwnd), "Lxy", lx, ly), xx -= lx, yy -= ly
		StringTrimLeft, pQ, pQ, 1
	}
	loop, parse, pQ
	if A_LoopField = x
		o%A_Index% := xx
	else if A_LoopField = y
		o%A_Index% := yy
	else if A_LoopField = w
		o%A_Index% := NumGet(RECT, 8, "Int") - xx - ( lx ? lx : 0)
	else if A_LoopField = h
		o%A_Index% := NumGet(RECT, 12, "Int") - yy - ( ly ? ly : 0 )
	return retAll ? o1 " " o2 " " o3 " " o4 : o1
}

SetSystemCursor() {
	CursorHandle := DllCall( "LoadCursor", Uint,0, Int,Cursor_int )
	Cursors = %Cursor_int%,32512
	loop , Parse, Cursors, `,
		DllCall( "SetSystemCursor", Uint,CursorHandle, Int,A_LoopField )
	return
}

RestoreCursors() {
	SPI_SETCURSORS := 0x57
	DllCall( "SystemParametersInfo", UInt,SPI_SETCURSORS, UInt,0, UInt,0, UInt,0 )
	return
}

In(x,a,b) { 
	IfLess x,%a%, return a
	IfLess b,%x%, return b
	return x
}

HexToDec(HexVal) {
	Old_A_FormatInteger := A_FormatInteger
	SetFormat IntegerFast, D
	DecVal := HexVal + 0
	SetFormat IntegerFast, %Old_A_FormatInteger%
	return DecVal
}

PostMessage_2CursorWin(Message, wParam = 0, lParam=0) {	
	OldcoordMode:= A_coordModeMouse
	coordMode, mouse, screen
	mouseGetPos X, Y, , , 2
	hWnd := DllCall("WindowFromPoint", "int", X , "int", Y)
	PostMessage %Message%, %wParam%, %lParam%, , ahk_id %hWnd%
	coordMode, mouse, %OldcoordMode%
} 	;	 </23.01.000004>

PostMessage_2CursorCTL(Message, wParam = 0, lParam=0) {	
	OldcoordMode:= A_coordModeMouse
	coordMode, mouse, screen
	mouseGetPos X, Y, , hWnd , 2 ;hWnd := DllCall("WindowFromPoint", "int", X , "int", Y)
	PostMessage %Message%, %wParam%, %lParam%, , ahk_id %hWnd%
	coordMode, mouse, %OldcoordMode%
} 	;	 </23.01.000004>

XY_INIT:
X_Old:="", Y_Old:="", toolX:="", toolY:="", X_Cursor:="", Y_Cursor:="", x:="", y:="", Thresh_Breach:=""
return

Toggle_Win_Drag_State:
if Win_Drag_State_Active {
	menu, submenu1, Uncheck, Raise window when Dragged,
	Win_Drag_State_Active :=
} else {
	menu, submenu1, check, Raise window when Dragged,
	Win_Drag_State_Active := True
}
return


CColor_(Wp, Lp, Msg, hWnd) {
	static 
	static WM_CTLCOLOREDIT=0x0133, WM_CTLCOLORLISTBOX=0x134, WM_CTLCOLORSTATIC=0x0138
		 ,LVM_SETBKCOLOR=0x1001, LVM_SETTEXTCOLOR=0x1024, LVM_SETTEXTBKCOLOR=0x1026, TVM_SETTEXTCOLOR=0x111E, TVM_SETBKCOLOR=0x111D
		 ,BS_CHECKBOX=2, BS_RADIOBUTTON=8, ES_READONLY=0x800
		 ,CLR_NONE=-1, CSILVER=0xC0C0C0, CGRAY=0x808080, CWHITE=0xFFFFFF, CMAROON=0x80, CRED=0x0FF, CPURPLE=0x800080, CFUCHSIA=0xFF00FF, CGREEN=0x8000, CLIME=0xFF00, COLIVE=0x8080, CYELLOW=0xFFFF, CNAVY=0x800000, CBLUE=0xFF0000, CTEAL=0x808000, CAQUA=0xFFFF00
 		 ,CLASSES := "Button,ComboBox,Edit,ListBox,Static,RICHEDIT50W,SysListView32,SysTreeView32"
	
	if (Msg = "") { 
		if !adrSetTextColor
			adrSetTextColor	:= DllCall("GetProcAddress", "uint", DllCall("GetModuleHandle", "str", "Gdi32.dll"), "str", "SetTextColor")
		 ,adrSetBkColor	:= DllCall("GetProcAddress", "uint", DllCall("GetModuleHandle", "str", "Gdi32.dll"), "str", "SetBkColor")
		 ,adrSetBkMode	:= DllCall("GetProcAddress", "uint", DllCall("GetModuleHandle", "str", "Gdi32.dll"), "str", "SetBkMode")
	
 ;Set the colors (RGB -> BGR)
		BG := !Wp ? "" : C%Wp% != "" ? C%Wp% : "0x" SubStr(WP,5,2) SubStr(WP,3,2) SubStr(WP,1,2) 
		FG := !Lp ? "" : C%Lp% != "" ? C%Lp% : "0x" SubStr(LP,5,2) SubStr(LP,3,2) SubStr(LP,1,2)

	 ;Activate message handling with OnMessage() on the first call for a class 
		winGetClass, class, ahk_id %hWnd% 
		if class not in %CLASSES% 
			return A_ThisFunc "> Unsupported control class: " class

		ControlGet, style, Style, , , ahk_id %hWnd% 
		if (class = "Edit") && (Style & ES_READONLY) 
			class := "Static"
	
		if (class = "Button")
			if (style & BS_RADIOBUTTON) || (style & BS_CHECKBOX) 
				 class := "Static" 
			else return A_ThisFunc "> Unsupported control class: " class
		
		if (class = "ComboBox") { 
			VarSetCapacity(CBBINFO, 52, 0), NumPut(52, CBBINFO), DllCall("GetComboBoxInfo", "UInt", hWnd, "UInt", &CBBINFO) 
			hWnd := NumGet(CBBINFO, 48)		;hWndList
			%hWnd%BG := BG, %hWnd%FG := FG, %hWnd% := BG ? DllCall("CreateSolidBrush", "UInt", BG) : -1

			IfEqual, CTLCOLORLISTBOX,,SetEnv, CTLCOLORLISTBOX, % OnMessage(WM_CTLCOLORLISTBOX, A_ThisFunc) 

			if NumGet(CBBINFO,44)	;hWndEdit
				hWnd := Numget(CBBINFO,44), class := "Edit"
		} 

		if class in SysListView32,SysTreeView32
		{
			m := class="SysListView32" ? "LVM" : "TVM" 
			SendMessage, %m%_SETBKCOLOR, ,BG, ,ahk_id %hWnd%
			SendMessage, %m%_SETTEXTCOLOR, ,FG, ,ahk_id %hWnd%
			SendMessage, %m%_SETTEXTBKCOLOR, ,CLR_NONE, ,ahk_id %hWnd%
			return
		}

		if (class = "RICHEDIT50W")
			return f := "RichEdit_SetBgColor", %f%(hWnd, -BG)

		if (!CTLCOLOR%Class%)
			CTLCOLOR%Class% := OnMessage(WM_CTLCOLOR%Class%, A_ThisFunc) 

		return %hWnd% := BG ? DllCall("CreateSolidBrush", "UInt", BG) : CLR_NONE, %hWnd%BG := BG, %hWnd%FG := FG
 } 
 
 ; Message handler 
	critical					;its OK, always in new thread.

	hWnd := Lp + 0, hDC := Wp + 0
	if (%hWnd%) { 
		DllCall(adrSetBkMode, "uint", hDC, "int", 1)
		if (%hWnd%FG)
			DllCall(adrSetTextColor, "UInt", hDC, "UInt", %hWnd%FG)
		if (%hWnd%BG)
			DllCall(adrSetBkColor, "UInt", hDC, "UInt", %hWnd%BG)
		return (%hWnd%)
	}
}

SetBk(hWnd, ghWnd, bc, tc=0xff0000) {
	a := {}
	a["ch"] := hWnd
	a["gh"] := ghWnd
	a["bc"] := ((bc&255)<<16)+(((bc>>8)&255)<<8)+(bc>>16)
	a["tc"] := ((tc&255)<<16)+(((tc>>8)&255)<<8)+(tc>>16)
	WindowProc("Set", a, "", "")
}

WindowProc(hWnd, uMsg, wParam, lParam) {
	Static Win := {}
	Critical
	if (uMsg = 0x133) and Win[hWnd].HasKey(lparam)
	{
		DllCall("SetTextColor", "UInt", wParam, "UInt", Win[hWnd, lparam, "tc"] )
		DllCall("SetBkColor", "UInt", wParam, "UInt", Win[hWnd, lparam, "bc"] )
		return Win[hWnd, lparam, "Brush"] ; return the HBRUSH to notify the OS that we altered the HDC.
	}
	if (hWnd = "Set") {
		a := uMsg
		Win[a.gh, a.ch] := a
		if not Win[a.gh, "WindowProcOld"]
			Win[a.gh,"WindowProcOld"] := DllCall("SetWindowLong", "Ptr", a.gh, "Int", -4, "Int", RegisterCallback("WindowProc", "", 4), "UInt")
		if Win[a.gh, a.ch, "Brush"]
			DllCall("DeleteObject", "Ptr", Brush)
		Win[a.gh, a.ch, "Brush"] := DllCall("CreateSolidBrush", "UInt", a.bc)
		; array_list(Win)
		return
	}
	return DllCall("CallWindowProcA", "UInt", Win[hWnd, "WindowProcOld"], "UInt", hWnd, "UInt", uMsg, "UInt", wParam, "UInt", lParam)
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
 if !(DllCall("user32\SetWindowCompositionAttribute", "ptr", hWnd, "ptr", &WINCOMPATTRDATA))
 return
 accent_size := VarSetCapacity(ACCENT_POLICY, 16, 0)
 return
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
	setTimer, tool1off, -1000
	return
}

contextmenRclicked() {
	tooltip, % Message_Menu_Clicked
	setTimer, tool1off, -1000
	return
}

abort_Mdrag() {
	tooltip, % Message_M2drag_Abort
	setTimer, tool1off, -1000
	return
}

m2_released() {
	tooltip % Message_M2_Released
	setTimer, tool1off, -1000
	return
}

mdrag_active() {
	tooltip, % Message_Drag_Active
	return
}

ThreadFail() {
	tooltip, %Message_Thread_Fail%, (A_ScreenWidth // 2), (A_ScreenWidth // 2)
	setTimer, tool1off, -3000
	return
}

Context_killed() {
	tooltip, %Message_Menu_Killed%,,,4
	setTimer, tool4off, -1000
	return
}

Quick_L_click() {
	tooltip % Message_Click_Fast
	setTimer, tool1off, -1000
	return
}

L_Released() {
	tooltip, %Message_Click_Release%,,,4
	setTimer, tool4off, -1000
	return
}

L_clicked_Desktop() {
	tooltip, %Message_Click_DTop%, (X_Cursor+100), (Y_Cursor+20)
	setTimer, Tool1Off, -750
	return
}

Clicked_Somewhere() {
	tooltip, %Message_Click_Other%
	setTimer, Tool1Off, -750
	return
}

LButton_Held() {
	tooltip %Message_held_DTop%
	setTimer, Tool1Off, -750
	return
}

touching_file() {
	tooltip, %Message_Touching% , toolx, tooly,4
	setTimer, Tool4Off, -750
	return
}

toolXoff(Index) {
	Tool%Index%Off:
	tooltip,,,,%Index%
}

Win_Activate:
winactivate, ahk_id %hWnd%
return

ToolOff:
{
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
}

_Feed_:
{
	global Message_Click:="::Clicked::", global Message_Menu_Clicked:="Context Menu Clicked", global Message_M2drag_Abort:="Aborting Drag", global Message_M2_Released:="released mouse2", global Message_Drag_Active:="Window drag activated' n - Mouse 1 to Cancel", global Message_Thread_Fail:="GetGUIThreadInfo failure", global Message_Menu_Killed:="menu killed", global Message_Click_Fast:="Quick click::", global Message_Click_Release:="mouse 1 released", global Message_Click_DTop:="Left Clicked Desktop", global Message_Click_Other:="clicked elsewhere", global Message_held_DTop:="clickheld on desktop", global Message_Touching:="touching file", global Message_Moved :="%FailState% ...`n %X% %X_Cursor% %y% %Y_Cursor%`n Movement detected `n %x1% %x2% %y1% %y2%, %x%, %75%"
	return
}

winGetTransparency:
 mouseGetPos, , , hWnd
 if (Trans_%hWnd% = "")
 Trans_%hWnd% := 100
 Trans := Trans_%hWnd%
 Trans0 := Trans
return

WinSetTransparency:
winGetClass, WindowClass, ahk_id %hWnd%
if WindowClass = Progman
	return
Trans0 := (Trans0 < 10) ? 10 : (Trans0 > 100) ? 100 : Trans0
Alpha0 := Trans * 2.55		; Init. Alpha
Alpha := Round(Trans0 * 2.55)	; Final Alpha
Trans := Trans0
Trans_%hWnd% := Trans
a := Alpha - Alpha0
b := AlphaIncrement
b *= (a < 0) ? -1 : 1	; Signed increment
a := Abs(a)				; Abs. iteration range
loop {
	Alpha0 := Round(Alpha0)
	WinSet, Trans, %Alpha0%, ahk_id %hWnd%
	if (Alpha0 = Alpha) {
		if (Alpha = 255) {
			if hWnd Not In %CleanUpList%
				{
				CleanUpList = %CleanUpList%%hWnd%`,
				setTimer, CleanUp, 10000
				}
		} else
			StringReplace, CleanUpList, CleanUpList, %hWnd%`,, , 1
		Break
	} else 
	if (a >= AlphaIncrement) {
		 Alpha0 += b
		 a -= AlphaIncrement
	} else Alpha0 := Alpha
}
return

tooltipCreate:
c := Floor(Trans / 4)
d := 25 - c
tooltipText := "Opacity: "
loop, %c%
tooltipText .= "|"
if (c > 0)
	tooltipText .= " "
tooltipText .= Trans . "%"
if (d > 0)
	tooltipText .= " "
loop, %d%
	tooltipText .= "|"
tooltip, %tooltipText%
mouseGetPos, MouseX0, MouseY0
setTimer, tooltipdestroy
return

tooltipdestroy:
if (A_TimeIdle < 1000) {
	mouseGetPos, MouseX, MouseY
	if (MouseX = MouseX0 && MouseY = MouseY0)
		return
}
setTimer, tooltipdestroy, Off
tooltip,
return

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CleanUp: 						;					 iniWrite, %Win_Drag_State% , M2DRAG.ini, Drag, Activate_Window
Bypass_Parse_Array:
for index, value in Bypass_ProcList_array
{
	if !ProcList
		ProcList := value
	else
		ProcList =% ProcList "," value
}
Bypass_ProcList := ProcList
for index, value in Bypass_ClassList_array
{
	if !ClassList
		ClassList := value
	else
		ClassList =% ClassList "," value
}
Bypass_ClassList := ClassList
for index, value in Bypass_TitleList_array
{
	if !TitleList
		TitleList := value
	else
		TitleList =% TitleList "," value
}
Bypass_TitleList := TitleList
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Bypass_RegWrite:
regWrite, REG_SZ, HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_ClassList, %Bypass_ClassList%
regWrite, REG_SZ, HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_ProcessList, %Bypass_ProcList%
regWrite, REG_SZ, HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_TitleList, %Bypass_TitleList%
Gui, Optiona:destroy
loop, Parse, CleanUpList, `,
{
	StringReplace, CleanUpList, CleanUpList, %A_LoopField%`,, , 1
	if (A_LoopField != "")
		WinSet, Trans, Off, ahk_id %A_LoopField%
}
if (A_exitReason = "")
	setTimer, CleanUp, Off
else
	exitApp
return
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;---------------------------------------------------------------------------------------
 HotkeyEvent:		;	hotkey, IfWinActive, ahk_id %Options_Hwnd% 	 
;---------------------------------------------------------------------------------------
if hotkey {			;	hotkey, lwin, bumhole
	hotkeycurrent := hotkey, hotkey_Old := hotkey
	tooltip % hotkey " " hotkey_Old " " hotkeycurrent
} else {
	if hotkey_Old
		hotkeycurrent=%hotkey_Old%
	else hotkeycurrent=%hotkey%
}
hotkey, %hotkeycurrent%, myLabia
return
;---------------------------------------------------------------------------------------
myLabia:
tooltip % hotkeycurrent
settimer tooloff, -1000
return
;---------------------------------------------------------------------------------------
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Open_Options_GUI:
{
	gui, Optiona:new , , Options
	gui +HwndOptions_Hwnd
	gui, Optiona:add, hotkey, wp vhotkey gHotkeyEvent w100 h21 0x200
	gui, Optiona:add, button, default w80, OK
	gui, Optiona:Show
	return
}
GuiClose(Options_Hwnd) {
	gosub HotkeyEvent
	return ; end of auto-execute section
}

Bypass_Last_Dragged_GUI: 		;		 DragbypassClass_new_possible 		; ahk_id %hwnd%
{
	winGet DragbypassClass_new_possibleProcName, ProcessName, %DragbypassClass_new_possible%
	winGetTitle DragbypassClass_new_possibleTitle, %DragbypassClass_new_possible%
	winGetClass DragbypassClass_new_possibleClass, %DragbypassClass_new_possible%
	gui, BypassDragged:new , , Bypass_Last_Dragged_GUI
	gui +hwndBypassDragged_hWnd
	gui, BypassDragged:add, checkbox, vTProcName ,Process %DragbypassClass_new_possibleProcName%
	gui, BypassDragged:add, checkbox, vTTitle ,WindowTitle %DragbypassClass_new_possibleTitle%
	gui, BypassDragged:add, checkbox, vTClass ,save Class %DragbypassClass_new_possibleClass%
	gui, BypassDragged:add, button, default gBlacklistGUISubmit w80, Add To BlackList (Enter)
	gui, BypassDragged:add, button, w80 gBlacklistGUIDestroy, Cancel (Esc)
	gui, show, center, Bypass_Last_Dragged_GUI
	OnMessage(0x200, "Help")
	return
}

BlacklistGUISubmit:
gui, BypassDragged:Submit
if TProcName {
	if Bypass_ProcList
		Bypass_ProcList_Array[BlacklistProcCount+1] := DragbypassClass_new_possibleProcName  
	else
		Bypass_ProcList_Array[1] := DragbypassClass_new_possibleProcName  
} else
if TTitle {
	if Bypass_TitleList
		Bypass_TitleList_Array[BlacklistTitleCount+1] := DragbypassClass_new_possibleTitle
	else 	
		Bypass_TitleList_Array[1] := DragbypassClass_new_possibleTitle
} else
if TClass {
	if Bypass_ClassList
		Bypass_ClassList_array[BlacklistClassCount+1] := DragbypassClass_new_possibleClass
	else
		Bypass_ClassList_array[1] := DragbypassClass_new_possibleClass
}

BlacklistGUIDestroy:
gui, BypassDragged:destroy 
TProcName := "", TTitle := "", TClass := ""
return

;-------------------------------------------------------------------------------
SliderEvent: ; slider changes come here
;-------------------------------------------------------------------------------
 GuiControlGet, Slider ; get new value for Slider
 GuiControl,, Text, %Slider%
return
;-------------------------------------------------------------------------------
AimControl(a, s) { ; control mouse speed
;-------------------------------------------------------------------------------
 Static OrigMouseSpeed := 10, CurrentMouseSpeed := DllCall("SystemParametersInfo", UInt, 0x70, UInt, 0, UIntP, OrigMouseSpeed, UInt, 0)
 DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, Ptr, a ? (s>0 AND s<=20 ? s : 10) : OrigMouseSpeed, UInt, 0)
}
;-------------------------------------------------------------------------------
MouseSlow: ; use slow mouse speed
;-------------------------------------------------------------------------------
AimControl(1, Slider)
return
;-------------------------------------------------------------------------------
MouseNormal: ; use normal mouse speed
;-------------------------------------------------------------------------------
AimControl(0, 0)
return

m2drag_default_toggle:
m2drag_Active := !m2drag_Active 
if m2drag_Active {
	m2drag_default = m2drag
	menu, submenu1, check, m2Drag all by default,
	if DragbypassClass_new_possible {
		menu, tray, add, Bypass the last Dragged window, Open_Options_GUI,
		Dragbypassmenu_enabled := true
	}
	if kooof {
		menu, tray, delete, Bypass the last attempted Dragged window,
		kooof := 
	}
} else {
	if Dragbypassmenu_enabled {
		menu, tray, delete, Bypass the last Dragged window,
		Dragbypassmenu_enabled :=
		}
		if DragAllowMenu_enabled {
			menu, tray, add, Add last attempted window drag to whitelist, Open_Options_GUI,
		kooof:=true
		}
		m2drag_default = BypassDrag
		menu, submenu1, Uncheck, m2Drag all by default,
}
return

EvaluateBypass_Class(hWnd) {
	winGetClass, Class, ahk_id %hWnd%
	switch Class {
		case BypassClassList_Default:
			return 1
		case Bypass_ClassList_array[1]:
			return 1
		case Bypass_ClassList_array[2]:
			return 1
		case Bypass_ClassList_array[3]:
			return 1
		case Bypass_ClassList_array[4]:
			return 1
		case Bypass_ClassList_array[5]:
			return 1
		case Bypass_ClassList_array[6]:
			return 1
		case Bypass_ClassList_array[7]:
			return 1
		case Bypass_ClassList_array[8]:
			return 1
		case Bypass_ClassList_array[9]:
			return 1
		case Bypass_ClassList_array[10]:
			return 1
		Default:
			return 0
	}
}
EvaluateBypass_Proc(hWnd) {
	winGet ProcName, ProcessName, ahk_id %hWnd%
	switch ProcName {
		case Bypass_ProcList_Array[1]:
			return 1
		case Bypass_ProcList_Array[2]:
			return 1
		case Bypass_ProcList_Array[3]:
			return 1
		case Bypass_ProcList_Array[4]:
			return 1
		case Bypass_ProcList_Array[5]:
			return 1
		case Bypass_ProcList_Array[6]:
			return 1
		case Bypass_ProcList_Array[7]:
			return 1
		case Bypass_ProcList_Array[8]:
			return 1
		case Bypass_ProcList_Array[9]:
			return 1
		case Bypass_ProcList_Array[10]:
			return 1
		default:
			return 0
	}
}
EvaluateBypass_Title(hWnd_) {
	winGetTitle, The_Title, ahk_id %hWnd_%
	switch The_Title {
		case Bypass_TitleList_Array[1]:
			return 1
		case Bypass_TitleList_Array[2]:
			return 1
		case Bypass_TitleList_Array[3]:
			return 1
		case Bypass_TitleList_Array[4]:
			return 1
		case Bypass_TitleList_Array[5]:
			return 1
		case Bypass_TitleList_Array[6]:
			return 1
		case Bypass_TitleList_Array[7]:
			return 1
		case Bypass_TitleList_Array[8]:
			return 1
		case Bypass_TitleList_Array[9]:
			return 1
		case Bypass_TitleList_Array[10]:
			return 1
		default:
			return 0
	}
}
return

Open_script_folder:
Run %A_ScriptDir%
return

Blacklist_RegRead: 									
regRead, Bypass_ClassList, HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_ClassList
regRead, Bypass_TitleList, HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_TitleList 
regRead, Bypass_ProcList, HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_ProcessList
return

BlacklistParse:
loop, Parse, Bypass_ProcList, `, 
{
	Bypass_ProcList_Array[A_Index] := A_LoopField
	BlacklistProcCount := A_Index
}
loop, Parse, Bypass_ClassList, `, 
{
	Bypass_ClassList_array[A_Index] := A_LoopField
	BlacklistClassCount := A_Index
}
loop, Parse, Bypass_TitleList, `, 
{
	BlacklistTitleCount := A_Index
	Bypass_TitleList_Array[A_Index] := A_LoopField
}
return

Menu_Init:
{
	menu, tray, NoStandard
	menu, tray, add, Open script folder, Open_script_folder,
	menu, tray, add, Options Window, Open_Options_GUI,
	menu, tray, standard
	menu, tray, NoStandard
	menu, SubMenu1, add, Handle Handler, Handle_Handler_Toggle
	menu, SubMenu1, add, Raise window when Dragged, Toggle_Win_Drag_State
	if Win_Drag_State_Active 
		menu, submenu1, check, Raise window when Dragged,
	menu, SubMenu1, add, m2Drag all by default, m2drag_default_toggle
	if ( m2drag_default = "m2drag" ) {
		menu, submenu1, check, m2Drag all by default,
		m2drag_Active := true
	}
	menu, tray, add, Settings, :SubMenu1
	menu, tray, standard
	menu, tray, Icon, mouse24.ico
	return
}

Get_Globals:
{
	global ImageGlassClass := "AHK_Class WindowsForms10.Window.8.app.0.34f5582_r6_ad1", mag_path := "C:\Program Files\AHK\Autohotkey.exe C:\Script\AHK\Working\M2DRAG_MAG.AHK", global PID, global ControlhWnd, global Cursor_int, global CursorChange, global EWD_OriginalWidth, global EWD_OriginalHeight, global ccc, global ddd, global DZThresh, global X_Cursor, global Y_Cursor, global X, global Y, global ToolX, global ToolY, global TTX, global TTY, global ZWidth2, global Zheight2, global ZWidth, global Zheight, global X_Start_OLD, global Y_Start_OLD, global OriginalPosX, global OriginalPosY, global X_Old, global Y_Old, global EWD_MidX, global EWD_MidY, global WindowHeight, global WindowWidth, global y_NET, global y_NETold, global x_NET, global x_NETold, global hWnd, global xoff, global yoff, global Idle_Mosue := A_TimeIdlemouse, global Idle_KB := A_TimeIdleKeyboard, global idle_Physical := A_TimeIdlePhysical, global IDle_main := A_TimeIdle, global hotkey, global DragbypassClass_new_possible, global Bypass_ProcList, global Bypass_TitleList_Array:=[], global Bypass_ClassList_array := [], global Bypass_ProcList_Array := [], global BlacklistProcCount, global BlacklistClassCount, global BlacklistTitleCount, global X_CursorS2, global Y_CursorS2
	global TClass, global TProcName, global TTitle, global pube_count := 0, global TClass, global TProcName, global TTitle, global Bypass_TitleList, global Bypass_ClassList, global Bypass_ProcList
	Mag := 0, XX := 0, YY := 0, m1resize := 1, Win_Drag_State_Active := True, AlphaIncrement := 0.2, m2drag_default := "m2drag"
	return 
}