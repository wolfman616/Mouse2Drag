SendMode Input 
#singleinstance force
#persistent

/* 
;Mouse2Drag 0.40: Windows User Interface Accesibility Enhancement enabled by Autohotkey
;
;Drag Windows by right clicking on any part of the window GUI for more than 500 milliseconds, and dragging.
;
;Applying the principles of linux alt drag, Second only to mouse button 1. Lets not go there
;
;Bugs to fix:
;
;Drag detection on the Workerwindow / desktop / icons move around 
;context menu  / tool tip detection  applications detection for certain elements such as Windows Media Player  which sports non compositted ;gui elements which can dislocate momentarily.
;
;Matt Wolff 2020 
 */


Global DecisionDuration := "t0.330"
Global TooltipFadeDuration := "t0.600"

RButton::
	KeyWait, Rbutton, %DecisionDuration%
	If ErrorLevel
		{
		CoordMode, Mouse  ; Switch to screen/absolute coordinates.
		MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
		WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
		WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin% 
		if EWD_WinState = 0
						; Only if the window isn't maximized
		;unmaximize  ?
		Tooltip, m2drag activated' n - Mouse 1 to Cancel
    SetTimer, EWD_WatchMouse, 10 ; Track cursor vector differential
	return

EWD_WatchMouse:
	GetKeyState, EWD_RButtonState, RButton, P
	if EWD_RButtonState = U  ; Button released, drag carried out.
		{
		SetTimer, EWD_WatchMouse, Off
		sleep, ToolTipFadeDuration
		Tooltip,
		return
		}

GetKeyState, EWD_EscapeState, LButton, P
if EWD_EscapeState = D  
	{
    SetTimer, EWD_WatchMouse, Off
    WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
ToolTip, Mouse 1 Actuated:  Aborting Drag Initiation Subroutine....

    return
	}
	;reposition  window to reflect mouse coordinates change
	CoordMode, Mouse
	MouseGetPos, EWD_MouseX, EWD_MouseY
	WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
	SetWinDelay, -1   ; Makes the below move faster/smoother.
	WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
	EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
	EWD_MouseStartY := EWD_MouseY
			;Tooltip, m2drag activated' n - Mouse 1 to Cancel
	Return
	}
Else
	{
    send {Rbutton}
	}
Return

~LButton::

MouseGetPos, begin_x, begin_y
KeyWait, Lbutton, t0.375
If ErrorLevel
    while GetKeyState("LButton")
    {
        MouseGetPos, x, y
        ToolTip, % begin_x ", " begin_y "`n" Abs(begin_x-x) " x " Abs(begin_y-y)
		SetWinDelay, 150
        Sleep, 150
    }
KeyWait, Lbutton, t0.375
If ErrorLevel
return,
else
sleep 100
    ToolTip,
return

