#noEnv
#persistent
#SingleInstance, force
sendMode,        Input
SETWINDELAY,     -1
SETBATCHLINES,   -1
setWorkingDir,   %a_scriptDir%

global frames, fps_desired, fps_sleep, Playing

fps_desired := 12
fps_sleep   := round( 1000 / fps_desired )
if (framecount()) {
	Playing := True
	settimer, Icon_animation_loop, -200
} else {                    ; nO sequence of icons found (1.ico, 2.ico, 3.ico)
	if 		   0 != 1 	    ; Not run with parameter
		filePath := "D:\Documents\My Pictures\6pkB.ico" ; specify the file path to gif
	else if     0 = 1	    ; run with parameter from menus
		filePath  = %1%
	if !(fileexist( filePath ) ) {
		msgbox,,%   "Error",% "Cant find `n" filePath
		FileSelectFile, filePath , Options, D:\Documents\My Pictures\, Title,% "iCO Files (*.ICO)"
}	}
return,

framecount() {
global
	loop {
		varprefix%a_index% := (a_scriptDir . "\" . a_index . ".ico")
		if !( exist := fileexist(varprefix%a_index%) )
			return, ( frames := a_index -1 )

}	}

Icon_animation_loop:
if !frames
	return,
	
loop {
	if     (current < frames)
		    current += 1
	else,   current := 1
	
	menu,   tray, icon,% varprefix%current%  
	sleep,% fps_sleep
	
	if !playing
		break
}
return,