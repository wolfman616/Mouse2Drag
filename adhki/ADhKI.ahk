	A_ScriptStartTime:=	A_TickCount
;,	A_ss:=	A_now
	Stopwatch_("start")
				 #noEnv					; (MW:2021-23) ;
			 #NotrayIcon
			#IfTimeout,200 		; <---;DANGER*--; (Performance impact if set too low*)
		#SingleInstance,		Force
#maxhotkeysPerInterval,	1440
 #maxThreadsPerhotkey,	3
	#InstallMouseHook
	#InstallKeybdHook
		 #MenuMaskKey,vkE8
			#KeyHistory,30
			 #UseHook,	On
			listlines,	On
			 SendMode,	Input
	SetControlDelay,-1
		 ;SetKeyDelay,-1
	SetBatchlines,	-1
		 SetWinDelay,	-1
	 DetectHiddenText,On
DetectHiddenWindows,On
	Settitlematchmode,2		;Was-"Slow"- ;(?:^)(")|(?:^.)(")|(")(?:$)|(")(?:.$)
	CoordMode,Tooltip,Screen
	  CoordMode,Caret,Screen
	  CoordMode,Mouse,Screen
	  CoordMode,Pixel,Screen
; ; =-=-=-  =-=-=-=  =-=-=-= ;  ; =-=-=-  =-=-=-=  =-=-=-= ;||; =-=-= ! =-=-= ;||; =-=-=-= ;
SetworkingDir,% (PathAHKExE:= Splitpath(A_AhkPath)).Dir  ; ; ; ; this-scripts-location ; ; ;
TrayIcOPth:= "C:\Icon\256\trusted.ico"	; Tray-icon ;=-; ;=-=-=-=-=-=-=-=-=-=-=-=-; ;=-=-; ;
rPiD := rP_ID_Gui("XLab")	; PiD ;					-=-; ;=-=-=-=-=-=-=-=-=-=-=-=-; ;=-=-; ;
; ; =-=-=-=-=-=-=-=-=-=-=-=-; ;=-=-=-=-=-=-=-=-=-=-=-=-; ;=-=-=-=-=-=-=-=-=-=-=-=-; ;=-=-; ;
_iNiT_SeQ:= "Varz>Blacklist_RegRead>Blacklist_ParseArr>WheeljewclawRegRead>MenuTray>Binds>AeroSnapInit>Groupinit>OnMsgzReg" ;
;-----======---------===----;-----======---------===----;-----======---------===----;----; ;
global UProc:= RegisterCallback("UEventHook","")	; WinH00k ;===----------;===----;----; ;
, infoTip_timeout:= -30000	; Win spy-Info Tooltip self destruction timeout (Ms). ;------; ;
, Kb_vis_feedback:=	True	; KB-Input Desktop-Gui ;-=========----------;===----;--------; ;
, m0_vis_feedback:=	True	; Mouse-Input Desktop-Gui ;=======----------;===----;--------; ;
, CtrlVPasteMsg	:=	False	; Clipboard-interaction notification msgbox ;===----;--------; ;
; -=========------	; 	BLOCKED-KEYS/TITLE		;		-=========----------;===----;----; ;
, CapsLockReqMod:=	True	; Enact CapsLock = (Shift & Caps) ;---------;===----;----;-;
, BList_NmPad:=	"ahk_exe wmplayer.exe,ahk_Class MozillaWindowClass" ;blisted "NumPad" Clss ;
, BList_F1_12:=	"ahk_eXe notepad++.exe,ahk_Group Desktop
 				,ahk_Class MozillaWindowClass" 								;"F-Keys";
, WList_F1_12:=	"ahk_Class AutoHotkey;f5,ahk_Group Desktop;f5,ahk_Class MozillaWindowClass;f5
				,ahk_Class MozillaWindowClass;f11,ahk_Class MozillaWindowClass;f12
				,ahk_Class MozillaWindowClass;f10,"
, BList_Arr0w			:=	"YouTube"	; Disabled Arrow keys, in this W-Titles list. ;
, BList_num0_9			:=	"ahk_Class MozillaWindowClass"	; Disabled Numeric 0-9 Key list ;
, EscCloseActWL_Exe		:=	"vlc,fontview,RzSynapse,ApplicationFrameHost,ExecTI,explorer
							,Professional_CPL,FileTypesMan,Discord,ScreenToGif2,ImageGlass
							,mmc,PowerToys.Settings,mame64"	; If-Active,Esc Closes these processes.;
, EscCloseAskWL_Exe		:=	"regedit,WMPlayer"	  ; If Active,Esc Prompts to Close these processes.;
, EscCloseFocWL_ahkTTL	:=	"gif-view," 		  ; If-Active,Esc Prompts to Close these WinTitles.;
, EscCloseRate:= 666		; Esc-Close-rate sleep (Ms) ( prevent unintentional closures. ) ;
, Word_Inversion_Dictionary_CSVSTR:= "man,woman,sun,moon,nigger,good person"	; define additional invesrion dictionary members.

gosub,iNiT_SeQ_init

global C:= 0

;-= -= -= -=  - - - - --= -= -= -=  - - - - --= -= -= -=  - - - - --= -= -= -=  - - - - --= -=-;

GroupAdd,Exp,ahk_Class CabinetWClass
GroupAdd,Exp,ahk_Class WorkerW

;-= -= -= -=  - - - - --= -= -= -=  - - - - --= -= -= -=  - - - - --= -= -= -=  - - - - --= -=-;

FPSTest:= False, EventWMhandla:="C:\Script\AHK\winevent_WMHANDLA.ahk"
dbgTT:= False ; Debug ToolTips (annoying / mostly useless) ;

M2dTimeoutThreshMS:= 670	; Right Mouse Button Supression time-threshold (Ms) ;
, OptM2dAutoActiv8:= True	; M2Drag Activate target. ;
, M2dStickySnap:= True 	; Snapd windows stay Snapd more. ;add thresh. ;
, M2dLB_ResiZe:= True 	; M1resize while M2Dragging. ;
, KbypassArrow:= True	; Enable KeyBlocking filter. ;
, KBypassNmpad:= True	; Numpad Blocking. ;
, KbypassFKeys:= True	; F1-12 Suppresion. ;
, RateUndoRedo:= 300	; Undo/Redo Rate (Ms) ;

SetNumLockState,On
SetCapsLockState,Off
SetScrollLockState,Off

m41n:
OnExit("x1t")
 WM_Allow()

	KbLED()
	(PathAHKExE:= Splitpath(A_AhkPath)).fn
,	 (_:= Splitpath(A_scriptFullPath).fn " Started`n@ " time4mat() "   In:  "
.	_:= a_tickCount-a_ScriptStartTime " Ms")
, hSmIcon:= LoadPicture("C:\Icon\24\ey3y3 24.ico","w24 Icon" . Index,ErrorLevel)
, hLgIcon:= LoadPicture("C:\Script\AHK\- Script\WinSpy\Resources\eyeopen48.ico","w48 Icon" . Index,ErrorLevel)
	SendMessage,0x80,0,hSmIcon,,ahk_id %a_scripthwnd% ; WM_SETICON,ICON_SMALL
	SendMessage,0x80,1,hLgIcon,,ahk_id %a_scripthwnd% ; WM_SETICON,ICON_LARGE
	SPI_THREADLOCALINPUT("Toggle")
stopwatch_()
return,

;-= -= -= -=  - - - - --= -= -= -=  - - - - --= -= -= -=  - - - - --= -= -= -=  - - - - --= -=-;
#s::run,C:\Script\AHK\- _ _ LiB\selectarea.ahk
#t::SPI_THREADLOCALINPUT(Mode="Toggle")
return,

SPI_THREADLOCALINPUT(Mode="Toggle") {
	Old_Res:= retest:= True
	Switch,mode {
		case,"Toggle": New_Res:= !Old_Res
			_:=dllcall("SystemParametersInfoW","UInt",0x104E,"UInt",0,"UInt",&Old_Res,"UInt",0,"UInt")
			_:=dllcall("SystemParametersInfoW","UInt",0x104F,"UInt",0,"UInt",New_Res, "UInt",0,"UInt")
			_:=dllcall("SystemParametersInfoW","UInt",0x104E,"UInt",0,"UInt",&retest, "UInt",0,"UInt")
			return,!(retest=Old_Res)? New_Res ; PassBk New-State
}	}

;-= -= -= -=  - - - - --= -= -= -=  - - - - --= -= -= -=  - - - - --= -= -= -=  - - - - --= -=-;

Groupinit: ; Group-Definition ; )
 GroupAdd,Desktop,ahk_Class CabinetWClass
 GroupAdd,Desktop,ahk_Class ExploreWClass
 GroupAdd,Desktop,ahk_Class WorkerW
 GroupAdd,ahk,ahk_Class AutoHotkeyGui
 GroupAdd,ahk,ahk_Class AutoHotkey
return,

TILDE_send:
TILDE_send2:
return,

Stylemen_Go:
result:= Send_WM_COPYDATA("stylemenu","AHK_ID " hWinEventwnd:= winexist("WinEvent.ahk ahk_class AutoHotkey"))
return,

Binds:
hotkey,% key_trans_colour:= "^#i",mouse_transcol_init,on
hotkey,% key_trans_reset:= "^1",trans_reset,on
hotkey,% key_trans_inc:= "^3",trans_inc,on
hotkey,% key_trans_dec:= "^2",trans_dec,on
hotkey,% key_OCR_init:= "#C",OCR_init,on
hotkey,% key_aero:= "#b",aero_init,on

hotkey,^rbutton,Stylemen_Go,on

hotkey,% HK_WMP_Q_fromexp:= "^q",Explorer_verb_hk,on

hotkey,~break,DisplayStandby,on

; -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~hotkeys-~-~-~-~-~-	-~-~-~-~	~-~-~-~- ~-~-~-
;hotkey,IfWinActive,ahk_exe werfault.exe ;hotkey,^V,Paste,ON
;hotkey,~LButton,TILDE_send2,on
hotkey,IfWinActive,ahk_exe AutoHotkeyU64_UIA - admin.exe ;hotkey,^V,Paste,ON
hotkey,~LButton,TILDE_send,on
hotkey,if

;hotkey,IfWinNotActive,ahk_exe AutoHotkeyU64_UIA - admin.exe ;hotkey,^V,Paste,ON

hotkey,~LButton,ElButtoon,On

hotkey,if,(Rbd)
hotkey,~LButton,ElButtoon,off
hotkey,LButton,ElButtoon,on
hotkey,if

;hotkey,~LButton & Space,infoTip_togl__,On ;hotkey,RButton,m2drag,On

; NPPlusPlus ;
HK_NP_LineCommentTogl_	:= "^;"
HK_NP_Save_2_Reload		:= "~^s"
HK_NP_space:= "space"

hotkey,ifWinActive,ahk_exe notepad++.exe
hotkey,%HK_NP_space%,HKi_Handl4,on ;hotkey,%hk_np_lineCommentTogl_%,np_lineCommentTogl_,on
hotkey,%hk_np_save_2_reload%,saveReloadScript,on ;hotkey,%hk_np_lineCommentTogl_%,np_lineCommentTogl_,on
hotkey,IF

loop,parse,% mag_key:= "#M,F23 & MButton",`, ;+#M
	hotkey,%a_loopfield%,mag_init,On
hotkey,^#MButton,infoTip_togl__,On

;caps_as_shift:= True
; if(caps_as_shift)
   ; hotkey,capslock,SendShift,on
; if(CapsLockReqMod)
; hotkey,^!Capslock,,on

loop,parse,% "+,^,^!,,^+,!",`,
	hotkey,% a_loopfield "Capslock",HKi_Handl4,on
loop,parse,% "^;,+2,^+2,+5,+9,+0,[,],+[,+],+1",`,
	hotkey,% a_loopfield,HKi_Handl4,on
hotkey,% "^Up",2kShuff,on ;hotkey,~LAlt,Wt_,On
hotkey,% "^!Enter",PHRun,on

; hotkey,IFWinActive,ahk_Class ConsoleWindowClass ;

regRead,me_email,HKEY_CURRENT_USER\Software\_MW,me_email
;msgbox % me_email

hotkey,% "^V",Paste,On ;hotkey,If
hotkey,% "^down",2kShuff,On
hotkey,% "~$f23",mspeedset,on
hotkey,% "~$f23 Up",mspeedunset,on
hotkey,% xboxbigx,retroarch,On
loop,parse,% keys_sizewin:= "~^-,~^=",`,
	hotkey,%a_loopfield%,sizewin,on
loop,parse,% "~!f13,~!f14,~!^+u,~^+f6,~#Tab,~^+!#h,~^!z,~+WheelUp,~+WheelDown",`,
	hotkey,%a_loopfield%,tablet_gestures,on
loop,parse,% "Digits_MAIN,togl_numpad_i,arrow_bypasscheck,KBypass_f1_12_Enable,wmpbinds",`,
	gosub,% a_loopfield
hotkey,#LButton,BumBluries,on
return,
#if (Rbd)
^f4::tt(test)
#IF
#if infoTip_isactive
	^#c::
	setTimer,infoTip_Copy,-1
	global infoTip_iscopied:= False
	setTimer,infoTip_togl,-15000
	return,
#if infoTip_iscopied
	~^v::
	infoTip_iscopied:= False
	setTimer,infoTip_togl,-666
	;sendinput,^v
	return,
#if

