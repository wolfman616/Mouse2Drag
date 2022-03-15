/*
	Ever wanted to be cooler than a linux user? How about rightclick mouse-dragging windows? One-handed's always better!
	
	*Right-Mouse-Button / Mouse-2:                                                                            (*default) 
	Drag any Window under cursor! Behaviour can be changed to only drag whitelisted, or alldrag except Blacklist*  

	*Left-Mouse-Button / Mouse-1:
	Resize window during drag. 		
	
	Ctrl & Win & middleclicK (MouseWheel):                                                  (Ctrl&Win&C to copy details) 
	WindowSpy Info details toggle. Once active, Hover and see Classnames and other usefull info,
	
	Innovative way of deciding how desired white/blacklistings are to be detected in future 
	Setting to Activate* window or not when drag.
	Ability to reindex Z-order of windows.
	Option to Click on any 3rd party tooltips to copy content and hide.
	Universal mousewheel in hot / hovered applications / menus.
	Registry saving of black/whitelists.

	(Quit application hotkey default = Ctrl & Shift & Win & RightClick (MouseWheelButton).)	
	More to be added.                                                                                    Matt Wolff 2022
*/			
#noenv
#persistent
#installmousehook
#KeyHistory,            0
ListLines,              Off
#singleinstance,        Force
coordMode,              Mouse, screen
coordMode,              Pixel, screen
SendMode,               Input
SetMouseDelay,         -1
#MaxThreadsPerHotkey,   10
#MaxHotkeysPerInterval, 1400
setBatchLines,         -1
setWinDelay,           -1
setWorkingDir,%         A_ScriptDir
settitlematchmode,      2 
;---------------------------------------------------------------------------------------
#Include <gdi+_all>
#Include <LayeredWindow> 
#Include <circle>
;---------------------------------------------------------------------------------------
gosub, Varz 
gosub, Blacklist_RegRead
gosub, Blacklist_ParseArr
gosub, Menu_Init
;---------------------------------------------------------------------------------------
Mane:
; Ignore ;;	:; sendlevel 1    ; #include ns.ahk ;gosub, _Feed_	;#WinActivateforce ;coordMode, tooltip, screen;

onExit, Clean_Up_your_mess    ; BLACKLIST-Window-ClassES

WM_Allow()                    ; allow foreign window-message ; ( not really working )

OnMessage(0x4a, "Receive_WM_COPYDATA") ; 0x4a is WM_COPYDATA

wm_allow()

reload_Adminhk()

hotkey, % MD_Bind, m2Drag, On ; P ; Priority

