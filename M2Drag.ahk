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
;ds 	M Wolff - 2020-2021
;ds
 */
	; sendlevel 1;#include ns.ahk ;goSub _Feed_ ;#WinActivateforce ;CoordMode, toolTip, Screen;BLACKLIST-Window-ClassES
#NoEnv																																	
#SingleInstance force
#Persistent
#InstallMouseHook
#MaxThreadsPerHotkey 10
SendMode Input ;
CoordMode, Mouse, screen
SetBatchLines -1 ;SetWinDelay -1
SetWorkingDir %A_ScriptDir% 


Menu, Tray, NoStandard
Menu, Tray, Add, Open script folder, Open_script_folder,
Menu, Tray, Standard

Onexit, Cleanup
global imageglass := "AHK_Class WindowsForms10.Window.8.app.0.34f5582_r6_ad1", global PID, global ControlhWnd, global Cursor_int, global CursorChange, global EWD_OriginalWidth, global EWD_OriginalHeight, global ccc, global ddd, global Trigg4
global CursorX, global CursorY, global X, global Y, global ToolX, global ToolY, global TTX, global TTY, global ZWidth2, global Zheight2, global ZWidth, global Zheight
global X_Start_OLD, global Y_Start_OLD, global OriginalPosX, global OriginalPosY, global XOld, global YOld, global EWD_MidX, global EWD_MidY

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
Win_Drag_State_Active := True
Menu, Tray, Icon, mouse24.ico
Menu, Tray, NoStandard
Menu, SubMenu1, Add, Handle Handler, Handle_Handler_Toggle
Menu, SubMenu1, Add, Raise window when Dragged, Toggle_Win_Drag_State
if Win_Drag_State_Active 
{
	Menu, submenu1, Check, Raise window when Dragged,

}
Menu, Tray, Add, Settings, :SubMenu1
Menu, Tray, Standard
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
AlphaIncrement := 0.2

maggy:="C:\Program Files\AHK\AutoHotkey.exe C:\Script\AHK\Working\M2DRAG_MAG.AHK", Mag:=0, XX := 0, YY :=0 
;collection := [ Chrome_WidgetWin_2, MozillaDropShadowWindowClass ]

#M:: 
	if !Mag {
		run % ahkizzle maggy
		Mag = 1
	}
	else Mag :=
	return
	
^+rButton:: 									;REGULAR RCLICK	     ;     CTRL  +   SHIFT  +   RIGHTCLICK
SendInput, { rButton } 			
return

;^+LButton:: 	 								;REGULAR RCLICK	     ;     CTRL  +   SHIFT  +   LCLICK
;SendInput, {LButton} 				
;return

^#Mbutton::  		;    CTRL    +     WIN    +     MIDDLE=MOUSE     (aka WHEELBUTTON)
	Handle_Handler_Toggle:
	Handle_Handler_Active := ! Handle_Handler_Active  ;            TOGGLE     INFO     DISPLAY
	if (Handle_Handler_Active) {
	Menu, submenu1, Check, Handle Handler,
		setTimer CursorTip, 30
		^#c::  ; 															CTRL     WIN     C 
		clipboard:=WindowUnderCursorInfo 		;      copy     Window     info     
		return
	} else {
		Menu, submenu1, unCheck, Handle Handler,
		gosub Handle_Handler_Toggle
		sleep 100
		setTimer CursorTip, off
		setTimer, ToolTipDestroy, -1750
		return
	}

^NumpadDot::exit 	;>=====CTRL=NUMPAD=DOT====>(NORMAL=RIGHT=CLICK=INCASE=OF=BUGS)=====<
return
 
~Esc::
if winactive(imageglass)
	WinClose , %imageglass%
return



