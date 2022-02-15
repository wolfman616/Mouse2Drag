#include C:\Script\AHK\- LiB\GDI+.ahk        	;	ninjMag by Matt Wolff
SetBatchLines -1                             	;	suggested to init from elevated script for hotkeys as below
#NoEnv											;	#M::  	
#SingleInstance force                        	;	+#M::	
#Persistent                                  	;	Mag_Path := "C:\Program Files\Autohotkey\Autohotkey.exe C:\Script\AHK\Working\M2DRAG_MAG.AHK", 
ListLines, Off                               	;	run % Mag_Path,
SendMode Input                               	;	return,
SetWinDelay -1                              	
SetWorkingDir %A_ScriptDir%                  	;	2022 
CoordMode Mouse, Screen                      	
IniRead, LastScaleFactor, zoom.ini, LastScaleFactor, LastScaleFactor, 4

menu, Tray, noStandard
menu, Tray, Icon, C:\Script\AHK\Working\search_32.ico
menu, Tray, Add, 	Inverted, invert,
menu, Tray, icon, 	Inverted, C:\Icon\20\invert goatse.ico
menu, tray, standard

global Antialias_on := 0, global Zoom := 8, global FPS := 60, global Zoom := LastScaleFactor, global MagSize := 300, global RefreshInterval := (1000/FPS), global WinDPI := A_ScreenDPI, global MagOffset := 333, global x, global y, global Area_offset := 1.2*zoom, global magoffset, global ninjMagID, global MagSize, global rim_, global Init_complete, global Offset_Matt2 

SS_BITMAP    	:= 	0xE
SS_ICON      	:= 	0x3
STM_SETIMAGE 	:= 	0x172IMAGE_BITMAP 	:= 	0x0
SRCCOPY			:= 	0x00CC0020

; TOP LEVEL WINDOW UIBAND (NOT WORKING YET) ninjMagID := DllCall("CreateWindowInBand", "uint", 0, "str", "Autohotkey", "str", "title", "uint", 0, "int", 0, "int", 0, "int", 200, "int", 200, "ptr", 0, "ptr", 0, "ptr", 0, "ptr", 0, "int", ZBID_UIACCESS := 2, "ptr")

mouseGetPos x, y
Offset_Matt2	:=	zoom 	* 	1.5 		;bodge to keep gui out of viewports gaze
Initial_X 		:= 	(x-271) + 	Offset_Matt2 
Initial_Y 		:= 	(y-271) + 	Offset_Matt2

Init_gui:
winSet, Style, 0x96000000
winSet, EXStyle, 0x00200008
winSet, Region, 0-0 W%MagSize% H%MagSize% R%MagSize%-%MagSize%, hwndHPI

gui, lens: new, +owner, ninjMag
gui, lens: +LastFound +Hwndninjmagid -Caption -DPIScale +disabled +AlwaysOnTop -SysMenu +ToolWindow +owndialogs
winSet, Style, 0x96000000
winSet, EXStyle, 0x00200008
gui, rim_:New, +hwndrim_y +Labelgui +parentlens +LastFound -Caption -DPIScale, ninjmag

