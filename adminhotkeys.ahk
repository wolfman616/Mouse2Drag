#noEnv 	;#warn
SetControlDelay, 20
SetKeyDelay, 20
#persistent
#InstallKeybdHook
#singleInstance,     	Force
;#KeyHistory,         	1
;ListLines,           	On
#maxhotkeysPerInterval, 1440
#maxThreadsPerhotkey,	10
DetectHiddenText, 		On
DetectHiddenWindows, 	On
settitlematchmode,		2
setbatchlines,        	-1
SetWinDelay,         	-1
coordMode,		Mouse,	Screen
coordMode, 		Pixel,	Screen
coordMode, 	  Tooltip,	Screen
sendMode,            	Input
setWorkingDir,      	%A_ScriptDir%
#Include 			    <gdi+_all>
#Include 			    <LayeredWindow> 
#Include 			    <circle>
Init_4gain :=  False,   UndoRate   :=  300
DbgTT      :=  True,    TT := -666 	; def tooltip time
groups() 

;---------=========----------============--------------===========----
TrayIconPath      := 	"C:\Icon\256\ICON5356_1.ico", 
;-=========-------------=========----------============--------------===========----	; BLOCK KEYS PER TITLE
BList_NmPad       := 	"ahk_exe wmplayer.exe,ahk_class MozillaWindowClass"
BList_F1_12       := 	"ahk_eXe notepad++.exe,ahk_Group Desktop,ahk_class MozillaWindowClass"
WList_F1_12       := 	"ahk_eXe notepad++.exe;f3,ahk_Group Desktop;f5,ahk_class MozillaWindowClass;f5,ahk_class MozillaWindowClass;f11,ahk_class MozillaWindowClass;f12,ahk_class MozillaWindowClass;f10,ahk_class AutoHotkey;f5"
BList_Arr0w       := 	"ahk_class MozillaWindowClass,ahk_Group Desktop"
BList_num0_9      := 	"ahk_Group Desktop,YouTube" ;	<---; not implemented
;-=========-------------=========----------============--------------===========----	; Esc 2 Quit ExEs
EscCloseWL_Exe    := 	"vlc,fontview,WMPlayer,RzSynapse,ApplicationFrameHost,Professional_CPL"
EscCloseAskWL_Exe := 	"regedit"
;-=========-------------=========----------============--------------===========----	; c 	hole
M2dLB_resize      := 	True
keybypass_Arrows  := 	True
keybypass_Numpad  :=    True
keybypass_FKeys   := 	True
DbgTT			  := 	True
;-=========----
gosub, 	Varz
gosub, 	Menus
gosub, 	Binds
gosub, Blacklist_RegRead
gosub, Blacklist_ParseArr
gosub, 	m41n
return,
;-=========----
;-=========----
m41n:
wm_allow()
OnMessage(0x4a, "Receive_WM_COPYDATA")
onExit, Rid_Karma
return,    

   groups() {
; Define group: -=Explorer windows=-=-=-=-=-=-
global
	GroupAdd, Desktop, ahk_class CabinetWClass 
	GroupAdd, Desktop, ahk_class AutoHotkey 
	; GroupAdd, Explorer, ahk_class Progman 
	; GroupAdd, Explorer, ahk_class WorkerW
	GroupAdd, Desktop, ahk_class ExploreWClass
	GroupAdd, Desktop,  ahk_class Progman 
	GroupAdd, Desktop,  ahk_class WorkerW
}

Paste:
SendInput, {Raw}%clipboard%
return
;traytip,GHHG,% "ADMhotkeyS LOADED",
	
Binds:	; -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~hotkeys-~-~-~-~-~-	-~-~-~-~	~-~-~-~- ~-~-~-
gosub, 	Digits_MAIN
gosub, 	arrow_bypasscheck
gosub, 	KBypass_f1_12_Enable ;gosub, 	f1_f12_bypasscheck
gosub, 	togl_numpad_i
hotkey, IF
hotkey, %loou%, 2kShuff, on
; hotkey, ~LAlt, 		Wt_, 		On 
hotkey, ^!Enter, 	phLaunch, 	on		
hotkey, IfWinActive, ahk_class ConsoleWindowClass
hotkey, ^V, Paste, ON
hotkey, IF
hotkey, %pooo%, 2kShuff, on

hotkey, IFwinnotactive, ahk_class gdkWindowToplevel
hotkey !R, NVsupress, on
hotkey ^!R, NVsupress, on

hotkey, IFwinactive, ahk_class gdkWindowToplevel
hotkey !R, gimpBypassNV, on
hotkey ^!R, gimpBypassNV, on
; hotkey, ^Up, 2kShuff, on
; hotkey, ^down, 2kShuff, on  
; hotkey, Delete,   delete_bypass_custom, on		
; hotkey, +Delete, 	KB_SendSelf_Unshifted, on		
; hotkey, +!Delete, KB_SendSelf_no_CTRL, on
; hotkey, IfWinNotActive , 	% "ahk_class " A_LoopField
; hotkey,  <^>!Space,		PauseToggle, on
 ; -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~HotStrings-~-~-~-~-~-~-~-~	~-~-~-~-	-~-~-~-~ -~-~-~
::btw::		by the way		                                                             
::myemail:: % email		                                                             
; -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~BINDS-~-~-~-~-~-~-~-~-~-~-	-~-~-~-~	~-~-~-~- ~-~-~-
;'$$$$$$$$$$$$$$$$$$$£££££££££££££££££££££££££££££££££""""""	""""""""	$$$$$$$$ $$$$$$
; 	-~-~-~-~-~-~ 	Win M 	-~-		Magnifier Toggle 		-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~
; #M::  			;		ALTgr + Right Arrow
; +#M::	
; TargetScript := winevent, STR_ := "mag_", result := (Send_WM_COPYDATA(STR_, TargetScript))
return,
~^NumpadDot::exit 	;>=====   CTRL=NUMPAD=DOT   ====>(  -NORMAL=RIGHT=CLICK-  )=====<
~f16::WheelLeft
~f17::WheelRight
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
gimpBypassNV:
tt("twat")
send,^!{F13}
return,
NVsupress:
Tt("Nvidia overlay supressed.") 
return,

Digits_MAIN:			;	digits keywrap
loop 9 {
	h_KI      := A_index
;	Shift_KI  := ( "+" . A_index )
	hotkey, If,
	Loop, Parse, BList_num0_9, `, 
	{
		hotkey, IfWinActive,    %A_LoopField%
		hotkey,	%h_KI%, Digits_0_9, on
		hotkey, IfWinActive,    %A_LoopField%
		hotkey, 0,  Digits_0_9, on
		hotkey, IfWinNotActive, %A_LoopField%
		hotkey,	%h_KI%, Digits_0_9, off
		hotkey, IfWinNotActive, %A_LoopField%
		hotkey, 0,  Digits_0_9, off
	;	hotkey,	%Shift_KI%, 	Digits_0_9
}	}
;hotkey, +0, Digits_0_9
return,

Digits_0_9: 	;	 disable digit-keys ( for youtube mainly )
ifwinactive, ahk_group desktop 
{
	WinGetActiveTitle, Title_Active
	if !instr(Title_Active,"YouTube") {
		handle := winactive("A")
		ControlGetFocus, cfo ,% heh:=( "ahk_id " . handle)
		;winGet ProcN, ProcessName,% heh:=( "ahk_id " . handle)
		if instr("Edit1", cfo) || instr(cfo,"Edit1") 
			goto, KB_SendSelf
		else, traytip, ADHKey,% "Numbers disabled`nPress Shift with them...", 1, 34
	}   else, traytip, ADHKey,% "Numbers disabled in Youtube`nPress Shift with them...", 1, 34
	; if ( ProcN = "firefox.exe" ) {
} else {
	ifwinactive, ahk_exe firefox.exe
	if !instr(%A_Thishotkey%,shif)	{
		WinGetActiveTitle, Title_Active
	if 	Title_Active contains YouTube 
		traytip, YouTube,% "Numbers disabled`nPress Shift with them...", 1, 34
	else, gosub, KB_SendSelf
	}   else, gosub, KB_SendSelf
}
return,

; ~LAlt & rbutton::
; settimer, StyleMenu_FixLaunch, -1
; return

rbutton::
main()
return