rButton::
mousegetpos, , , hWnd
aaaa=ahk_id %hWnd% 	
mousegetpos, CursorXs, CursorYs
wingetpos, WindowX, WindowY, WindowWidth, WindowHeight, % aaaa
xoff := ( CursorXs - WindowX ), Yoff := ( CursorYs - WindowY )
SetWinDelay, -1
WinGetClass, Class, % aaaa
switch Class {
	case Class1:
		goto mouse2_bypass
	case Class2:
		goto mouse2_bypass
	case Class3:
		goto mouse2_bypass
	case Class4:
		goto mouse2_bypass
	case Class5:
		goto mouse2_bypass
	case Class6:
		goto mouse2_bypass
	case Class7:
		goto mouse2_bypass
	case Class8:
		goto mouse2_bypass
	case Class9:
		goto mouse2_bypass
	case Class10:
		goto mouse2_bypass
	case BlackDesertWindowClass:
		goto mouse2_bypass
	case LaunchUnrealUWindowsClient:
		goto mouse2_bypass
	case AlienShooter:
		goto mouse2_bypass
	case WindowsForms10.Window.8.app.0.1475d71_r13_ad1:
		goto mouse2_bypass
	case Chrome_WidgetWin_1:
		goto Title_get
	case ApplicationFrameWindow:
		goto Title_get
	case WindowsForms10.Window.8.app.0.1475d71_r13_ad1:
		goto mouse2_bypass
	default:
		goto M2DRAG
}

M2DRAG:
mouseGetPos, CursorX, CursorY
while (GetKeyState("rButton" , "P") ) {
	Win_Move(Hwnd, CursorX-xoff, CursorY-Yoff, WindowWidth, WindowHeight, "")
	mouseGetPos, CursorX, CursorY
	if Win_Drag_State_Active
		winactivate, % aaaa 
	if !trigg4
		if (CursorX<CursorXs -25) || (CursorX>CursorXs +25) || (CursorY<CursorYs -25) || (CursorY>CursorYs +25) 
			trigg4 := True		
	if !insight {
		WinGet, EWD_WinState, MinMax, % aaaa
		CursorChange := 1, insight := 1
		if (EWD_WinState = 1) {
			while (GetKeyState("rButton" , "P") ) {
				if !trigg4
					if (CursorX<CursorXs -25) || (CursorX>CursorXs +25) || (CursorY<CursorYs -25) || (CursorY>CursorYs +25) 
						trigg4 := True		
				mouseGetPos, CursorX, CursorY
				if ( CursorX < ( CursorXs - 25 )) || ( CursorX > ( CursorXs + 25 )) || (CursorY < ( CursorYs - 25 )) || ( CursorY > ( CursorYs + 25 )) {	
					EWD_MidWidth:= (A_ScreenWidth/3)
					EWD_MidX:=CursorX-(WindowWidth/2)
					EWD_MidY:=CursorY-(WindowHeight/3)
					EWD_MidHeight:=(A_ScreenHeight/2)
					winRestore, % aaaa
					wingetpos, , , WindowWidth, WindowHeight, % aaaa
					Win_Move(Hwnd, EWD_MidX, EWD_MidY, EWD_MidWidth, EWD_MidHeight, 22) 
				}	
			}
		}
	}
}
if !trigg4 ; mouse released without moving past thresh
	SendInput, {rButton}
insight := "", trigg4 := False
return

Title_get:
WinGetTitle, The_Title, ahk_id %hWnd%
if ( The_Title = "Little Big Snake - Official Website - Opera" ) || ( The_Title = "Roblox" )
	goto mouse2_bypass
return

mouse2_bypass:
SendInput, {rButton Down} 
loop {
	GetKeyState, KSRB, rButton, P
	if (KSRB = "U") {	; Button released, drag carried out.
		SendInput, {rButton Up} 	
		Break
}	}
if !trigg4
	SendInput, {rButton}
insight := "", trigg4 := False
return

