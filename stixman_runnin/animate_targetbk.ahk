#noEnv ; play animation of sequentially named series of ico files 
#persistent
#SingleInstance,% "force"
sendMode,%        "Input"
SETWINDELAY,      -1
SETBATCHLINES,    -1
setWorkingDir,%    a_scriptDir
;menu, tray, nostandard
menu, tray, add,% "animation (toggle)", toggle_anim
menu, tray, add,% "Exit", xit

global frames, fps_desired, fps_sleep, Playing, filePath, OutFileName, OutDir, hund, uid, current

	; nO sequence of icons found (1.ico, 2.ico, 3.ico)
	if 		   0 != 1 	    ; Not run with parameter
		filePath := "D:\Documents\My Pictures\6pkB.ico" ; specify the file path to first icon
	else if     0 = 1	    ; run with parameter from menus
	{
	loop, parse, 1,% ";",
	{
		if (a_index = "1")
			filePath  := a_loopfield
		else if (a_index = "2")
			hund  := a_loopfield
		else if (a_index = "3")
			uid  := a_loopfield
	}
	if !(fileexist( filePath ) ) {
		msgbox,,%   "Error",% "Cant find `n" filePath
		FileSelectFile, filePath ,,% "D:\Documents\My Pictures\",% "select",% "iCO Files (*.ICO)"
}	}

SplitPath, filePath,, OutDir, OutExtension, OutNameNoExt

ONNE1 :=  strreplace(OutNameNoExt, "1")

global (%ONNE1%hund)        := hund
global (%ONNE1%uid)         := uid
global (%ONNE1%frame_index) := []
global (%ONNE1%hbitmaps)    := []
global (%ONNE1%frames)

IniRead, fps_desired,% (OutDir . "\" . ONNE1 . ".ini"), animationinfo, fpsdesired, 8
IniRead, frameindex,%  (OutDir . "\" . ONNE1 . ".ini"), animationinfo, frames

if fps_desired {
	(%ONNE1%fps_desired) := fps_desired
	  fps_sleep := ( 1000 / fps_desired )
} 

if frameindex {
	loop, parse, frameindex, `,
	{
		(%ONNE1%frame_index)[a_index] := a_loopfield
		(%ONNE1%frames) := A_index ; count total
	}	
	
	loop,% (%ONNE1%frames)
	{
		varprefix%a_index% := (OutDir . "\" . ONNE1 . a_index . ".ico")
		VarSetCapacity(varprefix_i%a_index%, fisize := A_PtrSize + 688)
		if 	DllCall("shell32\SHGetFileInfoW", "WStr", varprefix%a_index%, "UInt", 0, "Ptr", &varprefix_i%a_index%, "UInt", fisize, "UInt", 0x100)
		{
			varprefix_h%a_index% := NumGet(varprefix_i%a_index%, 0, "Ptr") 
			(%ONNE1%hbitmaps)[a_index]:= varprefix_h%a_index%
		}
	}
} else if (framecount()) {
		menu, tray, check,% "animation (toggle)" 
		settimer, Icon_animation_loop_init, -200
} 

Icon_animation_loop_init:
Playing := True

if (!frames && !(%ONNE1%frames) )
	return,
		
if   frames
	 nigg0r(%ONNE1%hund,%ONNE1%uid,(varprefix_h%current%))
else nigg0r(%ONNE1%hund,%ONNE1%uid,(%ONNE1%frames)) 
return,

framecount() {
	global
	loop {
		if !( exist := fileexist((OutDir . "\" . ONNE1 . a_index . ".ico")) )
			return, ( frames := a_index -1 )
		else {
			varprefix%a_index% := (OutDir . "\" . ONNE1 . a_index . ".ico")
			VarSetCapacity(varprefix_i%a_index%, fisize := A_PtrSize + 688)
			if DllCall("shell32\SHGetFileInfoW", "WStr", varprefix%a_index%, "UInt", 0, "Ptr", &varprefix_i%a_index%, "UInt", fisize, "UInt", 0x100)
			varprefix_h%a_index% := NumGet(varprefix_i%a_index%, 0, "Ptr") 
}	}	}

nigg0r(hWnd,u_i_D,framen) {
	global
	(framen%ONNE1%):= framen
	(hwnd%ONNE1%)  := Format("{:#x}",hWnd)
	(u_i_D%ONNE1%) := u_i_D
	if !current
		current    := 1
		
	if !%ONNE1%ind
		%ONNE1%ind := 1
		
	settimer, ti5m0r,% fps_sleep	
	return,
	
	ti5m0r:
		if  (%ONNE1%ind  < (%ONNE1%frames)) { ; (%ONNE1%frame_index)[current])
			 %ONNE1%ind +=  1
			if (current != (%ONNE1%frame_index)[%ONNE1%ind]) {
				current := (%ONNE1%frame_index)[%ONNE1%ind]
			}
		} else, current := ( %ONNE1%ind := 1 )
		
		TrayIcon_Set((hwnd%ONNE1%), (u_i_D%ONNE1%), (%ONNE1%hbitmaps)[current], 0, 0)
		
		if !playing
			settimer, ti5m0r, off
		return,
}

toggle_anim:
	Playing := !Playing
if Playing {
        settimer, Icon_animation_loop_init, -200
	    menu, tray, check,% "animation (toggle)"
} else,	menu, tray, uncheck,% "animation (toggle)"
return,

xit:
exitapp