CUR_FX_Enabled    :=  false 
Trailz_enabled    :=  false
curhilite_enabled :=  False
settimer CUR_FX_Enable, -1
return, ;--------=========    ; end of script   ; end of script   ; end of script   ; end of script   ; end of scr

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;         Binds       Binds       Binds       Binds       Binds       Binds       Binds       Binds       Binds                                          
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~^NumpadDot::exit 	;>=====   CTRL=NUMPAD=DOT   ====>(  -NORMAL=RIGHT=CLICK-  )=====<
MButton::
mouseGetPos, X_,  Y_, 	hVund, 	cVund
winGet PN, ProcessName, ahk_id %hVund%
winGetTitle	TI, 		ahk_id %hVund%
winGetClass	CN, 		ahk_id %hVund%	
if EXPLORER_MMB_OPENINNEW 				{
	if (PN = "explorer.exe")  			{ 		; ((CN = "CabinetWClass") && 
		mouseGetPos, , , , cVund
		if( cVund  =  "SysTreeView321") 	{   ; msgbox % analtrackfield := Explorer_GetSelection(hWnd=hVund) 	
			    send, ^{LButton}	                ; NOT WORKING Either :/
}	}	} else, send,  {MButton}
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~^+rButton:: 									;REGULAR RCLICK	 ; CTRL + SHIFT + RIGHTCLICK
sendInput, { rButton }
; if  !p_count
	 ; p_count :=  1
; else p_count +=  1
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#+LButton::PostMessage_2CursorWin(0x111, 41504, 0)
if ErrorLevel
	tooltip, %ErrorLevel% Error
setTimer, ToolOff, -1000
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#+rButton::PostMessage_2CursorCTL(0x111, 41504, 0)
if ErrorLevel
	tooltip, %ErrorLevel% Error
setTimer, ToolOff, -1000
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#MButton::
gosub, 	winGetTransparency
gosub, 	WinSetTransparency
gosub, 	tooltipCreate
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^2::
gosub, 	winGetTransparency
Opacit0 	-= 	10
gosub, 	WinSetTransparency
gosub, 	tooltipCreate
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^3::
gosub, 	winGetTransparency
Opacit0 	+= 	10
gosub, 	WinSetTransparency
gosub, 	tooltipCreate
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^f7:: 			; 		_-========set dwm blur Window========-_
mouseGetPos, , , swindow, control2
if !(swindow || control2)
	tooltip no handle to window or Old_call
SetAcrylicGlassEffect(bgrColor, 17, ahk_id swindow)
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^+f7:: 			;	 _-========set dwm blur Control handle========-_
mouseGetPos, , , swindow, control2
if !(swindow || control2)
tooltip no handle to window or Old_call
ControlGet, Old_call, hWnd ,,%control2% , ahk_id %swindow%
SetAcrylicGlassEffect(bgrColor, 17, ahk_id %Old_call%)
SetAcrylicGlassEffect(bgrColor, 17, ahk_id %control2%)
tooltip %Old_call%
settimer tooloff, -3000
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
^#Mbutton::    ;      CTRL + WIN + MIDDLE=MOUSE ( aKa MOUSEWHEEL BUTTON )
Handle_Handler_Toggle:
if !Handle_Handler_Active {
	menu, submenu1, check, Handle Handler,
	setTimer CursorTip, 300
	Handle_Handler_Active := True
	hotkey, ~^#c, HandlerCopyinfo
	return,
	HandlerCopyinfo: 				; 								 CTRL WIN C
	if WindowUnderCursorInfo
		CopyOF_ := True
	mouseGetPos, X_Cursor, Y_Cursor, Window, Control
	clipboard := GetUnderCursorInfo(X_Cursor, Y_Cursor)	; copy Window info
	Handle_Handler_Active := !Handle_Handler_Active
	WindowUnderCursorInfo := "", CopyOF_ := ""
	Handle_Handler_Active := !Handle_Handler_Active 	; TOGGLE - INFO - DISPLAY
	return,
} else {	
	hotkey, ^#c, off
	menu, submenu1, uncheck, Handle Handler,
	sleep 100
	setTimer, CursorTip, off
	setTimer, tooltipdestroy, -1750
	WindowUnderCursorInfo := ""
}
Handle_Handler_Active := !Handle_Handler_Active 	    ; TOGGLE - INFO - DISPLAY
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~!rbutton:: 	; 		ALT + Rbutton   -	 WinEvent/Style/Bypass Menu   
mousegetpos, , , RBhWnd
DragbypassClass_new_possible := "ahk_id " . RBhWnd
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#F10:: 			 ;		Wacom Barrel 1 Button
if(a_thishotkey  =  "#F10")        {
	MD_Bind		:=  "F10" 
	MD_Meth		:=  "L"
}
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
m2Drag:			;		M2Drag MOUSE 2  	 <========================= 		BEGINS   
mouseGetPos, X_mSt4, Y_MSt4, RBhWnd, rbcnthwnd
wingetpos,   X_Win,  Y_Win,  W_Win,  H_Win,% ( idd := ("ahk_id " . RBhWnd) )
;wingetclass, clssrb,% idd
if(a_thishotkey	=  "rButton" )     {
	MD_Bind	   :=  a_thishotkey	
	MD_Meth    :=  "P"
}
if (Bypass_title_True || Bypass_pname_True || Bypass_Class_True) {
	gosub, m2dReady
	return,
}
if !RB_D                           {
	gosub, corner_offset_get
	gosub, position_offset_get
	RB_D := True
}
if (EvaluateBypass_Class(RBhWnd) ) {
	Bypass_Class_True :=	True
	gosub, BypassDrag
	return,
}
else
if (EvaluateBypass_Proc(RBhWnd) )  {
	Bypass_pname_True :=	True
	gosub, BypassDrag
	return,
}
else
if (EvaluateBypass_Title(RBhWnd) ) {
	Bypass_title_True :=	True
	gosub, BypassDrag
	;==----============----
	return,
} else {
	M2_Drag_Ready:
	mouseGetPos, X_Cursor, Y_Cursor,
	if !M1_Trigger {
		X_WinS := X_Win,	Y_WinS := Y_Win
		W_WinS := W_Win,	H_WinS := H_Win
		if MD_Activ8Def
			winactivate,%  ("ahk_id " RBhWnd)
		if winexist(FF_ContextClass) 	;	 Firefox menu
			winClose
		else if winexist(ContextClass) 			;	 normal menus
		;if ; := "#32768"
		winClose
}	}			
;---------------------------------------------------------------------------------------
m2dReady: ;res:=Send_WM_COPYDATA(RBhWnd, admhk) tooltip % res NOT WORKING
while (getKeyState(MD_Bind, MD_Meth)) {
	mouseGetPos, X_Cursor, Y_Cursor,
	wingetpos, X_Win, Y_Win, , ,%  ("ahk_id " RBhWnd)
	
	gosub, position_offset_get
	if ( X_Cursor != X_Old ) and ( Y_Cursor != Y_Old ) {
		if !(getKeyState("LButton", "P") ) {
			Xnet := x_Cursor - x_MSt4
			Ynet := (y_Cursor - y_MSt4)
			ww := ""  ,  HH := ""
		} else {
			mousegetpos,  X_mSt4,   Y_MSt4
			wingetpos,    X_Wins,   Y_Wins,   W_Wins,   H_Wins,%  ("ahk_id " RBhWnd)
			ww := WII, HH := HII
		}
		x0x	:= (X_Wins + Xnet)	,  y0y := (Y_Wins + Ynet)

		if !(getKeyState("LButton", "P") ) {
			if M1_Trigger {
				mousegetpos, 	X_mSt4, 	Y_MSt4
				wingetpos, 		X_Wins, 	Y_Wins, 	W_Wins, 	H_Wins,%  ("ahk_id " RBhWnd)	
				x0x	:= (X_Wins)	
				y0y := (Y_Wins)		;gosub, position_offset_get ;gosub, corner_offset_get ;gosub, DimensionChk
				Win_Move(RBhWnd, x0x, y0y,,, "")
			}
			if !lbdd 
				Win_Move(RBhWnd, x0x, y0y,,, "")
		} else {
			gosub, position_offset_get
			gosub, corner_offset_get
			gosub, DimensionChk
		}
		if !XYThresh {			; 		Movement-thresh, afterwhich single click is	; 	Add a time thresh too
			if (X_Cursor<X_mSt4-25) || (X_Cursor>X_mSt4+25) || (Y_Cursor<Y_MSt4-25) || (Y_Cursor>Y_MSt4 +25) {
				if !triglb1 {
					DragbypassClass_new_possible = ("ahk_id " RBhWnd)
					menu, tray, add, Bypass the last Dragged window, Bypass_Last_Dragged_GUI,
					Dragbypassmenu_enabled := True
					XYThresh := True
			}	}
		} else { 				; 		XYThresh has procced..... 
		;PROB HEERE :(
			Status_M2Drag := True 	; 		m2drag begins  _>
			if (getKeyState("LButton", "P") ) {
				if !M1_Trigger {								
					M1_Trigger := True
					M1Resize := True
					x0x	:= (X_Wins + Xnet)	
					y0y := (Y_Wins + Ynet)
					gosub, corner_offset_get
					gosub, position_offset_get
				}
				settimer Watch_Lb, -1
			} else,	M1_Trigger := False, M1Resize := False
	}	}	

	if !insight {
		winGet, m2d_WinState, MinMax, ahk_id %RBhWnd%
		CursorChange := 1, insight := 1
		if (m2d_WinState = 1) { ; maximized
			while (getKeyState(MD_Bind , MD_Meth) ) {
				if !XYThresh {
					if (X_Cursor<X_mSt4 -25) || (X_Cursor>X_mSt4 +25) || (Y_Cursor<Y_MSt4 -25) || (Y_Cursor>Y_MSt4 +25) {
						XYThresh := True
						DragbypassClass_new_possible =ahk_id %RBhWnd%
						mouseGetPos, X_mSt4, Y_MSt4, RBhWnd
						wingetpos, X_Win, Y_Win, W_Win, H_Win, ahk_id %RBhWnd%
					} else {
						mouseGetPos, X_Cursor, Y_Cursor
						if (X_Cursor<(X_mSt4-25)) || (X_Cursor>(X_mSt4+25)) || (Y_Cursor<(Y_MSt4-25)) || (Y_Cursor>(Y_MSt4+25)) {
							m2d_MidW 	:= A_ScreenWidth/3, 	m2d_MidX := X_Cursor-(W_Win/2)
							m2d_MidY 	:= Y_Cursor-(H_Win/3), 	m2d_MidH := A_ScreenHeight/2
							winRestore, ahk_id %RBhWnd%
							wingetpos, X_Win, Y_Win, W_Win, H_Win, ahk_id %RBhWnd%
							Win_Move(RBhWnd, m2d_MidX, m2d_MidY, , ,  "")
			}	}	}	}
			if XYThresh
				DragbypassClass_new_possible =ahk_id %RBhWnd%
	}	}
	sleep 1
} 		;		end of main "Mdrag while-loop"					
Status_M2Drag := False, M1Resize := False, RB_D := False, M1_Trigger := False
settimer, cleanRBVars, -1

if !XYThresh 		;		mouse released without moving past thresh
	sendInput, {%MD_Bind%}
if M1Resize
	settimer m1_resizeGO, -1
insight := "", XYThresh := False ;, ; M1Resize := False
return,
;[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[
testi: ;==----============----
if (EvaluateBypass_Class(RBhWnd) ) {
	Bypass_Class_True :=	True
	return,
}
else
if (EvaluateBypass_Proc(RBhWnd) ) {
	Bypass_pname_True :=	True
	return,
}
else
if (EvaluateBypass_Title(RBhWnd) ) {
	Bypass_title_True :=	True
	return,
}
return,
;[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[
BypassDrag:
;click, down, right    ;[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]

SEND {%MD_Bind% DOWN}
mousegetpos, 	X_mSt4, 	Y_MSt4
wingetpos, 		X_Win, 		Y_Win, 		W_Win, 		H_Win, 		ahk_id %RBhWnd%

if !XYThresh { ; threshold of xy movement, afterwhich no longer a standard right click
	while (getKeyState(MD_Bind, MD_Meth) ) {
		getKeyState, KSLB, %MD_Bind%, %MD_Meth%
		if (KSLB  =  "D")
		lbdd     :=  True
		mousegetpos, X_Cursor, Y_Cursor
		wingetpos,   X_Win,    Y_Win,  W_Win,  H_Win,%  ("ahk_id " RBhWnd)
		if (X_Cursor<X_mSt4-25) || (X_Cursor>X_mSt4+25) || (Y_Cursor<Y_MSt4-25) || (Y_Cursor>Y_MSt4+25) {
			if !triglb1 {
				DragAllowClass_new_possible =ahk_id %RBhWnd%
				menu, tray, NoStandard
				menu, tray, add, Add last attempted window drag to whitelist, Open_Options_GUI,
				menu, tray, standard
				XYThresh := True, DragAllowMenu_enabled := True	, triglb1 := True
		}	}
		sleep, 1
}	}
send {%MD_Bind% Up}
insight := "", XYThresh := False, triglb1 := False, Bypass_Class_True := False, 	Bypass_pname_True := False, lbdd := False,	Bypass_title_True := False	
settimer, cleanRBVars, -1
return,

BypassDrag2:
send { %MD_Bind% Down }
while getKeyState(MD_Bind, MD_Meth) 
	sleep 5
send {%MD_Bind% Up}

insight := "", XYThresh := False, triglb1 := False
return,

m1_resizeGO:
mousegetpos, X_Cursor, Y_Cursor
;gosub, corner_offset_get
gosub, DimensionChk
return,

getKeyState, KSLB, LButton, P
if (KSLB = "D") {
	if LB_U {
		M1_Trigger := False
		LB_U       := False	; ?
	}
} else, settimer m1_resizeGO, off		
RB_D := False, triglb1 := False, XYThresh := False
return,

Watch_Lb:
if !OC1 {
	wingetpos, X_Win, Y_Win, , , ahk_id %RBhWnd%
	Y_MSt4 :=  Y_Cursor,      X_mSt4 := X_Cursor, 
	OC1 := True
}
x_NET := X_mSt4 - X_Cursor
if (x_NET  !=  x_NETold )
	W_Win  :=  W_Win + x_NET, X_mSt4 := X_Cursor
y_NET := Y_MSt4 - Y_Cursor
if (y_NET  !=  y_NETold)
	H_Win  :=  H_Win + y_NET, Y_MSt4 := Y_Cursor
x_NETold   :=  x_NET, y_NETold := y_NET
if LB_U {
	getKeyState, KSLB, %MD_Bind%, %MD_Meth%
	if (KSLB = "U") {
		settimer m1_resizeGO, off
		LB_U := True
	}
}
RB_D := False, triglb1 := False
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; +F9:: 
; TT("Nib Down")
; sendinput {LButton Down}
; return,
; +F9 up::
; TT("Nib Up")
; sendinput {LButton Up}
; return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
LButton::		
lbdd:=True
mousegetpos,,,LB_hWnd,LB_cWnd,2
WinGetClass, LB_Class, ahk_id %LB_hWnd%
if !Status_M2Drag {
	send {Lbutton Down}
	;send {LButton up}
	return,
}
else {	;PostMessage, 0x00A1, 17, ahk_id %LB_cWnd%
	if( LB_Class = "CabinetWClass") {
		while getKeyState("LButton", "P") {
			settimer position_offset_get2, 1	; Win_Move(RBhWnd, x0x, y0y, wii, Hii, "")
			sleep 1								; settimer m1_resizeGO, -1
		}
		return,									; if !getKeyState("LButton", "P") 
}	}											; return,			
return,

; LB_hWnd := ("ahk_id" . LB_hWnd), 	LB_cWnd := ("ahk_id" . LB_cWnd)
; WinGetClass, LB_ClassN, %LB_hWnd%
; mousegetpos, X, Y,
;; switch, LB_ClassN {
	;; case "#32770":			;  			( msgboX )
	;; {
		;; click left down
		;; WinGetClass, class_active, A

	  ;; if !(class_active = LB_ClassN || class_prev) 	;	 reveals performance issue with target app making not ontop and active after clicking 
		;; {
			;; Tooltip Inc Class`n%class_active%`n%LB_ClassN%
			;; sleep 300
			;; WinGetClass, class_active, A
		;; }
		;; while getKeyState("LButton", "P")
			;; sleep 1		
	;; }

;; }

; switch, class_active 
; {
	 ; case "DropDown":
	 ; {
		; msgBox, 4, Would you like to Close Dropdown?, 5 
		; IfMsgBox, Yes								; 5-sec timeout.
			; winclose,
		; if ((IfMsgBox, No) || (IfMsgBox, Timeout))
			; return,
		; return,
	 ; }
	; case "#32770":									; (msg box class)
	; { 												; #IfWinActive ahk_exe notepad++.exe
		; global BlackList_MBoxTXT_PNAME := "notepad++.exe"
		; oldclip := clipboard
		; Active_hwnd := (WinExist("A"))
		; WinGet, Active_PName, ProcessName, ahk_id %Active_hwnd%
		; WinGetActiveStats, Title, Width, Height, X, Y
		; if (Active_PName not in BlackList_MBoxTXT_PNAME) {
			;; tooltip % Title . " " . Width . " " . Height . " " . X . " " . Y . "`n" . Active_PName
			; winGetText, MsgBox_Txt, %LB_hWnd% 		; ahk_class #32770
			; ifInString, MsgBox_Txt, *
				; clipboard := MsgBox_Txt
			; else {
				; tt("trying to copy window-txt with ctrl-C")
				; send ^C
				; sleep 200
				; if Clipboard =% oldclip
					; tt("ctrl-c Failed")
		; }	}
		; return,
	; }
	; case "tooltips_class32":
	; {
		; ControlGetText, tooltiptxt,, %LB_hWnd%
		; clipboard := tooltiptxt
		; tooltip, Copied tool-tip, X, (Y+25)
		; sleep 888
		; WinClose
		; return,
	; } 
; return,
; }
; if Status_M2Drag
	; LB_D := True
; if !Status_M2Drag
	;;click left down
	; send {Lbutton down}
; while getKeyState("LButton", "P")
	; sleep 1
						; lbdd:=False
; send {Lbutton up}
; LB_D := False
; LB_U := True
; return,
;~$LButton UP:: 

;[[[[[[][[[[[[[[[[[[][[[[[[[[[[[[][[[[[[[[[[[[[][[[[[[[[[[[][][][][][][][][]
lbutton Up:: ;[[[[[[][[[[[[[[[[[[][[[[[[[[[[[[][[[[[[[[[[[[[][[[[[[[[[[[][][
settimer position_offset_get2, off
mousegetpos, 	X_mSt4, 	   Y_MSt4
wingetpos, 		X_Wins, 	   Y_Wins, 	W_Wins, H_Wins,% ("ahk_id " RBhWnd)
x0x	   := (Xnet+X_Wins), y0y:=(Y_Wins + Ynet)
gosub, corner_offset_get
gosub, position_offset_get
gosub, DimensionChk
lbdd	:=False
IF !LB_U
	 LB_U := True
LB_D := False
settimer cleanlbvars, -1
click left up
fff := False
return,
; ~^Lbutton up::  ; ~$Lbutton up:: ; ~^Lbutton up::  ; ~$Lbutton up:: ; ~^Lbutton up::  ; ~$Lbutton up:: ; ~^Lbutton up::  ; ~$Lbutton up:: 
; return,
cleanLBVars:
LB_ClassN_old := LB_ClassN, LB_ClassN := "", class_active := "", LB_hWnd := "", LB_cWnd := "", LB_D := False
return,
cleanRBVars:
Bypass_Class_True := False,  Bypass_pname_True := False,  Bypass_title_True := False	
HII := 0, WII := 0, x0x := 0, y0y := 0, ww := 0, HH := 0,
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;[[[[[[][[[[[[[[[[[[][[[[[[[[[[[[][[[[[[[[[[[[[][[[[[[[[[[[][][][][][][][][]
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;[[[[[[][[[[[[[[[[[[][[[[[[[[[[[[][[[[[[[[[[[[[][[[[[[[[[[[][][][][][][][][]
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#lbutton:: 	; Press Win+LB to turn off transparency for the Window under the mouse.
mouseGetPos,,, MouseWin
WinSet, TransColor, Off, ahk_id %MouseWin%
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#!g:: ; Press Win+G to show the current settings of the Window under the mouse.
mouseGetPos,,,MouseWin
winGet, Transparent, Transparent, ahk_id %MouseWin%
winGet, TransColor, TransColor, ahk_id %MouseWin%
tooltip `n Translucency:`n%Transparent%`nTransColor:`t%TransColor%
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
WheelUp::
WheelRight::
For key, value in ClassImgglass           	{
	if (winactive(("ahk_class " . value)))	{
		sendinput, {left}
		trig := true
		settimer, resettrig, -2000
		exit,
}	}
if !trig 
	sendinput,% "{WheelUp}"
return,
WheelDown::
WheelLeft::
For key, value in ClassImgglass         	{
	if (winactive(("ahk_class " . value)))	{
		send {right}
		trig := true
		settimer, resettrig, -2000
		exit,
}	}
if !trig 
	send,% "{WheelDown}"
return,
resettrig:
trig:=False
return

; +^WheelUp:: 	 		;>====FIX icons on desktop as zooming====>
; mouseGetPos, X_Cursor, Y_Cursor, ahk_id_CHECK
; winGetClass, AHK_Class_check, ahk_id %ahk_id_CHECK%,,
; if(AHK_Class_CHECK= "WorkerW") || (AHK_Class_CHECK="Progman")
	; Dtop_icons_Restore()
; return,
; +^WheelDown::
; mouseGetPos, X_Cursor, Y_Cursor, ahk_id_CHECK
; winGetClass, AHK_Class_check, ahk_id %ahk_id_CHECK%,,
; if (AHK_Class_CHECK= "WorkerW") || (AHK_Class_CHECK="Progman")
	; Dtop_icons_Restore()
; return,
; HOTKEY, +^WheelUp


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#c::
curFX_Toggle:
if !CUR_FX_Enabled
	  setTimer, CUR_FX_Enable,  -1
else, setTimer, CUR_FX_Disable, -1
gosub Menu_Init
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
F20::
f16::				; 	Wheel L = "page UP" without interfering with selection
^f16::
;tooltip % a_thishotkey "`n" ass
active_id := winexist("A")
winGetClass, 		Active_WinClass , A
mouseGetPos,,, 		Mouse_hWnd, Mouse_ClassNN
winGetClass, 		Mouse_WinClass , ahk_id %Mouse_hWnd%
 if (active_id != %Mouse_hWnd%)	
{ ; IE UNFOCUSED
		winexist(("AHK_Id " . Mouse_hWnd))

	if Mouse_WinClass in MozillaWindowClass,MozillaCompositorWindowClass,Chrome_WidgetWin_1
		ControlSend, ahk_parent, {f1}, ahk_id %Mouse_hWnd%
	else
	if Mouse_WinClass in CabinetWClass,Notepad++,RegEdit_RegEdit,#32770,MainWindowClassName,TMainForm
	{
		if ( A_Thishotkey = "^f16" ) || ( A_Thishotkey = "^f20" )  {
			sendinput ^{home}
			ControlSend, %Mouse_ClassNN%, ^{home} , ahk_id %Mouse_hWnd%
	}	 
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
{
	if ( A_Thishotkey = "^f16" ) || ( A_Thishotkey = "^f20" )  {
			sendinput ^{home}
	} else {
		if Mouse_ClassNN in DirectUIhWnd2,DirectUIhWnd3,Windows.UI.Core.CoreWindow
			SendMessage, 0x115, 2, 2, ScrollBar2, ahk_id %Mouse_hWnd%
		else
			SendMessage, 0x115, 2, 2, %Mouse_ClassNN%, ahk_id %Mouse_hWnd%
	}
}
else 
if Mouse_WinClass in MozillaWindowClass,MozillaCompositorWindowClass,Chrome_WidgetWin_1
{
	if ( A_Thishotkey = "^f16" ) || ( A_Thishotkey = "^f20" ) 
		send ^{f1}
	else
		ControlSend, ahk_parent, {f1}, ahk_class %Mouse_WinClass%
}
else
	Send, { PgUp }
active_id     :=
Mouse_hWnd    :=
Mouse_WinClass:=
Mouse_ClassNN :=	
return,

F19::
f17::		; 	Wheel r = page down without interfering with selection
^f17::
winGetClass, 	Active_WinClass , A
active_id := winexist("A")
mouseGetPos,,,	Mouse_hWnd, Mouse_ClassNN
winGetClass, 	Mouse_WinClass , ahk_id %Mouse_hWnd%
if (Mouse_hWnd != active_id) { 	; 	unfocused
 		winexist(("AHK_Id " . Mouse_hWnd))
 	if Mouse_WinClass in MozillaWindowClass,MozillaCompositorWindowClass1,Chrome_WidgetWin_1
		ControlSend, ahk_parent, {f2},  ahk_id %Mouse_hWnd%
	else
	if Mouse_WinClass in CabinetWClass,Notepad++,RegEdit_RegEdit,#32770,MainWindowClassName,TMainForm
	{
		if ( A_Thishotkey = "^f17" ) || ( A_Thishotkey = "^f19" )  {
			ControlSend, %Mouse_ClassNN%, ^{end} , ahk_id %Mouse_hWnd%
		}
		if Mouse_ClassNN in DirectUIhWnd2,DirectUIhWnd3
			SendMessage, 0x115, 3, 2, ScrollBar2, ahk_id %Mouse_hWnd%
		else
			SendMessage, 0x115, 3, 2, %Mouse_ClassNN%, ahk_id %Mouse_hWnd%
	} else
	if Mouse_ClassNN=WindowsForms10.Window.8.app.0.34f5582_r6_ad1
		ControlSend, %Mouse_ClassNN%, { Right } , ahk_id %Mouse_hWnd%
	else 
		ControlSend, , { PgDn }, ahk_id %Mouse_hWnd%
		
} else 		; FOCUSED
if Mouse_WinClass in CabinetWClass,Notepad++,RegEdit_RegEdit,#32770,MainWindowClassName,TMainForm
{
	if ( A_Thishotkey = "^f17" ) || ( A_Thishotkey = "^f19" )  {
		;if Mouse_WinClass = Notepad++
			send ^{end}
	} else {
		if Mouse_ClassNN in DirectUIhWnd2,DirectUIhWnd3
			SendMessage, 0x115, 3, 2, ScrollBar2, ahk_id %Mouse_hWnd%
		else
			SendMessage, 0x115, 3, 2, %Mouse_ClassNN%, ahk_id %Mouse_hWnd%
	}
} else
if Mouse_WinClass in MozillaWindowClass,MozillaCompositorWindowClass1,Chrome_WidgetWin_1
{
	if (( A_Thishotkey = "^f17" ) || ( A_Thishotkey = "^f19" ) )
		send ^{f2}
	else
		ControlSend, ahk_parent, {f2}, ahk_class %Mouse_WinClass%
}
else 
	Send, { PgDn }
	
active_id :=
Mouse_hWnd:=
Mouse_WinClass:=
Mouse_ClassNN:=	
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ctrl_hwnd_bg:
sleep 50
CColor(ControlhWnd, Background="0x000000", Foreground="0x000000") 
r00la(byref x, byref y) {
	winGetActiveTitle, Atitle
	winGetClass, aClass, %atitle%,,
	krabx:= Abs(X_Cursor-x)
	Kraby := Abs(Y_Cursor-y)
	R_return := " "X_Cursor ", " Y_Cursor "`n"
	. "X:" krabx " Y:" kraby ""
	return, R_return
}

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
return,

GetUnderCursorInfo(ByRef X_Cursor, ByRef Y_Cursor) {
	coordMode mouse, screen
	coordMode Pixel, screen
	mouseGetPos, X_Cursor, Y_Cursor, Window, Control
	winGetTitle Title, ahk_id %Window%
	winGetClass Class, ahk_id %Window%
	wingetpos X_Win, Y_Win, Width, Height, ahk_id %Window%
	winGet ProcName, ProcessName, ahk_id %Window%
	winGet PID, PID, ahk_id %Window%
	winGet, Style, Style, ahk_id %Window%
	winGet, ExStyle, ExStyle, ahk_id %Window%
	ControlGet, ContStyle, Style ,,%control%, ahk_id %Window%
	ControlGet, ContExStyle, ExStyle ,,%control%, ahk_id %Window%
	ControlGet, ControlhWnd, hWnd ,, %Control%, ahk_id %Window%
	PixelGetColor, colour, X_Cursor, Y_CursorzControlhWnd

	if ((length := StrLen(Title))>35) {
		TitleT 	:= SubStr(Title, 1 , 36)
		Title 	:= (Title . "...")
	}

	WindowUnderCursorInfo := "Title:  " Title "`n"
	. "Proc: " ProcName "`n"
	. "hWnd:                " Window "      PID: " PID "`n"
	. "Class: " Class "`n"
	. "Style / ExStyle:    " Style " - " ExStyle "`n"
	. "Control: "Control "`n"
	. "C_hWnd:             " ControlhWnd    " `n"
	. "C_Style / ExStyle: " ContStyle " - " ContExStyle "`n"
	;	. "control selected: " Selected_Item "`n"
	. "Rect:                         " Width " x " Height "`n"
	. "Top Left Pixel:            " X_Win ", " Y_Win "`n"
	. "Cursor screen-pos:     " X_Cursor ", " Y_Cursor "`n"
	. "Cursor window-pos:    " X_Cursor-X_Win ", " Y_Cursor-Y_Win "`n"
	;. "Colour under cursor " Colour "`n"
   
	coordMode Mouse
	getKeyState, p00, Space, P
	if p00 = D 	; Button released, drag carried out.
	SetBk(ControlhWnd, Window, 0x0000FF, 0xFF0000)
	getKeyState, kik, f9, P
	if kik = D 	; Button released, drag carried out.
	SetAcrylicGlassEffect(bgrColor, 17, ahk_id window)
	return, WindowUnderCursorInfo ; . HexToDec("0x" SubStr(BGR_Color, 5, 2)) ", "; . HexToDec("0x" SubStr(BGR_Color, 7, 2)) ")`n"
}
 
/* 

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
	return, DllCall("SetWindowPos", "uint", Hwnd, "uint", 0, "int", x, "int", y, "int", w, "int", h, "uint", hFlags)
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
			return, A_ThisFunc "> Invalid query parameter: " _
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
		hp := DllCall( "OpenProcess", "uint", 0x10|0x400, "int", False, "uint", _ )
		if (ErrorLevel or !hp)
			continue
		VarSetCapacity(buf, 512, 0), DllCall( "psapi.dll\GetModuleFileNameExA", "uint", hp, "uint", 0, "str", buf, "uint", 512), DllCall( "CloseHandle", hp )
		o%i% := buf
		continue
	}
	return, o1
}

Win_GetRect(hwnd, pQ="", ByRef o1="", ByRef o2="", ByRef o3="", ByRef o4="") {
	VarSetCapacity(RECT, 16), r := DllCall("GetWindowRect", "uint", hwnd, "uint", &RECT)
	ifEqual, r, 0, return,
	if (pQ = "") or pQ = ("*")
	retAll := True, pQ .= "xywh"
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
	return, retAll ? o1 " " o2 " " o3 " " o4 : o1
}

*/
 
SetSystemCursor() {
	CursorHandle := DllCall( "LoadCursor", Uint,0, Int,Cursor_int )
	Cursors = %Cursor_int%,32512
	loop , Parse, Cursors, `,
	DllCall( "SetSystemCursor", Uint,CursorHandle, Int,A_LoopField )
	return,
}

RestoreCursors() {
	SPI_SETCURSORS := 0x57
	DllCall( "SystemParametersInfo", UInt,SPI_SETCURSORS, UInt,0, UInt,0, UInt,0 )
	return,
}

In(x,a,b) {
	IfLess x,%a%, return, a
	IfLess b,%x%, return, b
	return, x
}

HexToDec(HexVal) {
	Old_A_FormatInteger := A_FormatInteger
	SetFormat IntegerFast, D
	DecVal := HexVal + 0
	SetFormat IntegerFast, %Old_A_FormatInteger%
	return, DecVal
}

PostMessage_2CursorWin(Message, wParam = 0, lParam=0) {
	OldcoordMode:= A_coordModeMouse
	coordMode, mouse, screen
	mouseGetPos X, Y, , , 2
	hWnd := DllCall("WindowFromPoint", "int", X , "int", Y)
	PostMessage %Message%, %wParam%, %lParam%, , ahk_id %hWnd%
	WinGetTitle, p00s, ahk_id %hWnd%
	tooltip % p00s
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
return,

Toggle_Win_Drag_State:
if MD_Activ8Def {
	menu, submenu1, Uncheck, Raise window when Dragged,
	MD_Activ8Def :=
} else {
	menu, submenu1, check, Raise window when Dragged,
	MD_Activ8Def := True
}
return,

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
		return, Win[hWnd, lparam, "Brush"] ; return the HBRUSH to notify the OS that we altered the HDC.
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
		return,
	}
	return, DllCall("CallWindowProcA", "UInt", Win[hWnd, "WindowProcOld"], "UInt", hWnd, "UInt", uMsg, "UInt", wParam, "UInt", lParam)
}

SetAcrylicGlassEffect(thisColor, thisAlpha, hWnd) {
	Static init, accent_state := 4,
	Static pad := A_PtrSize = 8 ? 4 : 0, WCA_ACCENT_POLICY := 19
	NumPut(accent_state, ACCENT_POLICY, 0, "int")
	NumPut(0xff000000, ACCENT_POLICY, 8, "int")
	VarSetCapacity(WINCOMPATTRDATA, 4 + pad + A_PtrSize + 4 + pad, 0)
	&& NumPut(WCA_ACCENT_POLICY, WINCOMPATTRDATA, 0, "int")
	&& NumPut(&ACCENT_POLICY, WINCOMPATTRDATA, 4 + pad, "ptr")
	&& NumPut(128, WINCOMPATTRDATA, 4 + pad + A_PtrSize, "uint")
	if !(DllCall("user32\SetWindowCompositionAttribute", "ptr", hWnd, "ptr", &WINCOMPATTRDATA))
		return,
	accent_size := VarSetCapacity(ACCENT_POLICY, 16, 0)
	return,
}
;---------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------
Dtop_icons_Get() {
	RunWait, Dicons_write.ahk
	return,
}
Dtop_icons_Restore() {
	RunWait, Dicons_recover.ahk
	return,
}
clicked() {
	tooltip, % Message_Click
	setTimer, tool1off, -1000
	return,
}
contextmenRclicked() {
	tooltip, % Message_Menu_Clicked
	setTimer, tool1off, -1000
	return,
}
abort_Mdrag() {
	tooltip, % Message_M2drag_Abort
	setTimer, tool1off, -1000
	return,
}
m2_released() {
	tooltip % Message_M2_Released
	setTimer, tool1off, -1000
	return,
}
mdrag_active() {
	tooltip, % Message_Drag_Active
	return,
}
ThreadFail() {
	tooltip, %Message_Thread_Fail%, (A_ScreenWidth // 2), (A_ScreenWidth // 2)
	setTimer, tool1off, -3000
	return,
}
Context_killed() {
	tooltip, %Message_Menu_Killed%,,,4
	setTimer, tool4off, -1000
	return,
}
Quick_L_click() {
	tooltip % Message_Click_Fast
	setTimer, tool1off, -1000
	return,
}
L_Released() {
	tooltip, %Message_Click_Release%,,,4
	setTimer, tool4off, -1000
	return,
}
L_clicked_Desktop() {
	tooltip, %Message_Click_DTop%, (X_Cursor+100), (Y_Cursor+20)
	setTimer, Tool1Off, -750
	return,
}
Clicked_Somewhere() {
	tooltip, %Message_Click_Other%
	setTimer, Tool1Off, -750
	return,
}
LButton_Held() {
	tooltip %Message_held_DTop%
	setTimer, Tool1Off, -750
	return,
}
touching_file() {
	tooltip, %Message_Touching% , toolx, tooly,4
	setTimer, Tool4Off, -750
	return,
}
toolXOff(Index) {
	Tool%Index%Off:
	tooltip,,,,%Index%
}
Win_Activate:
winactivate, ahk_id %hWnd%
return,
Tool1Off:
tooltip,,,,1
return,
Tool2Off:
tooltip,,,,2
return,
Tool3Off:
tooltip,,,,3
return,
Tool4Off:
tooltip,,,,4
return,
Tool5Off:
tooltip,,,,5
return,
_Feed_:
global Message_Click:="::Clicked::", global Message_Menu_Clicked:="Context Menu Clicked", global Message_M2drag_Abort:="Aborting Drag", global Message_M2_Released:="released mouse2", global Message_Drag_Active:="Window drag activated' n - Mouse 1 to Cancel", global Message_Thread_Fail:="GetGUIThreadInfo failure", global Message_Menu_Killed:="menu killed", global Message_Click_Fast:="Quick click::", global Message_Click_Release:="mouse 1 released", global Message_Click_DTop:="Left Clicked Desktop", global Message_Click_Other:="clicked elsewhere", global Message_held_DTop:="clickheld on desktop", global Message_Touching:="touching file", global Message_Moved :="%FailState% ...`n %X% %X_Cursor% %y% %Y_Cursor%`n Movement detected `n %x1% %x2% %y1% %y2%, %x%, %75%"
return,

winGetTransparency:
mouseGetPos, , , hWnd
if (t_%hwnd% = "")
t_%hwnd% := 100
Trans := t_%hwnd%
Opacit0 := Trans
return,

WinSetTransparency:
winGetClass, WindowClass, ahk_id %hWnd%
if WindowClass = Progman
return,
Opacit0  :=   (Opacit0 < 10) ? 10 : (Opacit0 > 100) ? 100 : Opacit0
Alpha0   :=   Trans * 2.55		  ; Init. Alpha
Alpha    :=   Round(Opacit0*2.55) ; Final Alpha
Trans    :=   Opacit0
t_%hwnd% :=   Trans
a        :=   Alpha - Alpha0
b        :=   AlphaIncrement
b        *=   (a < 0) ? -1 : 1	  ; Signed increment
a        :=   Abs(a)              ; Abs. iteration range
loop {
	Alpha0 := Round(Alpha0)
	WinSet, Trans, %Alpha0%, ahk_id %hWnd%
	if (Alpha0 = Alpha) {
		if (Alpha = 255) {
			if hWnd Not In %CleanUpList%
			{
				CleanUpList = %CleanUpList%%hWnd%`,
				setTimer, Clean_Up_your_mess, 10000
			}
		} else, StringReplace, CleanUpList, CleanUpList, %hWnd%`,, , 1
		break
	} else
	if (a >= AlphaIncrement) {
		Alpha0 += b
		a -= AlphaIncrement
	} else, Alpha0 := Alpha
}
return,
;]]]]]]]]]]]]]]]]]]]]]]]]]]]]    ;]]]]]]]]]]]]]]]]]]]]]]]]]]]]    ;]]]]]]]]]]]]]]]]]]]]]]]]]]]]    
CUR_FX_Enable:
MainWindow := New LayeredWindow(x := -1 , y := -1 , w := A_ScreenWidth+1 , h := A_ScreenHeight+1 , window := 1 , title := "MIDI" , smoothing := 2 , options := "+AlwaysOnTop -Caption +toolwindow +owner -SysMenu +AlwaysOnTop -DPIScale +E0x08000020" , autoShow := 1 , GdipStart := 1) ;~ Brush := Gdip_BrushCreateSolid("0x2200FF00")
BrshTrailz        :=  Gdip_BrushCreateSolid("0x338800ff")
BrshCurHighLight  :=  Gdip_BrushCreateSolid("0x7700aaff")
MouseGetPos, x, y
Circles := []
if Trailz_enabled
	loop,  50
		   Circles[A_Index] := New Circle(x,y,MainWindow.G,BrshTrailz)
gui, 1:   +LastFound +Hwndmousetracker +E0x08000020 -Caption -DPIScale +toolwindow +owner -SysMenu
sleep,     10
gui, 1:    Show,     noactivate, midi
gui, 1:   +LastFound +Hwndmousetracker +E0x08080020 -Caption -DPIScale +toolwindow +owner -SysMenu
CUR_FX_Enabled := true, oo:= opo
menu,      SubMenu2, rename,% oo,% opo:="CursorFX Off (currently on)"
menu,      SubMenu2, check,%  opo
menu,      SubMenu2, add,%    opo, CUR_FX_Disable
if curhilite_enabled
	menu,  SubMenu2, check,   Cursor HighlightSpot
menu,      SubMenu2, add,     Cursor Trails, Trailz_enabled
if Trailz_enabled
	menu,  SubMenu2, check,   Cursor Trails
setTimer,  CUR_FX_TIMER,      17
return,
;]]]]]]]]]]]]]]]]]]]]]]]]]]]]    ;]]]]]]]]]]]]]]]]]]]]]]]]]]]]    ;]]]]]]]]]]]]]]]]]]]]]]]]]]]]    
CUR_FX_Disable:
setTimer, CUR_FX_TIMER, off
gui, 1:hide,
gui, 1:destroy,
MainWindow.DeleteWindow( TurnOffGdip := 1 )
mainwindow := "", oo:= opo
menu,     SubMenu2, rename,%  oo ,% opo := "CursorFX On (currently off)"
menu,     SubMenu2, uncheck,% opo
menu,     SubMenu2, add,%     opo, CUR_FX_Enable
if curhilite_enabled
	menu, SubMenu2, uncheck,  Cursor HighlightSpot
menu,     SubMenu2, add,      Cursor Trails, Trailz_enabled
if Trailz_enabled
	menu, SubMenu2, uncheck,  Cursor Trails
CUR_FX_Enabled := False
return,
;]]]]]]]]]]]]]]]]]]]]]]]]]]]]
CUR_FX_TIMER:
MouseGetPos,tx,ty 
MainWindow.ClearWindow()
if curhilite_enabled
	Gdip_FillEllipse(MainWindow.G, BrshCurHighLight , tx-20, ty-20 , 40, 40)
if Trailz_enabled
	Loop, % Circles.Length()
		(Circles[A_Index].Move(tx,ty))?((Circles[A_Index].Active)?(Circles[A_Index].Draw()))
MainWindow.UpdateWindow()
return,
;]]]]]]]]]]]]]]]]]]]]]]]]]]]]
CUR_FX_Enabled:
curhilite_Enabled:
Trailz_Enabled:
switch a_thislabel {
	case "CUR_FX_Enabled":
		if !CUR_FX_Enabled
			  setTimer, CUR_FX_Enable,  -1
		else, setTimer, CUR_FX_Disable, -1
	case "Trailz_enabled":
		%a_thislabel% := !(%a_thislabel%)
		if Trailz_enabled
			  menu, SubMenu2, check,    Cursor Trails
		else, menu, SubMenu2, uncheck,  Cursor Trails
	case "curhilite_enabled":
		%a_thislabel% := !(%a_thislabel%)
		if curhilite_enabled
			  menu, SubMenu2, check,    Cursor HighlightSpot
		else, menu, SubMenu2, uncheck,  Cursor HighlightSpot
}	
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Clean_Up_your_mess: 	
MainWindow.DeleteWindow( TurnOffGdip := 1 )
gosub, Bypass_Parse_Array
gosub, kill_self
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;]]]]]]]]]]]]]]]]]]]]]]]]]]]]
DimensionChk:
WII := (W_Win + Xnet)
		if 	WII  <	 256
			WII  :=  256
	else if	WII  >	 3000
			WII	 :=	 3000	