;----------------------------- MIDDLE-MOUSE-BUTTON ;-----------------------------
; if(Explorer_MMB_OpenInNEW) { ;Switch,pn {;case,"explorer.exe":};if(PN=""){;((CN="CabinetWClass")
	; MouseGetpos, , ,mmbhWnd , mCtlName
	; Switch,mCtlName {
		; case,"SysTreeView321","SysTreeView322" : send,{^}{~LButton}
		; case,"ToolbarWindow322","ToolbarWindow323" : send,{^}{~LButton}
	; } ;if(mCtlName="SysTreeView321"){ ;msgbox,% res:=Explorer_GetSelection(hWnd=hVund) ;NOTWORKING
; } else,send,{MButton}
; return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;hotkey,#LButton, stLButton,on
; -~-~-~-~-~-~-~-~-~-~-~-~-~-~-H0tStr'z-~-~-~-~-~-~-~-~	~-~-~-~-	-~-~-~-~ -~-~-~-~-~
::btw::by the way
::myemail::% me_email
; -~-~-~-~-~-~-~-~-~-~-~-~-~-~-BINDS-~-~-~-~-~-~-~-~-~-~-	-~-~-~-~	~-~-~-~- ~-~-~-
;~^!NumpadDot::exitapp  ;>=====  Ctrl=Alt-NUMPAD=DOT   ====>(  EXiT  )=====<
~^!ScrollLock::TT("Script shutting down`nplease wait..." . exitapp())  ;>=====  Ctrl=NUMPAD=DOT   ====>(  -NORMAL=RIGHT=CLICK-  )=====<
 ^!Backspace:: Timer("explorer_kill",-1)  ;<<<<<<<<<<<<<< Ctrl=ALT=BACKSPACE >>>>>>>>>>>>>>>>
 ^!CtrlBreak::TT("Shut it down...ahk_exit_ALL()") ;<<<<<<<<<<<<<< Ctrl=ALT=BACKSPACE >>>>>>>>>>>>>>>>
 ^!Home::TT(run(a_winDir "\system32taskmgr.exe /7") "TaskMan Launching...") ;<<<<<<<<<<<<<< Ctrl=ALT=BACKSPACE >>>>>>>>>>>>>>>>

 ; LControl & RAlt:: Send,{lAlt Down}
 ; LControl & RAlt Up:: Send,{lAlt Up}

WMPBinds:
loop,parse,% _:="<^>!x,<^>!c,<^>!PgDn,<^>!Left,<^>!Right,<^>!space,<^>!f,<^>!s,<^>!Enter,<^>!Del,<^>!p",`,
{
	hotkey,IfWinExist,% WMPMATT
	hotkey,% a_loopfield,wmp_bind,On
} return,

SendCaps:
sendinput,{Capslock}
return,

SendShift:
init? return() : init1:= True
send,{Shift down}
while(getkeystate(a_thishotkey,"P"))
	Ssleep(4)
send,{Shift up}
init1:= False
return,

; capslock & s::
; hwnd:=winexist("A")
; ControlGetFocus, cname,ahk_id %hwnd%
; (eRRORlEVEL? tt("tHE TARGET WINDOW DOESN'T EXIST OR NONE OF ITS CONTROLS HAS INPUT FOCUS.",3), return())
; ControlGet,cWnd,Hwnd,, %cname%,ahk_id %hwnd%
; msgbox % cWnd
; ControlGet, sel, Selected ,,,ahk_id %cWnd%
; msgbox % sel
;  TT("Control with focus = " cname "`n Contents selected = " capitalize(sel))

;Capslock::Shift
;$Capslock::return,
;+CapsLock::
;return,

H00KMB:
HookMb:= dllcall("SetWinEventHook","Uint",0x0010,"Uint",0x0010,"Ptr",0,"Ptr"
, ProcMb_:= RegisterCallback("onMsgbox",""),"Uint",0,"Uint",0,"Uint",OoC)
 CapsState:= GetKeyState("CapsLock","T")
 send,{CapsLock}
TT(CapsState)

Digits_MAIN:	;digits keywrap
loop,9 {
 h_KI:= A_index ;Shift_KI := ( "+" . A_index )
 hotkey,If,
 Loop,Parse,BList_num0_9,`,
 {
	hotkey,	IfWinActive,	%a_loopfield%
	hotkey,	%h_KI%, Digits_0_9, on
	hotkey,	IfWinActive,	%a_loopfield%
	hotkey,	0,	Digits_0_9, on
	hotkey,	IfWinActive,	%a_loopfield%
	hotkey,!%h_KI%,	Digits_0_9,	on
	hotkey,	IfWinActive,	%a_loopfield%
	hotkey,	0,	Digits_0_9, on
 }	} ; hotkey,+0, Digits_0_9
return,

Digits_0_9:	;	 disable digit-keys ( for youtube mainly )
ifWinActive,ahk_group desktop
{
	WingetActiveTitle,Title_Active
	if(!instr(Title_Active,"YouTube")) {
		handle:= WinActive("A")
		ControlGetFocus,cfo,% heh:= "ahk_id " . handle
		if(instr("Edit1",cfo)||instr(cfo,"Edit1"))
			Goto,KB_SendSelf
		else,traytip,ADHKey,% "Numbers disabled`nhold alt combo...",1,34
	}	else,traytip,ADHKey,% "Numbers disabled in Youtube`nPress Shift with them...",1,34
} else {
	ifWinActive,ahk_Class MozillaWindowClass
	if(!instr(a_thishotkey,"!")) {
		WingetActiveTitle,Title_Active
		if(instr(Title_Active,"YouTube")) ;evade number binding -> transport
			traytip,YouTube,% "Numbers disabled`nCombine with Alt...",1,34
		else,Gosub("KB_SendSelf")
	} else,SendKiLongnanme(k:=strReplace(a_thishotkey,"!"))
} return,

OnMsgzReg:
	Wm_OnMsgs:= []
	loop,parse,% "0x203,0x0A1,0x201,0x404,0x0A2,0x202,0x4a",`,
	{
		switch,A_Loopfield {
			case,0x203:_:="WM_LButtonDBLCLK"
			case,0x0A1:_:="WM_NCLButtonDOWN"
			case,0x201:_:="WM_LButtonDOWN"
			case,0x404:_:="AHK_NOTIFYICON"
			case,0x0A2:_:="WM_NCLButtonUP"
			case,0x202:_:="WM_LButtonUP"
			case,0x04a:_:="Receive_WM_COPYDATA"
		}
		Wm_OnMsgs[a_index]:= OnMessage(A_Loopfield,_)
	}
return,

f23 & rButton::
rButton:: ; M2DRAG; M2DRAG; M2DRAG; M2DRAG; M2DRAG; M2DRAG; M2DRAG; M2DRAG; M2DRAG; M2DRAG; M2DRAG; M2DRAG
m2Drag: ; M2Drag MOUSE2 Right Mouse Button  <======== TIME TO WITNESS THE AGONY MM<<=========
m2time_S:= a_tickcount
fuckinggay:=False
MouseGetpos,X_MSt4,Y_MSt4,RBhWnd,rbcnthWnd,2
(trigger_resize? RBhWnd:= trigger_resize_hWnd)
Wingetpos,X_Win,Y_Win,W_Win,H_Win,% (idd:=("ahk_id " . RBhWnd))
M2_Drag_Ready:
MouseGetpos,X_Cur,Y_Cur
if(!M1_Trigger) {
	X_Win_S:= X_Win, Y_Win_S:= Y_Win, W_WinS:= W_Win, H_WinS:= H_Win
	if(_:= WinExist(CntxtClssFFx)) ;; Firefox menu ;;
		WinClose,ahk_id %_%
} if(a_thishotkey="rButton")
	MD_Bind:= a_thishotkey, MD_Meth:= "P"
if(Bypass_title_True||Bypass_PN_True||Bypass_Cls_True) {
	Gosub("m2dReady")
	return,
} if(!RB_D) {
	B_D:= True, ;m2time_S:= A_tickcount
	Gosub("Corner_Offset_get")
	Gosub("m2dWinPos_Agg")
} if(EvaluateBypass_Class(RBhWnd)) {
	Bypass_Cls_True:= True
	Gosub("BypassDrag")
	return,
} else,if(EvaluateBypass__Proc(RBhWnd)) {
	Bypass_PN_True:= True
	Gosub("BypassDrag")
	return,
} else,if(EvaluateBypass_Title(RBhWnd)) {
	Bypass_title_True:= True
	Gosub("BypassDrag")
	return,
} ;else {	;MouseGetpos,X_Cur,Y_Cur,RBhWnd
; ((M1_Trigger)? X_Win_S:= X_Win, Y_Win_S:= Y_Win
;, W_WinS:= W_Win, H_WinS:= H_Win);}

m2dReady:
while(getKeyState("rButton","P")) {
	if(EvaluateBypass_Class(RBhWnd)) {
		Bypass_Cls_True:= True
		Gosub,BypassDrag
		return,
	} else,if(EvaluateBypass__Proc(RBhWnd)) {
		Bypass_PN_True:= True
		Gosub,BypassDrag
		return,
	} else,if(EvaluateBypass_Title(RBhWnd)) {
		Bypass_title_True:= True
		Gosub,BypassDrag
		return,
	} else,sl33p()
	Gosub,m2dWaiting
} Goto,RBReset1
return,

/*
	;RBD_ClickThreshMs(Arg="") { ;; m2drag subroutine X/Y Trigerer from timer (not X/Y)
	;(invoked from timer, at time delay specified, results in forced actuation of
	;	global XYThresh from m2drag subroutine...;(Effectively inDirectly buffers the current Rbutton release,) ;global XYThresH ;global ;(n00s:= getKeystate("RButton","D")? XYThresH:= True) ; D/w XYThresh Garbage collected each keystroke via RB_CLEAN_VARS; ;msgbox,% n00s ;}
*/

m2dWaiting:
MouseGetpos,X_Cur,Y_Cur
X_MSt4:= X_Cur,Y_MSt4:= Y_Cur
Wingetpos,X_Win_S,Y_Win_S,W_Win,H_Win,% "ahk_id " RBhWnd
Gosub,m2dWinPos_Agg
LBTrigga:= False
if(!(X_Cur=X_Old)&&!(Y_Cur=Y_Old)) {
	if(!(getKeyState("LButton","P"))) {
		(Trigger_Resize)? (Trigger_Resize_hWnd:= RBhWnd, Goto("M2Drag")):()
		Xnet:= X_Cur -X_MSt4, Ynet:= Y_Cur -Y_MSt4, _WW_:= _HH_:= "" ;else,
	} x0x:= X_Win_S +Xnet, y0y:= Y_Win_S +Ynet
	if(!(getKeyState("LButton","P"))) {
		Wingetpos,,dY_,,dH_,% "ahk_id " RBhWnd
		if(dh_=TargetdH && dy_=TargetdY)
			 SnapdV:= True
;;;if(M1_Trigger) { ;procs post m1drag stops jerkons	;;	msgbox;;	;sendMessage,WM_LB_up,cornerclicked,,,ahk_id %RBhWnd%	;;;		TrigCorner:= XCorner:= YCorner := ""	;;;		MouseGetpos,X_MSt4,Y_MSt4	;;;		Wingetpos,X_Win_S,Y_Win_S,W_Win,H_Win,% "ahk_id " RBhWnd	;;;		x0x:= X_Win_S, y0y:= Y_Win_S;;;		} ; Gosub,m2dWinPos_Agg ;Gosub,corner_offset_get2 ;Gosub,DimensionChk

	/* 	;else ;{ ;if(IsWindowVisible(_:= WinExist(CntxtClssFFx))) ;Firefox menu
		; WinClose,ahk_Class %CntxtClssFFx%
		;	sleep,1000 ;	msgb0x(CntxtClssFFx " closed")
		;if(IsWindowVisible(_:= WinExist(CntxtClss_main))) ;normal menus
		;	WinClose,ahk_Class %CntxtClss_main% ;winget, idi, id, ahk_Class #32769
		;	sleep,1000 ;	msgb0x(CntxtClss_main " closed")
		;if(IsWindowVisible(_:= WinExist("ahk_Class #32769"))) { ;normal menus
		;	iFWinActive(_) {
		;		sendinput,{escape} ;WinClose,ahk_id %_%	sleep,1000 msgb0x(_ "higGireR")
	 */	; } ;}
		Winhide,ahk_Class %CntxtClss_main%
		Winhide,ahk_Class %MozillaDropShadowWindowClass%
		winexist("ahk_id " RBhWnd)
		(optM2dAutoActiv8? winActivate(RBhWnd))
		((!LBTrigga="")? return())
		Wingetpos,X_Win_S,Y_Win_S,W_Win_s,H_Win_s
		MouseGetpos,X_MSt4,Y_MSt4 ;critical
		(fpstest? (Frame_i:= 0,times:= a_tickcount))
				PostMessage, 0xA1, 2 ,,ahk_id %RBhWnd% ; WM_NCLBUTTONDOWN

		while,getKeyState("RButton","P") {
			rbd:= True
			if(m1_trigger) {
				MouseGetpos,X_Cur,Y_Cur
				m1_trigger:=False, X_MSt4:=X_Cur,Y_MSt4:=Y_Cur
				Wingetpos,X_Win_S,Y_Win_S,W_Win,H_Win,% "ahk_id " RBhWnd
			} else {
				MouseGetpos,X_Cur,Y_Cur
				if(SnapdV&&M2dStickySnap) {
					if(dh_=TargetdH&&dy_=TargetdY) {
						Wingetpos,,dY_,,dH_,% "ahk_id " RBhWnd
						WinMove(RBhWnd,(X_Cur-X_MSt4+X_Win_S),TargetdY,W_Win,H_Win)
					} else {
						SnapdV:=False, WinMove(RBhWnd,(X_Cur-X_MSt4+X_Win_S)
						, (Y_Cur-Y_MSt4+Y_Win_S),W_Win,H_Win)
					}
 				} else {
					if(fuckinggay) {
						Wingetpos,X_Win_S,Y_Win_S,W_Win,H_Win,% "ahk_id " RBhWnd
						MouseGetpos,X_MSt4,Y_MSt4 ;critical
							WinMove(RBhWnd,X_Win_S,Y_Win_S,W_Win,H_Win)
				,	X_Cur:=X_MSt4, Y_Cur:=Y_MSt4
						,fuckinggay:= false
					} WinMove(RBhWnd,(X_Cur-X_MSt4+X_Win_S)
					, (Y_Cur-Y_MSt4+Y_Win_S),W_Win,H_Win)
				} Frame_i++
				;((Frame_i=200)? (fps:=(((a_tickcount-times)*.002)**-1)*1000, tt(fps))) ; / Frame_i
				if(getKeyState("LButton","P")) { ; Wingetpos,X_Win_S,Y_Win_S,W_Win_s,H_Win_s
					;MouseGetpos,X_MSt4,Y_MSt4
					;gosub,corner_offset_get ;sleep,1
					m1_trigger:= True
					;return,
				} ;loop,666
			}
			Ssleep(10) ;,1 ; (!M1_Trigger?sl33p():sleep(1)) 			;sleep,10
		} ;WM_WINDOWPOSCHANGED()
	} else,	{	;nothing ;msgbox dicks 2
		sendMessage,% WM_LB_down,% WMReSz_%YCorner%_%XCorner%,,,ahk_id %RBhWnd%
		LBTrigga:= M1_Trigger:= M1Resize:= True
	}
} else { ;msgbox dicks 3
	Gosub("m2dWinPos_Agg")
	Gosub("Corner_Offset_Get2")
	Gosub(	"DimensionChk"	)
} if(!XYThresH) { ;Movement-thresh,
	((a_tickcount>(m2time_S+M2dTimeoutThreshMS))? XYThresH:= True
	: ((X_Cur<X_MSt4-25||X_Cur>X_MSt4+25||Y_Cur<Y_MSt4-25||Y_Cur>Y_MSt4+25)
	? XYThresH:= True, ((!triglb1)? Bypass_Last_Dragged_GUI
	, DragbypassClass_new_possible:= "ahk_id " . RBhWnd
	, DragbypassMenu_Enabled:= "")))
} else { ;________________.XY_ThReSH_ProCCeD.________________: }
	/* 	;if(a:= WinExist(CntxtClssFFx))	;FF0x-Menu;
	;|| if(aa:= WinExist(CntxtClss_main))		;Normal-Menu;
	;winget,idi,id,ahk_Class #32769			;Expl0r4-Drop-Menu;
	;if(aa:= WinExist("ahk_Class DropDown"))
	;	WinClose,ahk_id %aa%
	;wingetClass,CL,ahk_id %RBhWnd%
	;if(CL="CabinetWClass")
	;	sendinput,{escape}
	*/

	((!Status_M2Drag)?Status_M2Drag:= True ) ; <_____ ; __M2Drag-Start__ ; _____> ;
	if(getKeyState("LButton","P") ) {
		if(!M1_Trigger) {
		LBTrigga:= M1_Trigger:= M1Resize:= True
		,	x0x:= X_Win_S +Xnet, y0y:= Y_Win_S +Ynet
			Gosub("corner_offset_get2"), Gosub("position_offset_get")
		} Frame_i:= 0 ;critical
		(fpstest? times:= a_tickcount)
		while,getkeystate("LButton","P") {
			Wingetpos,X_Win_S,Y_Win_S,W_Win,H_Win,% "ahk_id " RBhWnd
			Xnet:= X_Cur-X_MSt4, Ynet:= Y_Cur -Y_MSt4 ;,	Frame_i++
			x0x:= X_Win_S +Xnet, y0y:= Y_Win_S +Ynet
			X_Win:=X_Win_S, y_Win:=Y_Win_S
		;,	((Frame_i=200)? (fps:=(((a_tickcount-times)*.002)**-1)*1000 ; / Frame_i
		;,	tt(fps " FPS")) : (Frame_i>300? tt("Iter: "Frame_i)))
			Ssleep(10) ; ;sl33p()
	}
	M1_Trigger:= M1Resize:= False ;:= False settimer,tt,-1
	Wingetpos,X_MSt4,Y_MSt4
	postMessage,% WM_LB_up,17,,,% "ahk_id " RBhWnd
	send,{LButton up} ;send,{blind}{LButton up}

	sleep,100
	global M1_Trigger:= True
		return,
	}
} return,

if(!insight) {
	Winget,m2d_WinState,MinMax,ahk_id %RBhWnd%
	CursorChange:= insight:= 1
	tt("niggerzz")
	if((m2d_WinState=1))
		return,
	else,while(getKeyState("rButton","P")) {
	tt("buggernug")
		if(!XYThresH) {
			if(X_Cur<X_MSt4-25)||(X_Cur>X_MSt4+25)
			||(Y_Cur<Y_MSt4-25)||(Y_Cur>Y_MSt4+25) {
				XYThresH:= True, DragbypassClass_new_possible:= "ahk_id" . RBhWnd
				MouseGetpos,X_MSt4,Y_MSt4,RBhWnd
				Wingetpos,X_Win,Y_Win,W_Win,H_Win,ahk_id %RBhWnd%
			} else {
				MouseGetpos,X_Cur,Y_Cur
				if((X_Cur<(X_MSt4-25))||(X_Cur>(X_MSt4+25))||(Y_Cur<(Y_MSt4-25))
				||(Y_Cur>(Y_MSt4+25))) {
					m2d_MidW:= A_ScreenWidth *0.333, m2d_MidX:= X_Cur - (W_Win *.5)
					m2d_MidY:= Y_Cur-(H_Win *0.333), m2d_MidH:= A_ScreenHeight *.5
					winRestore,ahk_id %RBhWnd%
					Wingetpos,X_Win,Y_Win,W_Win,H_Win,ahk_id %RBhWnd%
					WinMove(RBhWnd,m2d_MidX,m2d_MidY,W_Win,H_Win)
	}	}	}	}
	(XYThresH? DragbypassClass_new_possible:="ahk_id " . RBhWnd)
} return,

BypassDrag:
send,{rButton down}
MouseGetpos,X_MSt4,Y_MSt4,mw
Wingetpos,X_Win,Y_Win,W_Win,H_Win,ahk_id %RBhWnd%
if(!XYThresH) { ; threshold of xy movement, afterwhich no longer a standard right click
	while(getKeyState("rButton", "P") ) {
		getKeyState,KSLB,rButton,"P"
		((KSLB="D")? LBDD:= True)
		MouseGetpos,X_Cur,Y_Cur,m_hund,cn
		Wingetpos,X_Win,Y_Win,W_Win,H_Win,% "ahk_id " RBhWnd
		;if (X_Cur<X_MSt4-25)||(X_Cur>X_MSt4+25)||(Y_Cur<Y_MSt4-25)||-(Y_Cur>Y_MSt4+25) {
			; if !triglb1 {
				; DragAllowClass_new_possible =ahk_id %RBhWnd%
				; menu, tray, NoStandard
				; menu, tray, add, Add last attempted window drag to whitelist, Open_Options_GUI,
				; menu, tray, standard
				; XYThresH := True, DragAllowMenu_enabled := True	, triglb1 := True		; }		;}
		if(mcls="#32768") {
			MouseGetpos,,,m_hundl
			((!ahkmenu)? ahkmenu:= winExist("ahk_class #32768 ahk_exe AutoHotkeyU64_UIA.exe"))
		} else,wingetclass,mcls,ahk_id %m_hund%
	sleep,1
	}
} if(ahkmenu:= (winExist("ahk_class #32768 ahk_exe AutoHotkeyU64_UIA.exe"))!=0x0){
	MouseGetpos,,,m_hundl
	if(m_hundl=ahkmenu) {
		sendinput,{rButton Up}
		send,{LButton}
		ahkmenu:=""
		return,
	}
} else {
	winget,peen,processname,ahk_id %m_hundl%
	if(instr(peen,"autohotkey")) {
		sendinput,{rButton Up}
		send,{LButton}
		ahkmenu:=""
		return,
	}
} send,{rButton Up}
	; if(mcls="#32768") { ;||(mcls="Shell_TrayWnd")
		; send,{~LButton}		; tt("gayyy")	; }
insight:= "", XYThresH:= False, triglb1:= False, Bypass_Cls_True:= False, 	Bypass_PN_True:= False, LBDD:= False,	Bypass_title_True:= False
settimer,CleanRBVars,-1
return,

;-==-===-====-===-==-===-====-===-==-===-====-===-==-===-====-===-==-===-====-===-==-===-====-===-==-===-====-===-==-===-

RBReset1: ;  Mouse2 released without breaching XYThresH
switch,CN,{
	case,"ahk_Class ConsoleWindowClass" : return,	;default :
} ((!XYThresH)&&(!M1Resize))? (m2time_S-a_tickcount<800? SendKiLongnanme("rButton"))
Timer("RBReset2",-1)
return,

RBReset2:
Status_M2Drag:= XYThresH:= M1Resize:= rbd:= RB_D:= M1_Trigger:=  False
Timer("CleanRBVars",-1)
insight:= XYThresH:= False ;, ; M1Resize := False
return,

;[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[
testi: ;==----============----
(EvaluateBypass_Class(RBhWnd)? Bypass_Cls_True:= True
:(EvaluateBypass__Proc(RBhWnd)? Bypass_PN_True:= True
:(EvaluateBypass_Title(RBhWnd)? Bypass_title_True:= True)))
return,
;[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[

BypassDrag2:
send,{rButton Down}
while,getKeyState("rButton","L")
	sleep,2
send,{rButton Up}
settimer,clean2,-1
return,

LBTrigga:
global LBTrigga:= True
return,

Clean2:
insight:= XYThresH:= triglb1:= Status_M2Drag:= M1Resize:= rbd:= RB_D:= M1_Trigger:= False
settimer,CleanRBVars,-1
return,

;m1_resizeGO:
;MouseGetpos,X_Cur,Y_Cur ;Gosub,corner_offset_get
;Gosub("DimensionChk")
;return,

;m1_resizeNO:
;getKeyState,KSLB,LButton,P
;(KSLB = "D"? ((LB_U) ? (M1_Trigge:= LB_U:= False) : (Timer("m1_resizeGO","Off"))) : (rbd:= RB_D:= triglb1:= XYThresH:= False))
;return,

CleanRBVars:
Bypass_Cls_True:= Bypass_PN_True:= Bypass_title_True:= SnapdV:= False
HII:= WII:= x0x:= y0y:= _WW_:= _HH_:= 0
return,

STLButton:
MouseGetpos,,,ShWnd,CSTL,2 ;ControlGet,Ctrlhand,hWnd,,SysListView321,ahk_id %hWnd%
sendmessage,0x0030,0,1,,AHK_ID %CSTL% ; #WM_SETFONT null
TT(cstl "blaxpliit")
return,

ConTxT_iCount_rEval:
(ConTxT_iCount? (!(WinExist("ahk_Class #32768"))? ConTxT_iCount:= False))
return,

Ssleep(stime:=4) {
	DllCall("Winmm\timeBeginPeriod","UInt",3)
	DllCall("Sleep","UInt",stime)
	DllCall("Winmm\timeEndPeriod","UInt",3)
}

sl33p() {
	Ssleep(10)
}

;-==-===-====-===-==-===-====-===-==-===-====-===-==-===-====-===-==-===-====-===-==-===-====-===-==-===-====-===-==-===-
;====-===-==-===-====-===-==-===-====-===-==-===-====-===-==-===-====-===-==-===-====-===-==-===-====-===-==-===-====-===-

s3nd(k3y) {
	send,{%k3y%}
}

CnD(){
	CRITICAL
	send,{Ctrl Down}
	return,% byref bd_J:= True
}

LbU(){
	send,{LButton Up}
	return,% byref bd_I:= False
}

CnU(){
	CRITICAL
	send,{Ctrl Up}
	return,% byref bd_J:= False
}

BDI:
bd_i? bd_i:= False : ()
return,

GetClassLong(hWnd,Param) {
	Static GetClassLong:= A_PtrSize==8? "GetClassLongPtr":"GetClassLong"
	return,DllCall(GetClassLong,"Ptr",hWnd,"Int",Param)
}

BUMbluries: ; #LButton::
mousegetpos,,,MousehWnd,Mouse_cWnd,3
ic:= a_now
Aero_ChangeFrameAreaAll(MousehWnd)
VarSetCapacity(%ic%,16,0)
ii:= wingetpos(MousehWnd)
loop,5
	sleep,20
Left := NumPut(ii.x,%ic%,0), Top	:= NumPut(ii.y,%ic%, 4)
Right:= NumPut(ii.w,%ic%,8), Bottom:= NumPut(ii.h,%ic%,12)
;msgbox,% NumGet(%ic%,0,"Int") " £ £ " NumGet(%ic%, 4,"Int")
bum:= MakeLONG(loword(96),hiword(96)), bugger:= &%ic%
hha:= GetClassLong(MousehWnd,-24)
sendmessage,0x200C,% loword(96),% bugger,,ahk_id %g_hWnd%
dllcall("postMessage","uint",hha,"uint",loword(96),"uint",bugger)
%ic%:=""
return,

^LButton:: ;~^LButton::
LMBInterrupt:= bd_j:= True
while,getkeystate("Ctrl","P") {
	if(getKeyState("LButton","P")) {
		send,{Ctrl down}{LButton Down}
		while,getkeystate("LButton","P")
			sleep,3
		if(getKeyState("LShift","P"))
			send,{Ctrl}{shift}{LButton Up}
		send,{Ctrl}{LButton Up}
		bd_I:= False
		sleep,10
	} sleep,10
} CnU()
LMBInterrupt:= _:= False
return,

WinMove(hWnd="",X="",Y="",W="",H="",byref flags="") {
	static dts:=0
	((dts=0)? (dts:= ((Flags="")
	? (optM2dAutoActiv8? 0x4:0x015):dts:=flags)))
	;;static SWP_NOREDRAW=8,SWP_ASYNCWINDOWPOS=0x4000,SWP_BOTTOM=1,SWP_TOPMOST=-1,SWP_NOTOPMOST=-2
	;;static SWP_NOMOVE=2,SWP_NOSIZE=1,SWP_NOZORDER=4,SWP_NOACTIVATE=0x10,SWP_R=8,SWP_A=0x4000
	;;hFlags := SWP_NOZORDER | SWP_A
	;static global optM2dAutoActiv8
	;static flags, bellcheese:= False
	;tt(dts) ;}
	return,DllCall("SetWindowPos","uint",hWnd,"uint",0,"int",x,"int",y,"int",w,"int",h,"uint",dts)
}

; WinMove(hWnd="",X="",Y="",W="",H="") { ;,Flags=""
; static; static flags, bellcheese:=False
; (!bellcheese)? ((flags:=optM2dAutoActiv8? 0x4005:0x4015):()
; ,(F=""? F:=Flags)) ;return,DllCall("SetWindowPos","uint",hWnd,"uint",0,"int",x,"int",y,"int",w,"int",h,"uint",f) ; }

ElButtoon: ;LButton:: ;LButton:: xylock ;
; if(TILDE_send_LB&&(!TildeTrig)) {
	;;send,{LButton down}	; TildeTrig:= True ; }
if(!(getKeyState("LButton","p")))
	return,
mousegetpos,x,y,hw,cn
LMBInterrupt:= True
if(!(getKeyState("rButton","P"))) {
	lastlclickedtime:= a_tickcount
	if(cn="SysListView321"&&(!TILDE_send_LB)) {
		wingetClass,cn,ahk_id %hw%
		wingetClass,ca,A
		;send,{blind}{LButton Down}
	} ;else,send,{blind}{LButton Down}
	Timer("App_Check",400)
	LMBInterrupt:= False
	buggermylooseARSE:
	while,getkeystate("LButton","P") {
		if(LMBInterrupt) {
			;send,{LButton up}
			LMBInterrupt:= False
			return,
		} ;settimer,dtecttree,-300
		if(getKeyState("Ctrl","P")) {
			CnD()
			while,getkeystate("Ctrl","P") {
				if(!(getKeyState("LButton","P"))) {
					bd_i:= False ;send,^{LButton Up}
					return,
				} sleep,4
			} CnU()
		} sleep,4
	} Timer("App_Check",off) ;(TILDE_send_LB?(TILDE_send_LB:=False,result:= Send_WM_COPYDATA("clickup",EventScript)))
	(TILDE_send_LB? TILDE_send_LB:= TildeTrig:= False)
	;send,{blind}{LButton Up}
	bd_i:= False, Sleep(10)
	return,
} else { ;to my knowledge nothing now executing under here atm;
 	Test_A:= Active_hWnd:= WinExist( "A" ), LB_cWnd22:= ""
	wingetClass,Class_Active,A
	MouseGetpos,X_Cur1,Y_Cur1,LB_hWnd,LB_cWnd22 ;wingetClass,class_active,%  "ahk_id " Active_hWnd
	if(class_active="WorkerW"||instr(m1resizeblackLCL,class_active ","))
		return, ; add_log_m1_resize_prevented++ ;
	((Bypass_PName_True||Bypass_Class_True)?(Trigger_bypassed:= True))
	wingetClass,ClassN,% id_ . LB_hWnd ;if ClassN != CabinetWClass ;msgbox,% ClassN
	;if(class_active="CabinetWClass") { ;tt("kjk " XCorner " - " YCorner)
		; if winex ; winhidef
	;LBTrigga:= M1_Trigger:= M1Resize:= True
	;	sendMessage,WM_LB_down,% WMReSz_%YCorner%_%XCorner%,% "ahk_id " Active_hWnd
	;	if rt:= Winexist("ahk_Class Net UI Tool Window ahk_exe explorer.exe", "Undo") {
;	winclose, ahk_id %rt%			;SendMessage, 0x0028,0,1 ,,% "ahk_id " Active_hWnd
	;	}	;} else,

	if(!rbt_) {
		LBTrigga:= M1_Trigger:= M1Resize:= True
		Winget,m2d_WinState,MinMax,ahk_id %RBhWnd%
		CursorChange:= insight:= 1
		if(m2d_WinState!=1)
			winRestore,ahk_id %RBhWnd%
		else,if(SnapdV) {
			loop,{
				MouseGetpos,xnew,ynew
				if((xnew>X_Cur1 +3)||(xnew<X_Cur1 -3)) {
					ylock:= True
					if(!LBTrigrx) {
						msgb0x("no trig")
						if(xnew>X_Cur1 +3) {
							Snap_Y_Lockd:= True
							PostMessage,% WM_LB_down,0xA,% "ahk_id " Test_A
					} else,if(xnew<(X_Cur1-3)) {
						PostMessage,% WM_LB_down,0xB,% "ahk_id " Active_hWnd
						}
						LBTrigrx:= True, msgb0x("trig")
						break,
					} else,(Snap_Y_Lockd? TT("Y-LOcKd"))
				} if(ynew>Y_Cur1+3||ynew<Y_Cur1-3) {
					PostMessage,0x00A3,12,% "ahk_id " Active_hWnd ; send>double -click2windowtop-border* ;
					if(!LBTrigrx) { ; *assuming: "winSnapd"? UnSnap* ;
						LBTrigrx:= True,
						PostMessage,%WM_LB_down%,MReSz_%YCornerX%_%XCorner%,ahk_id %Active_hWnd%
						break,
			}	}	}
			SnapdV:= False	; FIX ME PLS ; KILL ME PLS ;
		} else,if(!(class_active="SDL_app")) {
			PostMessage,% WM_LB_down,% MReSz_%YCornerX%_%XCorner%,% "ahk_id " LB_cWnd22
			Wingetpos, 	X_Win_S,Y_Win_S,W_Wins,H_Wins,ahk_id %Active_hWnd%
			MouseGetpos,X_MSt4,Y_MSt4,,LB_cWnd22
			if(class_active="SDL_app") {
				while,getKeyState("LButton","P") {
					Wingetpos,X_Win,Y_Win,W_Win,H_Win,ahk_id %Active_hWnd%
					MouseGetpos,X_Cur1,Y_Cur1,,LB_cWnd22
					((!Trig_Logic2)? Trig_Logic2:= True, Gosub("corner_offset_get"))
					Gosub("Watch_Lbii"), Gosub("DimensionChkii") ; WinMove(Active_hWnd,xx,yy,WII,HII)
					xx:= x0x-XOff, yy:= y0y-YOff, x0x:=xx, y0y:=yy
				} return,
			} Gosub("corner_offset_get"), Gosub("Watch_Lbii")
			rbt_:= True, x_winn:= ""
		}
	} else,Gosub("DimensionChkii")
	if(M2dBypassEval())
		return,
	(optM2dAutoActiv8? winActivate("ahk_id " RBhWnd))
	;if(WinExist(CntxtClssFFx))	;Firefox menu;	WinClose,
	;if(WinExist(CntxtClss_main))		;normal menus;	WinClose,
	LBTrigga:= M1_Trigger:= M1Resize:= True
	postMessage,% WM_LB_down,WMReSz_%YCorner%_%XCorner%,,,ahk_id %RBhWnd%
	while,getKeyState("LButton","P") {
		if(getkeystate("shift","p"))
			goto,fukinmars
		M1_Trigger:= False
 		MouseGetpos,X_Cur1, Y_Cur1
		Wingetpos,	X_Win,	Y_Win,W_Win,H_Win,ahk_id %hWnd_A%
		Gosub("Watch_LBii"), xx:=x0x-XOff, yy:=y0y-YOff, x0x:=xx, y0y:=yy, Ssleep(1)
	} M1_Trigger:= True
	,bd_i:= rbt_:= !(ResizeTrig:= True)	;send,{LButton up}	;}	;return,
, fuckinggay:=true
	;postMessage,% WM_LB_up,17,,,% "ahk_id " RBhWnd
	send,{blind}{LButton up}
	ssleep(50)
	return,
;--------------------------------------------------------------------------------------------

LButton Up:: ; +LButton Up :
(TILDE_send_LB? TILDE_send_LB:= False, TildeTrig:=False, return())
if(getkeystate("RButton","P")){
	postMessage,% WM_LB_up,17,,,% "ahk_id " RBhWnd
}else,s:= getkeystate(shift,"T")? "+" : ""
	loop,parse,% "alt,shift,lcontrol,",`,
		if(getkeystate(a_loopfield,"P")) {
			Switch,a_loopfield {
				case,"lcontrol" : (!instr(k,"^")? k.="^")
				case,"!","alt"  : k.=(!instr(k,"!")? k.="!")
				;case,"shift","lshift" : k.="+^"
			}
		sendinput,%s%%k%{LButton up}
		(bd_I? (bd_i:= False, (ConTxT_Instances? Timer("ConTxT_Instances_re_eval2",-500))))
		getKeyState("LButton","P")? TT("logic",1000):()
	} k:=""
	return,
}	return, ;End m2drag-=End m2drag-=End m2drag-=End m2drag-=End m2drag-=End m2drag-=End m2drag-=End
;End m2drag-=End m2drag-=End m2drag-=End m2drag-=End m2drag-=End m2drag-=End m2drag-

;------------------------------------------------------------------------------------------
;-=-=^*^-=-=^*^-=-=^*^-=-=^*^-=-=^*^-=-=^*^-=-=^*^-=-=^*^-=-=^*^-=-=^*^-=-=^*^-=-=^*^-=-=^*
;------------------------------------------------------------------------------------------
fukinmars:
postMessage,% WM_LB_up,WMReSz_%YCorner%_%XCorner%,,,ahk_id %RBhWnd%
send,{blind}{lbutton up}
MouseGetpos,X_Cur,Y_Cur
m1_trigger:=False, X_MSt4:=X_Cur,Y_MSt4:=Y_Cur
Wingetpos,X_Win_S,Y_Win_S,W_Win,H_Win,% "ahk_id " RBhWnd
MouseGetpos,X_MSt4,Y_MSt4 ;critical
while(getkeystate("lbutton","p")&&(getkeystate("shift","p"))){
	rbd:= True
	MouseGetpos,X_Cur,Y_Cur
	if(SnapdV&&M2dStickySnap) {
		if(dh_=TargetdH&&dy_=TargetdY) {
			Wingetpos,,dY_,,dH_,% "ahk_id " RBhWnd
			WinMove(RBhWnd,(X_Cur-X_MSt4+X_Win_S),TargetdY,W_Win,H_Win)
		} else {
			SnapdV:=False, WinMove(RBhWnd,(X_Cur-X_MSt4+X_Win_S)
			, (Y_Cur-Y_MSt4+Y_Win_S),W_Win,H_Win)
		}
 	} else {
		rat2:=h_Win /W_Win
		hh2:=h_Win+	(agg:=y_Cur-y_MSt4)
		ww2:= hh2/rat2
		max:= w>h? w : h
		w:=W_Win+(x_Cur-X_MSt4)
		h:=H_Win+(Y_Cur-Y_MSt4)
		WinMove(RBhWnd,X_Win_S, Y_Win_S,ww2,hh2)
	}
} Wingetpos,,dY_,,dH_,% "ahk_id " RBhWnd
Wingetpos,X_Win_S,Y_Win_S,W_Win,H_Win,% "ahk_id " RBhWnd
MouseGetpos,X_MSt4,Y_MSt4 ;critical
return,

corner_offset_get:
XCorner:= ((XOff:= (X_MSt4 -X_Win_S))<W_win*.4)? "W":"E"
,YCorner:= ((YOff:= (Y_MSt4 -Y_Win_S))<H_win*.4)?"N":"S"
return,

m2dWinPos_Agg: ; MouseGetpos,X_Cur,Y_Cur,
(!(X_Win||Y_Win||W_Win||H_Win)? Gosub("DimensionChk"))
(!(XOff||y0y)? Gosub("corner_offset_get"))
x0x:= W_Wins-Xnet, y0y:= h_Wins-Ynet
return,

; m2dWinPos_Agg2:
	; tt("rgdgrgrgr")
; xy_agg:= 1.3, LB_hWnd:= RBhWnd
; MouseGetpos,X_Cur,Y_Cur
; Xnet := X_MSt4-(X_Cur)
; ,Ynet:= Y_MSt4-(Y_Cur)
; x0x	 := x_Win -(xy_agg *Xnet)
; ,y0y := y_Win -(xy_agg *Ynet)
; W_Win:= W_WinS-(xy_agg *Xnet)
; ,h_Win:=h_WinS-(xy_agg *Ynet)
; return,

; clean_ii:
; MouseGetpos,X_MSt4,Y_MSt4
; Wingetpos,X_Win_S,Y_Win_S,W_Wins,H_Wins,% ("ahk_id " RBhWnd)
; x0x:= (Xnet +X_Win_S), y0y:=(Y_Win_S +Ynet), LBDD:= False
; (!LB_U)? (LB_U:= True) : (LB_D:= False)
; settimer,cleanlbvars,-1
; return,

; cleanLBVars:
; LB_ClassN_old:= LB_ClassN
; ,LB_ClassN:= class_active:= LB_hWnd:= LB_cWnd:= ""
; LB_D:= ( fff:= False )
; return,	; ~^~LButton Up::  ; ~$~LButton Up:: ; ~^~LButton Up::  ; ~$~LButton Up::

;[][][][][][][][][][][][][][];[][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
								; The Key-Binds ;
;[][][][][][][][][][][][][][];[][][][][][][][][][][][][][];[][][][][][][][][][][][][][]

ScrollLock::TT("BIND ME`n,luv- ScR0LL0x...")

RetroArch: ;: ; X-box Controller X-Menu-Butt ;VK07: ;
loop,parse,% "mame,retroarch,mame32,mame64,mameui",`,
if(e:= winexist("ahk_exe " . a_loopfield . ".exe")) {
	if(!(winactive,ahk_id %e%)) {
		winActivate,ahk_id %e%
		sleep,80
		send,{VK07}
	} sleep,200

	if(!(winactive,ahk_id %e%)) {
		winget,pid,pid,A
		winget,pn,processname,ahk_pid %pid%
		if(!(pn="retroarch.exe"))
			process,close,%pid%
	} return,
}

run,% "S:\games\OLDIES\EMU\RetroArch\retroarch.exe"
,% "S:\games\OLDIES\EMU\RetroArch",pid
loop,10 {
	sleep,40
	if(e:= winexist("ahk_pid " pid)) {
		MamEd0p(e)
		return,
}	} return,

trans_reset: ;^1::
Gosub,winGetTransparency
Opaci_T:= 100
Gosub,WinSetTransparency
Gosub,tooltipCreate
return,

trans_dec: ;^2::
SetKeyDelay,0,0
Gosub,winGetTransparency
Opaci_T -=1
Gosub,WinSetTransparency
Gosub,tooltipCreate
SetKeyDelay,1000
return,

trans_inc: ;^3::
SetKeyDelay,0,0
Gosub,winGetTransparency
Opaci_T +=1
Gosub,WinSetTransparency
Gosub,tooltipCreate
SetKeyDelay,1000
return,

$delete:: ;$delete::$delete::$delete::$delete::$delete::$delete::$delete::
wingetClass,cl_s,A
if(instr(ExplorerClss,cl_s)) { ;explora
	handl:= WinActive("A")
	ControlGetFocus,Ct_fc,ahk_id %handl%
	if(instr("Edit1,Edit2,DirectUIhWnd1,",Ct_fc . ","))
		send,{delete}
	else,if(instr(ExplorerCnts,Ct_fc)) {
		BT:= a_thishotkey
		Gosub,Bicycle
	}
} else { ;all other classes
	send,{delete}
	DbgTT? TT("Delete Not Suppressed undefined","-500") : ()
} handl:= ""
return,

+^Delete::	;	+^Delete::+Delete+^Delete::+Delete+^Delete::+Delete
 +Delete::	;	+^Delete::+Delete+^Delete::+Delete+^Delete::+Delete
wingetClass,class_,A
if(class_="WorkerW"||class_="CabinetWClass") {
 send,{Shift up}
 blockinput,on
 sleep,100
 send,{Delete}
 sleep,500
 blockinput,off
} return,

; -::
; =::
; +-::
; +=::
sizewin:
winget,PN,Processname,A
Switch,PN {
	case,"mame64.exe": Switch,a_thishotkey {
			case,"^=" : sizewin("x2center")
			case,"^-" : sizewin("halvecenter")
			case,"+=" : sizewin("+10%")
			case,"+-" : sizewin("-10%")
		}	;Default: sendinput,%a_thishotkey%
} TT(PN)
return,

$^#Z:: ; 			UN DO MO FO UN DO MO FO UN DO MO FO UN DO MO
$^#Y:: ; 			DO MO FO UN DO MO FO UN DO MO FO UN DO MO FO
rCtrl & -::^z ; 	'-~_~_~_~_~_~_~_ UN-DO MO-FO _~_~_~_~_~_~_~-'
rCtrl & +::^y ;  '-~_~_~_~_~_~_~_ UN-DO MO-FO _~_~_~_~_~_~_~-'
a:= strReplace(a_thishotkey,"$^#")
send,^{%a%}
sleep,50
return,

; '-~_~_~_~_~_~_~_ UN-DO MO-FO _~_~_~_~_~_~_~-'
$^z:: ; "Ctrl Z" - bypass "Undo." in Explorer.exe
$^y:: ; "Ctrl Y" - bypass "Redo". in Explorer .exe
if !(WinActive("ahk_Group desktop")){
a:= strReplace(a_thishotkey,"$^")
send,^{%a%}
sleep,120
} return,

refresh:
(!(ahk_=(b:= WinExist("A")))? c:= b)
PostMessage,0x111,65410,,,ahk_id %A_ScripthWnd% ; WM_COMMAND-0x111 ;Refresh
(!ahk_?ahk_:= WinExist("A"))
if(b)
	loop,3
		if(winnotactive,ahk_id %b%)
			winActivate,ahk_id %b%
		else,sleep,10
Keywait,Break,T2,5
Keywait,Pause,T2,5
((brk="D"||brk2="D")? Timer("refresh","off"), ahk_:="")
return,

np_lineCommentTogl_:
sendinput,% "^q"
return, ;asfsdf

np_save_2_reload: ; ~^s:: ; Capture notepad++ Save hotkey Ctrl-S #if directive statement bound #IF ;if(WinActive("ahk_exe notepad++.exe"))
(sponk:=func("saveReloadScript").bind(winexist("A")))
settimer,% sponk,-10
return,


saveReloadScript(hwnd="") {
	WingetTitle,A_Title,% (hwnd=""? "A" : "ahk_id  " hwnd)
	if(instr(A_Title, "*")&&instr(A_Title, ".ahk")) {
		A_Title:= strReplace(A_Title,"*" ,"") ; *Asterisk = Unsaved Doc in NP++.
		Splitpath,A_Title,,,,fn
		ser:= fn . ".ahk - AutoHotkey"
		(!WinExist(ser)||fn=A_ScriptName?return())
		MsgBox,0x1034,% "Modified script: " fn,%  "Reload " (TargetScriptName:= fn . ".ahk") "?`n`tTimeout in 3 Secs",3
		ifMsgBox,Yes, {
			SplashTextOn,,, `t Reloading %fn%
			sleep,250
			if(TargetScriptName=A_ScriptName) {
				sleep, 900
				reload,
			} else,SendMessage,0x0111,65303,,,% TargetScriptName " - AutoHotkey" ;Reload WMsg ;else,ifmsgbox,noIfMsgBox,Timeoutreturn,
			settimer,splashtxtoff,-1000
		} return,
	}
}