gui, rim_:  +AlwaysOnTop +disabled -SysMenu +ToolWindow +owndialogs
gui, rim_:Add, Pic, w%MagSize% h%MagSize% hwndHPIC
WinSet, Transcolor, 000000 	;no alpha for now :(
if !Resize_complete
	gosub Region_set
mouseGetPos x, y
global Offset_Matt2 := zoom*1.5
Initial_X 	:= 	(x-271) + Offset_Matt2 
Initial_Y 	:= 	(y-271) + Offset_Matt2
HDD_Frame 	:= 	DllCall("GetDC", UInt, maindevicecontextblabla) 
HDC_Frame 	:= 	DllCall("GetDC", UInt, ninjMagID)
DllCall("UpdateLayeredWindow", "Uint", ninjMagID, "Uint", 0, "Uint", 0, "int64P", 300|300<<32, "Uint", HDC_Frame, "int64P", 0, "Uint", 0, "intP", 0xFF<<16|1<<24, "Uint", 16)
if !Init_complete {
	GdipToken := Gdip_Startup()
	blurdevi8X := 0.899,	blurdevi8Y := 0.899 	
	PBitMap := Gdip_CreateBitmap(300, 300)
	PGraphics := Gdip_GraphicsFromImage(PBitMap)
	Gdip_SetSmoothingMode(PGraphics, 4)
	PPath := Gdip_CreatePath(PGraphics)
	Gdip_AddPathEllipse(PPath, 0, 0, 300, 300)
	DllCall("Gdiplus.dll\GdipCreatePathGradientFromPath", "Ptr", PPath, "PtrP", PBrush)
	VarSetCapacity(POINT, 8)
	NumPut(300/2, POINT, 0, "Float")
	NumPut(300/2, POINT, 4, "Float")
	DllCall("Gdiplus.dll\GdipSetPathGradientCenterPoint", "Ptr", PBrush, "Ptr", &POINT)
	DllCall("Gdiplus.dll\GdipSetPathGradientCenterColor", "Ptr", PBrush, "UInt", 0x00000000)
	VarSetCapacity(COLOR, 4, 0)
	NumPut(0xaa00ff00, COLOR, 0, "UInt")
	COLORS := 1
	DllCall("Gdiplus.dll\GdipSetPathGradientSurroundColorsWithCount", "Ptr", PBrush, "Ptr", &Color, "IntP", COLORS)
	DllCall("Gdiplus.dll\GdipSetPathGradientFocusScales", "Ptr", PBrush, "Float", blurdevi8X, "Float", blurdevi8Y)
	Gdip_FillPath(PGraphics, PBrush, PPath)
	HBitmap := Gdip_CreateHBITMAPFromBitmap(PBitMap, 0x000000ff)
	;Control, Style, -%SS_ICON%, , ahk_id %HPIC%
	Control, Style, +%SS_BITMAP%, , ahk_id %HPIC%
	; Assign the bitmap
	SendMessage, STM_SETIMAGE, IMAGE_BITMAP, HBitmap, , ahk_id %HPIC%
	WinSet, Transcolor, 000000 		; 	doesnt need full alpha so this gui, is done for now
	hda_F := DllCall("GetDC", UInt, HPIC)
	DllCall("gdi32.dll\SetStretchBltMode", "Uint", hda_f, "Int", 5)
	DllCall("gdi32.dll\StretchBlt", "Uint",hda_f, "Int", 0, "Int", 0, "Int", 300 , "Int", 300 , "UInt", hd_frame, "UInt", 0, "UInt", 0, "Int", 300, "Int", 300, "UInt", "0x00440328")
	DllCall("UpdateLayeredWindow", "Uint", rim_y, "Uint", 0, "Uint", 0, "int64P", 300|300<<32, "Uint", hda_f, "int64P", 0, "Uint", 0, "intP", 0xFF<<16|1<<24, "Uint", 2)
	gui, lens: show
	gui, rim_: Show, x-16 y-10 ; h%MagSize% x%Initial_x% y%Initial_Y% NoActivate
} else { 
	tooltip, init complete	
	settimer, tooloff, -700
}
Init_complete := 1
StartTime := A_TickCount
loop {
	setTimer T_det, -1
	if toggling
		break
	if !Resize_complete
		gosub Region_set
	SetWinDelay -1
	mouseGetPos x, y
	XXX 	:= round((x-magoffset) + Area_offset), YYY := round((y-magoffset) + Area_offset)
	if XXX 	< 0
		XXX = 0
	if ( YYY < 0 ) {
		yyy = 0
		if (XXX	> (x - (magsize+(magsize/3)) ))
			XXX := XXX - 30
			if XXX	< 0
				XXX = 0
	}
	Zx 		:= 300/Zoom,	Zy 		:= 300/Zoom
	ViewX 	:= 2*Zx,		ViewY	:= 2*Zy
	if ViewY 	< 	0
		ViewY 	= 	0	
	if ViewX 	< 	0
		ViewX 	= 	0

	ViewPos_X := x-zx, 		ViewPos_Y := y-zy
	if ViewPos_X 	< 	0
		ViewPos_X 	= 	0
	if ViewPos_Y 	< 	0
		ViewPos_Y 	= 	0
	Win_Move(ninjmagid, XXX, YYY, MagSize, MagSize, 22) ; SWP_NOZORDER + SWP_NOACTIVATE
	DllCall("gdi32.dll\StretchBlt",UInt,HDC_Frame, Int,0, Int,0, Int, magsize , Int, magsize , UInt, HDD_Frame, UInt,ViewPos_X, UInt,ViewPos_Y, Int,ViewX, Int,ViewY, UInt, SRCCOPY)  
	DllCall("UpdateLayeredWindow", "Uint", rim_, "Uint", 0, "Uint", 0, "int64P", 300|300<<32, "Uint", HDD_Frame, "int64P", 0, "Uint", 0, "intP", 0xFF<<16|1<<24, "Uint", 2)
	DllCall("UpdateLayeredWindow", "Uint", ninjMagID, "Uint", 1, "Uint", 9, "int64P", 300|300<<32, "Uint", HDC_Frame, "int64P", 9, "Uint", 9, "intP", 0xFF<<16|1<<24, "Uint", 2)
}
return

Region_set:
winSet, Region, 0-0 W%MagSize% H%MagSize% R%MagSize%-%MagSize%, ahk_id %ninjMagid%
DllCall("UpdateLayeredWindow", "Uint", ninjMagID, "Uint", 0, "Uint", 0, "int64P", 300|300<<32, "Uint", HDC_Frame, "int64P", 0, "Uint", 0, "intP", 0xFF<<16|1<<24, "Uint", 2)
Resize_complete := 1
return

T_det:
if (ElapsedTime := A_TickCount - StartTime) > 1000
if KeyIsDown := GetKeyState("LWin", "P")
	if (KeyIsDown := GetKeyState("m", "P")) {	
		Paused := 1, Resize_complete := False
		gui, 2:Hide 
		gui, lens: Hide 
		toggling := True
	}
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
DllCall("UpdateLayeredWindow", "Uint", ninjMagID, "Uint", 0, "Uint", 0, "int64P", 300|300<<32, "Uint", HDC_Frame, "int64P", 0, "Uint", 0, "intP", 0xFF<<16|1<<24, "Uint", 2)
DllCall("UpdateLayeredWindow", "Uint", rim_y, "Uint", 0, "Uint", 0, "int64P", 300|300<<32, "Uint", hda_f, "int64P", 0, "Uint", 0, "intP", 0xFF<<16|1<<24, "Uint", 2)
return

OnExit guiClose 
guiClose:
gosub Clear_up_gdi
IniWrite, %Zoom% , zoom.ini , LastScaleFactor, LastScaleFactor
exitapp

Clear_up_gdi:
gui, 2:destroy 
gui, destroy
DllCall("gdi32.dll\DeleteDC", UInt,HDC_Frame )
DllCall("gdi32.dll\DeleteObject", UInt,HDC_Frame)
DllCall("gdi32.dll\DeleteDC", UInt,HDD_Frame )
DllCall("gdi32.dll\DeleteObject", UInt,HDD_Frame)
return

tooloff:
tooltip
return

;========================================================================================

Invert:
Invert := !Invert
	if Invert 
		SRCCOPY:="0x00330008"
	else 
		SRCCOPY:="0x00CC0020"	; NOTSRCCOPY
return

#B:: ;inverted colour toggle
settimer invert, -1
return

#M::
exitapp


; if (!Paused or (paused := 0)) { 
;;	menu, tray, noIcon
	; gui, 2:Hide 
	; gui, Hide 
	; Resize_complete := 
	; Paused := 1

; } else {
	; if paused {
; tooltip rim_ %paused%
		; menu, Tray, Icon, C:\Script\AHK\Working\search_32.ico
		; toggling := False
		; Paused :=
; exitapp
		; gosub Init_gui
	; }
; }
; return



In(x,a,b)  { 
	IfLess x,%a%, Return a
	IfLess b,%x%, Return b
	Return x
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
