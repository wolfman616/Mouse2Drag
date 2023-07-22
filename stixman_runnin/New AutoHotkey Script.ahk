#noEnv
#persistent
#SingleInstance,%      "Force"
DetectHiddenWindows,%  "On"
DetectHiddenText,%     "On"
SetTitleMatchMode,%   "Slow" 
setWorkingDir,% 		a_scriptDir

#INCLUDE C:\Script\AHK\- LiB\Trayicon.ahk ;#INCLUDE C:\Script\AHK\- LiB\TrayIcon_GetInfo.ahk


global frames, fps_desired, fps_sleep, Playing, iconinfoARR, HN, NID, max_index, fileinfo, fileinfo2, fileinfo3, steam_iconhandle, EventScript, hnd, hh, uu

fps_desired := 12, fps_sleep :=( round( 1000 / fps_desired )), iconinfoARR := []
C_Ahk	    :=	"ahk_class AutoHotkey"
EventScript :=	("WinEvent.ahk " . C_Ahk)

;hnd:=winexist("wmp_Matt.ahk")  

;gosub steamicon_make_hicon
steam_iconhandle:=ICO2hicon("C:\Icon\24\stemen.ico")
;ICO2hicon("C:\Icon\24\stemen.ico")

;hnd:=winexist("AHK_EXE MSIAfterburner.exe")  

if (framecount()) {
	Playing := True ;	menu, tray, check,% "animation (toggle)"
	settimer, Icon_animation_loop_init, -200
} else {					; nO sequence of icons found (1.ico, 2.ico, 3.ico)
	if 		   0 != 1 	    ; Not run with parameter
		filePath := "D:\Documents\My Pictures\6pkB.ico" ; specify the file path to first icon
	else if     0 = 1	    ; run with parameter from menus
		filePath  = %1% 
	if !(fileexist( filePath ) ) {
		msgbox,,%   "Error",% "Cant find `n" filePath
		FileSelectFile, filePath ,,% "D:\Documents\My Pictures\",% "select",% "iCO Files (*.ICO)"
}	}

iconinfoARR := ( ad := TrayIcon_GetInfo() ) ; get all tray items !iconinfoARR := TrayIcon_GetInfo("MSIAfterburner.exe")

 ;msgbox % "uid " iconinfoARR[1].uid "`nhwnd " iconinfoARR[1].hwnd "`nidcmd "  iconinfoARR[1].idcmd "`npid " iconinfoARR[1].pid "`nidx " iconinfoARR[1].idx "`nhicon " iconinfoARR[1].hicon "`nlocation " iconinfoARR[1].tray "`npname " iconinfoARR[1].process "`nclss "  iconinfoARR[1].class  ; 
 
gosub, tray_count
loop %max_index% { 
	; tt:= tt . " " . ( ringpiece := iconinfoARR[a_index].process)
	ringpiece := iconinfoARR[a_index].process
	switch ringpiece {

		case "steam.exe": ; regular icon replacement
			hh := iconinfoARR[a_index].hwnd
			uu := iconinfoARR[a_index].uid
			TrayIcon_Set( hh, uu, steam_iconhandle, 0, 0)
		;case "Wacom_TabletUser.exe":
		case "Power.exe","wallpaper32.exe": ; animated icon frames replacement
			hh := iconinfoARR[a_index].hwnd
			uu := iconinfoARR[a_index].uid
			
			TrayIcon_Set( hh, uu, steam_iconhandle, 0, 0)
			loc:= iconinfoARR[a_index].tray
		;	if !(loc = "Shell_TrayWnd") { 
		;		tt("Located in Tray: "   target_orig:=a_index " (Overflow)", 1000) ;	TrayIcon_Move(2,4)
				;msgbox % (ringp := iconinfoARR[a_index].idx  ) "`n"  (ring := iconinfoARR[a_index].uid  ) 
			;} 
			;hnd := iconinfoARR[a_index].hwnd
			;sleep 100
}	}  
; Gui,    +LastFound 
; hGui  := WinExist() ; dummy hwnd
; Tray_Add( hGui, "OnDummyTrayIcon", "shell32.dll:3", "My Tray Icon")
#INCLUDE C:\Script\AHK\- LiB\TT.ahk
#INCLUDE C:\Script\AHK\- LiB\SendWM_CoPYData.ahk
return,

