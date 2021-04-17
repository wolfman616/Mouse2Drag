SetWorkingDir %A_ScriptDir% 
#NoEnv
#SingleInstance force
#Persistent
SendMode Input  
;Menu, Tray, Icon, C:\Script\AHK\Working\search_32.ico
SetBatchLines -1
#NoTrayIcon
gui +AlwaysOnTop +Owner +Resize +ToolWindow
CoordMode Mouse, Screen
IniRead, LastScaleFactor, zoom.ini, LastScaleFactor, LastScaleFactor, 4
global Antialiasing := 0, global Zoom := 8, Paused := 1
global FPS := 60
global Zoom := LastScaleFactor
;global Zoom := 4
global MagSize := 300
global RefreshInterval:=(1000/FPS)
global WinDPI := A_ScreenDPI
global MagOffset := 433
global SRCCOPY:="0x00CC0020"
global Resize_complete :=

#B:: ;inverted colour toggle
Invert := !Invert
	if Invert 
		SRCCOPY:="0x00330008"
	else 
		SRCCOPY:="0x00CC0020"	; NOTSRCCOPY
return

#M::
if !Paused { 
	setTimer, Repaint, Off
	Gui, 2:Hide 
	Gui, Hide 
	Paused := 1
	Resize_complete := 
	return
} else {
	if !Resize_complete
		gosub Region_set
	gosub Init_Gui
	Paused :=
}

#if WinExist("ninjMag") 		; 	- to Zoom -
{ 
	^+Up:: 								; 	CTRL + SHIFT + M_WHEEL_UP / DOWN 
	^+Down::	 						; 	OR 
	^+WheelUp::                   	; 	KEYBOARD ARROW L / R to Zoom
	^+WheelDown::  	
	if (Zoom < 24 and ( A_ThisHotKey = "^+WheelUp" or A_ThisHotKey = "^+Up" )) {
		Zoom := round(Zoom *= 1.189)         ; cube root of 2))
		switch Zoom
		{
			case 3:
				Zoom = 4
			case 5:
				Zoom = 6
			case 7:
				Zoom = 8
			case 9:
				Zoom = 10
		}
	} else 
	if (Zoom >  1.0 and ( A_ThisHotKey = "^+WheelDown" or A_ThisHotKey = "^+Down" )) {
		Zoom := round(Zoom /= 1.189)
		switch Zoom
		{
			case 3:
				Zoom = 4
			case 5:
				Zoom = 4
			case 7:
				Zoom = 6
			case 9:
				Zoom = 8
		}	
	}
	Area_offset := 1.2*zoom
	;toolTip, MAG: %Zoom%00 Percent,A_ScreenWidth-235,A_ScreenHeight-300
	setTimer Tooloff, -2000
	return

	^+Left::	
	MagSize := MagSize + 4
	MagOffset := MagOffset + 4
	Resize_complete := 
	;setTimer Repaint2, -1
	return		

	^+Right:: 
	MagSize := MagSize - 4
	MagOffset := MagOffset - 4
	Resize_complete := 
	;setTimer Repaint2, -1
	return

}
	return



Init_Gui:
gui +AlwaysOnTop +Resize +owner +ToolWindow +LastFound
gui +Hwndninjmagid 	;Gui,Show,Hide ;get handle
winSet, Style, 0x96000000
;winSet, EXStyle, 0x00200008
	SetWinDelay -1

mouseGetPos x, y
Offset_Matt2 := zoom*1.5
Initial_X := (x-271) + Offset_Matt2 
Initial_Y := (y-271) + Offset_Matt2
HDD_Frame := DllCall("GetDC", UInt, PrintSourceID)
HDC_Frame := DllCall("GetDC", UInt, ninjMagID)
DllCall("gdi32.dll\SetStretchBltMode",Uint, HDC_Frame, int, 5)
;DllCall("gdi32.dll\StretchBlt",UInt,HDC_Frame, Int,0, Int,0, Int, MagSize , Int, MagSize , UInt, HDD_Frame, UInt,x-zx, UInt,y-zy, Int,2*Zx, Int,2*Zy, UInt, SRCCOPY)        
winSet, Region, 0-0 W%MagSize% H%MagSize% R%MagSize%-%MagSize%, ninjMag
if !Init_complete
	gui Show, w %MagSize% h %MagSize% x %Initial_x% y %Initial_Y% NoActivate, ninjMag