main(){
global
	m2Drag:			;		M2Drag MOUSE 2  	 <========================= 		BEGINS   
	mouseGetPos, X_mSt4, Y_MSt4, RBhWnd, rbcnthwnd
	if twonk {
		RBhWnd := killme
	}
	wingetpos,   X_Win,  Y_Win,  W_Win,  H_Win,% ( idd := ("ahk_id " . RBhWnd) )
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
	}		

	if twonk {
		twonk  := false
	} else {
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
	}	}	}	
	;---------------------------------------------------------------------------------------
	m2dReady: ;res:=Send_WM_COPYDATA(RBhWnd, admhk) tooltip % res NOT WORKING
	while (getKeyState("rbutton", "p")) {
		mouseGetPos, X_Cursor, Y_Cursor,
		wingetpos, X_Win, Y_Win, , ,%  ("ahk_id " RBhWnd)
		gosub, position_offset_get
		if ( X_Cursor != X_Old ) and ( Y_Cursor != Y_Old ) {
			if !(getKeyState("LButton", "P") ) {
				if twonk {
					killme := RBhWnd  ;WinExist("A")
					goto m2drag
				}
				Xnet := (x_Cursor - x_MSt4)
				Ynet := (y_Cursor - y_MSt4)
				ww   := ""  ,  HH := ""
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
					y0y := (Y_Wins)		;gosub, position_offset_get ;gosub, corner_offset_get2 ;gosub, DimensionChk
					Win_Move(RBhWnd, x0x, y0y,,, "")
				}
				Win_Move(RBhWnd, x0x, y0y,,, "")
			} else {
				gosub, position_offset_get
				gosub, corner_offset_get2
				gosub, DimensionChk
			}
			if !XYThresh {			; 		Movement-thresh, afterwhich single click is	; 	Add a time thresh too
				if (X_Cursor<X_mSt4-25) || (X_Cursor>X_mSt4+25) || (Y_Cursor<Y_MSt4-25) || (Y_Cursor>Y_MSt4 +25) {
					if !triglb1 {
						DragbypassClass_new_possible = ("ahk_id " RBhWnd)
						;menu, tray, add, Bypass the last Dragged window, Bypass_Last_Dragged_GUI,
						Dragbypassmenu_enabled := True
						XYThresh := True
				}	}
			} else { 				; 		XYThresh has procced..... 
			PROBHEERE:
				Status_M2Drag := True 	; 		m2drag begins  _>
				if (getKeyState("LButton", "P") ) {
					if !M1_Trigger {								
						M1_Trigger := True
						M1Resize := True
						x0x	:= (X_Wins + Xnet)	
						y0y := (Y_Wins + Ynet)
						gosub, corner_offset_get2
						gosub, position_offset_get
					}
					settimer Watch_Lbii, -1
				} else,	M1_Trigger := False, M1Resize := False
		}	}	

		if !insight {
	winGet, m2d_WinState, MinMax, ahk_id %RBhWnd%
			CursorChange := 1, insight := 1
			if (m2d_WinState = 1) { ; maximized
				while (getKeyState("rbutton" , "p") ) {
					if !XYThresh {
						if (X_Cursor<X_mSt4 -25) || (X_Cursor>X_mSt4 +25) || (Y_Cursor<Y_MSt4 -25) || (Y_Cursor>Y_MSt4 +25) {
							tooltip % X_Cursor<X_mSt4 " sdsd" 
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
								Win_Move(RBhWnd, m2d_MidX, m2d_MidY, "", "",  "")
				}	}	}	}
				if XYThresh
					DragbypassClass_new_possible =ahk_id %RBhWnd%
		}	}
		sleep 1
	} 		;		end of main "Mdrag while-loop"					
	Status_M2Drag := False, M1Resize := False, RB_D := False, M1_Trigger := False
	settimer, cleanRBVars, -1

	if !XYThresh 		;		mouse released without moving past thresh
		sendInput, {rbutton}
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
	BypassDrag:	;click, down, right    ;[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]
	send {rbutton down}	;SEND {%MD_Bind% DOWN}
	mousegetpos, 	X_mSt4, 	Y_MSt4
	wingetpos, 		X_Win, 		Y_Win, 		W_Win, 		H_Win, 		ahk_id %RBhWnd%

	if !XYThresh { ; threshold of xy movement, afterwhich no longer a standard right click
		while (getKeyState("rbutton", "P") ) {
			getKeyState, KSLB, rbutton, "P"
			if (KSLB  =  "D")
			lbdd     :=  True
			mousegetpos, X_Cursor, Y_Cursor
			wingetpos,   X_Win,    Y_Win,  W_Win,  H_Win,%  ("ahk_id " RBhWnd)
			if (X_Cursor<X_mSt4-25) || (X_Cursor>X_mSt4+25) || (Y_Cursor<Y_MSt4-25) || (Y_Cursor>Y_MSt4+25) {
				; if !triglb1 {
					; DragAllowClass_new_possible =ahk_id %RBhWnd%
					; menu, tray, NoStandard
					; menu, tray, add, Add last attempted window drag to whitelist, Open_Options_GUI,
					; menu, tray, standard
					; XYThresh := True, DragAllowMenu_enabled := True	, triglb1 := True
			; }	
			}
			sleep, 1
	}	}
	send {rbutton Up}
	insight := "", XYThresh := False, triglb1 := False, Bypass_Class_True := False, 	Bypass_pname_True := False, lbdd := False,	Bypass_title_True := False	
	settimer, cleanRBVars, -1
	return,

	BypassDrag2:
	send { rbutton Down }
	while getKeyState("rbutton", "L") 
		sleep 5
	send {rbutton Up}
	settimer clean2,-1
	return,
	
	clean2:
	insight := "", XYThresh := False, triglb1 := False
	Status_M2Drag := False, M1Resize := False, RB_D := False, M1_Trigger := False
	settimer, cleanRBVars, -1
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

	; Watch_Lb:
	; if !OC1 {
		; wingetpos, X_Win, Y_Win, , , ahk_id %RBhWnd%
		; Y_MSt4 :=  Y_Cursor,      X_mSt4 := X_Cursor, 
		; OC1 := True
	; }
	; x_NET := X_mSt4 - X_Cursor
	; if (x_NET  !=  x_NETold )
		; W_Win  :=  W_Win + x_NET, X_mSt4 := X_Cursor
	; y_NET := Y_MSt4 - Y_Cursor
	; if (y_NET  !=  y_NETold)
		; H_Win  :=  H_Win + y_NET, Y_MSt4 := Y_Cursor
	; x_NETold   :=  x_NET, y_NETold := y_NET
	; if LB_U {
		; getKeyState, KSLB, rbutton, "p"
		; if (KSLB = "U") {
			; settimer m1_resizeGO, off
			; LB_U := True
		; }
	; }
	; RB_D := False, triglb1 := False
	; return,
	; Watch_Lb:
	; if !OC1 {
		; wingetpos, X_Win, Y_Win, , , ahk_id %RBhWnd%
		; Y_MSt4 :=  Y_Cursor,      X_mSt4 := X_Cursor, 
		; OC1 := True
	; }
	; x_NET := X_mSt4 - X_Cursor
	; if (x_NET  !=  x_NETold )
		; W_Win  :=  W_Win + x_NET, X_mSt4 := X_Cursor
	; y_NET := Y_MSt4 - Y_Cursor
	; if (y_NET  !=  y_NETold)
		; H_Win  :=  H_Win + y_NET, Y_MSt4 := Y_Cursor
	; x_NETold   :=  x_NET, y_NETold := y_NET
	; if LB_U {
		; getKeyState, KSLB, rbutton, "p"
		; if (KSLB = "U") {
			; settimer m1_resizeGO, off
			; LB_U := True
		; }
	; }
	; RB_D := False, triglb1 := False
	; return,
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

	corner_offset_get:
	XOff := (X_mSt4 - X_WinS)	
	YOff := (Y_MSt4 - Y_WinS)
	;tooltip % XOff " ww " YOff " hh " ,,,2
	return,

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
	KOON    :=   1.3
	LB_hWnd :=   RBhWnd
	mousegetpos, X_Cursor, Y_Cursor,
	Xnet    :=   x_MSt4 - (x_Cursor)
	Ynet    :=   y_MSt4 - (y_Cursor)
	x0x	    :=   x_Win  - (KOON * Xnet)
	y0y     :=   y_Win  - (KOON * Ynet)
	W_Win   :=   W_WinS - (KOON*Xnet)
	h_Win   :=   h_WinS - (KOON*Ynet) ; Win_Move(RBhWnd, x0x, y0y, , , "")
	return,

	clean_ii:
	mousegetpos, X_mSt4, Y_MSt4
	wingetpos,   X_Wins, Y_Wins, W_Wins, H_Wins,% ("ahk_id " RBhWnd)
	x0x := (Xnet+X_Wins),y0y:=(Y_Wins + Ynet)	; gosub, corner_offset_get	; gosub, position_offset_get	; gosub, DimensionChk
	lbdd :=False
	IF !LB_U
		LB_U := True
	LB_D := False
	settimer cleanlbvars, -1	; click left up
	return, ; ~^Lbutton up::  ; ~$Lbutton up:: ; ~^Lbutton up::  ; ~$Lbutton up:: ; ~^Lbutton up::  ; ~$Lbutton up:: ; ~^Lbutton up::  ; ~$Lbutton up:: 
	; return,

	cleanLBVars:
	LB_ClassN_old := LB_ClassN, LB_ClassN := "", class_active := "", LB_hWnd := "", LB_cWnd := "", LB_D := False,	fff  := False
	return,
	cleanRBVars:
	Bypass_Class_True := False,  Bypass_pname_True := False,  Bypass_title_True := False	
	HII := 0, WII := 0, x0x := 0, y0y := 0, ww := 0, HH := 0,
	return,
	; ~rbutton::
	; tt("sadfdsf")
	; mousegetpos, x, y, LB_hWnd
	; return,
}