~LButton::
mousegetpos,X ,Y , hWnd
aaaa=ahk_id %hWnd% 	
WinGetClass, Class, % aaaa
Cursor_int := 32651, SetSystemCursor() 
if (class = "WorkerW" ) or (class = "ProgMan") {	; WaitMove
	mouseGetPos, CursorX, CursorY
	while (GetKeyState("LButton", "P")) {
		mouseGetPos, x, y
		if (XOld!=X) or (YOld!=y) {
			if (X > CursorX) {
				toolX := CursorX - 103
				toolTipbycursor:=r00la(X,Y)
				Thresh_Breach := true
			}
			else if (X < CursorX) {
				toolX := CursorX
				toolTipbycursor:=r00la(X,Y)
				Thresh_Breach := true
			}
			else if (y > CursorY) {
				tooly := CursorY -57
				toolTipbycursor:=r00la(X,Y)
				Thresh_Breach := true
			}
			else if (y < CursorY) {
				tooly := CursorY + 4
				toolTipbycursor:=r00la(X,Y)
				Thresh_Breach := true
			}
			if Thresh_Breach {
				toolTip, %toolTipbycursor%, %toolX% , %tooly% , 5
				XOld:=X, YOld:=Y,	Selected_Item_Check:= Explorer_GetSelection()
				sleep 20
				if Selected_Item_Check {
					SetSystemCursor()
					goSub tool5off
					touching_file()
					return
				}
			}
		}	
		else sleep 50
	}
	setTimer tool5off, -2000
	XOld:="", YOld:="", toolX:="", toolY:="", CursorX:="", CursorY:="", x:="", y:="", Thresh_Breach:=""
	RestoreCursors()
	L_Released()
}
return

^1::  	; Press ctl 1 to make the color under the mouse cursor invisible.
mouseGetPos, MouseX, MouseY, MouseWin
pixelGetColor, MouseRGB, %MouseX%, %MouseY%, RGB
WinSet, TransColor, Off, ahk_id %MouseWin%
sleep 100
WinSet, TransColor, %MouseRGB%, ahk_id %MouseWin% 	;	 WinSet, TransColor, 0xFFFFFF, ahk_id %MouseWin%
return

#lbutton:: 	; Press Win+y to turn off transparency for the Window under the mouse.
mouseGetPos,,, MouseWin
WinSet, TransColor, Off, ahk_id %MouseWin%
return