HII := (  H_Win  +   Ynet )
		if 	HII	 <	 256
			HII	 :=	 256
	else if HII	 >	 2000
		    HII  :=  2000
x0x := ( X_Cursor -  Xnet )
		if 	x0X	 < 	-1000
			X0X	 := -1000
	else if	X0X	 >	 3500
		    X0X  :=  3500
y0y := ( Y_Cursor -  Ynet )
		if 	y0y	 <  -1000
			y0y	 := -1000
	else if	y0y	 >	 2000
		    y0y  :=  2000	
return,
;]]]]]]]]]]]]]]]]]]]]]]]]]]]]
corner_offset_get:
XOff := (X_mSt4 - X_WinS)	
YOff := (Y_MSt4 - Y_WinS)
;tooltip % XOff " ww " YOff " hh " ,,,2
return,
;]]]]]]]]]]]]]]]]]]]]]]]]]]]]
position_offset_get:
mousegetpos, X_Cursor, Y_Cursor,
if !(X_Win || Y_Win || W_Win || H_Win)
	gosub, DimensionChk
if !(XOff || y0y)
	gosub, corner_offset_get
x0x	:= (W_Wins - Xnet)	
y0y := (h_Wins - Ynet)
return,
position_offset_get2:
KOON := 1.3
LB_hWnd := RBhWnd
mousegetpos, X_Cursor, Y_Cursor,
Xnet 	:= (x_MSt4 - (x_Cursor))
Ynet 	:= (y_MSt4 - (y_Cursor))
x0x		:= (x_Win - (KOON * Xnet))	
y0y 	:= (y_Win - (KOON * Ynet))
W_Win := (W_WinS - (KOON*Xnet))
h_Win := (h_WinS - (KOON*Ynet))
;Win_Move(RBhWnd, x0x, y0y, , , "")
return,
;]]]]]]]]]]]]]]]]]]]]]]]]]]]]
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
return,
;]]]]]]]]]]]]]]]]]]]]]]]]]]]]
tooltipdestroy:
if (A_TimeIdle < 1000) {
	mouseGetPos, MouseX, MouseY
	if (MouseX = MouseX0 && MouseY = MouseY0)
		return,
}
setTimer, tooltipdestroy, Off
tooltip,
return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;-----------------------------------------------------------------------------------------------------------------
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Send_WM_COPYDATA(ByRef StringToSend, ByRef Path_WinEvent) {
static TimeOutTime := 1500
	 VarSetCapacity(CopyDataStruct, 3*A_PtrSize, 0) ;
	 SizeInBytes := (StrLen(StringToSend) + 1) * (A_IsUnicode ? 2 : 1)
	 NumPut(SizeInBytes,   CopyDataStruct, A_PtrSize) 
	 NumPut(&StringToSend, CopyDataStruct, 2*A_PtrSize)
	 Prev_DetectHiddenWindows := A_DetectHiddenWindows
	 Prev_TitleMatchMode      := A_TitleMatchMode
	 DetectHiddenWindows On
	 SetTitleMatchMode 2
	 SendMessage, 0x4a, 0, &CopyDataStruct,,% Path_WinEvent,,,,% TimeOutTime
	 DetectHiddenWindows,%  Prev_DetectHiddenWindows
	 SetTitleMatchMode,%    Prev_TitleMatchMode
	 return, ErrorLevel 
}

