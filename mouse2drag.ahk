/* 
;Please Use autohotkey 1.2+ 32bit (UI Access) AutoHotkeyA32_UIA.exe
;mouse 2 to drag windows whilst retaining right click contexts etc
;mouse 2 ruler on desktop
;mouse 1 ruler on desktop
;Fun Tooltip with ruler which avoids the mouse

;Matt Wolff - 2020
 */
#WinActivateforce
SendMode input
#singleinstance force
#persistent
;Menu, Tray, Icon, mouse2drag32.png
setbatchlines -1
CoordMode, Mouse
;coordmode, mouse, screen
global twit=1
global begin_x:=
global begin_Y:=
xx:=
yy:=
0clicked=0
BrkLoop = 0
F12::
   UnderCursorToggle := (! UnderCursorToggle)
   If (UnderCursorToggle)
      SetTimer ToolTipUnderCursor, 250
   Else
   {
      SetTimer ToolTipUnderCursor, Off
      ToolTip,% GetUnderCursorInfo
   }
Return
brkcheck() {
MouseGetPos new1x, new1y, Window
if(new1x != Begin_X) or (new1y != Begin_Y)
BrkLoop = 1
Return
}

NumpadDot::Rbutton
Rbutton::
punter:
{
MouseGetPos, begin_x, begin_y, Window

WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %Window%
WinGet, EWD_WinState, MinMax, ahk_id %Window% 	
WinGetClass Class, ahk_id %Window%
;WinActivate
;WinGetTitle Title, aclass %Window%
EWD_MouseStartX_old=%EWD_MouseStartX%
					EWD_MouseStartY_old=%EWD_MouseStartY%
If (DetectContextMenu() = 1)
{
;tooltip, 
;removing context to refocus at desired loc
click, escape
goto punter
;WinActivate, ahk_id %Window%

}
;WinGetClass aclass, ahk_id %Window%
;WinActivate, ahk_id %Window%






if WinActive("ahk_class tooltips_class32")
return
while GetKeyState("rbutton" , "P") 
				{

						;tooltip, ahk_id %ahk_id%

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
;MouseGetPos, x, y


					GetKeyState, EWD_RbuttonState, RButton, P

					if EWD_RbuttonState = U  ; Button released, drag carried out.
						{

;click, right

						SetTimer, EWD_WatchMouse, Off
						SetTimer, tooloff, -2000
;tooltip up
CoordMode, Mouse
mousegetpos xxxx, yyyy

if  xxxx!=% begin_x
return
else

 click, right
return
; mousemove xxxx+1, yyyy+1
; mousemove xxxx, yyyy
; }

						return
						}
					GetKeyState, EWD_EscapeState, LButton, P
					if EWD_EscapeState = D  
						{
						SetTimer, EWD_WatchMouse, Off
						SetWinDelay -1
						WinMove, ahk_id %Window%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
						click, up
						;ToolTip, Aborting Drag
						return
						}
if class=WorkerW
{
;tooltip, desktop detected

while GetKeyState("rbutton" , "P") 
	{
	
}

return
}
else
					;reposition
					CoordMode, Mouse,
					MouseGetPos, EWD_MouseX, EWD_MouseY
					WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %Window%
					SetWinDelay, -1   
					WinMove, ahk_id %Window%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
					

					EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
					EWD_MouseStartY := EWD_MouseY

;tooltip, scummm

;if WinActive("ahk_class WorkerW")	||   WinActive("ahk_class Progman")
;tooltip mistake
					;Tooltip, m2drag activated' n - Mouse 1 to Cancel
;tooltip scum
					return
				


}

; else
; EWD_Watch2
		
; sendinput {RButton}			
; settimer, tooloff, -2000 

;tooltip slow click
	return		
}



numpadclear::
{
WINID := WinExist("A")
sleep 200
tooltip % WINID
return
}
EWD_Watch2:
					GetKeyState, EWD_RbuttonState, RButton, P
					if EWD_RbuttonState = U  ; Button released, drag carried out.
						{
CoordMode, Mouse
mousegetpos xxx, yyy
sleep 100
if  xxx=% EWD_MouseStartX_old
click right
						SetTimer, EWD_WatchMouse, Off
						SetTimer, tooloff, -2000
						return
						}




 ~LButton::
MouseGetPos, begin_x, begin_y, Window
WinGetClass Class, ahk_id %Window%
If WinActive("ahk_class Basebar")
tooltip cunt
If (DetectContextMenu() = 1)
	{
if class=WorkerW
{

	;WinActivate, ahk_id %Window%
click, escape


;MouseGetPos, begin_x, begin_y
click, down   
ruler()
}
if class=#32768
;tooltip, menu
	return
	}