#!g::  ; Press Win+G to show the current settings of the Window under the mouse.
mouseGetPos,,, MouseWin
WinGet, Transparent, Transparent, ahk_id %MouseWin%
WinGet, TransColor, TransColor, ahk_id %MouseWin%
toolTip Translucency:`n%Transparent%`nTransColor:`t%TransColor%
return

;>====FIX icons on desktop as zooming====>
+^WheelDown::
	mouseGetPos, CursorX, CursorY, ahk_id_CHECK
	WinGetClass, AHK_Class_CHECK, ahk_id %ahk_id_CHECK%,,
	if (AHK_Class_CHECK= "WorkerW") || (AHK_Class_CHECK="Progman")
		Dtop_icons_Restore()
	return

+^WheelUp::
	mouseGetPos, CursorX, CursorY, ahk_id_CHECK
	WinGetClass, AHK_Class_CHECK, ahk_id %ahk_id_CHECK%,,
	if(AHK_Class_CHECK= "WorkerW") || (AHK_Class_CHECK="Progman")
		Dtop_icons_Restore()
	return
	
+PgDn:: 		; 	Wheel r = page down without interfering with selection
^+PgDn::  	; 	Ctrl + Wheel r = "end" without interfering with selection  
WinGetClass, Active_WinClass , A
mouseGetPos, , , Mouse_hWnd, Mouse_ClassNN
WinGetClass, Mouse_WinClass , ahk_id %Mouse_hWnd%

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
	if ( A_ThisHotKey = "^+PgDn" ) {
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

+PgUp:: 		; 	Wheel L = "page down" without interfering with selection
^+PgUp:: 	; 	Ctrl + Wheel L = "home" without interfering with selection  
WinGetClass, Active_WinClass , A
mouseGetPos, , , Mouse_hWnd, Mouse_ClassNN
WinGetClass, Mouse_WinClass , ahk_id %Mouse_hWnd%
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
	if ( A_ThisHotKey = "^+PgUp" ) {
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

#+LButton::PostMessage_2CursorWin(0x111, 41504, 0)
if (ErrorLevel) {
	toolTip, %ErrorLevel% Error
	setTimer, ToolOff, -1000
}
return

#+rButton::PostMessage_2CursorCTL(0x111, 41504, 0)
if (ErrorLevel) {
	toolTip, %ErrorLevel% Error
	setTimer, ToolOff, -1000
}
return

#MButton::
goSub, WinGetTransparency
goSub, WinSetTransparency
goSub, toolTipCreate
return

^2::
	goSub, WinGetTransparency
	Trans0 -= 10
	goSub, WinSetTransparency
	goSub, toolTipCreate
	return

^3::
	goSub, WinGetTransparency
	Trans0 += 10
	goSub, WinSetTransparency
	goSub, toolTipCreate
	return

f7:: 			; 				_-========set dwm blur Window========-_
mouseGetPos, , , swindow, control2
if !(swindow || control2)
toolTip no handle to window or cunt
SetAcrylicGlassEffect(bgrColor, 17, ahk_id swindow)
toolTip bellend not %swindow%
return

; f8:: 			; 				_-========set dwm blur Control handle========-_
; mouseGetPos, , , swindow, control2
; if !(swindow || control2)
; toolTip no handle to window or cunt
; ControlGet, cunt, hWnd ,,%control2% , ahk_id %swindow%
; SetAcrylicGlassEffect(bgrColor, 17, ahk_id %cunt%)
; toolTip bellend not %cunt%
; return

numpadclear::
WINID := WinExist("A")
sleep 200
toolTip % WINID
return

#^p::
goto cooon
return
cooon:
sleep 50
CColor(ControlhWnd, Background="0x000000", Foreground="0x000000") {
	return CColor_(Background, Foreground, "", hWnd+0)
}
	
CursorTip:
coordmode toolTip, Screen
WindowUnderCursorInfo := GetUnderCursorInfo(CursorX, CursorY)
if ( CursorX < (A_ScreenWidth // 2) )
	TTX := (A_ScreenWidth // 2) + 100
else
	TTX := (A_ScreenWidth // 2) - 400
if ( CursorY < (A_ScreenHeight // 2) )
	TTY := (A_ScreenHeight // 2) + 100
else
	TTY := (A_ScreenHeight // 2)-300
if WindowUnderCursorInfo != %WindowUnderCursorInfoOld%
	{	;fixes flicker
	toolTip %WindowUnderCursorInfo%, %TTX% , %TTY%
	WindowUnderCursorInfoOld=% WindowUnderCursorInfo
	}
return

r00la(byref x, byref y) {
	WinGetActiveTitle, Atitle
	WinGetClass, aClass, %atitle%,,
	krabx:= Abs(CursorX-x)
	Kraby := Abs(CursorY-y)
	R_return := " "CursorX ", " CursorY "`n"
.  "X:" krabx " Y:" kraby ""
	return R_return
}