SplashTxtOff:
SplashTextoff
return,

!Shift:: ; -~-~-~-~-~-~ ; input-locale selector gui hotbind bypass ; -~-~-~-~-~-~ ;
+Alt::
if(w10_LocaleGui_Allowed)
	sendinput,% a_thishotkey
else,TT("shift-alt blocked (inputlocale bypass)")
return,

mouse_transcol_init: ;^#i:: ; Press ctl 1 to make the color under the mouse cursor invisible. ;
MouseGetpos,MouseX,MouseY,MouseWin
pixelGetColor,MouseRGB,% MouseX,% MouseY,RGB
winset,TransColor,Off,ahk_id %MouseWin%
TT(MouseRGB . " Will BE MADE TRANS_COLOR`n" . MouseX . ", " . MouseY . "`n" . MouseWin)
;Winset,TransColor,%MouseRGB% 254,ahk_id %MouseWin%	;	 Winset, TransColor, 0xFFFFFF, ahk_id %MouseWin%
return,

;~#B:: ; Acrylic / Aero Window-Blur ;
aero_init:
MouseGetpos,,,hw,cw,3
;stopwatch_("start")
((!instr(blurlist,hw ",")&&(!instr(unblurlist,hw ",")))? (Aero_ChangeFrameArea(hw,0,0,0,0), Aero_BlurWindow(hw,0)
, TT("UnInitiated in the AeroList`nPresuming Blurred`nresetting frame",5), unblurlist.= hw . ",")
: (!instr(blurlist,hw ",")? ((!blurlist? blurlist:= hw "," : blurlist.= hw ","), Aero_ChangeFrameAreaAll(hw), Aero_BlurWindow(hw)
, TT("Applying Aero-blur",5))
: (Aero_ChangeFrameArea(hw, 0, 0, 0, 0), Aero_BlurWindow(hw,0)
, TT("Already in AeroList`nUn-bluring",5), blurlist:= strreplace(blurlist,hw ","), unblurlist.= hw ","))) ;stopwatch_()
return, 

