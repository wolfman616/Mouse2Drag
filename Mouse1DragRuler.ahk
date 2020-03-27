#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;to add leave tooltip onscrteen for some time
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Screen
#Persistent
#SingleInstance force
; LButton::

~LButton::

MouseGetPos, begin_x, begin_y
KeyWait, Lbutton, t0.375
If ErrorLevel
    while GetKeyState("LButton")
    {
        MouseGetPos, x, y
        ToolTip, % begin_x ", " begin_y "`n" Abs(begin_x-x) " x " Abs(begin_y-y)
SetWinDelay, 50
        Sleep, 50
    }
KeyWait, Lbutton, t0.375
If ErrorLevel
return,
else
sleep 10000
    ToolTip,
return