Explorer_GetSelection(hWnd="") {
	WinGet, process, processName, % "ahk_id" hWnd := hWnd? hWnd:WinExist("A")
	WinGetClass Class, ahk_id %hWnd%
	if (process = "explorer.exe")
		if (Class ~= "Progman|WorkerW") {
			ControlGet, files, List, Selected Col1, SysListView321, AHK_Class %Class%
			loop, Parse, files, `n, `r
				Toreturn .= A_Desktop "\" A_loopField "`n"
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

GetUnderCursorInfo(ByRef CursorX, ByRef CursorY) {
	CoordMode Mouse, Screen
	CoordMode Pixel, Screen
	mouseGetPos, CursorX, CursorY, Window, Control
	WinGetTitle Title, ahk_id %Window%
	WinGetClass Class, ahk_id %Window%
	WinGetPos WindowX, WindowY, Width, Height, ahk_id %Window%
	WinGet PName, ProcessName, ahk_id %Window%
	WinGet PID, PID, ahk_id %Window%
	WinGet, Style, Style, ahk_id %Window%
	WinGet, ExStyle, ExStyle, ahk_id %Window%
	ControlGet, ContStyle, Style ,,%control%, ahk_id %Window%
	ControlGet, ContExStyle, ExStyle ,,%control%, ahk_id %Window%
	ControlGet, ControlhWnd, hWnd ,, %Control%, ahk_id %Window%
	PixelGetColor, colour, CursorX, CursorYControlhWnd
	if ((length:=StrLen(Title))>35) {
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
	} else  hFlags |= SWP_NOSIZE
	return DllCall("SetWindowPos", "uint", Hwnd, "uint", 0, "int", x, "int", y, "int", w, "int", h, "uint", hFlags)
}

Win_Get(Hwnd, pQ="", ByRef o1="", ByRef o2="", ByRef o3="", ByRef o4="", ByRef o5="", ByRef o6="", ByRef o7="", ByRef o8="", ByRef o9="") {
	if pQ contains R,B,L
		VarSetCapacity(WI, 60, 0), NumPut(60, WI),  DllCall("GetWindowInfo", "uint", Hwnd, "uint", &WI)
	k := i := 0
	loop {
		i++, k++
		if (_ := SubStr(pQ, k, 1)) = ""
			break
		if !IsLabel("Win_Get_" _ )
			return A_ThisFunc "> Invalid query parameter: " _
		Goto %A_ThisFunc%_%_%
		Win_Get_C:
				WinGetClass, o%i%, ahk_id %hwnd%		
		continue
		Win_Get_I:
				WinGet, o%i%, PID, ahk_id20/08/2009 %hwnd%		
		continue
		Win_Get_N:
				rect := "title"
				VarSetCapacity(TBI, 44, 0), NumPut(44, TBI, 0), DllCall("GetTitleBarInfo", "uint", hwnd, "str", TBI)
				title_x := NumGet(TBI, 4, "Int"), title_y := NumGet(TBI, 8, "Int"), title_w := NumGet(TBI, 12) - title_x, title_h := NumGet(TBI, 16) - title_y 
				goto Win_Get_Rect
		Win_Get_B:
				rect := "border"
				border_x := NumGet(WI, 48, "UInt"),  border_y := NumGet(WI, 52, "UInt")	
				goto Win_Get_Rect
		Win_Get_R:
				rect := "window"
				window_x := NumGet(WI, 4,  "Int"),  window_y := NumGet(WI, 8,  "Int"),  window_w := NumGet(WI, 12, "Int") - window_x,  window_h := NumGet(WI, 16, "Int") - window_y
				goto Win_Get_Rect
		Win_Get_L: 
				client_x := NumGet(WI, 20, "Int"),  client_y := NumGet(WI, 24, "Int"),  client_w := NumGet(WI, 28, "Int") - client_x,  client_h := NumGet(WI, 32, "Int") - client_y
				rect := "client"
		Win_Get_Rect:
				k++, arg := SubStr(pQ, k, 1)
				if arg in x,y,w,h
				{
					o%i% := %rect%_%arg%, j := i++
					goto Win_Get_Rect
				} else 
				if !j
					o%i% := %rect%_x " " %rect%_y  (_ = "B" ? "" : " " %rect%_w " " %rect%_h)
		rect := "", k--, i--, j := 0
		continue
		Win_Get_S:
			WinGet, o%i%, Style, ahk_id %Hwnd%
		continue
		Win_Get_E: 
			WinGet, o%i%, ExStyle, ahk_id %Hwnd%
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
			WinGetText, o%i%, ahk_id %hwnd%
		else WinGetTitle, o%i%, ahk_id %hwnd%
			continue
		Win_Get_M: 
		WinGet, _, PID, ahk_id %hwnd%
		hp := DllCall( "OpenProcess", "uint", 0x10|0x400, "int", false, "uint", _ ) 
		if (ErrorLevel or !hp) 
			continue
		VarSetCapacity(buf, 512, 0), DllCall( "psapi.dll\GetModuleFileNameExA", "uint", hp, "uint", 0, "str", buf, "uint", 512),  DllCall( "CloseHandle", hp ) 
		o%i% := buf 
		continue
	}	
	return o1
}

Win_GetRect(hwnd, pQ="", ByRef o1="", ByRef o2="", ByRef o3="", ByRef o4="") {
	VarSetCapacity(RECT, 16), r := DllCall("GetWindowRect", "uint", hwnd, "uint", &RECT)
	ifEqual, r, 0, return
		if (pQ = "") or pQ = ("*")
			retAll := true,  pQ .= "xywh"
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
		DllCall( "SetSystemCursor", Uint,CursorHandle, Int,A_loopfield )
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
	OldCoordMode:= A_CoordModeMouse
	CoordMode, Mouse, Screen
	mouseGetPos X, Y, , , 2
	hWnd := DllCall("WindowFromPoint", "int", X , "int", Y)
	PostMessage %Message%, %wParam%, %lParam%, , ahk_id %hWnd%
	CoordMode, Mouse, %OldCoordMode%
}  	;	 </23.01.000004>

PostMessage_2CursorCTL(Message, wParam = 0, lParam=0) {	
	OldCoordMode:= A_CoordModeMouse
	CoordMode, Mouse, Screen
	mouseGetPos X, Y, , hWnd , 2 ;hWnd := DllCall("WindowFromPoint", "int", X , "int", Y)
	PostMessage %Message%, %wParam%, %lParam%, , ahk_id %hWnd%
	CoordMode, Mouse, %OldCoordMode%
} 	;	 </23.01.000004>

Dtop_icons_Get() {
	RunWait, Dicons_write.ahk 
	return
}

Dtop_icons_Restore() {
	RunWait, Dicons_recover.ahk 
	return
}

clicked() {
	toolTip, % Message_Click
	setTimer, tool1off, -1000
	return
}

contextmenRclicked() {
	toolTip, % Message_Menu_Clicked
	setTimer, tool1off, -1000
	return
}

abort_Mdrag() {
	toolTip, % Message_M2drag_Abort
	setTimer, tool1off, -1000
	return
}

m2_released() {
	toolTip % Message_M2_Released
	setTimer, tool1off, -1000
	return
}

mdrag_active() {
	toolTip, % Message_Drag_Active
	return
}

ThreadFail() {
	toolTip, %Message_Thread_Fail%, (A_ScreenWidth // 2), (A_ScreenWidth // 2)
	setTimer, tool1off, -3000
	return
}

Context_killed() {
	toolTip, %Message_Menu_Killed%,,,4
	setTimer, tool4off, -1000
	return
}

Quick_L_click() {
	toolTip % Message_Click_Fast
	setTimer, tool1off, -1000
	return
}

L_Released() {
	toolTip, %Message_Click_Release%,,,4
	setTimer, tool4off, -1000
	return
}

L_clicked_Desktop() {
	toolTip, %Message_Click_DTop%, (CursorX+100), (CursorY+20)
	setTimer, Tool1Off, -750
	return
}

Clicked_Somewhere() {
	toolTip, %Message_Click_Other%
	setTimer, Tool1Off, -750
	return
}

LButton_Held() {
	toolTip %Message_held_DTop%
	setTimer, Tool1Off, -750
	return
}

touching_file() {
	toolTip, %Message_Touching% , toolx, tooly,4
	setTimer, Tool4Off, -750
	return
}

ToolOff:
	toolTip,
	return
Tool1Off:
	toolTip,,,,1
	return
Tool2Off:
	toolTip,,,,2
	return
Tool3Off:
	toolTip,,,,3
	return
Tool4Off:
	toolTip,,,,4
	return
Tool5Off:
	toolTip,,,,5
	return

Toggle_Win_Drag_State:
if Win_Drag_State_Active {
	Menu, submenu1, UnCheck, Raise window when Dragged,
	Win_Drag_State_Active :=
} else {
	Menu, submenu1, Check, Raise window when Dragged,
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
		WinGetClass, class, ahk_id %hWnd% 
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
				hWnd :=  Numget(CBBINFO,44), class := "Edit"
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

		return %hWnd% := BG ? DllCall("CreateSolidBrush", "UInt", BG) : CLR_NONE,  %hWnd%BG := BG,  %hWnd%FG := FG
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
		return Win[hWnd, lparam, "Brush"]  ; return the HBRUSH to notify the OS that we altered the HDC.
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

Win_Activate:
winactivate, ahk_id %hWnd%
return

_Feed_:
global Message_Click:="::Clicked::", global Message_Menu_Clicked:="Context Menu Clicked", global Message_M2drag_Abort:="Aborting Drag", global Message_M2_Released:="released mouse2", global Message_Drag_Active:="Window drag activated' n - Mouse 1 to Cancel", global Message_Thread_Fail:="GetGUIThreadInfo failure", global Message_Menu_Killed:="menu killed", global Message_Click_Fast:="Quick click::", global Message_Click_Release:="mouse 1 released", global Message_Click_DTop:="Left Clicked Desktop", global Message_Click_Other:="clicked elsewhere", global Message_held_DTop:="clickheld on desktop", global Message_Touching:="touching file", global Message_Moved :="%FailState% ...`n %X% %CursorX% %y% %CursorY%`n Movement detected `n %x1% %x2% %y1% %y2%, %x%, %75%"
return

WinGetTransparency:
   mouseGetPos, , , hWnd
   if (Trans_%hWnd% = "")
      Trans_%hWnd% := 100
   Trans := Trans_%hWnd%
   Trans0 := Trans
return

WinSetTransparency:
	WinGetClass, WindowClass, ahk_id %hWnd%
	if (WindowClass = "Progman") {
		return
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
	loop {
		Alpha0 := Round(Alpha0)
		WinSet, Trans, %Alpha0%, ahk_id %hWnd%
		if (Alpha0 = Alpha) {
			if (Alpha = 255) {
				if hWnd Not In %CleanupList%
					{
					CleanupList = %CleanupList%%hWnd%`,
					setTimer, Cleanup, 10000
					}
			} else {
				StringReplace, CleanupList, CleanupList, %hWnd%`,, , 1
				}
			Break
		}
      else if (a >= AlphaIncrement) {
         Alpha0 += b
         a -= AlphaIncrement
		} else {
			Alpha0 := Alpha
			}
		}
return

toolTipCreate:
   c := Floor(Trans / 4)
   d := 25 - c
   ToolTipText := "Opacity: "
   loop, %c% {
		ToolTipText .= "|"
   }
	if (c > 0)	{
		ToolTipText .= " "
	}
	ToolTipText .= Trans . "%"
	if (d > 0)	{
		ToolTipText .= " "
	}
	loop, %d% {
		ToolTipText .= "|"
	}
	toolTip, %ToolTipText%
	mouseGetPos, MouseX0, MouseY0
	setTimer, ToolTipDestroy
	return

ToolTipDestroy:
	if (A_TimeIdle < 1000) {
		mouseGetPos, MouseX, MouseY
		if (MouseX = MouseX0 && MouseY = MouseY0)
			{
			return
			}
	}
	setTimer, ToolTipDestroy, Off
	toolTip,
	return


Cleanup:
;iniWrite, %Win_Drag_State% , M2DRAG.ini, Drag, Activate_Window
loop, Parse, CleanupList, `,
{
	StringReplace, CleanupList, CleanupList, %A_loopField%`,, , 1
	if (A_loopField != "")
		{
		WinSet, Trans, Off, ahk_id %A_loopField%
		}
}
if (A_exitReason = "") {
	setTimer, Cleanup, Off
}
else	{
	exitApp
}

Open_script_folder:
Run %A_ScriptDir%
return