Param1Name() { ;call inside a func to show param arg
	ex:= Exception("",-2)
	FileReadLine,line,% ex.File,% ex.Line
	RegExMatch(line,ex.What "\(\s*\K[\w$@#:^ascii:]+",R)
	return,% ret:= (R? R:"No Param args")
}

stopwatch_(startend=""){
	static init:=0,T
	if(init=0||startend="Start")
		init:=1, t:= a_tickcount
	else,return,res:= a_tickcount-T, init:= T:= 0
	, TT("Stopwatch completed in:  " res " ms.")

}

~esc::	;~$esc::  ~$esc::  ~$esc::  ~$esc::  ~$esc::
+esc::	;$+esc::  $+esc::  $+esc::  $+esc::  $+esc::
Winget,ProcN,ProcessName,% "ahk_id " (handl3:=	WinActive("a"))
wingettitle,Title_Last,ahk_id %Handl3%
wingetClass,clss,ahk_id %Handl3%

(instr("workerw,progman",clss)?return() )
ProcN:= sTrReplace(ProcN,".exe")
if(instr(EscCloseActWL_Exe,ProcN)) {
	Switch,ProcN {
		case,"mame64" : if(Title_Last="MAME: No Driver Loaded [___empty]")
			return,
	} TT(("Closing " . ProcN),770) ;Win_Animate("a", "hide blend",900) UIPI
	sleep,100
	WinClose,
	sleep,% EscCloseRate
	return,
} else,if(instr(EscCloseAskWL_Exe,ProcN)) {
	msgbox,262209,Close %ProcN%?,Closing.`nTimeout in 4 Sec`nIssue...,4 ;Icon Asterisk-(info)-64-0x40 ;; Icon"Question"-32-0x20; ; WS_EX_TOPMOST-262144-0x40000 ;; OK/Cancel 1 0x1 ;Yes/No 4 0x4 ;; System Modal(top)-4096-0x1000
	if((ifmsgbox "Cancel")||(ifmsgbox "no")) {	;ifmsgbox OK
		TT("ESC_2_CLOSE`nCancelled",20,20,800)
		sleep,% EscCloseRate
		return,
	} else,WinClose
} else {
	Switch,clss {
		case,"AutoHotkeyGUI" : if strlen(Title_Last)<2
				return,
			if instr(EscCloseFocWL_ahkTTL,Title_Last . ",")
				WinClose,ahk_id %Handl3%
			sleep,% EscCloseRate
			return,
	}

	if(!trigg3r3d) {
		trigg3r3d:= True
		MouseGetpos,,,			winz
		wingetClass,aaa,ahk_id %winz%
	}

	if(aaa="#32768")
		ok2esc:= True
	else,if(f:= instr(aaa,"CustomizerGod")) {
		WingetActiveStats,Title,Width,Height,X,Y	;$esc up::
		if((Width<1220)&&(height<830))			;$+esc up::
			WinClose,						;if(ok2esc||escaped) {
	} else {							;	trigg3r3d:= False, ok2esc:= False, escaped:= False
		escaped:= True 				;if escaped
		send,{Esc}				;	send,{esc up}
}	}						;else,send,{esc}  ; } return,; #hotkeyInterval %hi% ; return,
sleep,% EscCloseRate
return,

^+WheelDown::^+d ; rerouted work-around mouse-hook in Nagscrpt
^+WheelUp::^+p
^WheelDown::
^WheelUp::
2kShuff:
MouseGetpos,,,mhWnd
wingetClass,mclss,% (mhnd:= ("ahk_id " . mhWnd))
if(init_wheel_Bypass) {
 settimer,HK_PairSend,-1
 settimer,BypassTimer,-250
} if(!instr("WorkerW,Progman,tooltips_class32",mclss)) ; desktop
 Timer("HK_PairSend",-1)
else,TT("Desktop: Supressed Zoom")
return,

;$insert::$insert::$insert::$insert::$insert::$insert::$insert::$insert::
$insert:: ;(GIMP Undo)=(Stylus button && GIMP ReDo)=(Ctrl +stylus button1)
if !(WinActive("ahk_exe gimp-2.10.exe")) {
  send,{insert} ; hotkeySendSelf(a_thishotkey) ; undo ;
  return,
} else { ;-------------=============-----------; undo ;
 sleep,20
 send,{escape}
 sleep,70
 send,^z
 while,getKeyState,insert
 {
  TT(a_now " hhhjjjt") ; settimer, dbgtt_nibdown5, -%RateUndoRedo%
  Sleep(150)
} } return,

;-P4sT3--P4sT3--P4sT3--P4sT3--P4sT3--P4sT3--P4sT3--P4sT3--P4sT3--P4sT3--P4sT3--
; ~^v:: ; a PassThru w.Paste
paste: ;^v:: ; a PassThru w.Paste
l_T:= wgetTitle("ahk_id " l_H:= WinExist("A"))
Wingetclass,CN,processname,ahk_id %l_H%
Winget,PN,processname,ahk_id %l_H%
switch,CN,{
	case,"ConsoleWindowClass" : Sendinput,RButton
	default : Send,{Blind}{lcontrol}v
} if(opt_LogClipboard)  {
	FormatTime,Tstamp,% a_now,d\M @ H:m
	pasted.insertat(1,{"timestamp":Tstamp,"title":l_T,"hWnd":l_H,"pn":PN})
	((Ctrlvpastemsg)? (msgb0x(pasted[1].timestamp " - Pasted into "
	, pasted[1].pn " (" pasted[1].title " (" pasted[1].hWnd "))")):())
} return,

;jewclaw
MouseGetpos,,,mwin_hWnd ;wingetClass,mclass_now,ahk_id %mwin_hWnd%
Winget,mpn_,processname,ahk_id %mwin_hWnd%
for,index,element in mwheeldrag
{
 if(instr(element,"MDrag_WH")) {
	if(index=mpn_) { ;detect correct whitelist target
		MDrag_WH:= True
		break, ;continue,
}	}	}
if(!MDrag_WH) {
	Send,{Blind}{Text}v
	return,
} else {
	initPosX:= X, initPosY:= Y, init:= True, Trig3rd_:= False
	while,getkeystate("v","P") {
		if((Aggy:= Y-initPosY)>16) {
			(!Trig3rd_? Trig3rd_:= True)
			, initPosY:= Y
			loop,2
				send,{WheelUp}
		} else,if(Aggy<-16) {
			(!Trig3rd_? Trig3rd_:= True)
			, initPosY:= y
			loop,2
				send,{WheelDown}
		} MouseGetpos,,y,
		sleep,%VScrollDelayT_m1%
		settimer,ClipOff,-250
	} if(!Trig3rd_)
		send,{%a_thishotkey%}
	Trig3rd_:= MDrag_WH:= False
}

ClipOff:
return,

OCR_init: ;#c::
run,C:\Script\AHK\Vis2.ahk	;OCR to clipboard
sleep,1000
return,

^+f::settimer,FinreplaceallwithSEL,-50

FinreplaceallwithSEL:
ahwnd:= winexist("a")
wingetclass,aclss,ahk_id %ahwnd%
if(aclss!="Notepad++"){
	send,{blind}^+f
	return,
}
send,^f
loop {
	Ssleep(10)
	if((a2hwnd:= winexist("a"))!=ahwnd)
		break,
} wingetclass,a2clss,ahk_id %a2hwnd%
if(a2clss!="#32770")
	return,
ControlGet,Seltxt,Selected,,edit1,ahk_id %a2hwnd%
ControlClick,x94 y15,ahk_id %a2hwnd%,,,,Pos
ControlSetText,edit2,% Seltxt,ahk_id %a2hwnd%
ControlClick,button31,ahk_id %a2hwnd%
winactivate,ahk_id %ahwnd% 
return,

~f::
tt()
j32:
xylock:= 1st_Btrigger:= False, y__:= ""
clipcursor(0,0,0,0,0)
return,

;^q::
^r::
^e::
^c::
^!e::
+Space::
+MButton::
 MButton::
Explorer_verb_hk:
MouseGetpos,X_,Y_,Mwnd,mCtlName
Winget,PN,ProcessName,	ahk_id %Mwnd%
WingetTitle,TI, 		ahk_id %Mwnd%
wingetClass,mClassName,	ahk_id %Mwnd%
;wingetClass,cClassName,	ahk_id %Mwnd% ;msgbox % cClassName  "  " mClassName " " mClassName
Switch,mClassName {
	case,"tooltips_class32":
	WinGetText,TTText,ahk_id %Mwnd%
	listvars
	clipboard:= " TOIOLTIP TEXT: " . TTText
} Folder_:= False
Switch,mCtlName {
	case,"SysTreeView321" : Switch,a_thishotkey {
			case,"^r" : Timer("Renametree",-1), Ssleep(666)
			return,
			case,"MButton","+MButton" : run,% Treegethot("GetPath")
				 Ssleep(666),
				 return,			
				case,"+Space" : Treegethot("Toggle"),Ssleep(666)
			return,
			case,"^c" : clipboard:= Treegethot("GetPath"), TT("Copied"), Sleep(666)
			return,
		}
} hActive:= winexist("A")
Winget,aPN,ProcessName,	ahk_id %hActive%
WingetTitle,aTI,		ahk_id %hActive%
wingetClass,ACls_,		ahk_id %hActive%
Switch,mClassName { ;classname;
	case,"#32768" : Switch,a_thishotkey {
			case,"^c" : Timer("menudetail_dump",-1), Sleep(666)
			return,
}		}
Switch,ACls_ {
	case,"CabinetWClass" : Switch,a_thishotkey {
			case,"^e" :blockinput,on
			_:= invokeverb(selexp:= Explorer_GetSelection(hActive),"Edit")
			blockinput,off
				return,
			case,"^q" :
				 try,_:= SendWM_CoPYData("q" selexp:= Explorer_GetSelection(hActive),EventWMhandla)
				return,
			case,"^r" :	sendkiSOLO("{f2}")
				sleep,80
				return,
				;ki:= func("SendKi").bind("{f2}") ; settimer,% ki,-100 ;SendKiLongnanme("f2"), Sleep(666) ; return,
			case,"MButton" : try,invokeverb(selexp:= Explorer_GetSelection(hActive),"openinnew")
				return,
		}
	case,"WorkerW" : Switch,a_thishotkey {
			case,"^e" :  res2:=invokeverb(selexp:= Explorer_GetSelection(hActive),"Edit")
				return,
			case,"^r" : ki:=func("SendKi").bind("{f2}")
				settimer,% ki,-50
				return,
			case,"MButton" : selexp:= Explorer_GetSelection(hActive)
				if instr(selexp,".txt")
				; notepad++ [--help] [-multiInst] [-noPlugin]
				; [-l<Language>] [-udl="My UDL Name"]
				; [-L<langCode>]
				; [-n<line>] [-c<column>] [-p<pos>] [-x<left-pos>] [-y<TopPos>]
				; [-monitor] [-nosession] [-notabbar] [-ro] [-systemtray] [-loadingTime]
				; [-alwaysOnTop] [-openSession] [-r]
				; [-qn="Easter Egg Name" | -qt="Text to Type" | -qf="D:\path to\file"]
				; [-qSpeed(1|2|3)] [-quickPrint]
				; [-settingsDir="d:\your settings dir\"] [-openFoldersAsWorkspace]
				-titleAdd="nu-instance" -nosession -l<Language> [-udl="My UDL Name"]
				; [-pluginMessage="text for plugin(s)"]
				; [filepath]
			try,res2:=invokeverb(selexp,"openinnew")
				return,
		}
	case,"Notepad++","Scintilla","Scintilla1","Scintilla2","Scintilla3" :
	wingettitle,aTI,a
		Switch,a_thishotkey {
			case,"MButton" :
				send,^{f3}
				Sleep(666)
				return,
			;default: msgbox,% aTI
	}
	case,"32770":
		if(apn="notepad++.exe")
			switch,a_thishotkey {
				case,"^c" : send,^c
				case,"MButton" : send,^{f3}
			}
	case,"AHK_Class gdkWindowToplevel":
		if(!1st_Btrigger) {
			coordMode,Mouse,Screen
			settimer,bobGATE_Timer,25
			1st_Btrigger:= True
			MouseGetpos,xs,ys
			Winget,mpn_,processname,ahk_id %mwin_hWnd%
		;;; WITHOUT MOUSE1 OR STYLUS NIB-DOWN ;;;
			clipcursor(1,xs,ys-1,xs,ys+2)
			,initPosY:= ys, TT("w0`n" a_thishotkey)
			while(getKeyState("MButton","P"))
			settimer,Aggr_Y_Timer,-20
		}
} if(ConTxT_iCount) {
	send,{enter}
	settimer,ConTxT_iCount_rEval,-2000 ; } else,if(!(A_TimeIdleMouse<450)) ; HK_A_ZTrim(a_thishotkey)
} else,if((a_thishotkey="+Space")||(a_thishotkey="+MButton"))
	send,% "+{" LTrim(a_thishotkey,"+") "}"
else,if(a_thishotkey="MButton")
	send,{MButton}
else,sendinput,% a_thishotkey ;msgbox % (ACls_)
return,

sendKi(key) {
	send,% key
}

sendkiSOLO(keys) {
	blockinput,on
	send,% keys
	sleep,40
	blockinput,off
}

~!w::
MouseGetpos,,,nnd,k12eye
gdipfix_start:
sleep,700
Nnn:= Gdip_Start(), dcC:= GetDC(nnd)
mDC:= Gdi_makeDC(0), mBM:= Gdi_DIBcreate(mDC,1,1,32)
oBM:= Gdi_SelObject(mDC,mBM)
dllcall("gdi32.dll\SetStretchBltMode","Uint",dcC,"Int",5)
dllcall("gdi32.dll\StretchBlt","Uint",dcC,"Int",0,"Int",0,"Int"
,3000,"Int",1200,"Uint",mdc,"Uint",0,"Uint",0,"Int",1,"Int",1,"Uint","0x00CC0020")
Gdi_shutsesh(pToken),(Nnn),(a=0||b=0)? Gosub("gdipfix_start") : ()
return,

mag_init:
;#M::							;			Mag				;
;+#M::						;	ALTgr + Right Arrow		;
;F23 & MButton::	;	~F23 & MButton up::		;
if(!WinExist(magwin)) {
	if(!hWnd:= WinExist(EventScript))
		settimer,MagRun,-10
	else,settimer,MagRunViaWM,-10
	InitMag:= True ;Sleep(MagWMdelay_)
 return,
} else { ; #InputLevel 1
	sendlevel,1
	sendevent,{Blind}{f23 up}
	sendlevel,0
	Ssleep(50) ; #InputLevel 0
	settimer,MagKillViaWM,-180
	return,
}
	;(bol:= WinExist(magwin)? r:= postM5g(0x0111,magwin,65307))
;	_:= postM5g(0x0111,bol,65307,0), InitMag:= False
	;Sleep(MagWMdelay_) ;Sleep(MagWMdelay_)
return,

MagRun:
MagRunViaWM:
if(a_thislabel="MagRunViaWM")
	_:= SendWM_CoPYData("bAggy",EventScript)
else,run,C:\Script\AHK\Working\M2DRAG_MAG.AHK
return,

MagKill:
MagKillViaWM:
if(a_thislabel="MagKillViaWM")
	_:= SendWM_CoPYData("fad3out",magwin)
return,

$^insert::
if(!(WinActive("ahk_exe gimp-2.10.exe")))
	hotkeySendSelf(a_thishotkey)
else { ; GIMP: Supress RButton menu-popup hardcoded in GIMP. ;
	sleep,20
	send,{escape}
	sleep,70
	send,^y
} return,

postM5g(Message,hWnd="",wParam:=0,lParam:=0) {
	postMessage,% Message,% wParam,% lParam,,% (!hWnd? (
	, x:="") : (x:= isint(hWnd)? ("ahk_id " . hWnd) : hWnd))
	return,errOrlevel
}

~#F10:: ; gimp sending m2drag ;gimp routed Mouse1 pen nib><routed Mouse2 / undo barrel 1
click right down
TT("Barrel 1 Down")
return,
~#F10 up::
click right up
TT("Barrel 1 Up")
return,

tablet_gestures:
return,

switch,a_thishotkey {
	case,"~!f13" :	TT("Rotate CW")
	case,"~!f14" :	TT("Rotate C-CW")
	case,"~!^+u" :	TT("5 finga downswipe")
	case,"~^+f6" :	TT("5 finga tap") ; Ctrl shift F6
	case,"~#Tab" :	TT("4 finga downswipe")
	case,"~^+!#h":  TT("4 finga upswipe")
	case,"~^!z"  :	TT("3 finga tap")
	case,"~+WheelUp" :	TT("2 Finger swipe R")
	case,"~+WheelDown" :TT("2 Finger swipe L")
} return,

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; +F9::
; TT("Nib Down")
; sendinput {~LButton Down}
; return,
; +F9 up::
; TT("Nib Up")
; sendinput {~LButton Up}
; return,
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

f21:: ;XButton1::		;		System Back and Forward
f22:: ;XButton2::		;		MOUSE BUTTONS BACK / FWD
MouseGetpos,tx,ty,M_hWnd,M_Ctrl
if(M_hWnd=(A_hWnd:= WinExist("A"))) {
 wingetclass,M_class,ahk_id %M_hwnd%
 switch,M_class {
 	case,"WorkerW" : TT("D-Top (Not Implemented")
 	case,"RegEdit_RegEdit": if(a_thishotkey="f21")
 			send,{backspace}
 	default:kiSendRemapped1(a_thishotkey)
 }
} else {
	wingetClass,M_class,ahk_id %M_hWnd%
	wingetClass,a_Class,ahk_id %A_hWnd%
	if(M_Class="MultitaskingViewFrame")
		send,!{tab}
	else,kiSendRemapped1(a_thishotkey)
} sleep(250)
return,

Swipe(hWnd,hotkey) { ; if !hWnd { ; send !{tab} ; send +!{tab} ; return, ; }
	if(hotkey="f21") {
		send,#{Left}
		TT("Bk-butt")
	} else,if(hotkey="f22") {
			send,#{Right}
			TT("Fwd butt")
	} else,Msgbox,% "other back fwd buttons pls consult the MATL ===---"
	WinWaitActive,ahk_Class MultitaskingViewFrame,,2
	if(WinActive("ahk_Class MultitaskingViewFrame")) {
		if((S_hWnd:= WinExist("A"))=hWnd) {
			Send,!{tab}
			TT("Alt tabbed")
			return,
		} else { ; ActivateWin(hWnd, -10) ;
			winActivate,AHK_ID %hWnd%,,2
			(errOrlevel? msgb0x(errOrlevel))
		} WinWaitActive,AHK_ID %hWnd%,,2
	} x_hWnd:= hWnd
}
; wacom GestureHID:                        HID\VID_056A&PID_0392&REV_0109&Col02
; HID\VID_056A&PID_0392&REV_0109&Col01     HID\VID_056A&PID_0392&Col02
; HID\VID_056A&PID_0392&Col01              HID\VID_056A&UP:FF00_U:000A
; HID\VID_056A&UP:0001_U:0001              HID_DEVICE_UP:FF00_U:000A
; HID_DEVICE_SYSTEM_MOUSE                  HID_DEVICE_UPR:FF00-FFFF 
; HID_DEVICE_UP:0001_U:0001                HID_DEVICE

WMP_Bind:
Switch,onTheWmpCmds:= strReplace(a_thishotkey,"<^>!","") {
	case,"PgDn"	:	STR_:= "VolDn"
	case,"PgUp"	:	STR_:= "VolUp"
	case,"Right":	STR_:= "JumpNext"
	case,"Left"	:	STR_:= "JumpPrev"
	case,"Space":	STR_:= "PauseToggle"
	case,"Enter":	STR_:= "Open_Containing"
	case,"c"		:	STR_:= "Converter"
	case,"Del"	:	STR_:= "godie"
	case,"p"		:	STR_:= "Add2Playlist"
	case,"f"		:	STR_:= "SearchExplorer"
	case,"s"		:	STR_:= "CopySearchSlSk"
	case,"x"		:	STR_:= "CutCurrent"
} result:= Send_WM_COPYDATA(STR_,WMPMatt)
return,

~+o::
mousegetpos,,,hw,cw,3
winset,top,,ahk_id %hw%
winset,AlwaysOnTop,on,ahk_id %hw%
a:= winexist("Wince-Pie"), tt("ad")
DllCall("SetWindowPos","uint",hW,"uint",a,"int","","int","","int","","int","","uint",0x43)
return,

#r:: 		;RUN dlg ; + circumvents gpo / corrupt user-profile.
run,% (_:= "explorer shell:::" . "{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}")
return,

^#x::
+^#x::		; ExtractAudio from youtube
if(!WinExist(wTtL_YT_dL))
	run,% Path_YT_dL
else,TargetScript:= YTScript, STR_:= "ExtractAudio", result:= Send_WM_COPYDATA(STR_,TargetScript)
return,

