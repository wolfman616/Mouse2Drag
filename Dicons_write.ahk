﻿; "DeskIcons.ahk"
; Updated to be x86 and x64 compatible by Joe DF
; Revision Date : 22:13 2014/05/09
; From : Rapte_Of_Suzaku
; http://www.autohotkey.com/board/topic/60982-deskicons-getset-desktop-icon-positions/

/*
	Save and Load desktop icon positions
	based on save/load desktop icon positions by temp01 (http://www.autohotkey.com/forum/viewtopic.php?t=49714)
	
	Example:
		; save positions
		coords := DeskIcons()
		MsgBox now move the icons around yourself
		; load positions
		DeskIcons(coords)
	
	Plans:
		handle more settings (icon sizes, sort order, etc)
			- http://msdn.microsoft.com/en-us/library/ff485961%28v=VS.85%29.aspx
	
*/
SetWorkingDir %A_ScriptDir%  
DeskIcons(coords="")
{
	Critical
	static MEM_COMMIT := 0x1000, PAGE_READWRITE := 0x04, MEM_RELEASE := 0x8000
	static LVM_GETITEMPOSITION := 0x00001010, LVM_SETITEMPOSITION := 0x0000100F, WM_SETREDRAW := 0x000B
	
	ControlGet, hwWindow, HWND,, SysListView321, ahk_class Progman
	if !hwWindow ; #D mode
		ControlGet, hwWindow, HWND,, SysListView321, A
	IfWinExist ahk_id %hwWindow% ; last-found window set
		WinGet, iProcessID, PID
	hProcess := DllCall("OpenProcess"	, "UInt",	0x438			; PROCESS-OPERATION|READ|WRITE|QUERY_INFORMATION
										, "Int",	FALSE			; inherit = false
										, "ptr",	iProcessID)
	if hwWindow and hProcess
	{	
		ControlGet, list, list,Col1			
		if !coords
		{
			VarSetCapacity(iCoord, 8)
			pItemCoord := DllCall("VirtualAllocEx", "ptr", hProcess, "ptr", 0, "UInt", 8, "UInt", MEM_COMMIT, "UInt", PAGE_READWRITE)
			Loop, Parse, list, `n
			{
				SendMessage, %LVM_GETITEMPOSITION%, % A_Index-1, %pItemCoord%
				DllCall("ReadProcessMemory", "ptr", hProcess, "ptr", pItemCoord, "UInt", &iCoord, "UInt", 8, "UIntP", cbReadWritten)
				ret .= A_LoopField ":" (NumGet(iCoord,"Int") & 0xFFFF) | ((Numget(iCoord, 4,"Int") & 0xFFFF) << 16) "`n"
			}
			DllCall("VirtualFreeEx", "ptr", hProcess, "ptr", pItemCoord, "ptr", 0, "UInt", MEM_RELEASE)
		}
		else
		{
			SendMessage, %WM_SETREDRAW%,0,0
			Loop, Parse, list, `n
				If RegExMatch(coords,"\Q" A_LoopField "\E:\K.*",iCoord_new)
					SendMessage, %LVM_SETITEMPOSITION%, % A_Index-1, %iCoord_new%
			SendMessage, %WM_SETREDRAW%,1,0
			ret := true
		}
	}
	DllCall("CloseHandle", "ptr", hProcess)
	return ret
}
FileMove, %A_ScriptDir%\D_ICON.txt
, %A_ScriptDir%\D_ICON.old
coords := DeskIcons()
iniwrite, %coords%,D_ICON.txt,coords
; load positions
;DeskIcons(coords)