Receive_WM_COPYDATA(wParam, lParam){
	 StringAddress     :=   NumGet(lParam + 2*A_PtrSize) 
	 CopyOfData        :=   StrGet(StringAddress)
		 if  CopyOfData =   status
			 result    :=   Send_WM_COPYDATA((A_IsSuspended . A_IsPaused), Path_WinEvent)
	else if CopyOfData  =   magtoggle 
             run % ahk_path mag_path   ;  -----------------> MAGNIFIER <-----------------
	else if (CopyOfData =  "Bypass_Last_Dragged_GUI")
			 settimer,      Bypass_Last_Dragged_GUI, -1
	return,  True
}
;----------------------------------------------------------------------------------------
Open_Options_GUI: ; WIP
gui, 	Optiona:new , , Options
gui 	+HwndOptions_Hwnd
gui, 	Optiona:add, hotkey, wp vhotkey gHotkeyEvent w100 h21 0x200
gui, 	Optiona:add, button, default w80, OK
gui, 	Optiona:Show
return,
GuiClose(Options_Hwnd) {
	gosub, HotkeyEvent
	return, ; end of auto-execute section
}
;----------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------
Menu_Init:
menu, tray, NoStandard
menu, tray, add, Open script folder, Open_ScriptDir,
menu, tray, add, Options Window, Open_Options_GUI,
menu, tray, standard
menu, tray, NoStandard
if !CUR_FX_Enabled {
	menu,     SubMenu2, add,%     opo := "CursorFX On (currently off)", CUR_FX_Enabled
	menu,     SubMenu2, uncheck,% opo
	menu,     SubMenu2, add,      Cursor HighlightSpot, curhilite_enabled
	if curhilite_enabled
		menu, SubMenu2, uncheck,  Cursor HighlightSpot
	menu,     SubMenu2, add,      Cursor Trails, Trailz_enabled
	if Trailz_enabled
		menu, SubMenu2, uncheck,  Cursor Trails
} else, {
	menu,     SubMenu2, add,%    opo:="CursorFX Off (currently on)", CUR_FX_Enabled
	menu,     SubMenu2, check,%  opo
	menu,     SubMenu2, add,%    "Cursor HighlightSpot", curhilite_enabled
	if curhilite_enabled
		menu, SubMenu2, check,%  "Cursor HighlightSpot"
	menu,     SubMenu2, add,%    "Cursor Trails", Trailz_enabled
	if Trailz_enabled
		menu, SubMenu2, check,%  "Cursor Trails"
}
menu,         SubMenu1, add,%    "Handle Handler", Handle_Handler_Toggle
menu,         SubMenu1, add,%    "Raise window when Dragged", Toggle_Win_Drag_State
if MD_Activ8Def
	menu,     submenu1, check,%  "Raise window when Dragged",
