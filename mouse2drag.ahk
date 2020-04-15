/* 
;Please Use autohotkey 1.2+ 32bit (UI Access) AutoHotkeyA32_UIA.exe
;mouse 2 to drag windows whilst retaining right click contexts etc
;mouse2 ruler on desktop
;mouse 1 ruler on desktop
;Fun Tooltip with ruler which avoids the mouse

;to fix disable drag on detection of click icon on desktop
;Matt Wolff - 2020
 */

SendMode input
#singleinstance force
#persistent
;Menu, Tray, Icon, mouse2drag32.png
setbatchlines -1
coordmode, mouse, screen
Global DecisionDuration := "t0.330"
Global TooltipFadeDuration := "t0.600"
NumpadDot::Rbutton
Rbutton::
{
MouseGetPos, begin_x, begin_y
If (DetectContextMenu() = 1)
{
;tooltip, removing context to refocus at desired loc
sendinput {escape}
sendinput {LButton}
begin_x=0 
begin_y=0 
x=0
y=0
}
sendinput {MButton}
sendinput {MButton}
WinGetActiveTitle, Atitle
sleep 20
WinGetClass, aclass, %atitle%,,
sleep 25
;tooltip, %aclass%,,,6
if WinActive("ahk_class WorkerW")
	{
MouseGetPos, begin_x, begin_y
click, down
Long_Answer:
KeyWait, rbutton, t0.020
	If ErrorLevel
		{
		MouseGetPos, x, y
		if(x != begin_x)  or  (y != begin_y)
			{
			;tooltip, time breached
			while GetKeyState("rbutton", "P")  ; this is the part that is not working
				{
				MouseGetPos, x, y
				if(x > begin_x) 
				toolx:= begin_x - 103
				if (x < begin_x)
				toolx:= begin_x
				if (y > begin_y) 
				tooly:= begin_y -57
				if (y < begin_y)
				tooly:= begin_y+ 4
				ToolTip, % begin_x ", " begin_y "`n" "X:" Abs(begin_x-x) " Y:" Abs(begin_y-y), toolx, tooly		
				SetWinDelay, 100
				Sleep, 50
				} 
		click, up			
		;tooltip, ruler ended,,,5
		settimer, tooloff, 5000
		return
		;tooltip, dragging a square on desktop ENDED,,,5
				}		
			else
				{
				while GetKeyState("rbutton", "P")
					{
					MouseGetPos, x, y
					;tooltip,mouse 2 held waiting and checking for user decision
					sleep 50
					if(x != begin_x)  or  (y != begin_y)
					goto Long_Answer
					}
				}

		}
send {rbutton}
;tooltip RClick Released
begin_x=0 
begin_y=0 
x=0
y=0
return
}
else
Long_Answer2:
{
	KeyWait, rbutton, t0.020
	If ErrorLevel
		{
		MouseGetPos, x, y
		if(x != begin_x)  or  (y != begin_y)
			{
			SetWinDelay -1
			;click, down, Rbutton
			while GetKeyState("rbutton" , "P") 
				{
				SetWinDelay -1
				CoordMode, Mouse  ; Switch to screen/absolute coordinates.
				MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
				WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
				WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin% 
				if EWD_WinState = 0
							; Only if the window isn't maximized
																									;unmaximize  ?
				;tooltip, window drag activated' n - Mouse 1 to Cancel
				SetTimer, EWD_WatchMouse, 1 ; Track cursor vector differential
				return
				EWD_WatchMouse:
					GetKeyState, EWD_RbuttonState, RButton, P
					if EWD_RbuttonState = U  ; Button released, drag carried out.
						{
						SetTimer, EWD_WatchMouse, Off
						SetTimer, tooloff, 2000
						return
						}
					GetKeyState, EWD_EscapeState, LButton, P
					if EWD_EscapeState = D  
						{
						SetTimer, EWD_WatchMouse, Off
						SetWinDelay -1
						WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
						;ToolTip, Aborting Drag
						return
						}
					;reposition
					CoordMode, Mouse
					MouseGetPos, EWD_MouseX, EWD_MouseY
					WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
					SetWinDelay, -1   
					WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
					EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
					EWD_MouseStartY := EWD_MouseY
					;Tooltip, m2drag activated' n - Mouse 1 to Cancel
					return
				}
			settimer, tooloff, 2000 
			return
			}
				while GetKeyState("rbutton", "P")
					{
					MouseGetPos, x, y
					;tooltip,mouse 2 held waiting and checking for user decision
					sleep 50
					if(x != begin_x)  or  (y != begin_y)
					goto Long_Answer2
					}
sendinput {RButton}
tooltip slow click
		}		
else 
	{
	sendinput {RButton}
	;tooltip, quick Rclicked
	}
return
}
return
}

numpadclear::
{
WINID := WinExist("A")
sleep 200
tooltip % WINID
return
}

DetectContextMenu()
{
   GuiThreadInfoSize = 48
   VarSetCapacity(GuiThreadInfo, 48)
   NumPut(GuiThreadInfoSize, GuiThreadInfo, 0)
   if not DllCall("GetGUIThreadInfo", uint, 0, str, GuiThreadInfo)
   {
      MsgBox GetGUIThreadInfo() indicated a failure.
      return
   }
   if (NumGet(GuiThreadInfo, 4) & 0x4)
      Return 1 
   Else
      Return 0
}
  
 ~LButton::
MouseGetPos, begin_x, begin_y
GoSub Ruler
return
Ruler:
{
sleep 100
	;MouseGetPos, begin_x, begin_y
	WinGetActiveTitle, Atitle
	WinGetClass, aclass, %atitle%,,
	KeyWait, Lbutton, t0.075
	If (ErrorLevel) && (If WinActive("ahk_class WorkerW")) ; or (aclass=("CabinetWClass")))
		while GetKeyState("LButton")
			{
			WinGetActiveTitle, Atitle
			WinGetClass, aclass, %atitle%,,
			MouseGetPos, x, y
			if(x > begin_x) 
			toolx:= begin_x - 103
			if (x < begin_x)
			toolx:= begin_x
			if (y > begin_y) 
			tooly:= begin_y -57
			if (y < begin_y)
			tooly:= begin_y+ 4
			ToolTip, % begin_x ", " begin_y "`n" "X:" Abs(begin_x-x) " Y:" Abs(begin_y-y), toolx, tooly		
			SetWinDelay, 100
			Sleep, 100
			}
SetWinDelay -1
	SetTimer, tooloff, 5000
	return 
} 

tooloff:
{
tooltip,
return
}

^right::
exitapp