^#Space::	; Youtube Audio-Xtract
+^#Space::	; Ctrl - WIN - SPACEBAR
TargetScript:= YTScript, STR_:= "PlayPause", result:= Send_WM_COPYDATA(STR_,TargetScript)
return,

^#Left::	; Youtube Prev
+^#Left::	; Ctrl-WIN-LEFTARROW
TargetScript:= YTScript, STR_:= "prev", result:= Send_WM_COPYDATA(STR_,TargetScript)
return,

^#Right::	; Youtube Next
+^#Right::	; Ctrl-WIN-LEFTARROW
TargetScript:= YTScript, STR_:= "next", result:= Send_WM_COPYDATA(STR_,TargetScript)
return,


~^!f::
~^!g::
Switch,a_thishotkey {
	case,"~^f" : inkdek:= -1	;results in increment +1
	case,"~^g" : inkdek:= +1	;results in increment -1
} TT("bbb" coefficient_menuh -=inkdek,2)
return,

dbgtt_nibdown0:
TT("nib down")
return,

dbgtt_nibdown2:
TT("barrel 1 click")
return,

dbgtt_nibdown5:
TT("undo")
send,^z
sleep,300
return,

dbgtt_redo:
TT("redo")
send,^y
sleep,300
return,

DisplayStandby: ;~break:: ; Win+O ;
if(a_priorkey="RControl") {
	TT("display resting...",1000)
	Sleep,1000 ; Give chance to release keys (in case,their release would wake up the monitor again).
	SendMessage,0x0112,0xF170,2,,Program Manager ;Turn Monitor Off :0x0112-WM_SYSCOMMAND,0xF170-SC_MONITORPOWER;
	sleep,2000 ; Note: Use -1 in place of 2 to turn the monitor on.; Use 1 in place of 2 to activate the monitor's low-power mode.
} return,

~^#m::
reload,
return,

;-----------------------------		MWHEEL LEFT 		 ;-----------------------------
+f18::WheelLeft		;	shift wheel_L to send original Wheel_L
WheelLeft::
^f18::				;	Ctrl + wheel_L => PG_Home (interferes so look for alternative)
^F20::				;	logi sensitivity up button (sub button on lmb)
 F20::				;	logi sensitivity up button (sub button on lmb)
 F18::				; 	Wheel L = "page UP" without interfering with selection
if(ConTxT_iCount) {
	SendKiLongnanme("left"), Timer("ConTxT_iCount_rEval",-3000)
	return,
} active_id:=	WinExist("A")
wingetClass,	Active_WinClass,A
MouseGetpos,, ,	Mouse_hWnd,MClass
wingetClass,	Mouse_WinClass,ahk_id %Mouse_hWnd%
wingetClass,Act_WinClass,ahk_id %active_id%
if(!(active_id=Mouse_hWnd)) { ; UnFOCuSED ;
		WinExist(("AHK_Id " . Mouse_hWnd))
	if(instr("MozillaWindowClass,MozillaCompositorWindowClass,Chrome_WidgetWin_1,", (Mouse_WinClass . ","))) {
		if(Act_WinClass=Mouse_WinClass) {
			winActivate,
			send,^{f2}
		} else,ControlSend,ahk_parent,{f1},ahk_id %Mouse_hWnd%
	} else,if(instr("CabinetWClass,MMCMainFrame,Notepad++,RegEdit_RegEdit,#32770,MainWindowClassName,TMainForm,",(Mouse_WinClass))) {
		if(a_thishotkey="^f16"||a_thishotkey="^f20") {
			sendinput,^{home}
			ControlSend,% MClass,^{home},ahk_id %Mouse_hWnd%
		} if(instr("DirectUIhWnd2,DirectUIhWnd3,SysListView321,",(MClass . ",")))
			SendMessage,0x115,loword(2),0,ScrollBar2,ahk_id %Mouse_hWnd%
		else,if(instr("SysTreeView321,",(MClass . ","))) 
			SendMessage,0x115,loword(2),0,%  MClass,ahk_id %Mouse_hWnd%
		 ; else,if(instr("SysListView321,",(MClass . ","))) {
		 ; SendMessage,0x115,loword(3),0,% MClass,ahk_id %Mouse_hWnd%
		 ; }
		else,SendMessage,0x115,loword(2),0,% MClass,ahk_id %Mouse_hWnd%
	} else,if(MClass="WindowsForms10.Window.8.app.0.34f5582_r6_ad1")
		ControlSend,% MClass,{Left},	ahk_id %Mouse_hWnd%
	else,ControlSend,,{PgUp},				ahk_id %Mouse_hWnd%
} else,if(instr("CabinetWClass,Notepad++,RegEdit_RegEdit,#32770,MainWindowClassName,MMCMainFrame,TMainForm,Windows.UI.Core.CoreWindow,", (Mouse_WinClass . ","))) {
	if((a_thishotkey="^f16")||(a_thishotkey="^f20"))
		sendinput,^{home}
	else,SendMessage,0x115,loword(2),0,% instr("DirectUIhWnd2,DirectUIhWnd3,Windows.UI.Core.CoreWindow,SysListView321,",(MClass . ","))? "ScrollBar2" : MClass,ahk_id %Mouse_hWnd%
} else,if(instr("MozillaWindowClass,MozillaCompositorWindowClass,Chrome_WidgetWin_1,",(Mouse_WinClass . ","))) {
	if(a_thishotkey="^f16" )||(a_thishotkey="^f20")
		send,^{f1}
	else,ControlSend,ahk_parent,{f1},ahk_Class %Mouse_WinClass%
} else,Send,{PgUp}
settimer,clean3,-1
return,

;------------------		M-WHEEL >RIGHT>
+f17::WheelRight	;	shift wheel_R to send original Wheel_R
WheelRight::
^f17::				;	Ctrl + wheel_r => PG_END
^F19::				;	logi sense Down button on lmb
F19::				;	logi sense Down button on lmb
f17::				;	WheelR = page down without interfering with selection
if(ConTxT_iCount) {
	SendKiLongnanme("right")
	Timer("ConTxT_iCount_rEval",-3000)
	return,
} active_id:=	WinExist("A")
MouseGetpos,,,	Mouse_hWnd,MClass
wingetClass,	Mouse_WinClass,ahk_id %Mouse_hWnd%

; Switch,Mouse_WinClass {
	; case,"gdkWindowToplevel":
		; wingettitle,Title, ahk_id %Mouse_hWnd%
		; if (Title ="Export Image...")
			; send,{end}
; }

wingetClass,Act_WinClass,ahk_id %active_id%
if(Mouse_hWnd!=Active_iD) { ;unfocused
	WinExist(("AHK_Id " Mouse_hWnd))
if(instr("MozillaWindowClass,MozillaCompositorWindowClass1,Chrome_WidgetWin_1,",(Mouse_WinClass . ","))) {
	if(Act_WinClass=Mouse_WinClass) {
		winActivate,
		send,^{f2}
	} else,ControlSend,ahk_parent,{f2},ahk_id %Mouse_hWnd%
} else,if(instr("CabinetWClass,Notepad++,RegEdit_RegEdit,#32770,MainWindowClassName,MMCMainFrame,TMainForm,",(Mouse_WinClass . ","))) {
	if(a_thishotkey="^f17"||a_thishotkey="^f19")
		ControlSend,% MClass,^{end},ahk_id %Mouse_hWnd%
	else,if(instr("DirectUIhWnd2,DirectUIhWnd3,",(MClass . ",")))
		 SendMessage,0x115,loword(3),0,ScrollBar2,ahk_id %Mouse_hWnd%
	else,if(instr("SysTreeView321,",(MClass . ",")))
		 SendMessage,0x115,loword(3),0,% MClass,ahk_id %Mouse_hWnd%
	else,SendMessage,0x115,loword(3),0,% MClass,ahk_id %Mouse_hWnd%
} else,if(MClass="WindowsForms10.Window.8.app.0.34f5582_r6_ad1")
	 ControlSend,% MClass,{Right},ahk_id %Mouse_hWnd%
else,ControlSend,,{PgDn},ahk_id %Mouse_hWnd%
} else,if(instr("CabinetWClass,Notepad++,RegEdit_RegEdit,#32770,MMCMainFrame,MainWindowClassName,TMainForm,",(Mouse_WinClass . ","))) {
	if(a_thishotkey="^f17"||a_thishotkey="^f19") ;focused MMCMainFrame
		 send,^{end} ;if Mouse_WinClass = Notepad++
	else,SendMessage,0x115,loword(3),0,% instr("DirectUIhWnd2,DirectUIhWnd3,",(MClass . ","))? "ScrollBar2" : MClass,ahk_id %Mouse_hWnd%
} else,if(instr("MozillaWindowClass,MozillaCompositorWindowClass1,Chrome_WidgetWin_1,",(Mouse_WinClass . ","))) {
	if(a_thishotkey="^f17")||(a_thishotkey="^f19")
		send,^{f2}
	else,controlSend,ahk_parent,{f2},ahk_Class %Mouse_WinClass%
}	else,send,{ PgDn }
settimer,clean3,-1
return,

clean3:
active_id:= Mouse_hWnd:= Mouse_WinClass:= MClass:= ""
return,

;-----------------------------        MWHEEL UP DOWN
~WheelUp:: ; TaskListThumbnailWnd needs to be addressed later, with injection of top and bottom buttons
~WheelDown::
if(d_trig) {
	send,{%a_thishotkey%}
	d_trig:= True, Timer("mwheel_D_Trig_Reset",-1212)
}
if(WinExist("ahk_Class #32768")) {
	if(!WinActive("ahk_exe SndVol.exe")) {
		send,% "{" . (strReplace(a_thishotkey,"~wheel")) . "}"
		return,
	} else,winhide,% "ahk_exe SndVol.exe"
	Timer("ConTxT_iCount_rEval2",-1212)
	return,
} else,if(Winactive("ahk_Class wmp Skin Host")) {
	send,% "{" strreplace(a_thishotkey,"~Wheel") "}"
} else,d_trig:= True
if(WinActive("ahk_Class AutoHotkeyGUI"))
	send,{~%a_thishotkey%} ; workaround to allow next scripts to access hotkey
else,send,{%a_thishotkey%}
return,

mwheel_D_Trig_Reset:
mwheel_IGTrig_Reset:
r:= strReplace(r:= strreplace(a_thislabel,"MWheel_"),"_Reset")
(%r%):= False ;d_trig:= False, igtrig:= False
return,

ConTxT_iCount_rEval2:
(!WinExist("ahk_Class #32768")? ConTxT_iCount:= False
: Timer("ConTxT_iCount_rEval2",-1212))
if(!(getKeyState("LButton","P"))) {
	send,{LButton Up} ; click up  ; lsend {~LButton Up} ; ||
	clicked:= True ; IMPORTANT : NEEDED ELSE Ctrl ADDED TO DRAG WILL DIE!
} return,

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

mspeedset: ;$f23::;SPI_GETMOUSESPEED:=0x70;SPI_SETMOUSESPEED:=0x71
if(!f23_init) {
	if dllcall("SystemParametersInfo","UInt",0x70,"UInt",0,"UIntP",MouseSensOrig,   "UInt",0)
	if dllcall("SystemParametersInfo","UInt",0x71,"UInt",0,"Ptr",  MouseSensOrig*.4,"UInt",0)
		f23_init:= True
} ;This prevents keyboard auto-repeat from doing the dllcall too much more than necessary
return,

mspeedUnset: ;;~f23 Up:: ;tt("send " A_sendlevel "`n input " a_inputlevel "`n")
Ssleep(4)
try,{
	if dllcall("SystemParametersInfo","UInt",0x70,"UInt",0,"UIntP",MouseSensOrignew,"UInt",0)
		(MouseSensOrignew=MouseSensOrig? MouseSensOrig:=MouseSens0)
	if dllcall("SystemParametersInfo","UInt",0x71,"UInt",0,"Ptr",MouseSensOrig,"UInt",0)
		f23_init:= False
} Ssleep(70)
return,

infoTip_togl__:
; ^#MButton::            ;  Ctrl + WIN + MIDDLE=MOUSE-BUTT
settimer,infoTip_togl,-1
sleep,10
return,

^9:: ; #2: Disable DWM rendering of the window's frame.
dllcall("dwmapi\DwmSetWindowAttribute","ptr",WinExist("Window Title"),"uint"
,DWMWA_NCRENDERING_POLICY:= 2,"int*",DWMNCRP_DISABLED:= 1,"uint",4)
TT(lasterror())
return,

^0:: ; To undo it (this might also cause any set region to be ignored):
dllcall("dwmapi\DwmSetWindowAttribute","ptr",WinExist("Window Title"),"uint"
,DWMWA_NCRENDERING_POLICY:= 2,"int*",DWMNCRP_ENABLED:= 2,"uint",4)
TT(lasterror())
return,
#ifwinactive ahk_class gdkWindowToplevel
f13::-
f14::=
#if
^#a::
anisyringe:= DllCall("LoadImage","Int",0
								, "Str", "C:\Icon\- Icons\- CuRS0R\_ ani\INJEX.ani"
								, "Int", 2 ;IMAGE_CURSOR
								, "Int", 64,"Int",64
								, "UInt",0x10,"Ptr")
controlget,cw,hwnd,,static2,ahk_exe regedit.exe
SetImg(cw,anisyringe)
return,
;=======================================================================END==KEY=BINDZ===============
SetImg(hwnd,hBitmap) { ; Example:Gui,Add,Text,0xE w500 h300 hwndhPic
	 ;STM_SETIMAGE=0x172 ;SS_Bitmap=0xE
	   Static Ptr := "UPtr"
	If(!hBitmap||!hwnd)
		return,
	;sendmessage,0x172,1,hBitmap,,ahk_id %hwnd% ; msgbox,% hwnd ;sendmessage,0x0170,0xE,,,ahk_id %hParent%
	; sendmessage,0x172,hBitmap,,,ahk_id %hwnd% ;msgbox % errorlevel " test"
	E := DllCall("SendMessage", "Ptr", hwnd, "UInt", 0x172, "UInt", 0x1, "Ptr", hBitmap)
	;DelObj(E)
	return,e
}

DelObj(hObject) {
   return DllCall("DeleteObject", "UPtr", hObject)
}
;--===---===---===---===---===---===SUBROUTINES---===---===---===---===---===---===---===---===---===
NegateDTopF: ;2slo2bPractical : ISSUES WITH DICONS TEARING THRU WHOLE OS-UI
gui,BackMain:New,-DPIScale +toolwindow +owner -SysMenu +AlwaysOnTop +e0x20
gui,BackMain:+LastFound +hWndMainhWnd -Caption
gui,BackMain:color,99ccff
winSet,Transcolor,99ccff
pToken:= Gdip_Startup()
gui,pic:	New,-DPIScale +hWndhpic +parentBackMain +ToolWindow +e0x20 E0x80000
gui,pic:	+LastFound -Caption -SysMenu +OwnDialogs
gui,pic:	color,0f3f5c
gui,BackMain:Show,% "na x0 y0 " wh:="w" . a_screenwidth . " h" . a_screenheight
gui,BackMain:hide
glob_DC:= dllcall("GetDC","UInt",0), main_DC:= dllcall("GetDC","UInt",MainhWnd)
dllcall("gdi32.dll\SetStretchBltMode","Uptr",main_DC,"UInt",3)
mdc:= dllcall("GetDC","UInt",hpic)
dllcall("gdi32.dll\SetStretchBltMode","Uptr",SysLv_DC,"UInt",3)
dllcall("gdi32.dll\SetStretchBltMode","Uptr",mdc,"UInt",3)
hProgman:= WinExist("ahk_Class WorkerW", "FolderView") ? WinExist()
:  WinExist("ahk_Class Progman", "FolderView")
ShDef_DC:= dllcall("GetDC","UInt",hShellDefView:=dllcall("user32.dll\GetWindow","ptr",hProgman	   ,"int",5,"ptr"))
SysLv_DC:= dllcall("GetDC","UInt",hSysListView:= dllcall("user32.dll\GetWindow","ptr",hShellDefView,"int",5,"ptr"))
dd:=desktop(), dllcall("SetParent","ptr",hpic,"ptr",dd)
gui,pic:	show,na x0 y0 %wh%
winhide,ahk_id %hSysListView%
dllcall("UpdateLayeredWindow","Uint",hpic,"Uint",0,"Uint",0,"int64P",a_screenwidth|a_screenheight<<32
,		"Uint",SysLv_DC,"int64P",0,"Uint",0,"intP",0xff<<16|1<<24,"Uint",2), Show:=-1
winhide,ahk_id %hSysListView%
dllcall("UpdateLayeredWindow","Uint",MainhWnd,"Uint",0,"Uint",0,"int64P", a_screenwidth|a_screenheight<<32
,	"Uint",mdc,"int64P",0,"Uint",0,"intP",0xff<<16|1<<24, "Uint", 2)
loop,9
	sleep,50
winshow,ahk_id %hSysListView%
sleep,100
send,{LButton Down}
sleep,100
gui,pic:hide
gui,pic:destroy
return,

Renametree: ; wingetClass,Ac,A
mousegetpos,X,Y,HW,CW
;((Ac="SysTreeView321")? TreegetHot("Rename"))
(CW="SysTreeView321"? TreegetHot("Rename"))
return,

Tree_NodeToggle:
mousegetpos,x,y,hw,CW
(CW="SysTreeView321"? TreegetHot("Toggle"))
sleep,800
return,

CopyT:
(LastCpy_H? LastCpy_H_old:= LastCpy_H)
LastCpy_H:= WinExist("A")
(LastCpy_T? LastCpy_T_old:= LastCpy_T)
Wingettitle,LastCpy_T,A
return,

menudetail_dump:
Winget,hWnd,ID,ahk_Class #32768
if(!hWnd)
	return,
SendMessage,0x1E1,0,0,,ahk_Class #32768 ;MN_GETHMENU
if (!(hMenu:= errOrlevel)) {
	msgb0x("fail",2)
	return,
} Winget,vPID,PiD,% "ahk_id " hWnd ; OpenProcess may not be needed to set an external menu item's icon to HBMMENU_MBAR_RESTORE
if(!hProc:= dllcall("OpenProcess",UInt,0x1F0FFF,Int,0,UInt,vPID,Ptr))
	return,
Loop,% dllcall("GetMenuItemCount",Ptr,hMenu)
{
 (Vtext=""? Vtext:= "-------------------separator")
 vtextold:= trim((vtextold . "`n" . vtext))
 vChars:= dllcall("user32\GetMenuString",Ptr,hMenu,UInt,vIndex,Ptr,0,Int,0,UInt,0x400) +1
 VarSetCapacity(vText, vChars << !!A_IsUnicode)
 dllcall("user32\GetMenuString",Ptr,hMenu,UInt,vIndex,Str,vText,Int,vChars,UInt,0x400) ; MF_BYPOSITION
 vPos:= vIndex:= A_Index-1, vSize:= A_PtrSize= 8? 80 : 48
 VarSetCapacity(MENUITEMINFO,vSize,0)
 dllcall("SetMenuItemInfo",Ptr,hMenu,UInt,vPos,Int,1,Ptr,&MENUITEMINFO)
}dllcall("CloseHandle",Ptr,hProc)
clipboard=%vtextold%,%vtext%
vtextold:= vtext:= ""
return,

infoTip_togl: ;  Toggle - INFO - DISPLAY
infoTip_isactive:= !infoTip_isactive
HHandler:
if(infoTip_isactive) {
 menu,tray,check,Handle Handler,
 setTimer,infoTip_refresh,50
 setTimer,infoTip_refresh2,70
 setTimer,infoTip_kill,% infoTip_timeout
} else {
	menu,tray,uncheck,Handle Handler,
	Ssleep(90)
	setTimer,infoTip_refresh,off
	setTimer,infoTip_refresh2,off
	infoTip_isActive:= False
	setTimer,HHandler,off
	tooltip,,,,1
	tooltip,,,,2
} return,

infoTip_kill:
infoTip_isActive:= False
setTimer,HHandler,-1
return,

infoTip_Copy: 						;	Ctrl & Win & bC
MouseGetpos,X_Cur,Y_Cur,Window,Control
clipboard:= _infoTip_(X_Cur,Y_Cur)	;	Copy Window info
,infoTip_isactive:= !infoTip_isactive
,infoTip_INFO:= ""
infoTip_isactive:= !infoTip_isactive ;	Toggle - INFO - DISPLAY
return,

infoTip_refresh:
coordmode,tooltip,screen
((X_Cur<A_ScreenWidth *.5)? TTX:=(A_ScreenWidth *.5) +100 : TTX:=(A_ScreenWidth *.5) -400)
,((Y_Cur<A_ScreenHeight*.5)? TTY:=(A_ScreenHeight*.5) +100 : TTY:=(A_ScreenHeight*.5) -300)
   infoTip_INFO:= _infoTip_(X_Cur,Y_Cur)