else 
	gui Show, w %MagSize% h %MagSize% x %XXX% y %YYY% NoActivate, ninjMag
Init_complete := 1
setTimer, Repaint, %RefreshInterval%


Region_set:
winSet, Region, 0-0 W%MagSize% H%MagSize% R%MagSize%-%MagSize%, ahk_id %ninjMagid%
Resize_complete := 1
return

Repaint:
if Resize_complete
 {
	SetWinDelay -1
	mouseGetPos x, y
	XXX := round((x-magoffset) + Area_offset)
	YYY := round((y-magoffset) + Area_offset)
	; if (XXX < 0) and if (YYY < 0)
	; {
		; XXX:=Abs(xxx)
		; yyy:=Abs(yyy)	
	; }
	if XXX < 0
	{
		xxx = 0
	}
	if YYY < 0
	{
		yyy = 0
		if (xxx > (x - (magsize+(magsize/3)) ))
			XXX := xxx - 30
			if XXX < 0
			{
				xxx = 0
			}
	}
	Zx := 300/Zoom
		Zy := 300/Zoom

/* 	
if ((xxx > (x - (magsize+(magsize/2.5)))) and if (xxx < (x +(magsize+(magsize/2.5))))) and if ((yyy > (y - (magsize+(magsize/2.5)))) and if (y < (y + (magsize+(magsize/2.5))))) {
		XXX := x + Area_offset 
		YYY := y + Area_offset
	} 
*/
	ViewX := 2*Zx
	ViewY := 2*Zy
	if ViewY < 0
		ViewY = 0	
	if ViewX < 0
		ViewX = 0

	ViewPos_X := x-zx
	ViewPos_Y := y-zy
	if ViewPos_X < 0
		ViewPos_X = 0
	if ViewPos_Y < 0
		ViewPos_Y = 0
	DllCall("gdi32.dll\StretchBlt",UInt,HDC_Frame, Int,0, Int,0, Int, magsize , Int, magsize , UInt, HDD_Frame, UInt,ViewPos_X, UInt,ViewPos_Y, Int,ViewX, Int,ViewY, UInt, SRCCOPY)        
	Win_Move(ninjMagID, XXX, YYY, MagSize, MagSize, 22) ; SWP_NOZORDER + SWP_NOACTIVATE

} else gosub Region_set
return

Repaint2:
mouseGetPos x, y
Zx := round(magsize/Zoom)
Zy := round(magsize/Zoom)
if Invert 
	SRCCOPY:="0x00330008"
else 
	SRCCOPY:="0x00CC0020"	; NOTSRCCOPY
DllCall("gdi32.dll\SetStretchBltMode",Uint, HDC_Frame, int, 5)
DllCall("gdi32.dll\StretchBlt",UInt,HDC_Frame, Int,0, Int,0, Int, MagSize , Int, MagSize , UInt, HDD_Frame, UInt,x-zx, UInt,y-zy, Int,2*Zx, Int,2*Zy, UInt, SRCCOPY)        
return

OnExit GuiClose 
GuiClose:
gosub Clear_up_gdi
IniWrite, %Zoom% , zoom.ini , LastScaleFactor, LastScaleFactor
exitapp

Clear_up_gdi:
Gui, 2:destroy 
Gui, destroy
DllCall("gdi32.dll\DeleteDC", UInt,HDC_Frame )
DllCall("gdi32.dll\DeleteDC", UInt,HDD_Frame )
DllCall("gdi32.dll\DeleteObject", UInt,HDC_Frame)
DllCall("gdi32.dll\DeleteObject", UInt,HDD_Frame)
return

tooloff:
tooltip
return
;========================================================================================

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


Win_Move(Hwnd, X="", Y="", W="", H="", Flags="") { ;	static bitmask SWP_NOMOVE=2, SWP_NOREDRAW=8, SWP_NOSIZE=1, SWP_NOZORDER=4, SWP_NOACTIVATE = 0x10, SWP_ASYNCWINDOWPOS=0x4000, HWND_BOTTOM=1, HWND_TOPMOST=-1, HWND_NOTOPMOST = -2

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

In(x,a,b)  { 
	IfLess x,%a%, Return a
	IfLess b,%x%, Return b
	Return x
}