menu,         SubMenu1, add,%    "m2Drag all by default", MD_DefaultDragAll_toggle
if ( MD_DefaultDragAll = True )  {
	menu,     submenu1, check,%  "m2Drag all by default",
	m2drag_Active     := True 
}
menu, tray,     add, Settings, :SubMenu1 
menu, SubMenu1, add, Cursor FX, :SubMenu2
menu, SubMenu1, icon, Cursor FX, C:\Icon\24\stardavidgopld2.ico
;-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=
menu, tray, standard
menu, tray, Icon, mouse24.ico
;-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=
return,
;---------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------
HotkeyEvent:		;	hotkey, IfWinActive, ahk_id %Options_Hwnd%
if hotkey {	
	hotkeycurrent := hotkey, hotkey_Old := hotkey
	tooltip % hotkey " " hotkey_Old " " hotkeycurrent
} else {
	if hotkey_Old
		hotkeycurrent=%hotkey_Old%
	else hotkeycurrent=%hotkey%
}
hotkey, %hotkeycurrent%, my_h
return,
;---------------------------------------------------------------------------------------
my_h:
tooltip % hotkeycurrent
settimer tooloff, -1000
return,
;---------------------------------------------------------------------------------------
Bypass_Last_Dragged_GUI: 		;		 DragbypassClass_new_possible 		; ahk_id %hwnd%
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
return,