if(!(infoTip_INFO=infoTip_INFOOld)) {
	tooltip,% infoTip_INFO,% TTX,% TTY,2
	infoTip_INFOOld:= infoTip_INFO
}
(A_TimeIdle>60000? Timer("infoTip_togl",-1))
return,

infoTip_refresh2:
coordmode,tooltip,screen
;((X_Cur<A_ScreenWidth *.5)? TTX:=(A_ScreenWidth *.5) +100 : TTX:=(A_ScreenWidth *.5) -400)
; ,((Y_Cur<A_ScreenHeight*.5)? TTY:=(A_ScreenHeight*.5) +100 : TTY:=(A_ScreenHeight*.5) -300)
   ;infoTip_INFO:= _infoTip_(X_Cur,Y_Cur)
;if(!(infoTip_INFO=infoTip_INFOOld))
 ;{
tooltip,% infoTip_INFO,% TTX,% TTY,1
;infoTip_INFOOld:= infoTip_INFO
;}
(A_TimeIdle>60000? Timer("infoTip_togl",-1))
return,

Explorer_Kill: ;<<<<<<<<<<<<<<EXPLORER RESTART/KILL>>>>>>>>>>>>>>>
run,% comspec " /C taskkill /f /im explorer.exe",,hide
sleep,1400
Explorer_New:
run,% comspec " /C explorer.exe",xpid,hide
sleep,1400
try,(!WinExist("ahk PiD " xpid)? (runcmd("explorer.exe")))
catch,
	sleep,880
return,

;---===---===---===---===---===---===END-SUBROTINES---===---===---===---===

;----------------------------------- REG READ ----------------------------
Blacklist_RegRead:
regRead,Bypass_ClassList,%	RegBase,Blacklist_ClassList
regRead,Bypass_TitleList,%	RegBase,Blacklist_TitleList
regRead,Bypass_ProcList,%	RegBase,Blacklist_ProcessList

WheeljewclawRegRead:
mwheeldrag:=[]
TT("reading reg...",300)
loop,parse,% "HKCU\SOFTWARE\_MW\mousewheel", `,
{
	key_:= a_loopfield
	Loop,Reg,% key_,KV
	{
		regRead,v_
		mwheeldrag[A_LoopRegName]:= v_
}	} return,

Blacklist_ParseArr:
TT("Parsing Blacklist")
loop,Parse,Bypass_ProcList, `,
{
	if(a_index=1) {
		BypassProcListStr		:= a_loopfield
		,BypassProcListArr[1]		:= a_loopfield
	} else {
		BypassProcListArr[A_Index]:= a_loopfield
		if(a_index<21) {
			BypassProcListStr	:= (BypassProcListStr "," a_loopfield)
			,BlacklistProcCount	:= A_Index
		} else,msgbox,% "ErrorBypassing Proc",% "More than 21 Blacklisted .Exes"
}	}

loop,Parse,Bypass_ClassList,`,
{
	BypassClassListArr[A_Index]:= a_loopfield
	(!BypassClassListStr? (BypassClassListStr:= q . a_loopfield . q) : BypassClassListStr:= (BypassClassListStr . "," . q . a_loopfield . q))
	BlacklistClassCount:= A_Index
}

loop,Parse,Bypass_TitleList,`,
{
	BypassTitleListArr[A_Index]:= a_loopfield, (!BypassTitleListStr? BypassTitleListStr:= q . a_loopfield . q : BypassTitleListStr:= (BypassTitleListStr . "," . q . a_loopfield . q))
	BlacklistTitleCount:= A_Index
} TT("Finished arsing Blacklist.")
return,

Bypass_Parse_Array:
for,index,value in BypassProcListArr
	(!ProcList? ProcList:= value : ProcList:= ProcList "," value)
Bypass_ProcList:= ProcList

for,index,value in BypassClassListArr
	(!ClassList? ClassList:= value : ClassList:= ClassList "," value)
Bypass_ClassList:= ClassList

for,index,value in BypassTitleListArr
	(!TitleList? TitleList:= value : TitleList:= TitleList "," value)
Bypass_TitleList:= TitleList

EvaluateBypass_Class(hWnd) {
	;global systray_RB
	wingetClass,ClassN,% (id_ . hWnd)
		; msgbox % ClassN "`n" BypassClassListStr

	systray_RB:=(ClassN="Shell_TrayWnd"? True:False)
	if(instr(BypassClassListStr,ClassN))
		return,1
	switch,ClassN{
		case,"PCsuxRox":return,1
	} return,0
} 

EvaluateBypass__Proc(hWnd) {
	Winget,ProCN,ProcessName,% id_ hWnd,
	if(BypassProcListStr) {
		msgbox % BypassProcListStr
		if instr(BypassProcListStr,proCN "," )
			return,1
	}	Switch,ProCN {
		case,"DOSBox.exe" : return,1
		case,startmenu : return,1
		;case,(Bypass_ProcList contains ProCN) : return,1
		Default : return,
		case,fagg : return,1
}	}

EvaluateBypass_Title(hWnd) {
	WingetTitle,Titl3,% id_ . hWnd,
		if Titl3 in %BypassTitleListStr%
		return,1
	; Switch,Titl3 {
	; case,BypassTitleListArr[1], BypassTitleListArr[2], BypassTitleListArr[3], BypassTitleListArr[4], BypassTitleListArr[5], BypassTitleListArr[6], BypassTitleListArr[7], BypassTitleListArr[8], BypassTitleListArr[9], BypassTitleListArr[10], BypassTitleListArr[11], BypassTitleListArr[12], BypassTitleListArr[13], BypassTitleListArr[14], BypassTitleListArr[15], BypassTitleListArr[16], BypassTitleListArr[17], BypassTitleListArr[18], BypassTitleListArr[19], BypassTitleListArr[20]: return,1
	; Default:
		; return,0
} return,

BP_RegDelete:
RegDelete,% RegBase,Blacklist_ClassList
RegDelete,% RegBase,Blacklist_ProcessList
RegDelete,% RegBase,Blacklist_TitleList
return,

BP_RegWrite: 
msgbox % Bypass_ClassList
regWrite,REG_SZ,% RegBase,Blacklist_ClassList,% Bypass_ClassList
regWrite,REG_SZ,% RegBase,Blacklist_ProcessList,% Bypass_ProcList
regWrite,REG_SZ,% RegBase,Blacklist_TitleList,% Bypass_TitleList
return,

Toggle_Win_Drag_State:
menu,submenu1,% (optM2dAutoActiv8:=!optM2dAutoActiv8)? "Uncheck":"check",Raise window when Dragged
return,

TripleBeemedOff:
TripleBeemed:= False, tt("tbeem")
return,

NavPaneNodeAutoToggle:
if(!TripleBeemed) {
	TripleBeemed:= True
	settimer,TripleBeemedoff,-749
} (TreeLast:= TreegetHot("GetPath"))?	TreeSPree++ : (TreeSPree:= 0, TreeLast=(TreegetHot("GetPath")))
(TreeSPree=3? TreegetHot("shrink"),TreeSPree:=0) ;msgbox % TreeSPree " spree`ntree"  Sexytree "`nlast " TreeLast
tt("NP")
return,

Vignette_On:
if(!Winexist("C:\Script\AHK\__TESTS\vignette.ahk ahk_class AutoHotkey"))
	run,% "C:\Script\AHK\__TESTS\vignette.ahk"
else,gosub,Vignette_off
return,

Vignette_Off:
if(h:=Winexist("C:\Script\AHK\__TESTS\vignette.ahk ahk_class AutoHotkey"))
	Send_WM_COPYDATA("exit","ahk_id " . h) ;
else,gosub,Vignette_on
return,

App_Check:
CoordMode,Mouse,Window
MouseGetpos,X_Cur1,Y_Cur1,m_hWnd,m_ctltt
; winget,pn,processname,ahk_id %m_hWnd% ; switch,PN {
	; case,"werfault.exe": (result:= Send_WM_COPYDATA("click",EventScript)); }
; WINGETTITLE,WTTL,ahk_id %m_hWnd%
; (INSTR(WTTL,"C:\Script\AHK\ADhKI.ahk - AutoHotkey v")?m_ctltt=""?result:= Send_WM_COPYDATA("clickup",EventScript): result:= Send_WM_COPYDATA("click",EventScript))
wingetclass,class_,ahk_id %m_hWnd%
wingetClass,m_class,% "ahk_id " m_hWnd ;;;;;TT(m_ctltt)
Switch,m_Class {
	;case,"WMP Skin Host" : ;TT(X_Cur1 "," Y_Cur1)
	case,"CabinetWClass" : if((winexist("ahk_class SysDragImage"))&&(m_ctltt="SysTreeView321")&&!TripleBeemed)
			settimer,NAVPANEnodeautotoggle,-1
} return,

; Switch,m_ctltt {
; case,"RICHEDIT50W1","RICHEDIT50W2":
	; controlget,mchWnd,hWnd,,%m_ctltt%,ahk_id %m_hWnd%
	; sendmessage,0x0030,0,1,,ahk_id %mchWnd% ;WM_SETFONT
; }
;-==-===-====-===-==-===-====-===-==-===-====-===-==-===-====-=====-==-===-====-===-
;-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-=-=-=
;                      -==-=-=-=-=^^^@::@::@^^^-==-=-=-=-=

SndKi(Ki,Down_Up="") {	;	(!d_u = assuming click 1'ce)
((down_up="D")? down_up:="Down"
: ((down_up="U")? down_up:="Up"
: down_up:=""))
Send,{%ki% %down_up%}
return,~errOrlevel

} ;-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-=-=
;	^~LButton Up:: ;;~$~LButton Up::
;	 ~LButton Up::
;	 ((!clicked)?(SndKi("~LButton","U"),(clicked:= True))) ; a_thishotkey
;	?TT(a_now):TT(errOrlevel)sendinput {~LButton Up} ;click up
;	 if LBTrigrx {
;	    PostMessage,% WM_LB_up,% WMReSz_S_E,% "ahk_id " hWnd_A
;		 LBTrigrx:=False
;	 } return,
;	-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==-=-=-=-=-==
;[][]     [][][][]     [][];

StyleMenu_FixLaunch:
StyleMenu_Trigger:= False
WinClose("ahk_Class #32768")
((!(WinExist("ahk_Class #32768")))? (result:= Send_WM_COPYDATA("StyleMenu",EventScript),spinn4(hw,"800"))
:	(WinClose("ahk_Class #32768"), TT("persisting menu window")))
return,

;[][][][][][][][][][][][][][]

;[][][][][][][][][][][][][][]

; corner_offset_get0:
; XOff:= (X_MSt4-X_Win_S), YOff:= (Y_MSt4-Y_Win_S)
; return,

DimensionChkii:
((WII:= (W_Wins +X_net)<256)? (WII:= 256) : (WII>3000? (WII:= 3000)))
,((HII:= (H_Wins +Y_net)<256)? (HII:= 256) : (HII>2000? (HII:= 2000)))
(((x0x:= (X_Cur1 -X_net))<-1000)? (X0X:=-1000) : (X0X>3500? (X0X:= 3500)))
,(((y0y:= (Y_Cur1 -Y_net))<-1000)? (y0y:=-1000) : (y0y>2000? (y0y:= 2000)))
return,

Watch_Lbii:
x0x:= (X_Cur1 +(x_NET:= (X_MSt4-X_Cur1)))
,y0y:= (Y_Cur1 +(y_NET:= (Y_MSt4-Y_Cur1)))
return,

;[][][][][][][][][][][][][][]
Edit_C(inout) {
	ControlGetFocus,cf,% inout
	if instr("Edit1,DirectUIhWnd1,", (cf . "," ))
		return,True
} ;return,False

Bicycle: ; strips hotkey combos for splitting original key for bypass seive
;  	 ie:  numbers 1-9 blocked in youtube,-> Allowed with Shift, Ctrl or Alt.
;    ie2: arrows diabled in explorer -> Except when in edit controls
hWndA  := WinActive("A")
if(!dki)
 dki  := a_thishotkey
if(dki contains "$" && dki!=$) {
 ttdki:= strReplace(dki,"$")  ; hotkey loopback marker
 , dki:= ttdki
} if(dki contains "^" && dki!=$) {
 ttdki:= strReplace(dki,"^","Control + ")
 , dki:= strReplace(dki,"^")
} if(dki contains "!" && dki!=$) {
 ttdki:= strReplace(dki,"!","Alt + ")
 , dki:= strReplace(dki,"!")
} if(instr(arrowlist,dki) || instr("^z^y", dki)) { ; add to taste
	ControlGetFocus,cf,% inout
	if(Edit_C(("ahk_id " . hWndA)))
		send,{%a_thishotkey%}
	else,if(instr("DirectUIhWnd1",CF)) ; additional CNt names, should a function be made?
		send,{%a_thishotkey%}
} else,if(instr(numpadsrs,dki))
	wingetClass,ClassA,A
if(ClassA="MozillaWindowClass") {
	WingetActiveTitle,A_Title
if(instr(A_Title,"YouTube")) {
	if(instr(dki,"+")) {
		dki:= strReplace(dki:= strReplace(dki,"!"),"+")
		send,{%a_thishotkey%}
	} else,TT( dki " Disabled in Youtube.",-300)
} else {
	dki:= strReplace(dki:= strReplace(dki,"!"),"+")
	send,{ %a_thishotkey% }
}	} dki:= ""
return,

WingetTransparency:
MouseGetpos,   ,   ,  hWnd
(T_%hWnd% = "") ? (T_%hWnd%:= 100):()
Trans:= (T_%hWnd%), Opaci_T:= Trans
return,

WinsetTransparency:
wingetClass,WindowClass,ahk_id %hWnd%
if(WindowClass="Progman")
	return,
Opaci_T	:=	(Opaci_T<1)? 1 : (Opaci_T>99)? 100 : Opaci_T
Alpha0	:=	Trans *2.56			;	Init. Alpha
Alpha	:=	Round(Opaci_T*2.56) ;	Final Alpha
Trans	:=	Opaci_T
t_%hWnd%:=	Trans
a:=	Alpha-Alpha0, b:=	AlphaIncrement
b*=	(a<0)? -1 : 1		;	Signed increment
a:=	Abs(a)					;	Abs. iter. range
loop,{
	Alpha0:= Round(Alpha0)
	Winset,Trans,% Alpha0,ahk_id %hWnd%
	if(Alpha0=Alpha||Alpha=255)
		break,
	else,if(a >=AlphaIncrement) {
				Alpha0 +=b
			a -=AlphaIncrement
	} else,	Alpha0:= Alpha
} return,

AeroSnapInit:
Switch,A_ScreenDPI {
	case,"96"	: SetEnvironmentVariableW:= 50
	case,"120"	: TargetdY:= 54 ;if(((Y_Win = "74")||(Y_Win="54"))&&(((H_Win = "1149"))||(H_Win = "1147")||(H_Win= "1131")));SnapdV:= True
	case,"144"	: TargetdY:= 58, TargetdH:= 1140 ;if(((Y_Win = "74")||(Y_Win="66"))&&(((H_Win = "1133"))||(H_Win = "1129")||(H_Win= "1131")));SnapdV:= True
	case,"168"	: TargetdY:= 66
	case,"192"	: TargetdY:= 70
	Default 	: TargetdY:= "NonStandard"
} return,

ToolTipCreate:
C:= Floor(Trans*0.5), D:= (50 -C)
TooltipText:="[ TRANZ ]"
loop,% C
	tooltipText.="|"
(c>0? tooltipText.=" ")
tooltipText.= 100 -Trans . "%"
(d>0? tooltipText.=" ")
loop,% d
	tooltipText.="|"
tooltip,% tooltipText,,,3
MouseGetpos,MouseX0,MouseY0
setTimer,TooltipDestroy,-1000
return,

TooltipDestroy:
infoTip_INFO:= ""
tooltip,,,,3
return,

BypassTimer:
init_wheel_Bypass:= False
return,

WGetTitle(ahkidtype="") {
 (ahkidtype="")? (ahkidtype:="A"):()
 Wingettitle,_T,% ahkidtype
 return,retval:=(!(_T="")? (_T) : ("Untilted"))
}

Aggr_Y_Timer: ; Aggregate Y_Timer
(!getKeyState("MButton","P")? Timer("Aggr_Y_Timer","Off"))
MouseGetpos,x,y
if(Trig3rd_)
	return,
Aggy:= y -initPosY
if(Aggy!=0){
	Sleep(50)
	return,
} else,if(Aggy>0) {
	Trig3rd_:= True, SendKiLongnanme(WheelUp)
	(y__? y:=y__), y__:="", yyy:= y +coefficient_menuh +Aggy
	sleep,20
	clipcursor(0,xs,(yyy-1),xs,(yyy+2))
	clipcursor(1,xs,(yyy-1),xs,(yyy+2))
	sleep,30
	MouseGetpos, x,	y__
	initPosY:=		y__
} else,if(!(Aggy="")&&(Aggy<0)) {
	Trig3rd_:= True, SendKiLongnanme("WheelDown")
	(y__? y:= y__:()), y__:="", yyy:= y -coefficient_menuh -Aggy
	sleep,20
	clipcursor(0,xs,yyy-1,xs,(yyy+2))
	clipcursor(1,xs,yyy-1,xs,(yyy+2))	; else,sleep, 250
	sleep,30							; MouseGetpos,,y
	MouseGetpos,x,	y__		; sleep,% VScrollDelayT_m1
	initPosY:=		y__			; settimer,ClipOff,-100
}

BobGatE_Timer:
Trig3rd_:=False
return,

HK_PairSend:
init_wheel_Bypass:= True
HK:= StrSplit(a_thishotkey,,,2)
send,% (HK[1]) "{" . (HK[2]) . "}"
Timer("BypassTimer",-250)
return,

;;;;; WITH MOUSE-1 || STYLUS NiB-DOWN ;;;;;
if (getKeyState("~LButton","P")) {
	clipcursor(1,Xs,Ys-1,Xs,Ys+2)
	XYLock:= True, Aggy:=Y-Ys,Ys:=Y
	if(Aggy>0)
		send,{WheelUp}
	else,if(Aggy<0)
		send,{WheelDown}
	sleep,50
} settimer,J32,-60
return,

HK_Critical(HK){
	critical
	send,{%HK%}
	return,!errOrlevel
}

HK_A_ZTrim(HK,Trim="") {
	HK:= LTrim(HK,OmitChars:= "~$")
	send,{%HK%}
	return,!errOrlevel
}

Getworker_Mousepos() {
	static MEM_COMMIT:= 0x1000, MEM_RELEASE:= 0x8000, PAGE_READWRITE:= 0x04
		, PROCESS_VM_OPERATION:= 0x0008, PROCESS_VM_READ:= 0x0010
		, LVM_GETITEMCOUNT:= 0x1004, LVM_GETITEMRECT:= 0x100E
	MouseGetPos,x,y,hWnd
	if(!hWnd=WinExist("ahk_Class Progman")||hWnd=WinExist("ahk_Class WorkerW"))
		return,
	ControlGet,hWnd,hWnd,,SysListView321
	if not WinExist("ahk_id" hWnd)
		return,
	WinGet,PiD,PiD
	if(hProcess:= dllcall("OpenProcess","UInt",PROCESS_VM_OPERATION|PROCESS_VM_READ,"Int",False,"UInt",PiD)) {
		item:= "", VarSetCapacity(iCoord,16)
		SendMessage,% LVM_GETITEMCOUNT,0,0
		loop,% errOrlevel {
			pItemCoord:= dllcall("VirtualAllocEx","Ptr",hProcess,"Ptr",0,"UInt",16,"UInt",MEM_COMMIT,"UInt",PAGE_READWRITE)
			SendMessage,% LVM_GETITEMRECT,% a_Index-1,% pItemCoord
			dllcall("ReadProcessMemory","Ptr",hProcess,"Ptr",pItemCoord,"Ptr",&iCoord,"UInt",16,"UInt",0)
			dllcall("VirtualFreeEx","Ptr",hProcess,"Ptr",pItemCoord,"UInt",0,"UInt",MEM_RELEASE)
			Left := NumGet(iCoord,0,"Int"), Top	  := NumGet(iCoord, 4,"Int")
			Right:= NumGet(iCoord,8,"Int"), Bottom:= NumGet(iCoord,12,"Int")

			if(left<x and x<right and top<y and y<bottom) {
				ControlGet,list,List	;	>>Delete extraneous date chars	>>:
				RegExMatch(StrSplit(list,"`n")[a_Index],"O)(.*)\t(.*)\t(.*)\t(.*)",Match)
				item:= {left:left,top:top,right:right,bottom:bottom
						, name:Match[1], size:Match[2], type:Match[3]
						, date:RegExReplace(Match[4],A_IsUnicode? "[\x{200E}-\x{200F}]":"\?")}
				; - Unicode LTR (Left-to-Right) mark (0x200E=8206)
				; - Unicode RTL (Right-to-Left) mark (0x200F=8207)
				break,
		}	} dllcall("CloseHandle","Ptr",hProcess)
	}	return,byref item
}

WM_WINDOWPOSCHANGED(hWnd="") {
	global RBhWnd
	VarSetCapacity(WPOS,28,0)
	R:= rect((hWnd=""? hWnd:= RBhWnd))
	numput(hWnd	,WPOS, 0,"Uint")
	numput(R.L	,WPOS, 8,"Int")
	numput(R.T	,WPOS,12,"Int")
	numput(R.W	,WPOS,16,"Int")
	numput(R.H	,WPOS,20,"Int")
	numput(0x230,WPOS,24,"Uint")
	sendmessage,0x0047,0,&WPOS,,ahk_id %hWnd%
} ;SWP_NOOWNERZORDER=0x0200 | SWP_NOACTIVATE=0x0010 | SWP_FRAMECHANGED=0x0020;

LoWord(Dword,Hex=0) {
	static WORD:= 0xFFFF
	return,(!Hex)? (Dword&WORD) : Format("{1:#x}",(Dword&WORD))
}

HiWord(Dword,Hex=0) {
	static BITS:= 0x10, WORD:= 0xFFFF
	return,(!Hex)? ((Dword>>BITS)&WORD) : Format("{1:#x}",((Dword>>BITS)&WORD))
}

MakeLONG(LOWORD,HIWORD,Hex=0) {
	static BITS:= 0x10, WORD:= 0xFFFF
	return,(!Hex)? ((HIWORD<<BITS)|(LOWORD&WORD)) : Format("{1:#x}"
	,	((HIWORD<<BITS)|(LOWORD&WORD)))
}
;	 -~-~-~-~-~-~-~-~--~>>   Bypass   >>-~--~-~-~-~-~-~-~-~-~-~>>
;	 -~-~-~-~-~-~-~-~--~>>   Bypass   >>-~--~-~-~-~-~-~-~-~-~-~>>

M2dBypassEval() {
	return,((EvaluateBypass_title(LB_hWnd))||(EvaluateBypass__Proc(LB_hWnd))||(EvaluateBypass_class(LB_hWnd)))? 1:0
}

; Winget,ProCN,ProcessName,ahk_id %A_hWnd%
; for,k,v in PName {
;  if(v=ProCN)
;    Gosub,hotkeySendSelf
; }
; Swipe(A_hWnd,a_thishotkey)
; return,

IsWindowVisible(hWnd) {
	return,dllcall("IsWindowVisible","Ptr",hWnd)
}

Sleep(dur:= 1) {
	listlines,off
	sleep,% dur
}

LVM_GetText(hWnd,N,C:=1) {								; list view
	N -=1																		; convert to 0 based index
	varSetCapacity(t,511,1)									; init *struct*
	varSetCapacity(lvItem,A_PtrSize * 7)		; init *struct*
	numPut(1,lvItem,"uint")									; mask
	numPut(N,lvItem,A_PtrSize,"int")				; i_item	N
	numPut(C-1,lvItem,A_PtrSize *2,"int")		; i_SubItem	C
	numPut(&T,lvItem,A_PtrSize *5,"ptr")		; Ptr_szText preReq
	numPut(512,lvItem,A_PtrSize *6)					; cch_TMax*output struct*
	dllcall("SendMessage","uint",hWnd,"uint",4211,"uint",N,"ptr",&lvItem)
	return,T 																;4211-LVM_GETITEMTEXTW;
}

UEventHook(UProc,Event,hWnd,idObject,idChild,event_thread) {
	global static ConTxT_iCount
	, HookM:= dllcall("SetWinEventHook","Uint",0x0006,"Uint",0x0006,"Ptr",0,"Ptr",UProc := RegisterCallback("UEventHook",""),"Uint",0,"Uint",0,"Uint",0x0000|0x0002)
	, initt:= dllcall("SetWinEventHook","Uint",0x0007,"Uint",0x0007,"Ptr",0,"Ptr", UProc,"Uint",0,"Uint",0,"Uint",0x0000|0x0002)
	, HookMb:=  dllcall("SetWinEventHook","Uint",0x0010,"Uint",0x0010,"Ptr",0,"Ptr", UProc,"Uint",0,"Uint",0,"Uint",0x0000|0x0002)
	, Hooksel:=  dllcall("SetWinEventHook","Uint",0x8006,"Uint",0x8006,"Ptr",0,"Ptr", UProc,"Uint",0,"Uint",0,"Uint",0x0000|0x0002)
	, Hookseltxt:=  dllcall("SetWinEventHook","Uint",0x8014,"Uint",0x8014,"Ptr",0,"Ptr", UProc,"Uint",0,"Uint",0,"Uint",0x0000|0x0002)
	tt(event)
	Switch,event {
		case,"6" : ConTxT_iCount++ ; += 1 ;TT("tt+")
		case,"7" : ConTxT_iCount-- ; -= 1 ;TT("tt-")
	} settimer,ConTxT_iCount_rEval,-1700 ;workaround menu exist after closed
}

Send_WM_COPYDATA(ByRef STR_,ByRef TargetScript) {
	VarSetCapacity(CopyDataStruct,3*A_PtrSize,0)
	SizeInBytes:= (StrLen(STR_) +1) *(A_IsUnicode? 2 : 1)
	NumPut(SizeInBytes,CopyDataStruct,A_PtrSize)
,	NumPut(&STR_,CopyDataStruct,2*A_PtrSize)
	Prev_DetectHiddenWindows:= A_DetectHiddenWindows
,	Prev_TitleMatchMode:= A_TitleMatchMode
	DetectHiddenWindows On
	SetTitleMatchMode 2
	TimeOutTime:= 4000
	SendMessage,0x4a,0,&CopyDataStruct,,% TargetScript,,,,% TimeOutTime
	DetectHiddenWindows %Prev_DetectHiddenWindows%
	SetTitleMatchMode %Prev_TitleMatchMode%
	return,errOrlevel 
}

Receive_WM_COPYDATA(wParam,lParam ) {
	local re
	CopyOfData:= StrGet(StringAddress:= NumGet(lParam+(2*A_PtrSize)))
	if(NewStr:= SubStr(CopyOfData,0,2)="mb") {
		StringTrimLeft,icop,CopyOfData,2
		winwaitactive,ahk_Class #32770
		icon2msgb0x(icop)
		return,
	} else,(newstr="wm"? msgb0x("New wm: " newstr,5))
	
	if(instr(CopyOfData,"BypassDragclass_")) {
		NewBypassClass:= strreplace(CopyOfData,"BypassDragclass_")
		re:= Func("bypassclass_Togl").bind(NewBypassClass)
		settimer,% re,-10
		return,
	} ;msgbox,% CopyOfData " WM RX @ ADMIN"
	Switch,CopyOfData {
		case,"ReReadwhReg": Gosub,WheeljewclawRegRead
		Default: ;msgbox,% CopyOfData " WM RX @ ADMIN"
		if((islabel(CopyOfData))||(isfunc(CopyOfData)))
			settimer,% CopyOfData,-10
	  ;	case,"blurmymenu": ; settimer, aeroloopbk_, 1
	} ;	C_Str=C:\Windows\system32\cmd.exe /s /k pushd "%CopyOfData%"
	return,True
}

bypassclass_Togl(class) {
	if(!instr(Bypass_ClassList,"," class))
		Bypass_ClassList.= "," . class
	else,Bypass_ClassList:=strreplace(Bypass_ClassList,"," class)
	gosub,BP_RegWrite	; msgbox % "TOGGLINHGNOW " Bypass_ClassList
	gosub,Parsebypassclass
	BypassClassListstr:=""
	BypassClassListArr:=[]
	gosub,Blacklist_ParseArr
	gosub,Blacklist_ParseArr
	return,Bypass_ClassList
}

; ~y::
; gosub,Parsebypassclass
; BypassClassListstr:="" 
; BypassClassListArr:=[]
; gosub,Blacklist_ParseArr
; return

RemoveHookz() {
  global 	HookM,HookMb,initt,HookCr
 (HookM?	dllcall("UnhookWinEvent","Ptr",HookM),	 HookM := 0)
 (HookM?	dllcall("GlobalFree","Ptr",HookM,"Ptr"), HookM := 0)
 (initt?	dllcall("UnhookWinEvent","Ptr",HookMb),	 HookMb:= 0)
 (initt?	dllcall("GlobalFree","Ptr",initt,"Ptr"), initt := 0)
 (HookCr?	dllcall("UnhookWinEvent","Ptr",HookCr),	 HookCr:= 0)
 (HookCr?	dllcall("GlobalFree","Ptr",HookCr,"Ptr"),HookCr:= 0)
}

x1t(ExitReason, ExitCode) {
	global
	menu,tray,noicon
	;gosub,BP_RegWrite
	return,(!instr("Logoff,Shutdown",ExitReason)?  TT("Script shutdown.`n" ExitReason "`n" ExitCode),RemoveHookz(),exitapp())
}

SetForegroundWindow(hWnd) { ;https://msdn.microsoft.com/en-us/library/windows/desktop/ms633539(v=vs.85).aspx
	return,DllCall("SetForegroundWindow","int",hWnd)
}

EndTask(hWnd,fShutDown,fForce) { ;add me 2
	return,DllCall("EndTask","int",hWnd,"int",fShutDown,"int",fForce)
}

kiSendRemapped1(byref keyvnotk) { ; quick un-mapper for some nonstandard inputs ;
	Switch,keyvnotk {
		case,"f21" : send,{XButton1}
		case,"f22" : send,{XButton2}
}	}

; )__________)_____INPUT-LOG_2_3y3__________________( ;
_2_3y3_Accs_init() { ; Peripheral input-feedbk-gUis ;
	global	Kb_vis_feedback,K3y2eye,K3y2eye2
	,	m0_vis_feedback,m2eye,	m2eye2
	if( m0_vis_feedback )	{
		run,%m2eye%,,,pid1
		menu,tray,check,m2eye
		winwait,ahk_pid %pid1%
		m2eye2:= WinExist()
	} else,(TT("skipping m23y3 initialization..."))
	if(Kb_vis_feedback)	{
		run,%K3y2eye%,,,pid2
		menu,tray,check,k12eye
		winwait,ahk_pid %pid2%
		K3y2eye2:= WinExist()
	} else,(TT("skipping k3y23y3 initialization..."))
} ;-= -= -= -=  - - - - --= -= -= -=  - - - - --= -= -= -=  - - - - --= -= -= -=  - - - - --= -=-;

ActivateWin(hWnd,delay) {
if(!hWnd) {
	send,!{tab}
	TT("Failed, rem")
} else {
	(!Delay? Delay:= -100)
	Act_handle_str:= ("ahk_id " . hWnd ), Act_DelayT:= Delay
	settimer,Act_Then,% Act_DelayT
	return,

	Act_Then:
	winActivate,% Act_handle_str
	WinWait,Act_handle_str,,2
	if(WinActive(Act_handle_str)) {
		Act_DelayT:= "", Act_handle_str:= ""
		return.1
	} else,if(SetForegroundWindow(hWnd))
		return,1
	return,0
}	} wingetClass,cl_s,
(cl_s? ((!instr("cabinetwclass,WorkerW",cl_s))? SendKiLongnanme(F1)))
return,

f1_bypassed_explorer:	;:	F1	:: ; remove help
IfWinnotActive, AHK_Group Desktop
	send,{%a_thishotkey%}
else {
	BT:= a_thishotkey
	Gosub,Bicycle
} return,

F1_F12_Toggle:
BypassFKeys:= !bypassFKeys
F1_F12_bypasscheck:
(BypassFKeys? Gosub("kBypass_f1_12_Enable")
: (KBpF112_Init? Gosub("kBypass_f1_12_Disable")))
return,

KBypass_f1_12_Enable:
return,

#y::
kbLED()
return,

kbLED(cmd="") {
	loop,2
		loop,parse,% "1,2,4,3,5,6,7",`,
 		{
			KeyboardLED(a_loopfield,(on:=!on)?"on":"off")
			sleep,250
}		}

Togl_numpad: ; numpad bypass
NumpadKeys_str:= ""
BypassNmpad:= !BypassNmpad
togl_numpad_i: ;if BypassNmpad { ;menu,tray,check,Disable Numpad ;if !InitNum_Ttrig {;InitNum_Ttrig:= True loop,10 {
aa:= (a_index - 1)
Loop,Parse,BList_NmPad, `,
{
 if  !NUM_PAD_c
 	  NUM_PAD_c:= ("Numpad" . aa)
 else {
	  NUM_PAD_c:= (NUM_PAD_c . ",Numpad" . aa)
	  hotkey,IfWinActive,% a_loopfield
 	  hotkey,Numpad%aa%,Bicycle,on
 } ; if numpadkeys_str ; numpadkeys_str:= (numpadkeys_str . "," . "Numpad" . aa) ;else,numpadkeys_str:= ("Numpad" . aa)
}
Loop,Parse,num_others, `,
{
	bb:= a_loopfield
	Loop,Parse,BList_NmPad, `,
	{
		hotkey,IfWinActive, %a_loopfield%
		hotkey,% bb,Bicycle,on ;numpadkeys_str:= (numpadkeys_str . "," . bb) ;key_NumP_ar.Push(bb)
	}
} ;}

