﻿#noEnv ; play animation of sequentially named series of ico files 
#persistent
#SingleInstance,% "force"
sendMode,%        "Input"
SETWINDELAY,      -1
SETBATCHLINES,    -1
setWorkingDir,%    a_scriptDir
menu, tray, nostandard
menu, tray, add,% "Exit", xit
gui 1:new, +hwndhn
Gui, 1:Add, Button, Default w80, OK
gui_titlebar_disable("1")
gui, 1:show

global frames, fps_desired, fps_sleep, Playing, filePath, OutFileName, OutDir,
fps_desired := 12, fps_sleep := ( 1000 / fps_desired )
if (framecount()) {
	Playing := True
	menu, tray, check,% "animation (toggle)"

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
	menu, tray, icon,% filePath

SplitPath, filePath, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
global OutNameNoExt1 := Trim(OutNameNoExt, OmitChars = "1")
msgbox % OutNameNoExt1
return,

framecount() {
	global
	loop {
		;if !( exist := fileexist((a_scriptDir . "\" . a_index . ".ico")) )
		if !( exist := fileexist((OutDir . "\" . OutNameNoExt1 . a_index . ".ico")) )
			return, ( frames := a_index -1 )
		else {
			varprefix%a_index% := (a_scriptDir . "\" . a_index . ".ico")
			VarSetCapacity(varprefix_i%a_index%, fisize := A_PtrSize + 688)
			if DllCall("shell32\SHGetFileInfoW", "WStr", varprefix%a_index%, "UInt", 0, "Ptr", &varprefix_i%a_index%, "UInt", fisize, "UInt", 0x100)
			varprefix_h%a_index% := NumGet(varprefix_i%a_index%, 0, "Ptr") 
}	}	}

Icon_animation_loop_init:
if !frames
	return,
menu, tray, add,% "animation (toggle)", toggle_anim
loop {
	if	(current < frames)
		 current += 1
	else,current := 1

	SendMessage 0x80, 0, varprefix_h%current%,, ahk_id %hn%  ; WM_SETICON, ICON_SMALL
	SendMessage 0x80, 1, varprefix_h%current%,, ahk_id %hn%  ; WM_SETICON, ICON_LARGE
	menu,	tray,	icon,% ("HICON:*" . varprefix_h%current%)
	sleep,% fps_sleep
	if !playing
		break
}
return,

toggle_anim:
	Playing := !Playing
if Playing {
		timer("Icon_animation_loop_init",-200)
		menu,tray,check,% "animation (toggle)"
} else,	menu,tray,uncheck,% "animation (toggle)"
return,

xit:
exitapp