BlacklistGUISubmit:
gui, BypassDragged:Submit
if TProcName {
	if Bypass_ProcList
		BypassProccListArr[BlacklistProcCount+1] := DragbypassClass_new_possibleProcName
	else
		BypassProccListArr[1] := DragbypassClass_new_possibleProcName
} else
if TTitle {
	if Bypass_TitleList
		BypassTitleListArr[BlacklistTitleCount+1] := DragbypassClass_new_possibleTitle
	else
		BypassTitleListArr[1] := DragbypassClass_new_possibleTitle
} else
if TClass {
	if Bypass_ClassList
		BypassClassListArr[BlacklistClassCount+1] := DragbypassClass_new_possibleClass
	else
		BypassClassListArr[1] := DragbypassClass_new_possibleClass
}
BlacklistGUIDestroy:
gui, BypassDragged:destroy
TProcName := "", TTitle := "", TClass := ""
return,
;-------------------------------------------------------------------------------
SliderEvent: ; slider changes come here
;-------------------------------------------------------------------------------
GuiControlGet, Slider ; get new value for Slider
GuiControl,, Text, %Slider%
return,
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
AimControl(a, s) { ; control mouse speed
	Static OrigMouseSpeed := 10, CurrentMouseSpeed := DllCall("SystemParametersInfo", UInt, 0x70, UInt, 0, UIntP, OrigMouseSpeed, UInt, 0)
	DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, Ptr, a ? (s>0 AND s<=20 ? s : 10) : OrigMouseSpeed, UInt, 0)
}
;-------------------------------------------------------------------------------
MouseSlow: ; use slow mouse speed
;-------------------------------------------------------------------------------
AimControl(1, Slider)
return,
;-------------------------------------------------------------------------------
MouseNormal: ; use normal mouse speed
;-------------------------------------------------------------------------------
AimControl(0, 0)
return,