KBypass_f1_12_Disable:
return,

; loop,12
	; hotkey,% ("F" . A_Index), off
; return,

;numpadsrs:= (NUM_PAD_c . "," . num_others)
;return,

arrow_Toggle:
KbypassArrow:= !KbypassArrow
KbypassArrow? Gosub("arrow_bypasscheck") : Gosub("arrow_reenable")
return,

arrow_bypasscheck:
if(KbypassArrow)
	Loop,Parse,arrowlist,`,
	{
		bm:= a_loopfield
		Loop,Parse,BList_Arr0w,`,
		{
			hotkey,IfWinActive,% a_loopfield
			hotkey,% bm,Bicycle
	}	} return,

arrow_reenable:
for,index,element in key_Arrow_ar ;TT(hotkey "`t " element " `t OFF")
	hotkey,% element,off
msgbox,% "testreenable"
return,

hotkeySendSelf:
send,{%a_thishotkey%} ;TT("%a_thishotkey%`n%hWnd%")
return,

KB_SendSelf:
(InStr(a_thishotkey,"$")? s3nd((Orig_Int:= strReplace(a_thishotkey,"$","")))
: s3nd(a_thishotkey))
return,

KB_SendSelf_no_Ctrl:
(InStr(a_thishotkey,"^")? s3nd(Orig_Int:= strReplace(a_thishotkey,"^", ""))
: s3nd(a_thishotkey))
return,

hotkeySendSelf(AHKBind) {
	if (instr(AHKBind,PassThru-LoopBk)) {
		AHKBind:= strReplace(AHKBind,("`" PassThru - "`" LoopBk))
		if(!errOrlevel) {
			(getKeyState(AHKBind,a_hkMeth:="P")? (a_hkPrest:= True)
			: (getKeyState(AHKBind,a_hkMeth:= "L")? (a_hkPrest:= True)
			: TT("hotkey error`nIssue detecting Logical or Physical")))
			while,getKeyState(AHKBind,a_hkMeth)	{
				(!getKeyState(AHKBind,a_hkMeth))? (a_hkPrest:= False, temp:= True):()
				(!a_hkPrest? (!temp? a_hkPrest:= True : msgb0x("issue with LOGIC, Professor.",1)))
				sleep,1
			} if(!a_hkPrest&&!temp)
				msgbox,% "issue"
			else {
				a_hkPrest:= False
				if(!getKeyState(AHKBind,a_hkMeth)) {
					SetKeyDelay,1000
					send,{%AHKBind%}
					SetKeyDelay,0
	}	}	}	}
	return,
}

gimpBypassNV:
send,^!{F13}
TT("tw@")
return,

NVsupress:
TT("Nvidia overlay supressed.")
return,

controlactive() {
	ControlGetFocus,CF,a
	if(CF)
		return,CF
}

lb_size_end:
TT("LB Resize`nup",2)
return,

DimensionChk:
(WII:=(W_Wins+X_net))<256?	WII:=256	: (WII>3000? WII:= 3000)
(HII:=(H_Wins+Y_net))<256?	HII:=256	: (HII>2000? HII:= 2000)
(x0x:=(X_Cur1-X_net)<-1000)? X0X:=-1000 : (X0X>3500? X0X:= 3500)
(y0y:=(Y_Cur1-Y_net)<-1000)? y0y:=-1000 : (y0y>2000? y0y:= 2000)
return,

Watch_Lb:
x_NET:= X_MSt4-X_Cur1, y_NET:= Y_MSt4-Y_Cur1
, x0x:= X_Cur1+x_NET, y0y:= Y_Cur1+y_NET
return,

corner_offset_get2: ;corner_offset_getii:;XOff:=(X_MSt4-X_Win_S), YOff:=(Y_MSt4-Y_Win_S)
XOff2:= X_Cur1-X_Win,	YOff2:= (Y_Cur1-Y_Win)
return,

keyNOfeedbk:
if(instr(a_thishotkey,"$" ))
	send,% (b_thishotkey:= strReplace(a_thishotkey,"$"))
else,TT("Error","-3000")
return,

kill_self:
gui,Optiona:Destroy
loop,Parse,CleanUpList,`,
{
	StringReplace,CleanUpList,CleanUpList,%a_loopfield%`,,,1
	if(a_loopfield !="")
		Winset,Trans,Off,ahk_id %a_loopfield%
} exitApp, ; was...(aboe)
;___----\;.,.,.,.,.,.,.,.,.,.,;return,

MenuTray: ; Menu,Tray,NoStandard ;
Menu,Tray,Icon
Menu,Tray,Icon,%	TrayIcOPth ;,,32
;Menu,Tray,Add,%	"ListlinesEX",%			"Listlines"
Menu,Tray,Add,%	"Handle Handler",%		"MenHAngLa"
Menu,Tray,Add,%	"Open Script Folder",%	"Open_ScriptDir"
Menu,Tray,Add,%	"Disable Numpad",%		"togl_numpad"
Menu,Tray,Add,%	"line num",%			"lines"
Menu,Tray,icon,% "line num",%			"C:\Icon\256\ICON323_1.ico"
Menu,Tray,% BypassNmpad? "Check" : "Uncheck",%	"Disable Numpad"
Menu,Tray,Standard
Menu,Tray,Add,m2eye,m2eye
Menu,Tray,Add,k12eye,k12eye
return,

m2eye:
k12eye:
run,% %A_thislabel%
return,

handle_handler:
TT("litk12eyek1k3")
return,

LBCtrlState:
while(getKeyState("Ctrl","P"))
	if(getKeyState("~LButton","P"))
		while(getKeyState("Ctrl","P")&&getKeyState("~LButton","P"))
			(!(getKeyState("~LButton","P")))? TT("StyleMenu_FixLaunch,-1") : ()
	else,SendKiLongnanme("LButton","Up"),SendKiLongnanme("Ctrl","Up")
		,TT("Log1c test:`nFailure, pr0fess0r.")
return,

lines:
lines:=!lines ;dv:= New DebugVarGui(dbg,{name: a_linenum, value: a_linenum, readonly: True})
if(lines)? timer("linestt",20) : timer("linestt","off")
return,