;	OnDummyTrayIcon(Hwnd, Event){
;	  	if (Event != "R")		;return if event is not right click
;			return
;;		MsgBox Right Button clicked
;	return 
; PostMessage, nMsg, 2, 0x204, , ahk_id %HN%
;hicon:=		 LoadPicture("1.ico",,1)

VarSetCapacity(fileinfo2, fisize := A_PtrSize + 688)
if ass:=DllCall("shell32\SHGetFileInfoA", "Str", (a_scriptDir . "\2.ico")
, "UInt", 0, "Ptr", &fileinfo2, "UInt", fisize, "UInt", 0x100)
; hicon2 := NumGet(fileinfo2, 0, "Ptr")
; hicon  := LoadPicture("1.ico",,1)
 VarSetCapacity(NID, szNID := ((A_IsUnicode ? 2 : 1) * 384 + A_PtrSize*5 + 40),0)
    NumPut( szNID, NID, 0                           )
    NumPut( hn,  NID, (A_PtrSize == 4) ? 4   : 8  )
    NumPut( 1028,   NID, (A_PtrSize == 4) ? 8   : 16 )
    NumPut( 2,     NID, (A_PtrSize == 4) ? 12  : 20 )
    NumPut( "shell32.dll:3", NID, (A_PtrSize == 4) ? 20  : 32 )
    ; NIM_MODIFY := 0x1
    DllCall("Shell32.dll\Shell_NotifyIconA", "UInt",0x1, "Ptr",&NID)
return,

framecount() {
	global
	loop {
		if !( exist := fileexist((a_scriptDir . "\" . a_index . ".ico")) )
			return, ( frames := a_index -1 )
		else {
			varprefix%a_index% := (a_scriptDir . "\" . a_index . ".ico")
			VarSetCapacity(varprefix_i%a_index%, fisize := A_PtrSize + 688)
			if DllCall("shell32\SHGetFileInfoW", "WStr", varprefix%a_index%, "UInt", 0, "Ptr", &varprefix_i%a_index%, "UInt", fisize, "UInt", 0x100)
			varprefix_h%a_index% := NumGet(varprefix_i%a_index%, 0, "Ptr") 
}	}	}
 
Icon_animation_loop_init:

frame_delays:="85,85,85,85,85,85"

if !frames
	return,
settimer, dloop, 0
return,

dloop:
	loop, parse, frame_delays, `,
	{
		if     (current < frames)
				current += 1
		else,   current := 1
		TrayIcon_Set(hh, uu,varprefix_h%current%,0, 0)
		;menu,   tray, icon,% ("HICON:*" . varprefix_h%current%)
		sleep,% a_loopfield
		if !playing
			break,
	}
return,

toggle_anim:
	Playing := !Playing
if Playing {
        settimer, Icon_animation_loop_init, -200
	    menu, tray, check,%   "animation (toggle)"
} else,	menu, tray, uncheck,% "animation (toggle)"
return,
 
tray_count:
loop 
	if ldoc:= iconinfoARR[ a_index ].tray
		max_index = %a_index%
	else, break
return,

ICO2hIcon(IconPath) {
	VarSetCapacity(fileinfo, (fisize := A_PtrSize + 688))
	if DllCall("shell32\SHGetFileInfoW", "WStr", IconPath, "UInt", 0, "Ptr", &fileinfo, "UInt", (fisize := A_PtrSize + 688), "UInt", 0x100)
	{
		rez := NumGet(fileinfo, 0, "Ptr") 
		return, rez
}	}

xit: 
exitapp

~#^rbutton::
mousegetpos, mx, my, hw, cn
wingetclass, cl,% "ahk_id " hw
if (cl = "Shell_TrayWnd" || cl = "NotifyIconOverflowWindow") {
	if (target_pos:=(TrayIcon_GetHotItem())) {
		gosub, tray_count
		;loop %max_index% { 
			; tt:= tt . " " . ( ringpiece := iconinfoARR[a_index].process)
			; tt(ringpiece := iconinfoARR[a_index].idx)
			; if (ringpiece = target_pos)
			; tt((iconinfoARR[a_index].process) a_index) 
			; tt(stt:=iconinfoARR[target_pos+1].process)
			; stt := ("Tray_" . (AN:= iconinfoARR[target_pos+1].process))
			stt := "TrayiconMenu" 
			;tt(stt)
			TT(res:=SendWM_CoPYData(stt, EventScript))
}	}
else tt("error")
return,

^Left::
hot:= TrayIcon_GetHotItem()
TrayIcon_Move(hot, hot-1)
tooltip % TrayIcon_GetInfo(hot-1)
return
^right::
hot:= TrayIcon_GetHotItem()
TrayIcon_Move(hot, hot+1)
tooltip % TrayIcon_GetInfo(hot+1)
return
^up::
tooltip, % "sfdf " . (iconinfoARRs := TrayIcon_Button("AutoHotkey.exe", sButton := "R", bDouble := true, index := 1))
as := NumGet(fileinfo, 0, "Ptr")
; settimer, Icon_animation_loop_init, -200msgbox % TrayIcon_Set(hnd, 1028,hic, 0, 0), 0,0)
settimer, Icon_animation_loop_init, -200
return,

#f::
menu, tray, icon,% "HICON:*shell32.dll:5"
return,
#g::
menu, tray, icon,% "HICON:*shell32.dll:6"
return,
#h::
return,

NIF_ICON=2, NIF_MESSAGE=1, NIF_TIP=4, MM_SHELLICON := 0x500
uid=100
;Tray_Modify(hn,"", x,"") 
	VarSetCapacity( NID, 88, 0) 
	 ,NumPut(88,	NID)
	 ,NumPut(HN,	NID, 4)
	 ,NumPut(++uid,	NID, 8)
	 ,NumPut(2, NID, 12)
	 ,NumPut((hFlags := NIF_ICON | NIF_TIP | NIF_MESSAGE), NID, 16)
	 ,NumPut(X, NID, 20)
	 ,DllCall("lstrcpyn", "uint", &NID+24, "str", Tooltip, "int", 64)
	 	DllCall("shell32.dll\Shell_NotifyIconW", "uint", 0, "uint", &NID)
return,

Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle) {
	VarSetCapacity(CopyDataStruct, 3*A_PtrSize, 0) 
	SizeInBytes := (StrLen(StringToSend) + 1) * (A_IsUnicode ? 2 : 1)
	NumPut(SizeInBytes, CopyDataStruct, A_PtrSize) 
	NumPut(&StringToSend, CopyDataStruct, 2*A_PtrSize)
	Prev_DetectHiddenWindows := A_DetectHiddenWindows
	Prev_TitleMatchMode := A_TitleMatchMode
	DetectHiddenWindows On
	SetTitleMatchMode 2
	TimeOutTime := 2700
	SendMessage, 0x4a, 0, &CopyDataStruct,,% TargetScriptTitle,,,,% TimeOutTime
	DetectHiddenWindows %Prev_DetectHiddenWindows%
	SetTitleMatchMode %Prev_TitleMatchMode%
	return, ErrorLevel
}

Open_ScriptDir:
toolTip %a_scriptFullPath%
z=explorer.exe /select,%a_scriptFullPath%
run %comspec% /C %z%,, hide
sleep 1250

ToolOff:
toolTip,
return