MD_DefaultDragAll_toggle:
m2drag_Active := !m2drag_Active
if m2drag_Active {
	MD_DefaultDragAll := True
	menu, submenu1, check, m2Drag all by default,
	if DragbypassClass_new_possible {
		menu, tray, add, Bypass the last Dragged window, Open_Options_GUI,
		Dragbypassmenu_enabled := True
	}
	if k_0ff {
		menu, tray, delete, Bypass the last attempted Dragged window,
		k_0ff :=
	}
} else {
	if Dragbypassmenu_enabled {
		menu, tray, delete, Bypass the last Dragged window,
		Dragbypassmenu_enabled :=
	}
	if DragAllowMenu_enabled {
		menu, tray, add, Add last attempted window drag to whitelist, Open_Options_GUI,
		k_0ff:=True
	}
	MD_DefaultDragAll := False
	menu, submenu1, Uncheck, m2Drag all by default,
}
return,
f18::
coordMode, 			mouse, desktop
coordMode, 			tooltip, mouse
ttip("youcunt", 3000, 3)
coordMode, 			mouse, screen
coordMode, 			pixel, screen
return
TTip(TxT="",time=1000,ttnum=1) {
	if !dbgTT
	return 0
	mousegetpos, x, y
	coordMode, 		tooltip, mouse
	tooltip,% TxT,% (x -150),% (y-50),% ttnum
	sleep,% time
	tooltip,,,,% ttnum
	
}

Blacklist_RegRead:
regRead, Bypass_ClassList,	HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_ClassList
regRead, Bypass_TitleList,	HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_TitleList
regRead, Bypass_ProcList,	HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_ProcessList
return,

Blacklist_ParseArr:
tooltip Parsing Blacklist
 
loop, Parse, Bypass_ProcList, `,
{	
	if(a_index = 1) {
		BypassProcListStr := A_LoopField
		BypassProccListArr[1] := A_LoopField 
	} else {
		BypassProccListArr[A_Index] := A_LoopField
		if(a_index < 21) {
			BypassProcListStr := ( BypassProcListStr "," A_LoopField)	
			BlacklistProcCount := A_Index
		} else, msgbox,% "ErrorBypassing Proc",% "More than 21 Blacklisted .Exes"
}	}

loop, Parse, Bypass_ClassList, `,
{
	BypassClassListArr[A_Index] := A_LoopField
	If !BypassClassListStr 
		BypassClassListStr :=  q . A_LoopField . q
	else
		BypassClassListStr := (BypassClassListStr . "," . q . A_LoopField . q)
	BlacklistClassCount := A_Index
}

