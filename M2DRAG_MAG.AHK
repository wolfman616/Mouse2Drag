SetWorkingDir %A_ScriptDir% 
#NoEnv
#SingleInstance force
#Persistent
SendMode Input  
SetBatchLines -1
;#NoTrayIcon
Gui +AlwaysOnTop +disabled 
CoordMode Mouse, Screen
IniRead, LastScaleFactor, zoom.ini, LastScaleFactor, LastScaleFactor , 4
global Zoom:=LastScaleFactor
Paused:=0
FPS = 4
global RefreshInterval:=(1000/FPS)
global Antialiasing = 0
global WinDPIMultiplicator := A_ScreenDPI / 144
global Rx = 256 									; half vertical/horizontal side of ninjMag window
global Ry = 230
global rox := round(Rx/WinDPIMultiplicator)
global roy := round(Ry/WinDPIMultiplicator)
global Zx := round(Rx/Zoom) 							
global Zy := round(Ry/Zoom)
Gui Show, , ninjMag
Gui, Hide 
gosub faggbot
#M::
   if !Paused
		{ 
		Gui, 2:Hide 
		Gui, Hide 
		SetTimer, Repaint, Off
		Paused = 1
		}
   else
		{
gosub faggbot


		Paused :=
		}
return

#if WinExist("ninjMag")
	{ ; Conditional pass through
	^+Up::							
	^+Down::	 							
	^+WheelUp::                      ; Ctrl+Shift+ WHEEL or ARROW to Zoom
	^+WheelDown:: 
	ToolTip, MAG: %Zoom% Percent,A_ScreenWidth-235,A_ScreenHeight-300
	settimer tooloff, -2000
	If (Zoom < 39 and ( A_ThisHotKey = "^+WheelUp" or A_ThisHotKey = "^+Up" ))
		Zoom *= 1.189207115         ; cube root of 2))
	If (Zoom >  1 and ( A_ThisHotKey = "^+WheelDown" or A_ThisHotKey = "^+Down" ))
		Zoom /= 1.189207115
	Zx := Rx/zoom
	Zy := Ry/zoom
return
	}

In(x,a,b)  { 
	IfLess x,%a%, Return a
	IfLess b,%x%, Return b
	Return x
	}

Repaint:
	MouseGetPos x, y
	xz := In(x-Zx-6,0,A_ScreenWidth-2*Zx) ; keep  frame on screen
	yz := In(y-Zy-6,0,A_ScreenHeight-2*Zy) ; 
	WinMove Frame,,%xz%, %yz%, % 2*Zx, % 2*Zy 
DllCall("gdi32.dll\SetStretchBltMode", uint, hdc_frame, int, 4)
	DllCall("gdi32.dll\StretchBlt", UInt,hdc_frame, Int,0, Int,0, Int,2*Rx, Int,2*Ry, UInt,hdd_frame, UInt,xz, UInt,yz, Int,2*Zx, Int,2*Zy, UInt,0xCC0020)        
	; SRCCOPY
	Return

tooloff:
	tooltip
	return
faggbot:
{
	Menu, Tray, Icon, search_32.ico
	X_OUT:=A_ScreenWidth-Rox
	Y_OUT:=A_ScreenHeight-Roy
	Gui Show, w %Rx% h %Ry% x %X_OUT% y %Y_OUT% NoActivate , ninjMag    ;bottom right
	WinGet ninjMagID, id, ninjMag
	WinSet, Style, 0x10000000,ninjMag 
	WinSet, ExStyle, 0x08000008, ninjMag
	WinSet Transparent, 0, ninjMag 
	WinSet Transparent, 255, ninjMag 
	WinGet PrintSourceID, ID
	hdd_frame := DllCall("GetDC", UInt, PrintSourceID)
	hdc_frame := DllCall("GetDC", UInt, ninjMagID)
	SetTimer, Repaint, %RefreshInterval%
	return
	}

GuiClose:
	{
	DllCall("gdi32.dll\DeleteDC", UInt,hdc_frame )
	DllCall("gdi32.dll\DeleteDC", UInt,hdd_frame )
	IniWrite, %Zoom% , zoom.ini , LastScaleFactor, LastScaleFactor
	exitapp
	}

OnExit GuiClose 