linesTT:
linenumber:=a_linenumber
;critical ;dbg.property_get("-n" DvArg(this.dbg, this.fullname))
;TT(dv "dVVV") ;FromXmlNodes("a_linenumber", dbg, args:="") { ;TT(a_linenumber)
return,

AHK_NOTIFYICON(wParam, lParam) { ; 0x201: ; WM_LButtonDOWN   ; 0x202:; WM_LButtonUP
	listlines,off
	Switch,lParam {
		case,0x0021: TT("h3LLo mASTER...")			;WM_MOUSEACTIVATE-0x0021
		;   return,% (ret:=refresh_uptime_(True))
		;	return,% Refresh_uptime_(True)
		case,0x203: Timer("ID_VIEW_VARIABLES",-1) 	;WM_LButtonDBLCLK-0x203
			, TT("Loading Var-Table...")
		case,0x0208 : msgb0x(A_ScriptName,"Reload?`n`n`n`tTimeout in 3 Secs" ;WM_MBUTTONUP
			,	4,262209,"","C:\Icon\128\kixtart2022.ico")
		if(ifmsgbox "Cancel"||ifmsgbox "no")
			return,
		;else,ifmsgbox,OK,Reload,
		else,Reload,
		("Reloading...`t in 1.",500) ;	settimer,ID_TRAY_RELOADSCRIPT,-1
		sleep,% EscCloseRate ;Timer("ID_TRAY_RELOADSCRIPT",-1)
		return,
		; case,0x205:  ;	;return,(trayActiv?MENSpunction())	WM_RBUTTONUP ; menuTrayUndermouse() experimental fail
	} ;exit,
} ;TRAY WM_;^^^^^;

menuTrayUndermouse() {
	global
	listlines,off
	MouseGetpos,x,y,hWnd
	wingetClass,Mclass,ahk_id %hWnd%
	if(Mclass="#32768") {
		TT("Mclass 32768")
		return,1
}	}

MENSpunction() {
	Menu,Tray,Show
	trayActiv:= False
}

ID_TRAY_EXIT:
ID_TRAY_PAUSE:
ID_TRAY_SUSPEND:
ID_VIEW_VARIABLES:
ID_TRAY_EDITSCRIPT:
ID_TRAY_RELOADSCRIPT:
PostMessage,0x0111,(%a_thislabel%),,,% A_ScriptName " - AutoHotkey"
return,
; END / TRAY MENU / END / TRAY MENU / END / TRAY MENU / END / TRAY | / END / TRAY |

MenHAngLa() { ;_p0n-d-dangl4hl_;
	global
	listlines,off

	static CMDelev:="C:\Script\AHK\CMD_Elev.ahk"
	Switch,"A_ThisMenuItem" {
		case,"Open Script Folder" 	:settimer,Open_ScriptDir,-10
		case,"Handle Handler"		:settimer,HHandler,-10
		case,		 "k12eye"		:run(K3y2eyE)
		case,		  "m2eye"		:run(M2eyE)
		default: if(islabel(A_ThisMenuItem)||isfunc(A_ThisMenuItem))
			settimer,% A_ThisMenuItem,-30
			else,if(%A_ThisMenuItem%!="")
				run,% a_Thismenuitem
	}
	return,
}

HKi_Handl4() {
	Switch,A_thishotkey {
			case,"^!CapsLock": send,{CapsLock}
			case, "CapsLock" 	: txtselreplace("invert")
			case,"^CapsLock" 	: txtselreplace("lower")
			case,"+capslock" 	: txtselreplace("upper")
			case,"^+CapsLock"	: txtselreplace("CapitaliseWithWords") ;XList; (Capitalise Target Wordlist)
			case,"^;"			: txtselreplace("commentline")
			case,"+1" 			: if(!txtselreplace("not"))
					sendinput,% a_thishotkey
			case,"+2"			: if(!txtselreplace("quote"))
					sendinput,% a_thishotkey
			case,"+9","+0"		: if(!txtselreplace("enclose_brackets"))
					sendinput,% a_thishotkey
			case,"+5"			: if(!txtselreplace("Enclose_Percents"))
					sendinput,% a_thishotkey
			case,"+[","+]"		: if(!txtselreplace("Enclose_braces"))
					sendinput,% a_thishotkey
			case,"[","]"		: if(!txtselreplace("Enclose_square_brackets"))
					sendinput,% a_thishotkey
			case,"Space"		: if(!txtselreplace("Enclose_Spaces"))
					send,{%a_thishotkey%}
}	}

Desktop_Margins: ; Testing Delete me ;
TT("Left: " Desktop_MarginLeft "`nRight: " Desktop_MarginRight "`nTop: " Desktop_MarginTop "`nBottom: " Desktop_MarginBottom)
return,

ScintillaNP(WM="",wParam="",lParam=0){
	Ssleep(50)
	winget,ll,list,ahk_class Notepad++
	loop,% ll {
		ControlGet,ctrlHand,hWnd,,Scintilla1,% "ahk_id " ll%A_Index%
		winget,PN,processname,ahk_id %ctrlHand%
		switch,PN {
			case,"notepad++.exe" : NPphWnd:= ctrlHand
				continue,
	}	}
	if(!(isint(wParam)))
		StringTrimRight,linen,wParam,3
	else,linen:= wParam ;0x
	linen--
	Sendmessage,% wm,% linen,% lparam,,ahk_id %ctrlHand%
}

PHRun: ;Launch Process Hacker; (Ctrl-ALT-ENTER) ;
run,% Path_PH
TT("Launching Process Hacker.`n`t One moment...")
return,

WM_LButtonDBLCLK(wParam,lParam) {
	global
	return,
}

WM_NCLButtonDOWN(wParam,lParam) {
	global
	click,
}

WM_NCLButtonUP(wParam,lParam) {
	click,up
	return,
}

WM_LButtonUP(wParam,lParam) {
	click,up
	return,
}

Class CloseExe {
	Static EscCloseAskWL_ExeArr	:= ["regedit","notepad.exe"]
	, EscCloseNoAskWL_ExeArr 	:= ["vlc","fontview","RzSynapse","ApplicationFrameHost","Professional_CPL","7zFM.exe"]
	, EsCNoCloseWL_ExeArr 		:= ["Calculator"]
	_NewEnum() {
		return,New CEnumerator(this.CloseExeArr)
}	}
Class CloseWTTL { ; not working
	Static EscCloseAskWL_WTtlArr:=["C:\Script\AHK\WM_FIND-SIFT.ahk - AutoHotkey v1.1.33.10"]
	, EscCloseNoAskWL_WTtlArr 	:=["MYaRsE","fontview","RzSynapse","ApplicationFrameHost","Professional_CPL","7zFM.exe"]
	, EsCNoCloseWL_WTtlArr 		:=["Calculator"]
	_NewEnum() {
		return,New CEnumerator(this.CloseExeArr)
}	}
Class PName {
	static PNameArr:=["firefox.exe","chrome.exe","explorer.exe"]
	_NewEnum() {
		return,New CEnumerator(this.PNameArr)
}	}
Class SwipeBypassCName {
	static SwipeBypassCNameArr:=["ahk_Class WorkerW","ahk_Class Progman","ahk_Class CabinetWClass","ahk_Class Shell_TrayWnd","ahk_Class #32770"]
	_NewEnum() {
		return,New CEnumerator(this.SwipeBypassCNameArr)
}	}
Class TName {
	static TNameArr:=["Replace","Infromation","explorer.exe","sidebar.exe","StartMenuExperienceHost.exe"]
	_NewEnum() {
		return,New CEnumerator(this.TNameArr)
}	}
Class CEnumerator {
	__New(Object) {
		this.Object:= Object
		this.first := True
		this.ObjMaxIndex:= Object.MaxIndex()
	}
	Next(ByRef key,ByRef value) {
		if(this.first) {
			this.Remove("first")
			key:= 1
		} else,key++
		(key <=	this.ObjMaxIndex)? value:=this.Object[key] : key:=""
		return,key !=""
}	}

;^`'`'<
;^^^^^^`'`'<
; 	-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~	vARz	-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~
vARz: ;gl0b@l:
global XList:= "AHK,autohotkey,var,obj,replace,get,append,invert,byte,hex,replace,regex,format,exit,string,target,StrLen"
FormatTime,A_Time_scriptstart,% a_ScriptStartTime,% "H:m - d\M"
global fpstest,M2dTimeoutThreshMS,Act_DelayT,w10_LocaleGui_Allowed,email,Explorer,Desktop,TrayIcOPth,BList_NmPad,BList_F1_12,WList_F1_12,BList_Arr0w,WList_Arr0w,BList_num0_9,EscCloseActWL_Exe,EscCloseAskWL_Exe,WM_LB_down,WMReSz_N_W,WMReSz_S_E,turds,aa,bb,bbbb,cc,tyt,fkk,rbt_,LB_cWnd2,handle,handl2,handl3,dhand,LB_cWnd,lb_CLass,hWnd_A,proCN,EscCloseRate,InitNum_Ttrig,Trigger_bypassed,TTn,tt,LB_hWnd,RateUndoRedo,Bypass_Cls_True,num_others,trigg3r3d,ok2esc,escaped,shif,HK_PH1,HK_PH2,passThru,LoopBk,ExplorerCNts,ExplorerClss,YTScript,M2DRAG,WMPMATT,EventScript,Path_Mag,Path_PH,Clix,bi,x_hWnd,DbgTT,TargetScript,Act_handle_str,quote_MAX_INDEX,fkeys_str0,quotes,qstr,XOff,YOff,X_Cur1,X_Win,Y_Win,W_Win,H_Win,wii,hii,XCent,BypassNmpad,M2dLB_ResiZe,KbypassArrow,bypassFKeys,CtlUpArrow,TTn,HK_PH1,C_Ahk,qq,qt,key_Func_ar,key_Del_ar,key_NumP_ar,key_Arrow_ar,d8CNtxt_Reg,d8CNtxt_RegFixValue,Desktop_Margin,BList_NmPad,arrowlist,bt,KBpF112_Init,bm,dki,BlacklistClassCount,numpadsrs,lastcopied,lastpasted_T_old,lastpasted_T,lastpasted_H_old,lastpasted_H,Mag_lnk,clicked,ResizeTrig_hWnd,AHKDir,a_ScriptStartTime,TickSS,TripleBeemed,m_hund,c,ahk_,unblurlist:=""
; 				-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~	vARz	-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~
global Path_WinEvent,CntxtClssFFx,DragbypassClass_new_possible,Bypass_ProcList,BlacklistProcCount,BlacklistClassCount,BlacklistTitleCount,PiD,ControlhWnd,Cursor_int,CursorChange,m2d_OriginalWidth,m2d_OriginalHeight,ccc,ddd,XYThresH,X,Y,ToolX,ToolY,TTX,TTY,X_Old,Y_Old,m2d_MidX,m2d_MidY,H_Win,W_Win,y_NET,y_NETold,x_NET,x_NETold,hWnd,hotkey,TTitle,p_count,TClass,TProCName,Bypass_TitleList,Bypass_ClassList,CopyOF_,Status_M2Drag,LB_D,RB_D,rbd,M1_Trigger,MD_Meth,Bypass_PN_True,Bypass_Cls_True,RBhWnd,BypassProcListStr,HII,_HH_,_WW_,WII,Ynet,Xnet,X_Win_S,Y_Win_S,H_WinS,W_WinS,X_Cur,Y_Cur,Y_Cur1,X_MSt4,Y_MSt4,rbCNthWnd,LBDD,b,admhk,MD_Bind,MD_DefaultDragAll,BypassClassListStr,q,g,Bypass_title_True,iD_,dbgTT,curhilite_enabled,infoTip_isactive,infoTip_iscopied,tk12eye,d_trig,igtrig,ConTxT_iCount,UProc,mwheeldrag,ScrollDelayT_m2,pasted,LBTrigga,TargetdY,TargetdH,x_s,y_s,lastlclickedtime			;^^^^^^`'`'<
global ResizeTrig,InitMag,Trig3rd_,TriggerNotUsed,MDrag_WH,mouselockdrag,Ctrl__init,stylementrig,SnapdV,M2dStickySnap,LBTrigrx,WM_LB_up,PathAHKExE,WtL_AniTarget_,PathAniTarget,xylock,Aggy,ys,xs,ElButtoon,initPosY,1st_Btrigger,coefficient_menuh,Ctrlvpastemsg,bd_i,bd_j,K3y2eye,m0_vis_feedback,Kb_vis_feedback,m2eye,x0x,y0y,ShiftPriorKi,magwin,infoTip_timeout,LMBInterrupt,hw,Test_A,Trig_Logic2,Snap_Y_Lockd,MagWMDelay_,SexyTree,TreeLast,TreeSPree,TrigCorner,XCorner,YCorner,key_trans_inc,key_trans_reset,key_trans_dec,key_OCR_init,key_aero,key_trans_colour,EventWMhandla,systray_RB,ahkmenu,MouseSensOrig,MouseSensOrigOLD,MouseSensO,cornerclicked,OPTM2D_Activ8,hWinEventwnd, fuckinggay
global ID_VIEW_VARIABLES:=65407, ID_TRAY_EDITSCRIPT:=65304, ID_TRAY_SUSPEND:=65305,ID_TRAY_PAUSE:=65306, ID_TRAY_EXIT:=65307, ID_TRAY_RELOADSCRIPT:=65303, WM_LB_up:= 0x00A2,WM_LB_down:= 0x00A1, Mag:= 0,XX:= 0,YY:= 0,m1resize:= 1, coefficient_menuh:= 66, optM2dAutoActiv8:= dbgTT:= Explorer_MMB_OpenInNEW:= True,iD_:= "ahk_id "
, AlphaIncrement:= 0.01, xboxbigx:= "VK07", blurlist, VScrollDelayT_m1:= 20, VScrollDelayT_m2:= 10,me_email ; controls vscrol sensi. (pick something between 20 - 100
, admhk:= "adminhotkeys.ahk" . (C_Ahk:= " ahk_Class Autohotkey"), Path_WinEvent:= "WinEvent.ahk ahk_Class AutoHotkey"

, MD_Bind:= "rButton", MD_DefaultDragAll:= "m2drag"
, Path_YT_dL	:= "c:\program files\AutoHotkey\AutoHotkeyU64_UIA.exe C:\Script\AHK\Working\YT.ahk"
, Path_Anitray	:= "c:\program files\AutoHotkey\AutoHotkeyU64_UIA.exe C:\Script\AHK\anitray.ahk"
, Path_Mag		:= "C:\Program Files\Autohotkey13311\AutoHotkeyU64_UIA.exe C:\Script\AHK\Working\M2DRAG_MAG.AHK"
, PathAniTarget	:= """C:\Script\AHK\stixman_runnin\Animate_Target.ahk""" ; See second-half of script
, PathAHKExE	:= quote("C:\Program Files\Autohotkey\AutoHotkey.exe")
, K3y2eye:="C:\Script\AHK\KeyHistory_input-log-uiSCI.ahk", m2eye:="C:\Script\AHK\Mouse_input-log-ui.ahk"
, Mag_lnk="C:\Script\AHK\Working\mag.lnk", WtL_AniTarget_:= "animate_target.ahk ahk_Class AutoHotkey"
, CntxtClss_main	:= "AHK_Class #32768",	CntxtClssFFx:= "AHK_Class MozillaDropShadowWindowClass"
, wTtL_YT_dL	:= ("C:\Script\AHK\Working\YT.ahk - AutoHotkey v1.1.33.10")
, BypassClassListDfault:= "WorkerW,gdkWindowToplevel,"
, BypassTitleListArr:= [], BypassClassListArr:= [], BypassProcListArr := [], MWheelDrag:= []
, Pasted:= [{}], G:= " , ", TTn:= 1
q ="
z="
b = " . %q% . "
	dllcall("SystemParametersInfo","UInt",0x70,"UInt",0,"UIntP",MouseSensO,"UInt",0)

iniRead,email,ad.ini,e,e,test@i.cycles.co
RegBase:= "HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag"
regRead,Bypass_ClassList,% RegBase ,Blacklist_ClassList
gosub,Parsebypassclass

Menu,Tray,Icon,% TrayIcOPth

Sysget,XCent,78
Sysget,YCent,79
XCent:=	(floor(0.5*XCent)), YCent:= (floor(0.5*YCent))
Sysget,Desktop_Margin,MonitorWorkArea
w10_LocaleGui_Allowed:= False
 d8CNtxt_Reg:= "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\z99 File Admin\shell\copyPaste_mod_date"  ; long path
 d8CNtxt_RegFixValue:= "Copy Date-Modified" ;Reset the context menu entry txt to "Copy Date.." (System was shutdown after FileDate was Copied.)
regWrite,REG_SZ,% d8CNtxt_Reg,muiverb,% d8CNtxt_RegFixValue ;Rebuke the abomination!...gogo,Glowball
num_others:= "NumLock,NumpadDiv,NumpadMult,NumpadAdd,NumpadSub,NumpadEnter,NumpadPgDn,NumpadPgUp,NumpadEnd,NumpadHome,NumpadClear,NumpadDel,NumpadDot,NumpadIns,NumpadUp,NumpadLeft,NumpadRight,NumpadDown"
arrowlist:= "Left,Right,Up,Down"
HK_PH1	:= 	"^!Enter", HK_PH2:= ("+" . HK_PH1), shif:= "+", passThru:= "~", LoopBk:= "$"
C_Ahk	:=	"ahk_Class AutoHotkey"
YTScript:=	("YT.ahk " . C_Ahk)	;(C_Ahk . " YT.ahk")
M2DRAG	:=	("M2Drag.ahk " . C_Ahk) ;(C_Ahk . " M2Drag.ahk")
WMPMATT	:=	("wmp_Matt.ahk " . C_Ahk) ;(C_Ahk . " wmp_Matt.ahk")
magwin	:=	("M2DRAG_MAG.AHK " . C_Ahk) ;(C_Ahk . " M2DRAG_MAG.AHK")
Path_PH	:=	"C:\Apps\Ph\processhacker\x64\ProcessHacker.exe"
ExplorerCNts:= 	"DirectUIhWnd3,SysListView321,DirectUIhWnd"
EventScript	:=	"WinEvent.ahk ahk_Class AutoHotkey"
Path_Mag	:=	"C:\Script\AHK\Working\mag.lnk"
ExplorerClss:= 	"CabinetWClass,WorkerW,Progman"
key_Arrow_ar[1]:=	"Left",	key_Arrow_ar[2]:= "Right"
key_Arrow_ar[3]:=	"Up",	key_Arrow_ar[4]:= "Down"
WmReSz_N_w:= 13,			WmReSz_S_e:= 17
WmReSz_S_e:= 17,			WmReSz_N_w:= 13
WmReSz_N_e:= 14,			WmReSz_S_w:= 16
return,

Parsebypassclass:
BypassClassListArr:=[] 
loop,Parse,Bypass_ClassList,`,
{
 BypassClassListArr[A_Index]:= a_loopfield
 (!BypassClassListStr? BypassClassListStr:= ( q . a_loopfield . q)
: (BypassClassListStr:= (BypassClassListStr . "," . q . a_loopfield . q)))
	BlacklistClassCount:= A_Index
} return,

iNiT_SeQ_init:
loop,Parse,_iNiT_SeQ,>
	Gosub,% a_loopfield
#include <AERO_LIB> ; Aero_lib()
#include <GDi+_All>
#include <LayeredWindow>
#include <Circle>
#include <Spinner>
#include <RemoteTreeView>
#include C:\Script\AHK\- _ _ LiB\_Const\tvn.ahk
#include C:\Script\AHK\- _ _ LiB\_Const\Const_Process.ahk
#include <editlex>

Aero_StartUp() 

 WM_Allow()
 
_2_3y3_Accs_init()

TT_0ff:
tooltip,
return,

Open_ScriptDir()	; NOT-CALLED :

rP_ID_Gui(gui_name="") { ; Attain Identity of this script ;
	(gui_name=""? gui_name:= a_ScriptName)
	global WtL:=  gui_name . " ahk_Class AutoHotkeyGUI"
	gui,higGireR: New,,XLab
	gui,higGireR: Show,Hide w10 h10
	return,DllCall("GetCurrentProcessId")
}

;_'-=-_'-=-_'-=GDIP-=-_'-=-'-=-_'-=-_'GDIP=-_'-=-_'-=-_
;'-=-_GDIP-=-_'-=-'-=-_'GDIP=-_'-=-_'-=-_'-='-=-_'-=_GDIP=-_'-=-_
;_'-=-_'-=-_'-=GDIP-=-_'-=-'-=-_'-=-_'GDIP=-_'-=-_'-=-_
Gdip_Start() {
	If Not dllcall("GetModuleHandle","str","gdiplus")
		dllcall("LoadLibrary","str","gdiplus")
	VarSetCapacity(si,16,0),si:= Chr(1)
	dllcall("gdiplus\GdiplusStartup","UintP",pToken,"Uint",&si,"Uint",0)
	return,pToken
}

Gdi_DIBcreate(hDC,nW,nH,bpp=32,ByRef pBits="") {
	NumPut(VarSetCapacity(bi,40,0),bi)
	NumPut(nW,bi,4), NumPut(nH,bi,8)
	NumPut(bpp,NumPut(1,bi,12,"UShort"),0,"Ushort")
	return,dllcall("gdi32\CreateDIBSection","Uint",hDC,"Uint",&bi,"Uint"
	,DIB_RGB_COLORS:= 0,"UintP",pBits,"Uint",0,"Uint",0)
}

Gdi_makeDC(hD:=0) {
	return,dllcall("gdi32\CreateCompatibleDC","Uint",hDC)
}

Gdi_SelObject(hDC,hGdiObj) {
	return,dllcall("gdi32\SelectObject","Uint",hDC,"Uint",hGdiObj)
}

Gdi_DelDC(hDC) {
	return,dllcall("gdi32\DeleteDC","Uint",hDC)
}

Gdi_DelObj(hGdiObj) {
	return,dllcall("gdi32\DeleteObject","Uint",hGdiObj)
}

Gdi_ShutSesh(pToken) {
	dllcall("gdiplus\GdiplusShutdown","Uint",pToken)
	((hModule:= dllcall("GetModuleHandle","str","gdiplus"))? dllcall("FreeLibrary","Uint",hModule))
	return,0
}

;END/_'-=-_'-=-_'-=GDIP-=-_'-=-'-=-_'-=-_'GDIP=-_'-=-_'-=-_END/
;END/_'-=GDIP-=-_'-=-'-='-=-_'GDIP==-_'-=-'-='-=-_'GDIP=-_'-=-_'-=-_END/
;-=-=-=-;=======================================;-=-=-=-=-=-
;-=-=-=-;				  f1n  					;-=-=-=-=-=-
;-=-=-=-;=======================================;-=-=-=-=-=-