if aax
{
aax:=
ruler()
}
else
{
WinGetTitle aTitle, aclass %Window%
WinGetClass aclass, ahk_id %Window%
MouseGetPos, begin_x, begin_y
;tooltip, clicked
settimer, tooloff, 750
;WinActivate, ahk_id %Window%
if class=WorkerW
Ruler()
if (If WinActive("ahk_class WorkerW"))  ||  (If WinActive("ahk_class Progman")) 
aax:= % Explorer_GetSelection()
else
return
if !aax
Ruler()
else 
;tooltip, clicked on %AAX%
return
Ruler()
{
	;MouseGetPos, begin_x, begin_y
	WinGetActiveTitle, Atitle
	WinGetClass, aclass, %atitle%,,
LongAnswer3:
	KeyWait, Lbutton, t0.500
	If (ErrorLevel) && ((If WinActive("ahk_class WorkerW"))  ||  (If WinActive("ahk_class Progman")))
{
		MouseGetPos, x, y
		if (x != begin_x)  ||  (y != begin_y)
			{
			while GetKeyState("LButton", "P")
				{
aax:= % Explorer_GetSelection()

				WinGetActiveTitle, Atitle
				WinGetClass, aclass, %atitle%,,
				MouseGetPos, x, y
				if (x > begin_x) 
				toolx:= begin_x - 103
				if (x < begin_x)
				toolx:= begin_x
				if (y > begin_y) 
				tooly:= begin_y -57
				if (y < begin_y)
				tooly:= begin_y+ 4
			ToolTip, % begin_x ", " begin_y "`n" "X:" Abs(begin_x-x) " Y:" Abs(begin_y-y), toolx, tooly 
				;SetWinDelay, 100
				Sleep, %twit%
if aax
{
;tooltip, touching files stop ruler, toolx, tooly
;sleep 1000
tooltip
exit
}
				}
;SetWinDelay -1
;tooltip, mouse 1 released ,,,2 
	SetTimer, tooloff, -5000
	return 
		} 
else 
while GetKeyState("lbutton", "P")
	{
tooltip, no change x y  mouse 1 held ;(waiting decision)
if aax   ;tooltip %aax%,,,5
return
if x!=begin_x !! y!=begin_y
ruler()
return
	}
return
}
else
;tooltip vcuucucucnt
return
}}

return
tooloff:
{
tooltip,
exit
}
exit
HexToDec(HexVal)
{
   Old_A_FormatInteger := A_FormatInteger
   SetFormat IntegerFast, D
   DecVal := HexVal + 0
   SetFormat IntegerFast, %Old_A_FormatInteger%
   Return DecVal
}

Explorer_GetSelection(hwnd="") {
    WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")
    WinGetClass class, ahk_id %hwnd%
    if (process = "explorer.exe")
        if (class ~= "Progman|WorkerW") {
            ControlGet, files, List, Selected Col1, SysListView321, ahk_class %class%
            Loop, Parse, files, `n, `r
                ToReturn .= A_Desktop "\" A_LoopField "`n"
        } else if (class ~= "(Cabinet|Explore)WClass") {
            for window in ComObjCreate("Shell.Application").Windows
			try
				{
				if (window.hwnd==hwnd)
					sel := window.Document.SelectedItems
				}
            catch
				return
for item in sel
                ToReturn .= item.path "`n"
        }
    return Trim(ToReturn,"`n")
}
return

GetUnderCursorInfo(ByRef CursorX, ByRef CursorY)
	{
	CoordMode Mouse, Screen
	CoordMode Pixel, Screen
	MouseGetPos, CursorX, CursorY, Window, Control
	WinGetTitle Title, ahk_id %Window%
	WinGetClass Class, ahk_id %Window%
	WinGetPos WindowX, WindowY, Width, Height, ahk_id %Window%
	WinGet PName, ProcessName, ahk_id %Window%
	WinGet PID, PID, ahk_id %Window%
	ControlGet, sel, Selected, ,ahk_id %Window%
	WindowUnderCursorInfo := "ahk_id " Window "`n"
	. "ahk_class " Class "`n"
	. "title: " Title "`n"
	. "control: " Control "`n"
	. "control selected: " sel "`n"
	. "PID: " PID "`n"
	. "process name: " PName "`n"
	. "top left (" WindowX ", " WindowY ")`n"
	. "(width x height) (" Width " x " Height ")`n"
	. "cursor's window position (" CursorX-WindowX ", " CursorY-WindowY ")`n"
	. "cursor's screen position (" CursorX ", " CursorY ")`n"
	. HexToDec("0x" SubStr(BGR_Color, 5, 2)) ", "
	. HexToDec("0x" SubStr(BGR_Color, 7, 2)) ")`n"
	Return WindowUnderCursorInfo
	}

ToolTipUnderCursor:
   WindowUnderCursorInfo := GetUnderCursorInfo(CursorX, CursorY)
   CoordMode ToolTip, Screen
   ; place tooltip in quadrant opposite of cursor
   If ( CursorX < (A_ScreenWidth // 2) )
      TTXOffset = 150
   Else
      TTXOffset = -150
   If ( CursorY < (A_ScreenHeight // 2) )
      TTYOffset = 150
   Else
      TTYOffset = -150
   ToolTip %WindowUnderCursorInfo%
      , ( (A_ScreenWidth // 2) + TTXOffset )
      , ( (A_ScreenHeight // 2) + TTYOffset )
Return

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
 return

#If (DetectContextMenu() = 1)

WheelUp::
    Send, { up }
    Return

WheelDown::
    Send, { down }
    Return

PgDn::    ;  WheelRight
    Send, { right }
    Return

PgUp::    ;  WheelLeft
    Send, { left }
    Return

MButton::
	Send, { enter }
	return

f8::
twit:=twit +1
return





^right::
exitapp