loop, Parse, Bypass_TitleList, `,
{
	BypassTitleListArr[A_Index] := A_LoopField
	If !BypassTitleListStr 
		BypassTitleListStr :=  q . A_LoopField . q
	else
		BypassTitleListStr := (BypassTitleListStr . "," . q . A_LoopField . q)
	BlacklistTitleCount := A_Index
}
tooltip, "Finished parsing Blacklist."
settimer tooloff, -350
return,

Bypass_Parse_Array:
for index, value in BypassProccListArr
{
	if !ProcList
		ProcList := value
	else
		ProcList =% ProcList "," value
}
Bypass_ProcList := ProcList

for index, value in BypassClassListArr
{
	if !ClassList
		ClassList := value
	else
		ClassList =% ClassList "," value
}
Bypass_ClassList := ClassList

for index, value in BypassTitleListArr
{
	if !TitleList
		TitleList := value
	else
		TitleList =% TitleList "," value
}
Bypass_TitleList := TitleList

EvaluateBypass_Class(hWnd) 					{
	winGetClass, ClassN,% ( id_ . hWnd)
	if  BypassClassListStr contains %ClassN%
		return, 1
	return, 0
}

EvaluateBypass_Proc(hWnd) 					{
	startmenu=StartMenuExperienceHost.exe
	fagg =% ( BypassProccListArr[2] BypassProccListArr[1]  BypassProccListArr[3]  BypassProccListArr[4] b BypassProccListArr[5] b BypassProccListArr[6] b BypassProccListArr[7] b BypassProccListArr[8] b BypassProccListArr[9] b BypassProccListArr[10] b BypassProccListArr[11] b BypassProccListArr[12] b BypassProccListArr[13] b BypassProccListArr[14] b BypassProccListArr[15] b BypassProccListArr[16] b BypassProccListArr[17] b BypassProccListArr[18] b BypassProccListArr[19] b BypassProccListArr[20] z)

	winGet ProcN, ProcessName, % id_ hWnd,
	if BypassProcListStr contains %procn%
		return, 1
	switch ProcN 							{
		case startmenu:
			return, 1
		case (Bypass_ProcList contains ProcN):
			return, 1
		default:
			return, 0	
		case fagg:
			return, 1
}	}

EvaluateBypass_Title(hWnd) 					{
	winGetTitle, Titl3, % id_ . hWnd,
		if Titl3 in %BypassTitleListStr%
		return, 1
	switch Titl3 {
		case BypassTitleListArr[1], BypassTitleListArr[2], BypassTitleListArr[3], BypassTitleListArr[4], BypassTitleListArr[5], BypassTitleListArr[6], BypassTitleListArr[7], BypassTitleListArr[8], BypassTitleListArr[9], BypassTitleListArr[10], BypassTitleListArr[11], BypassTitleListArr[12], BypassTitleListArr[13], BypassTitleListArr[14], BypassTitleListArr[15], BypassTitleListArr[16], BypassTitleListArr[17], BypassTitleListArr[18], BypassTitleListArr[19], BypassTitleListArr[20]:
			return, 1
		default:
			return, 0
}	}
return,

BP_RegDelete:
RegDelete, HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_ClassList
RegDelete, HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_ProcessList
RegDelete, HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_TitleList
return,
BP_RegWrite:
regWrite, REG_SZ, HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_ClassList, 		%ClassList%
regWrite, REG_SZ, HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_ProcessList, 	%ProcList%
regWrite, REG_SZ, HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag, Blacklist_TitleList, 		%TitleList%
return,

Varz:
global Idle_Mouse, Idle_KB, idle_Physical, Idle_main, Path_WinEvent, Mag_path, ContextClass, FF_ContextClass, ClassPicView1, ClassPicView2, ClassImgglass, DragbypassClass_new_possible, Bypass_ProcList, BlacklistProcCount, BlacklistClassCount, BlacklistTitleCount, PID, ControlhWnd, Cursor_int, CursorChange, m2d_OriginalWidth, m2d_OriginalHeight, ccc, ddd, XYThresh, X,  Y, ToolX, ToolY, TTX, TTY, ZWidth2, Zheight2, ZWidth, Zheight, X_Start_OLD, Y_Start_OLD, OriginalPosX, OriginalPosY, X_Old, Y_Old, m2d_MidX, m2d_MidY, H_Win, W_Win, y_NET, y_NETold, x_NET, x_NETold, hWnd, hotkey, TClass, TProcName, TTitle, p_count, TClass, TProcName, TTitle, Bypass_TitleList, Bypass_ClassList, Bypass_ProcList, CopyOF_, M1Resize, Status_M2Drag, LB_D, RB_D, M1_Trigger, MD_Meth, Bypass_pname_True, Bypass_Class_True, BypassTitleListArr, BypassClassListArr, BypassProccListArr, MD_Activ8Def, RBhWnd, BypassProcListStr, HII, HH, ww, WII, y0y, x0x, Ynet, Xnet, XOff, YOff, X_WinS, Y_WinS, H_WinS, W_WinS, X_Cursor, Y_Cursor, X_mSt42, Y_MSt42, X_mSt4, Y_MSt42, X_Win, Y_Win, rbcnthwnd, lbdd, BypassClassListDfault, b, C_Ahk, admhk, MD_Bind, MD_DefaultDragAll,BypassClassListStr, q, g, Bypass_title_True,iD_,dbgTT,AlphaIncrement, Sleep2, Mag, XX, YY, curhilite_enabled, Trailz_enabled, CUR_FX_Enabled, opo

Sleep2 := 2000, Mag := 0, XX := 0, YY := 0, m1resize := 1, AlphaIncrement := 0.2, MD_Activ8Def := True, dbgTT := True, iD_ := "ahk_id "
C_Ahk	       := " ahk_class Autohotkey"
admhk 		   := "adminhotkeys.ahk" . C_Ahk 
MD_Bind        := "rButton", MD_DefaultDragAll := "m2drag"
Idle_Mouse     := A_TimeIdlemouse
Idle_KB        := A_TimeIdleKeyboard
idle_Physical  := A_TimeIdlePhysical
Idle_main      := A_TimeIdle
Path_WinEvent  := "WinEvent.ahk ahk_class AutoHotkey"
Mag_path       := "C:\Program Files\Autohotkey\AutoHotkeyA32_UIA.exe C:\Script\AHK\Working\M2DRAG_MAG.AHK"
ContextClass   := "AHK_Class #32768"
FF_ContextClass:= "AHK_Class MozillaDropShadowWindowClass"
ClassPicView1  := "WindowsForms10.Window.8.app.0.34f5582_r6_ad1"
ClassPicView2  := "WindowsForms10.Window.8.app.0.141b42a_r6_ad1"
BypassTitleListArr := []
BypassClassListArr := []
BypassProccListArr := []
ClassImgglass      := []
ClassImgglass[1]   := ("AHK_Class " . ClassPicView1)
ClassImgglass[2]   := ("AHK_Class " . ClassPicView2)
BypassClassListDfault = "WORKERW" , "gdkWindowToplevel"
g := " , "
q ="
z="
b = " . %q% . "
return,

kill_self:
Gui, Optiona:destroy
exitApp 	; was... (below)
loop, Parse, CleanUpList, `,
{
	StringReplace, CleanUpList, CleanUpList, %A_LoopField%`,, , 1
	if (A_LoopField != "")
	WinSet, Trans, Off, ahk_id %A_LoopField%
}
if (A_exitReason = "")
	setTimer, Clean_Up_your_mess, Off
return,

InvokeVerb(path, menu, validate=True) {
	objShell := ComObjCreate("Shell.Application")
	if InStr(FileExist(path), "D") || InStr(path, "::{") {
		objFolder := objShell.NameSpace(path) 
		objFolderItem := objFolder.Self
	} else {
		SplitPath, path, name, dir
		objFolder := objShell.NameSpace(dir)
		objFolderItem := objFolder.ParseName(name)
	}
	if validate {
		colVerbs := objFolderItem.Verbs 
		loop % colVerbs.Count {
			verb := colVerbs.Item(A_Index - 1)
			retmenu := verb.name
			StringReplace, retmenu, retmenu, & 
			if (retmenu = menu) {
				verb.DoIt
				return, True
		}	}
			return, False
	} else
	objFolderItem.InvokeVerbEx(menu)
} 

Open_ScriptDir()