F20::
f16::				; 	Wheel L = "page UP" without interfering with selection
^f16::
;tooltip % a_thishotkey "`n" ass
active_id := winexist("A")
winGetClass, 		Active_WinClass , A
mouseGetPos,,, 		Mouse_hWnd, Mouse_ClassNN
winGetClass, 		Mouse_WinClass , ahk_id %Mouse_hWnd%
 if (active_id != %Mouse_hWnd%)	{
 ; IE UNFOCUSED
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
} else, Send, { PgUp }
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
} else, Send, { PgDn }
settimer clean3, -1
return,

clean3:
active_id :=
Mouse_hWnd:=
Mouse_WinClass:=
Mouse_ClassNN:=	
return,

ImgGlassScroll_L:
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
ImgGlassScroll_R:
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

Toggle_Win_Drag_State:
if MD_Activ8Def {
	menu, submenu1, Uncheck, Raise window when Dragged,
	MD_Activ8Def :=
} else {
	menu, submenu1, check, Raise window when Dragged,
	MD_Activ8Def := True
}
return,

Lbutton:: 
clicked:=false
if !(getKeyState( "Rbutton", "P")) {
	click down 	;send {lbutton down}
	return,
} else {
	if !faggot
		send {f21} 
	Active_hwnd := 	WinExist("A")
	WinGetClass, class_active, A
	LB_cWnd22	:=
	MouseGetPos, X_Cursor1, Y_Cursor1, LB_hWnd, LB_cWnd22
	wingetClass, Class,%  "ahk_id " Active_hwnd
	if (Class = "WorkerW")
		return,
	if (Bypass_pname_True || Bypass_Class_True)
		Trigger_bypassed 	:= 	True
	if Bypass_Class_True
		Trigger_bypassed 	:= 	True
		mousegetpos, X_mSt4, Y_MSt4, 
		wingetpos,   X_Wins, Y_Wins, W_Wins, H_Wins, ahk_id %Active_hwnd%
		winGetClass, ClassN, % ( id_ . LB_hWnd)
		;if ClassN != CabinetWClass	;msgbox % ClassN
	if (Class = "CabinetWClass") {
		PostMessage, %WM_LB_down%, %WMResize_N_W%,% "ahk_id " Active_hwnd
		while getKeyState("Lbutton", "P")
			sleep 2
		send {lbutton up) ;click up  ;lsend {LButton up} ; or ; IMPORTANT : NEEDED ELSE CTRL ADDED TO DRAG WILL DIE!
		clicked:=true
		return,
	} else {
		if !rbt_ {
		;	PostMessage, %WM_LB_down%, %WMResize_S_E%,% "ahk_id " LB_cWnd22
			wingetpos, 	X_Wins, Y_Wins, W_Wins, H_Wins, ahk_id %Active_hwnd%
			MouseGetPos,X_mSt4, Y_MSt4, ,LB_cWnd22
			wingetpos, 	X_Win, 	Y_Win, 	W_Win, 	H_Win, 	ahk_id %Active_hwnd%
			MouseGetPos,X_Cursor1 ,Y_Cursor1 , , LB_cWnd22
			x_winn := ""
			gosub, corner_offset_get0
			gosub, Watch_Lbii
			rbt_ := True
		} else, gosub, DimensionChkii
	}
	while( getKeyState("Lbutton", "P")) { 
		mousegetpos, 	X_Cursor1, Y_Cursor1
		wingetpos, 		X_Win, 	Y_Win, 	W_Win, 	H_Win, 	ahk_id %Active_hwnd%
		;tooltip % X_mSt4 " " y_mSt4 "`n" X_Cursor1 " " Y_Cursor1
		gosub, 	Watch_Lbii
		
		gosub, 	DimensionChk
		xx := (x0x - XOff),	yy := (y0y - YOff)
		x0x :=xx
		y0y:=yy
		Win_Move(Active_hwnd, xx, yy, wii, hii, "")
	}
rbt_ := False	
global twonk:=true 
} 
return,

lbutton Up:: ;;~$LButton UP:: [[[[[[][[[[[[[[[[[[][[[[[[[[[[[[][[[[[[[[[[[[[][[[[[[[[[[[][][
if 		!clicked
	send, {Lbutton UP} ;;click up
return

corner_offset_get0:
	XOff := (X_mSt4 - X_WinS)	
	YOff := (Y_MSt4 - Y_WinS)
	return,
	
DimensionChkii:
WII := (W_Wins + X_net)
		if 	 WII  <  256
			 WII  := 256
	else, if WII  >  3000
			 WII  := 3000	
HII := (H_Wins + Y_net)
		if   HII  <  256
			 HII  := 256
	else, if HII  >  2000
		HII	:=	2000
x0x := (X_Cursor1 - X_net)
		if   x0X  < -1000
			 X0X  := -1000
	else, if X0X  >  3500
		     X0X  := 3500
y0y := (Y_Cursor1 - Y_net)
		if 	 y0y  <  -1000
			 y0y  := -1000
	else, if y0y  >	 2000
		     y0y  := 2000	
return,

Watch_Lbii:
x_NET := (X_mSt4-X_Cursor1), y_NET := (Y_MSt4-Y_Cursor1), x0x := (X_Cursor1+x_NET), y0y := (Y_Cursor1+y_NET)
return,

;[][][][][][][][][][][][][][]
StyleMenu_FixLaunch:
StyleMenu_trigger := False
result := Send_WM_COPYDATA("StyleMenu", EventScript)
return,
;[][][][][][][][][][][][][][]
Wt_:
if dbgtt
	tooltip,% "menuinit"
hotkey, ~LAlt, Wt_, off
hotkey, LAlt, zzz, on
KeyWait, LAlt
settimer, BlockInput_Toggle, -1
hotkey, ~LAlt, Wt_, off
sleep 1
hotkey, LAlt, zzz, off
return,
;[][][][][][][][][][][][][][]

#e::
zzz:
ttp(( a_now . "`n" . nigg))
return,
;[][][][][][][][][][][][][][]

^+Delete::
Del_this := A_thishotkey
WinGetClass, cl_s, A
if (instr(ExplorerClss,cl_s)) { 	; 	sendself_no_ctrl:
	ControlGetFocus, cnt, % "ahk_id " (handl := winactive("a"))
	if (InStr("Edit1,DirectUIHWND1", cnt)) 
		  Del_this := strReplace(Del_this, "^+")
	else, Del_this := strReplace(Del_this, "^" )
	send, {%Del_this%}
	if (InStr(Del_this, "+")) 
	a3 		  :=  "Shift-"
	else, a3  :=  "Normal "
	ttp(( a3  .   "Delete"))
} else {
	send {%A_thishotkey%}
	if DbgTT_advanced
		ttp("Sent: Ctrl, Shift & Del")
}
return

$delete::
WinGetClass, cl_s, A
if (instr(ExplorerClss,cl_s)) { 	; 	sendself_no_ctrl:
	handl := winactive("a")
	ControlGetFocus, Ct_fc, ahk_id %handl%
	if (instr("Edit1,DirectUIHWND1",Ct_fc)) { 	; 	sendself_no_ctrl:
		send {delete}
		sleep 1
		return,
	} else, 
if (instr(ExplorerCnts,Ct_fc)) {	; 	sendself_no_ctrl:
	BT := A_THISHOTKEY
	gosub, Bicycle
	}
} else {	; all other classes
	send {delete}
	if DbgTT_advanced
		ttp("Delete Not Suppressed undefined", "-500")
}
handl := ""
return,

+Delete::
turds:=Explorer_GetSelection()

;loop, parse, turds, `n,
;	ct4 := a_index
; if ct4 > 1
	; FileStrCc := ct4 . " items"
; else, {
	; SplitPath, 	turds,,, OutExtension, OutNameNoExt,
	; FileStrCc := (OutNameNoExt . "." . OutExtension)
; }
msgbox,0x2121, Confirm Deletion, % ("Send " turds " to RecycleBin?")
ifmsgbox ok
	msgbox, 0x2131, % "Del?...Sure?", R U sH0Re?....`n`nhuhu
	ifmsgbox, ok		;if ct4 > 1	;loop, parse, turds, `n,;filerecycle,% a_loopindex
		filerecycle,% turds
return,
; 	'-~_~_~_~_~_~_~_ UN-DO MO-FO _~_~_~_~_~_~_~-'	 	'-~_~_~_~_~_~_~_ UN-DO MO-FO _~_~_~_~_~_~_~-'	 	'-~_~_~_~_~_~_~_ UN-DO MO-FO _~_~_~_~_~_~_~-'	
; UNDO MOFO
$^z:: 				;			"Ctrl Z" - bypass "Undo." in Explorer.exe
$^y:: 				; 			"Ctrl Y" - bypass "Redo". in Explorer .exe
if !(winactive("ahk_Group desktop"))
	  gosub, NoDollarSend
else, {

	dki := a_thishotkey
	gosub, Bicycle
}
return,

Bicycle: ; strips intentionally mutated hotkey combos for intention of original key and general bypass seive 
;  	 ie:  numbers 1-9 blocked in youtube,-> Allowed with Shift, Ctrl or Alt. 
;    ie2: arrows diabled in explorer -> Except when in edit controls
    act   := winactive("A")
IF !dki
	dki   := a_thishotkey
if (dki contains "$"  && dki != $) {
	ttdki := strreplace( dki, "$")  ; for tooltip msg
	dki   := ttdki
}
if (dki contains "^"  && dki != $) {
	ttdki := strreplace( dki, "^", "Control + ")
	dki   := strreplace( dki, "^")
}
if (dki contains "!"  && dki != $) {
	ttdki := strreplace( dki, "!", "Alt + ")
	dki   := strreplace( dki, "!")
}
if (instr(arrowlist, dki) || instr("^z^y", dki)) { ; add to taste
	ControlGetFocus, cf ,% inout
	if edit_c(("ahk_id " . act)) 
		sendinput, {%a_thishotkey%}
	else if instr("DirectUIHWND1", cf) ; additional cnt names, should a function be made?
		sendinput, {%a_thishotkey%}
}
else if instr(numpadsrs, dki)
	wingetActiveTitle, A_Title
	if instr(A_Title, "YouTube") {
		if (instr(dki, "+")) {
			dki   := strreplace( dki, "!")
			dki   := strreplace( dki, "+")
			send, { %a_thishotkey% }
		} 
		else ttp( dki " Disabled in Youtube." , "-300" )
	}
else ttp( dki " Disabled." , "-300" ) 
dki := ""
return

^#i:: 	; Press ctl 1 to make the color under the mouse cursor invisible.
mouseGetPos, MouseX, MouseY, MouseWin
pixelGetColor, MouseRGB, %MouseX%, %MouseY%, RGB
WinSet, TransColor, Off, ahk_id %MouseWin%
ttp( (msg := ( MouseRGB . " Will BE MADE TRANS_COLOR`n" . MouseX . ", " . MouseY . "`n" . MouseWin)))
WinSet, TransColor, %MouseRGB% 200, ahk_id %MouseWin% 	;	 WinSet, TransColor, 0xFFFFFF, ahk_id %MouseWin%
return,

~$esc::
$+esc::
#hotkeyInterval 1000
winGet ProcN, ProcessName,% "ahk_id " (handl3	:=	winactive("a"))
ProcN := strreplace(ProcN, ".exe")
if ProcN in %EscCloseWL_Exe%
{
	ttp((ProcN . ", Closing..."))
	WinClose
} else, if ProcN in %EscCloseAskWL_Exe%
{ 
	msgbox, 262209, Close %ProcN%? , Closing.`nTimeout in 4 Sec`nIssue forth,4 ; Icon Asterisk (info) 64 0x40 ;; Icon "Question" 32 0x20 ; ; WS_EX_TOPMOST 	262144 	0x40000 ;; 	OK/Cancel 1 0x1 ;	Yes/No 4 0x4 ; ; System Modal (top) 4096 0x1000 
	;ifmsgbox OK		
	if((ifmsgbox "Cancel") || (ifmsgbox "no"))	
	{
		traytip,% "ESC_2_CLOSE",% "Cancelled"
		return,
	} else, WinClose
} else {
IfWinActive, Get Parameters ahk_exe AutoHotkey.exe 
	winClose, 	
	if winactive(cls_IMGGLASS[1])
	winClose, %  cls_IMGGLASS[1]
	if !trigg3r3d {
		trigg3r3d := True
		mousegetpos , , , winz
		WinGetClass, aaa ,  ahk_id %winz%, 
	}
	if aaa      =  #32768
		ok2esc :=  True 
	else, if (f := instr(aaa,"CustomizerGod")) {
		WinGetActiveStats, Title, Width, Height, X, Y		
		if ((Width < 1220) && (height < 830))
			winclose,
	} else {
		escaped := True
		send {Esc}
}	}
return,
$esc up::
$+esc up::
if (ok2esc || escaped) {
	trigg3r3d := False, ok2esc := false, escaped := False
	if    escaped 
		  send, {esc up}
	else, send, {esc}
}
#hotkeyInterval %hi%
return, 
; SUPPRESS HOTKEY-PAIR @ DESKTOP-MOUSE-OVER ! : @@~~~ EG CTRL + MWHEEL TO ZOO
^+WheelUp::  ^+p ; rerouting to get around cpu mouse hook in magscrpt
^+WheelDown:: ^+d
 ^Wheeldown::      
2kShuff:
mousegetpos, , , mHwnd
WinGetClass, mclss,% (mhnd := ("ahk_id " . mHwnd))
if init_wheel_Bypass {
	settimer HK_PairSend, -1
	settimer bypasstimer, -250
}
if !instr("WorkerW,Progman,tooltips_class32", mclss) ; desktop
	settimer HK_PairSend, -1
else,ttp("Desktop: Supressed Zoom")
return

HK_PairSend:  
  init_wheel_Bypass:=true
	hK := StrSplit(A_Thishotkey , , , 2)
	switch hK[1] {
		case "!":
			HK[1] := "Alt"
		case "^":
			HK[1] := "Control"
		case "+":		
			HK[1] := "Shift"
		default:
			msgbox,% HK[1] ": unrecognised hkotkey prefix."
	}
	send,% "{" . (hk[1]) . "}" . "{" . (hk[2]) . "}"
			;msgbox,% "{" (hk[1]) "}" "{" (hk[2]) "}"
		settimer bypasstimer, -250

return,

bypasstimer:
init_wheel_Bypass:= false
return

+^Delete::+Delete
!Shift::   ;   -~-~-~-~-~-~   ;   input-locale selector gui hotbind bypass   -~-~-~-~-~-~
+Alt::
if w10_LocaleGui_Allowed
		send, {%A_Thishotkey%}
else, ttp("shift-alt blocked (inputlocale bypass)")
return,
	;	>>>-------------======-------------------------======------------- WACOM TABlet Stuff -------------======------------- >
	;       Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad
+F9::     ;-------------======-------------     WACKEM STYLUS NIB EVENT     ^^-------------======-------------
ttp("Nib Down")
send {LButton Down}
return,
+F9 up::
ttp("Nib Up")
send {LButton Up}
return,

$insert::	 	; -------------======------------- 	GIMP Undo = Stylus button && GIMP ReDo = Ctrl + stylus button 1 	-------------======-------------
if !(winactive("ahk_exe gimp-2.10.exe")) {
	;hotkeySendSelf(A_thishotkey)	;		undo 		-------------=============------------- 		 			undo 	
	send {insert}
	return,
} else {
	sleep 20
	send {escape}
	sleep 70
	send ^z
	while getKeyState,insert
		ttp(a_now)
; settimer, dbgtt_nibdown5, -%UndoRate%
}	
return,

~^c::
if  lastcopied_H
	lastcopied_H_old:=lastcopied_H
lastcopied_H := winexist("A")
if  lastcopied_T
	lastcopied_T_old:=lastcopied_T
wingettitle, lastcopied_T, "A"
return,

~^v::
if  lastpasted_H
	lastpasted_H_old:=lastpasted_H
lastpasted_H := winexist("A")
if  lastpasted_T
	lastpasted_T_old:=lastpasted_T
wingettitle, lastpasted_T, "A"
return,

~!w::
tt("sdsdsdsdsdsdsds")
mousegetpos,,,nnd,cunt
gdipfix_start:
sleep, 700
Nnn  := Gdip_Startup()
dcC  := GetDC(nnd)
mDC := Gdi_CreateCompatibleDC(0)
mBM := Gdi_CreateDIBSection(mDC, 1, 1, 32) 
oBM := Gdi_SelectObject(mDC, mBM)
a:=DllCall("gdi32.dll\SetStretchBltMode", "Uint", dcC, "Int", 5)
b:=DllCall("gdi32.dll\StretchBlt", "Uint", dcC, "Int", 0, "Int", 0, "Int", 3000, "Int", 1200, "Uint", mdc, "Uint", 0, "Uint", 0, "Int", 1, "Int", 1, "Uint", "0x00CC0020")
Gdip_ShutdownI(Nnn)
if a = 0 || b = 0
	goto gdipfix_start
return,

~F15::
return,
~F15 UP::
#M::  					;		ALTgr + Right Arrow
+#M::	
if !winexist(,"ninjmag") 
	run,% Mag_
return,

Gdip_ShutdownI(pToken) {
   DllCall("gdiplus\GdiplusShutdown", "Uint", pToken)
   If hModule := DllCall("GetModuleHandle", "str", "gdiplus")
         DllCall("FreeLibrary"    , "Uint", hModule)
   return, 0
} 

$^insert::	 
send {escape}	 			; 		get rid of annoying hardcoded Rbutton menu popup in GIMP 
send ^Y
if !(winactive("ahk_exe gimp-2.10.exe")) {
	hotkeySendSelf(A_thishotkey)	;		undo 		-------------=============------------- 		 			undo 		
	return,
} else {
	sleep, 20
	send {escape}
	sleep 70
	send, ^y
	while getKeyState,insert {
		tooltip,% A_NOW ; settimer, dbgtt_nibdown5, -%UndoRate%
}	}
return,
; g i m p routed Mouse1 / pen nib 1 -----=====-----; g i m p routed Mouse2 / undo barrel 1
 ~#F10:: ;~ sending thru to m2drag
click right down
ttp("Barrel 1 Down")
return,
~#F10 up::
click right up
ttp("Barrel 1 Up")
return,
~!f13::
ttp("rotate CW")
return,
~!f14::
ttp("rotate C-CW")
return,
~+wheeldown::
ttp("2 Finger swipe L")
return,
~+wheelup::
ttp("2 Finger swipe R")
return,
~^!z::
ttp("3 finga tap")
return,
~^+!#h::
ttp("4 finga upswipe")
return,
~#Tab::
ttp("4 finga downswipe")
return,
~!^+u:: 
ttp("5 finga downswipe")
return,
~^+f6:: 				;		ctrl shift F6 
ttp("5 finga tap")
return,

XButton1::			 	;		System Back and Forward
XButton2::				;		MOUSE BUTTONS BACK / FWD 
mouseGetPos, tx, ty, M_hwnd, M_ctrl
A_hwnd := WinExist("A")
if (M_hwnd = A_hwnd) {
	if (M_Class = "WorkerW")
		ttp("D-Top (Not Implemented")
	else, send {%A_thishotkey%}
		
} else {
	wingetclass, M_class, ahk_id %M_hwnd%
	winGetClass, a_Class, ahk_id %A_hwnd%
	if (M_Class = "MultitaskingViewFrame")
		Send !{tab} 
	else, send {%A_thishotkey%}
}
return,

;	 -~-~-~-~-~-~-~-~--~>>   Bypass   >>-~--~-~-~-~-~-~-~-~-~-~>>
winGet ProcN, ProcessName, ahk_id %A_hwnd%
for k, v in PName {
	if (v = ProcN)
		gosub, hotkeySendSelf
}
Swipe(A_hwnd, a_thishotkey)
return,

~^s::	 ; 		Capture Save hotkey Ctrl-S
wingetActiveTitle, A_Title
if winactive("ahk_exe notepad++.exe") 		 		  {
	if instr(A_Title, ".ahk") 						  {
		if instr(A_Title, "*")						  {
			A_Title := StrReplace(A_Title, "*" , "") 	; *ASTERISK denotes unsaved doc in np++ WinTitle
			SplitPath, A_Title, tName, npDir, npExtension, npNameNoExt, npDrive 
			ser := npNameNoExt . ".ahk - AutoHotkey"
			TargetScriptName := (npNameNoExt . ".ahk"	)
			if ((WinExist(ser)) or if (npNameNoExt = "WinEvent")) {
				MsgBox, 262240,%  "Modified script: "npNameNoExt,% "Reload " TargetScriptName " now?`nTimeout in 6 Secs", 6
				; MsgBox,, %  "Modified script: "npNameNoExt,% "Reload " TargetScriptName " now?`nTimeout in 6 Secs", 6
				; IfMsgBox Timeout 
					; ttp("cuntface")    
				ifmsgbox, OK,                         {
					if (npNameNoExt = "adminhotkeys") {
						reload 
						exit
					} else {
						traytip, %TargetScriptName%, reloading, 2, 32
						postMessage, 0x0111, 65303,,, %TargetScriptName% - AutoHotkey		; Reload WMsg 
}	}	}	}	}	}
return, 

;<^Ralt::
 ; ALT GR solo bypass to prevent interfence with menus etc
;tt(a_thishotkey)
;return,                         
; <^Ralt up::
 ; ALT GR solo bypass to prevent interfence with menus etc
;tt(a_thishotkey)
;return,  
; f18::
; settimer, Stylemenu_init, -1
; return
<^>!PgUp::				; ALTgr + Page UP 	; 	Volume Up	
;+<^>!PgUp::		
TargetScript := WMPMATT, STR_ := "VolUp", result := (Send_WM_COPYDATA(STR_, TargetScript))
return,
<^>!PgDn::	 			; ALTgr + Page Down 	; 	Volume Up	
;+<^>!PgDn::
TargetScript := WMPMATT, STR_ := "VolDn", result := (Send_WM_COPYDATA(STR_, TargetScript))
return,
<^>!Space::				; ALTgr + Space
    +<^>!Space::
TargetScript := WMPMATT, STR_ := "PauseToggle", result := (Send_WM_COPYDATA(STR_, TargetScript))
return,
<^>!Left::				; ALTgr + Left Arrow
+<^>!::	
TargetScript := WMPMATT, STR_ := "JumpPrev", result := (Send_WM_COPYDATA(STR_, TargetScript))
return,
<^>!Right::	 			; ALTgr + Right Arrow
;+<^>!Right::	
TargetScript := WMPMATT, STR_ := "JumpNext", result := (Send_WM_COPYDATA(STR_, TargetScript))
return,
<^>!Enter:: 			; ALTgr + Enter	
;+<^>!Enter:: 			; open current media loc & clipboard details
TargetScript := WMPMATT, STR_ := "Open_Containing", result := Send_WM_COPYDATA(STR_, TargetScript)
return,
<^>!c::					; ALTgr + C
;+<^>!c::	
TargetScript := WMPMATT, STR_ := "Converter", result := Send_WM_COPYDATA(STR_, TargetScript)
return,
<^>!x::					; ALTgr x 
;+<^>!x::
TargetScript := WMPMATT, STR_ := "CutCurrent", result := Send_WM_COPYDATA(STR_, TargetScript)
return,
<^>!Del::				; ALTgr + Del
;+<^>!Del::	
TargetScript := WMPMATT, STR_ := "godie", result := Send_WM_COPYDATA(STR_, TargetScript)
return,
<^>!p::					; ALTgr + Enter
;+<^>!p::			
TargetScript := WMPMATT, STR_ := "Add2Playlist", result := Send_WM_COPYDATA(STR_, TargetScript)
return,
<^>!f::					; ALTgr + f
+<^>!f::	
TargetScript := WMPMATT, STR_ := "SearchExplorer", result := Send_WM_COPYDATA(STR_, TargetScript)
return,
<^>!s::					; ALTgr + s
+<^>!s::				; Search SlSK for alternatives to current
TargetScript := WMPMATT, STR_ := "CopySearchSlSk", result := Send_WM_COPYDATA(STR_, TargetScript)
return,
^#x::	
+^#x::					; ExtractAudio from youtube
TargetScript := YTScript, STR_ := "ExtractAudio", result := Send_WM_COPYDATA(STR_, TargetScript)
return,
^#Space::				; Youtube Audio-Xtract 
+^#Space::				; CTRL - WIN - SPACEBAR
TargetScript := YTScript, STR_ := "PlayPause", result := Send_WM_COPYDATA(STR_, TargetScript)
return,
^#Left::				; Youtube Prev			
+^#Left::				; CTRL-WIN-LEFTARROW
TargetScript := YTScript, STR_ := "prev", result := Send_WM_COPYDATA(STR_, TargetScript)
return,
^#Right::				; Youtube Next
+^#Right::				; CTRL-WIN-LEFTARROW			
TargetScript := YTScript, STR_ := "next", result := Send_WM_COPYDATA(STR_, TargetScript)
return,

ttp(TxT = "", ti="") {
if dbgtt {
		tooltip, % TxT,
		if ti
			  settimer, TT_0ff,% ti
		else, settimer, TT_0ff,% tt
}	}

TT_0ff:
tooltip,
return
return,

Receive_WM_COPYDATA(wParam, lParam) {				
	StringAddress := NumGet(lParam + 2*A_PtrSize)		 
	CopyOfData := StrGet(StringAddress) 						 
	msgbox,% CopyOfData " sds!"									
	C_Str=C:\Windows\system32\cmd.exe /s /k pushd "%CopyOfData%"	
	return, True
}

Send_WM_COPYDATA(ByRef STR_, ByRef TargetScript) {
	VarSetCapacity(CopyDataStruct, 3*A_PtrSize, 0)
	SizeInBytes := (StrLen(STR_) + 1) * (A_IsUnicode ? 2 : 1)
	NumPut(SizeInBytes, CopyDataStruct, A_PtrSize)
	NumPut(&STR_, CopyDataStruct, 2*A_PtrSize)
	Prev_DetectHiddenWindows := A_DetectHiddenWindows
	Prev_TitleMatchMode := A_TitleMatchMode
	DetectHiddenWindows On
	SetTitleMatchMode 2
	TimeOutTime := 4000
	SendMessage, 0x4a, 0, &CopyDataStruct,, %TargetScript%,,,, %TimeOutTime%
	DetectHiddenWindows %Prev_DetectHiddenWindows%
	SetTitleMatchMode %Prev_TitleMatchMode%
	return, errorlevel
}

Swipe(hwnd, hotkey) {
	; if !hwnd {
		; send !{tab}
		; send +!{tab}
		; return,
	; }
	if ( hotkey =     "XButton1") {
		send #{Left}
		ttp("Bk-butt")
	} else {
		if ( hotkey	= "XButton2") {
			send #{Right}
			ttp("Fwd butt")
		} else, Msgbox % "other back fwd buttons pls consult the p===---"
	}
	WinWaitActive, ahk_class MultitaskingViewFrame,, 2
	if (winactive("ahk_class MultitaskingViewFrame")) {
		S_hwnd := wineXist("A")
		if (S_hwnd = hwnd) {
			Send !{tab} 
			ttp("alt tabbed")
			return,
		} else {	;	ActivateWin(hwnd, -10)
			winactivate, AHK_ID %hwnd%,, 2		
			if errorlevel
				msgbox % errorlevel		
		}
		WinWaitActive, AHK_ID %hwnd%,, 2
	}
	x_hwnd := hwnd
}

ActivateWin(hwnd, delay) {
	if !hwnd { 
		send !{tab} 
		ttp("Failed, rem")
	} else {
		if !Delay
			Delay := -100	
		Act_handle_str := ("ahk_id " . hwnd ), Act_DelayT := delay
		settimer, Act_Then, %Act_DelayT% 
		return,
		
		Act_Then:
		winactivate %Act_handle_str%
		WinWait, Act_handle_str,, 2
		if winactive(Act_handle_str) {
			Act_DelayT := "", Act_handle_str := ""
			return, 1
		} else, return, 0
}	}

togl_numpad:	; numpad bypass
numpadkeys_str := ""
keybypass_Numpad := !keybypass_Numpad
togl_numpad_i:

;if keybypass_Numpad {
	;menu, tray, check, Disable Numpad
	;if !num_init_trigger {
		;num_init_trigger := True
		loop, 10		{
			aa := (a_index - 1)
			Loop, Parse, BList_NmPad, `,
			{
					;MSGBOX %A_LoopField%  
				;if A_LoopField contains £
				;{
				;	loop, parse, A_LoopField, £,
				;	{
							;MSGBOX %A_LoopField%3
					;	if a_index = 1
					;		1st := A_LoopField
						;if a_index = 2
					;		2nd	:= A_LoopField
				;	}
					;hotkey, IfWinActive,% 1st,% 2nd
			;	}
			;	else, 
			;	{
			if !Niggercunt
				niggercunt:= ("Numpad" . aa)
else
			niggercunt:= (niggercunt . ",Numpad" . aa)
				hotkey, IfWinActive,% A_LoopField
				hotkey,  Numpad%aa%, Bicycle, on
	        }
				; if   numpadkeys_str
				     ; numpadkeys_str := (numpadkeys_str . "," . "Numpad" . aa)
				; else,numpadkeys_str := ("Numpad" . aa)
		}	
		Loop Parse, num_others, `,
		{
			bb := A_LoopField
			Loop Parse, BList_NmPad, `,
			{
				hotkey, IfWinActive, %A_LoopField% 
				hotkey, % bb, Bicycle, on
				;numpadkeys_str := (numpadkeys_str . "," . bb)
			;	key_NumP_ar.Push(bb)	
		}	}
		;}
		numpadsrs:= (niggercunt . "," . num_others)

		return,
	;} else {
	;	for index, element in key_NumP_ar
		;	hotkey, % element, TT
	;}
; } else {
	; menu, tray, uncheck, Disable Numpad
	; if !num_init_trigger {
		; num_init_trigger := True
		; loop, 10 {
			; cc := (a_index-1)
			; Loop, Parse, BList_NmPad, `,
			; {
			; MSGBOX % A_LoopField
				; hotkey, IfWinActive, % A_LoopField
				; hotkey, % "Numpad" . cc, TT
				; }
			;	numpadkeys_str := (numpadkeys_str . "," . "Numpad" . cc)
				;key_NumP_ar.Push("Numpad" . cc)
		; }
		; Loop, Parse, num_others, `,
		; {
			; Loop, Parse, BList_NmPad, `,
			; {
				; hotkey, IfWinActive, % A_LoopField
				; hotkey, % A_LoopField, TT
				; }
			;	numpadkeys_str := (numpadkeys_str . "," . A_LoopField)
				;key_NumP_ar.Push(A_LoopField)	
		; };
	; } else {
		; for index, 	element in key_NumP_ar
			; hotkey,	% element, off
; }	}
; return,

F1_F12_Toggle:
keybypass_FKeys := !keybypass_FKeys
f1_f12_bypasscheck:
if keybypass_FKeys {
	 GOSUB KBypass_f1_12_Enable
} else, {
 if KBpF112_Init
	 GOSUB KBypass_f1_12_Disable
}
return,

msgbox,% ("this will never appear")

KBypass_f1_12_Enable:
loop, 12 {
	if (a_index = "1") {
		hotkey,% "F1", f1_bypassed_explorer, on
	} else {	
		tyt  := ("F" . A_Index)
		Loop Parse, BList_F1_12, `,	
		{
			hotkey, IfWinActive, %A_LoopField%
			hotkey, %tyt%, Bicycle, on
		}
		Loop Parse, WList_F1_12, `,	
		{
			Loop Parse, A_LoopField,% ";",
			{
				switch a_index {
					case "1":
						wint := A_LoopField
					case "2":
						hotkey, IfWinActive,% wint
						hotkey,% A_LoopField, Bicycle, off
}	}	}	}	}
kbpf112_init := True
return,

KBypass_f1_12_Disable:
loop 12
	hotkey % ("F" . A_Index), off
return,

arrow_toggle:
keybypass_Arrows := !keybypass_Arrows
if keybypass_Arrows {
	 GOSUB, arrow_bypasscheck 
	 }
else,GOSUB, arrow_reenable
return,

arrow_bypasscheck:
if keybypass_Arrows
Loop, Parse, arrowlist, `,
{
	bm := A_LoopField
	Loop, Parse, BList_Arr0w, `,
	{
		hotkey, IfWinActive,% A_LoopField
		hotkey, %bm%, Bicycle	
}	}
return,

arrow_reenable:
msgbox, ccc
for index, element in key_Arrow_ar
	hotkey,% element, off
return,

f1_bypassed_explorer:	;:	F1	:: ; remove help
IfWinnotActive, AHK_Group Desktop
{

	send, {%A_thishotkey%}  
	}
else {
	BT := A_THISHOTKEY
	gosub, Bicycle
}
return,

KB_SendSelf:
if 	InStr(A_Thishotkey, "$")
		send,% 	(Orig_Int := strReplace(A_Thishotkey, "$", ""))
else, 	send,	{%A_Thishotkey%}
return,
KB_SendSelf_no_CTRL:
if InStr(A_Thishotkey, "^")
		send % (Orig_Int := strReplace(A_Thishotkey, "^", ""))
else, 	send {%A_Thishotkey%}
return,

BlockInput_Toggle:
if !bi {
	bi 	:= 	True,	BlockInput, on
	;send {LAlt Up}
	settimer, BI_OFF, -500
	return,
	BI_OFF:
	bi 	:= 	False, BlockInput, OFF
	;send {LAlt Up}
	return,
} else, settimer, StyleMenu_FixLaunch, -100
return,

dbgtt_nibdown0:
ttp("nib down")
return,
dbgtt_nibdown2:
ttp("barrel 1 click")
return,
dbgtt_nibdown5:
ttp("undo")
send ^z
sleep 300
return,
dbgtt_redo:
ttp("redo")
send ^y
sleep 300
return,

hotkeySendSelf:
send {%a_thishotkey%}
ttp("%a_thishotkey%`n%hwnd%")
return,
hotkeySendSelf(A_HOTKI)                {
	if instr(a_hotKi, PassThru-LoopBk) {
		a_hotKi := strReplace(a_hotKi, ("`"PassThru - "`"LoopBk), "") 
		if !errorlevel                 {
			if getKeyState(a_hotKi, a_hkMeth := "P")
				a_hkPrest := True
			else, 
			if getKeyState(a_hotKi, a_hkMeth := "L") 
				a_hkPrest := True
			else, 
				ttp("hotkey error`nIssue detecting Logical or Physical")
			while getKeyState(a_hotKi, a_hkMeth) {
				if !getKeyState(a_hotKi, a_hkMeth) {
					a_hkPrest := False, temp := True
				}
				If !a_hkPrest 
					if !temp
						a_hkPrest := True
					else, msgbox % "issue with LOGIC, Professor."
				sleep 1
			}
			if !a_hkPrest && !temp
				msgbox issue
			else, {
				a_hkPrest := False
				if !getKeyState(a_hotKi, a_hkMeth) {
					SetKeyDelay, 1000
					send {%a_hotKi%}
					SetKeyDelay, 0
					ttp((a_hotKi . "`nSent"))	
		}	}	}
		else, ttp((HK_Stript . errorlevel))
	}
	return,
}

lb_size_go:
MouseGetPos, x, y, LB_hWnd, LB_cWnd,2
LB_cWnd2 := ("ahk_id " . LB_cWnd)
PostMessage, 0x00A1, 13, %LB_cWnd2%
while getKeyState("Lbutton", "P")   { 
	sleep 2
	Active_hwnd := WinExist("A")
	WinGetClass, class_active, A
	tooltip % LB_cWnd "`n" LB_cWnd2
}
tooltip,% "up11"
return,  
 
;==----============----
edit_c(inout) {
	ControlGetFocus, cf ,% inout
	if instr("Edit1,DirectUIHWND1", cf)
		return, true
	return, false
}
lb_size_end:
tooltip LB Resize`nup
return,

Watch_Lb:
x_NET := (X_mSt4-X_Cursor1), y_NET := (Y_MSt4-Y_Cursor1), x0x := (X_Cursor1+x_NET), y0y := (Y_Cursor1+y_NET)
return,

corner_offset_getii:
XOff := (X_mSt4 - X_WinS), YOff := (Y_MSt4 - Y_WinS)
corner_offset_get2:
XOff2 := (X_Cursor1 - X_Win), YOff2 := (Y_Cursor1 - Y_Win) 	;	tooltip % XOff " ww " YOff " hh " ,,,2 	;tooltip % XOff " ww " YOff " hh " ,,,2                                              
return,

nodollarsend:
if	 a_thishotkey contains $
	 send % (b_thishotkey := strreplace(a_thishotkey, "$"))
else, ttp("Error", "-3000")
return,

Rid_Karma:
Clean_Up_your_mess: 	
MainWindow.DeleteWindow( TurnOffGdip := 1 )
gosub, kill_self
Global Die := True
TreeStance:
sleep, 666
ttp((A_thislabel "called tho"))
if !Die
	return,
else, exitapp, 

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

;___----\
;.,.,.,.,.,.,.,.,.,.,		;	return,
; -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~vARz-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~
vARz:
Globals:
global Explorer, Desktop, TrayIconPath, BList_NmPad, BList_F1_12, WList_F1_12, BList_Arr0w, WList_Arr0w, BList_num0_9, EscCloseWL_Exe, EscCloseAskWL_Exe, WM_LB_down, WMResize_N_W, WMResize_S_E, WM_LB_down, RB_Down, EscCloseAskWL_Exe, EscCloseWL_Exe, turds, aa, bb, bbbb, cc, tyt, fkk, rbt_, LB_cWnd2, handle, handl2, handl3, dhand, LB_cWnd, lb_CLass, LB_cWnd, Active_hwnd, procn, Act_DelayT, eMail, TrayIconPath, num_init_trigger, Trigger_bypassed, TTn, tt, LB_hWnd, ClassPicView1, ClassPicView2, cls_IMGGLASS, xx, yy, UndoRate, Bypass_Class_True, num_others, trigg3r3d, ok2esc, escaped, shif, HK_PH1, HK_PH2, passThru, LoopBk, ExplorerCnts, ExplorerClss, YTScript, M2DRAG, WMPMATT, EventScript, Mag_Path, Path_PH, Clix, bi, x_hwnd, DbgTT, TargetScript, Act_handle_str, quote_MAX_INDEX, fkeys_str0, quotes, qstr, x_NET, y_NET, x0x, XOff, y0y, YOff, X_mSt4, Y_MSt4, X_Cursor1, Y_Cursor1, x_NET, y_NET, W_Wins, h_Wins, X_Win, Y_Win, W_Win, H_Win, wii, hii, XCent, keybypass_Numpad, M2dLB_resize, keybypass_Arrows, keybypass_FKeys, loou, pooo, Bypass_ClassList, TTn, HK_PH1, C_Ahk, qq, qt, key_Func_ar, key_Del_ar, key_NumP_ar, key_Arrow_ar, w10_LocaleGui_Allowe, d8Cntxt_Reg, d8Cntxt_RegFixValue,	BypassClassListArr, w10_LocaleGui_Allowed, email, Desktop_Margin, BList_Arr0w, BList_NmPad, arrowlist, bt, KBpF112_Init, bm, dki, BlacklistClassCount, numpadsrs, lastcopied, lastpasted_T_old, lastpasted_T, lastpasted_H_old, lastpasted_H, Mag_, clicked, killme
global Idle_Mouse, Idle_KB, idle_Physical, Idle_main, Path_WinEvent, Mag_path, ContextClass, FF_ContextClass, ClassPicView1, ClassPicView2, ClassImgglass, DragbypassClass_new_possible, Bypass_ProcList, BlacklistProcCount, BlacklistClassCount, BlacklistTitleCount, PID, ControlhWnd, Cursor_int, CursorChange, m2d_OriginalWidth, m2d_OriginalHeight, ccc, ddd, XYThresh, X,  Y, ToolX, ToolY, TTX, TTY, ZWidth2, Zheight2, ZWidth, Zheight, X_Start_OLD, Y_Start_OLD, OriginalPosX, OriginalPosY, X_Old, Y_Old, m2d_MidX, m2d_MidY, H_Win, W_Win, y_NET, y_NETold, x_NET, x_NETold, hWnd, hotkey, TClass, TProcName, TTitle, p_count, TClass, TProcName, TTitle, Bypass_TitleList, Bypass_ClassList, Bypass_ProcList, CopyOF_, M1Resize, Status_M2Drag, LB_D, RB_D, M1_Trigger, MD_Meth, Bypass_pname_True, Bypass_Class_True, BypassTitleListArr, BypassClassListArr, BypassProccListArr, MD_Activ8Def, RBhWnd, BypassProcListStr, HII, HH, ww, WII, y0y, x0x, Ynet, Xnet, XOff, YOff, X_WinS, Y_WinS, H_WinS, W_WinS, X_Cursor, Y_Cursor, X_mSt42, Y_MSt42, X_mSt4, Y_MSt42, X_Win, Y_Win, rbcnthwnd, lbdd, BypassClassListDfault, b, C_Ahk, admhk, MD_Bind, MD_DefaultDragAll,BypassClassListStr, q, g, Bypass_title_True,iD_,dbgTT,AlphaIncrement, Sleep2, Mag, XX, YY, curhilite_enabled, Trailz_enabled, CUR_FX_Enabled, opo, Handle_Handler_Active, handlercopied, tcunt
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
; -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~vARz-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~
	
;^^^^^^`'`'<
regRead,     Bypass_ClassList,%  "HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag", Blacklist_ClassList
loop, Parse, Bypass_ClassList, `,
{
	BypassClassListArr[A_Index] := 	A_LoopField
	If  !BypassClassListStr 
		 BypassClassListStr     :=  ( q . A_LoopField . q )
	else BypassClassListStr     := 	( BypassClassListStr . "," . q . A_LoopField . q )
	BlacklistClassCount 		:= 	A_Index
}

Mag_  = "C:\Program Files\Autohotkey\Autohotkey.exe" "C:\Script\AHK\Working\M2DRAG_MAG.AHK"
loou := "^Up"
pooo := "^down"
Init_4gain := True
Sysget, Desktop_Margin, MonitorWorkArea
Sysget, XCent, 	78
Sysget, YCent, 	79
XCent	:= 	(floor(0.5*XCent)) 
YCent	:= 	(floor(0.5*YCent))
iniRead, email, ad.ini, e, e, test@i.cycles.co 
w10_LocaleGui_Allowed :=  False
d8Cntxt_Reg           :=  "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\z99 File Admin\shell\copyPaste_mod_date"  ; Cosmetic workaround to avoid confusing context entry txt
d8Cntxt_RegFixValue   :=  "Copy Date-Modified" ; Reset the context menu entry txt to "Copy Date.." (System was shutdown unexpectedly after FileDate was retained.) 
regWrite, REG_SZ,% d8Cntxt_Reg, muiverb,% d8Cntxt_RegFixValue 		; 		rebuke the abomination!	goto Globals 
Init_4gain  :=  False		;	}
num_others  :=  "NumLock,NumpadDiv,NumpadMult,NumpadAdd,NumpadSub,NumpadEnter,NumpadPgDn,NumpadPgUp,NumpadEnd,NumpadHome,NumpadClear,NumpadDel,NumpadDot,NumpadIns,NumpadUp,NumpadLeft,NumpadRight,NumpadDown"      
arrowlist   :=  "Left,Right,Up,Down"

TTn         :=  1
HK_PH1 	    :=  "^!Enter", HK_PH2 := ("+" . HK_PH1), shif := "+", passThru := "~", LoopBk := "$"
C_Ahk	    :=	"ahk_class AutoHotkey"
ExplorerCnts:= 	"DirectUIHWND3,SysListView321,DirectUIHWND"
ExplorerClss:= 	"CabinetWClass,WorkerW,Progman"
YTScript 	:=	("YT.ahk " . C_Ahk)
M2DRAG 		:=	("M2Drag.ahk " . C_Ahk)
WMPMATT 	:=	("wmp_Matt.ahk " . C_Ahk)
EventScript :=	("WinEvent.ahk " . C_Ahk)
Mag_Path 	:=	"C:\Program Files\Autohotkey\Autohotkey.exe C:\Script\AHK\Working\M2DRAG_MAG.AHK"
Path_PH 	:=	"C:\Apps\Ph\processhacker\x64\ProcessHacker.exe"
WM_LB_down  := 	0x00A1
WMResize_N_W 	:= 	13
WMResize_S_E 	:= 	17
cls_IMGGLASS 	:= 	[]
qq 				:= 	[]
qt 				:= 	[]
key_Func_ar 	:= 	[]		
key_Del_ar 		:= 	[]		
key_NumP_ar 	:= 	[]		
key_Arrow_ar	:= 	[]		
key_Arrow_ar[1] := 	"Left"
key_Arrow_ar[2] := 	"Right"
key_Arrow_ar[3]	:= 	"Up"
key_Arrow_ar[4] := 	"Down"

ClassPicView1	:= 	"WindowsForms10.Window.8.app.0.34f5582_r6_ad1"
ClassPicView2 	:= 	"WindowsForms10.Window.8.app.0.141b42a_r6_ad1"
cls_IMGGLASS[1] := 	("ahk_class " . ClassPicView1)
cls_IMGGLASS[2] := 	("ahk_class " . ClassPicView2)
return,

Menus:
menu, 	tray, 	add,%  "Open Script Folder", Open_ScriptDir
menu, 	tray, 	icon,%  TrayIconPath
menu, 	tray, 	add,%  "Disable Numpad", 	 togl_numpad
if keybypass_Numpad 
		menu, 	tray, 	check,%				"Disable Numpad"
else, 	menu, 	tray, 	uncheck,%           "Disable Numpad"
menu, 	tray, 	standard
return,

Desktop_Margins:
tooltip, % (prick := ("Left: " Desktop_MarginLeft "`nRight: " Desktop_MarginRight "`nTop: " Desktop_MarginTop "`nBottom: " Desktop_MarginBottom))
return,

sendf5:
send {f5}
ttp("F5", "-400")
return,

phLaunch: 				;	Process Hacker CTRL ALT ENTER
ttp("LAUNCHING PH")
run % Path_PH
return,

Open_ScriptDir()

^q:: ;Write out menu entries
mousegetpos,,,hw_nd,
wingetclass, Ac, ahk_id %hw_nd%
if (AC = "#32768")
	settimer, menudetail_dump, -1
else send {ctrl}{q}
return,

menudetail_dump:
WinGet, hWnd, ID, ahk_class #32768
if !hWnd
	return
SendMessage, 0x1E1, 0, 0, , ahk_class #32768 ;MN_GETHMENU
if !hMenu := ErrorLevel
	return
WinGet, vPID, PID, % "ahk_id " hWnd
;OpenProcess may not be needed to set an external menu item's icon to HBMMENU_MBAR_RESTORE
if !hProc := DllCall("OpenProcess", UInt,0x1F0FFF, Int,0, UInt,vPID, Ptr)
	return
Loop, % DllCall("GetMenuItemCount", Ptr,hMenu)
	{
	if !Vtext
		Vtext:="-------------------separator"
	vtextold:=trim((vtextold . "`n" . vtext))
	
	vChars := DllCall("user32\GetMenuString", Ptr,hMenu, UInt,vIndex, Ptr,0, Int,0, UInt,0x400) + 1
	VarSetCapacity(vText, vChars << !!A_IsUnicode)
	DllCall("user32\GetMenuString", Ptr,hMenu, UInt,vIndex, Str,vText, Int,vChars, UInt,0x400) ;MF_BYPOSITION 
	vPos := A_Index-1
	vIndex := A_Index-1
	vSize := A_PtrSize=8?80:48
	VarSetCapacity(MENUITEMINFO, vSize, 0)
	DllCall("SetMenuItemInfo", Ptr,hMenu, UInt,vPos, Int,1, Ptr,&MENUITEMINFO)
	}
DllCall("CloseHandle", Ptr,hProc) 
clipboard=%vtextold%,%vtext%
vtextold:=
vtext:=
return

DimensionChk:
WII := (W_Wins + X_net)
		if 	 WII  <  256
			 WII  := 256
	else, if WII  >  3000
			 WII  := 3000	
HII := (H_Wins + Y_net)
		if   HII  <  256
			 HII  := 256
	else, if HII  >  2000
		HII	:=	2000
x0x := (X_Cursor1 - X_net)
		if   x0X  < -1000
			 X0X  := -1000
	else, if X0X  >  3500
		     X0X  := 3500
y0y := (Y_Cursor1 - Y_net)
		if 	 y0y  <  -1000
			 y0y  := -1000
	else, if y0y  >	 2000
		     y0y  := 2000	
return,

class CloseExe
{
	Static 	EscEscCloseAskWL_ExeArr	:= 	["regedit"]
	Static 	EscCloseNoaskArr 		:= 	["vlc", "fontview", "RzSynapse", "ApplicationFrameHost", "Professional_CPL,"]
	Static 	EscNoClosearr 			:= 	["Calculator"]
	_NewEnum() {
		return, new CEnumerator(this.CloseExeArr)
}	}

class PName
{
	static PNameArr	:= ["firefox.exe", "chrome.exe", "explorer.exe"]
	_NewEnum() {
		return, new CEnumerator(this.PNameArr)
}	}

class SwipeBypassCName
{
	static SwipeBypassCNameArr := ["ahk_class WorkerW", "ahk_class Progman", "ahk_class CabinetWClass", "ahk_class Shell_TrayWnd", "ahk_class #32770"]
	_NewEnum() {
		return, new CEnumerator(this.SwipeBypassCNameArr)
}	}

class TName
{
	static TNameArr := ["Replace", "Infromation", "explorer.exe", "sidebar.exe", "StartMenuExperienceHost.exe"]
	_NewEnum() {
		return, new CEnumerator(this.TNameArr)
}	}

class CEnumerator
{
	__New(Object) {
		this.Object := Object
		this.first := True
		this.ObjMaxIndex := Object.MaxIndex()
	}
	Next(ByRef key, ByRef value) {
		if (this.first) {
			this.Remove("first")
			key 	:=	1
		}
		else, 	key ++
		if 	(key 	<=	this.ObjMaxIndex)
			value 	:=	this.Object[key]
		else,	key :=	""
		return,,	key !=	""
}	}


/* 
; The following DllCall is optional: it tells the OS to shut down this script first (prior to all other applications).
DllCall("kernel32.dll\SetProcessShutdownParameters", "UInt", 0x4FF, "UInt", 0)
OnMessage(0x0011, "WM_QUERYENDSESSION") 
return,
WM_QUERYENDSESSION(wParam, lParam)
{
    ENDSESSION_LOGOFF := 0x80000000
    if (lParam & ENDSESSION_LOGOFF)  ; User is logging off.
        EventType := "Logoff"
    else,  ; System is either shutting down or restarting.
        EventType := "Shutdown"
    try
    {
        ; Set a prompt for the OS shutdown UI to display.  We do not display
        ; our own confirmation prompt because we have only 5 seconds before
        ; the OS displays the shutdown UI anyway.  Also, a program without
        ; a visible window cannot block shutdown without providing a reason.
        BlockShutdown("Example script attempting to prevent " EventType ".")
        return, false
    }
    catch
    {
        ; ShutdownBlockReasonCreate is not available, so this is probably
        ; Windows XP, 2003 or 2000, where we can actually prevent shutdown.
        MsgBox, 4,, %EventType% in progress.  Allow it?
        IfMsgBox Yes
            return, True  ; Tell the OS to allow the shutdown/logoff to continue.
        else
            return, false  ; Tell the OS to abort the shutdown/logoff.
    }
}
BlockShutdown(Reason)
{
    ; If your script has a visible GUI, use it instead of A_ScriptHwnd.
    DllCall("ShutdownBlockReasonCreate", "ptr", A_ScriptHwnd, "wstr", Reason)
    OnExit("StopBlockingShutdown")
}
StopBlockingShutdown()
{
    OnExit(A_ThisFunc, 0)
    DllCall("ShutdownBlockReasonDestroy", "ptr", A_ScriptHwnd)
}
; Uncomment the appropriate line below or leave them all commented to
;   reset to the default of the current build.  Modify as necessary:
; codepage := 0        ; System default ANSI codepage
; codepage := 65001    ; UTF-8
; codepage := 1200     ; UTF-16
; codepage := 1252     ; ANSI Latin 1; Western European (Windows)
if (codepage != "")
    codepage := " /CP" . codepage
cmd="%A_AhkPath%"%codepage% "`%1" `%*
key=AutohotkeyScript\Shell\Open\Command
if A_IsAdmin    ; Set for all users.
    RegWrite, REG_SZ, HKCR, %key%,, %cmd%
else,            ; Set for current user only.
    RegWrite, REG_SZ, HKCU, Software\Classes\%key%,, %cmd%
 */
  ;hotkey, LControl & RAlt, volup
/* 
HK_WMP_ 			 :=  "<^>!" ;global yt_arr
HK_WMP_ARR			 :=  []
HK_WMP_ARR["PgUp" ]	 :=  "wmpVolUp"
HK_WMP_ARR["PgDn" ]	 :=  "VolDn"
HK_WMP_ARR["Space"]  :=  "PauseToggle"
HK_WMP_ARR["Left" ]	 :=  "JumpPrev"
HK_WMP_ARR["Right"]  :=  "JumpNext"

for index, element in HK_WMP_ARR
	hotkey,% ki:= (HK_WMP_ . index),% element
return 
VolDn:
VolUp:
wmpVolUp:
if dbgtt
	traytip, test, vol
PauseToggle:
JumpPrev:
JumpNext:
tooltip asdsd
result := (Send_WM_COPYDATA(A_thislabel, WMPMATT)) ;result := (Send_WM_COPYDATA(%a_thislabel%, WMPMATT))
return
*/



