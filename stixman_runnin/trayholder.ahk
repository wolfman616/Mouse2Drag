#noEnv 
#persistent
listLines,           Off 
#keyhistory        off
#SingleInstance  off

if 0 = 0     	                ; check for initial arguments 
exitapp,

gosub, var_                   ; variable declarations

try, Menu, Tray, Icon,% ( "HBITMAP:*" . (hbitmap:=Png2hBitmap(gb64)) ) 

DetectHiddenWindows, 	On
DetectHiddenText, On
settitlematchmode, 2
settitlematchmode, slow
menu, tray, nostandard
menu, tray, add, Close all, clients_kill
SetBatchLines,       -1
SetWinDelay,         -1
item_ar := []                    ; array holding all client attributes
WMAllow()                      ; allow wm_copydata 
onexit("Cclose")

newaddition = %1%        ; initial arguments used to launch this script in format "procpath;window-handle;PiD;Title"

newaddition:                  ; label invoked every new client  with new value in "newaddition"
resindex += 1                 ; client instance index
loop, parse, newaddition,% ";",
{
	switch a_index {
		case "1":
			thispname  := a_loopfield
		case "2":
			handle       := a_loopfield
		case "3":
			pid            := a_loopfield
		case "4":
			ttl              := a_loopfield
}	}
item_ar.push({ "hwnd" : handle ,  "PN" : thispname , "pid" : pid , "title" : ttl })
if !trayinit {
	try,  menu,   tray, icon,% thispname
	trayinit := True
}

SplitPath, thispname, proc_,,, procname
procname:=RegeXreplace(procname,"(\b\w)(.*?)","$U1$2") 
menu,      tray, add,% resindex . " " . ttl .  " ( " . procname . " ) ",% "Restore" . resindex
try menu, tray, delete, Restore all 
if resindex>1
	menu,  tray, add, Restore all, restoreall
menu,      tray, tip,% proc_ " docked"
tt(pid  " "  thispname " minimized to tray...", 1800)
winhide,   ahk_id %handle%
return

clients_kill:
s:="trayremove;" . thispname
		ss:="SHELLH00K ahk_class AutoHotkeyGUI"
		winget coc, id , %ss%
		aaa:="ahk_id " . coc
		for, i in item_ar
{
	winshow,%        "ahk_pid " . item_ar[i].pid
	winwaitactive,% "ahk_pid " .  item_ar[i].pid
	sleep, 100	; Process, Close,% "ahk_pid " . item_ar[i].pid
	winkill,%            "ahk_pid " . item_ar[i].pid 
			Ee:= Send_WM_COPYDATA(s, aaa)

}
	global cuntface:=true
Cclose()
exitapp,

Cclose() { 
global item_ar
s:="trayremove;" . thispname
		ss:="SHELLH00K ahk_class AutoHotkeyGUI"
		winget coc, id , %ss%
		aaa:="ahk_id " . coc
		if !cuntface 
	for, i in item_ar {
		winshow,%    "ahk_pid " . item_ar[i].pid
		
		Ee:= Send_WM_COPYDATA(s, aaa)
	}
	sleep, 900
	exitapp,
}

WMA() { ; allow lower elevation based window messages to be recvd
	Loop 2
		DllCall( "ChangeWindowMessageFilter", "uInt", "0x" (i:=!i?49:233), "uint", 1)
	return, ErrorLevel
}

Rx(wParam, lParam) { ; rcv wm_copydatastring
	global static init := OnMessage(0x4a, "Rx") ; register wm_copydata 
	global  newaddition := StrGet(NumGet(lParam + 2*A_PtrSize)) 
	gosub, newaddition
	return, 1
}	

Tx(ByRef StringToSend, ByRef TargetScriptTitle) { ; send wm_copydatastring
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
Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle)  ; ByRef saves a little memory in this case.
; This function sends the specified string to the specified window and returns the reply.
; The reply is 1 if the target window processed the message, or 0 if it ignored it.
{
    VarSetCapacity(CopyDataStruct, 3*A_PtrSize, 0)  ; Set up the structure's memory area.
    ; First set the structure's cbData member to the size of the string, including its zero terminator:
    SizeInBytes := (StrLen(StringToSend) + 1) * (A_IsUnicode ? 2 : 1)
    NumPut(SizeInBytes, CopyDataStruct, A_PtrSize)  ; OS requires that this be done.
    NumPut(&StringToSend, CopyDataStruct, 2*A_PtrSize)  ; Set lpData to point to the string itself.
    Prev_DetectHiddenWindows := A_DetectHiddenWindows
    Prev_TitleMatchMode := A_TitleMatchMode
    DetectHiddenWindows On
    SetTitleMatchMode 2
    TimeOutTime := 4000  ; Optional. Milliseconds to wait for response from receiver.ahk. Default is 5000
    ; Must use SendMessage not PostMessage.
    SendMessage, 0x4a, 0, &CopyDataStruct,, %TargetScriptTitle%,,,, %TimeOutTime% ; 0x4a is WM_COPYDATA.
    DetectHiddenWindows %Prev_DetectHiddenWindows%  ; Restore original setting for the caller.
    SetTitleMatchMode %Prev_TitleMatchMode%         ; Same.
    return ErrorLevel  ; Return SendMessage's reply back to our caller.
}
restore1:
restore2:
restore3:
restore4:
restore5:
restore6:
restore7:
restore8:
restore9:
restore10:
idx:=Format("{:d}",strreplace(a_thislabel, "restore",""))
s:="trayremove;" . (item_ar[idx].PN)
p:="WinEvent.ahk ahk_class AutoHotkeyGUI"
ss:="SHELLH00K ahk_class AutoHotkeyGUI"
winget coc, id , %ss%
aaa:="ahk_id " . coc
f:= item_ar[idx].hwnd
winshow, ahk_id %f%
try menu, tray, delete,% ( resindex . " " . item_ar[resindex].title .  " ( " . procname . " ) " ~)
 Ee:= Send_WM_COPYDATA(s, aaa)
item_ar.delete(idx)
resindex   -=1
if resindex < 1
	exitapp,
sleep, 40
return,

restoreall:


Cclose()
return,

;[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]

Png2hBitmap(base64input, NewHandle := False) {
	Static hBitmap := 0
	If (NewHandle)
	   hBitmap     := 0
	If (hBitmap)
	   Return hBitmap
	VarSetCapacity(B64, 3864 << !!A_IsUnicode)
	If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &base64input, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
	   Return False
	VarSetCapacity(Dec, DecLen, 0)
	If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &base64input, "UInt", 0, "UInt", 0x01, "Ptr", &Dec, "UIntP", DecLen, "Ptr", 0, "Ptr", 0)
	   Return False
	hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
	pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
	DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", &Dec, "UPtr", DecLen)
	DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
	DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream)
	hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
	VarSetCapacity(SI, 16, 0), NumPut(1, SI, 0, "UChar")
	DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &SI, "Ptr", 0)
	DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", pBitmap)
	DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "PtrP", hBitmap, "UInt", 0)
	DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
	DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
	DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
	DllCall(NumGet(NumGet(pStream + 0, 0, "UPtr") + (A_PtrSize * 2), 0, "UPtr"), "Ptr", pStream)
	Return hBitmap
}
return,

var_:
gb64 := "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAQK0lEQVRYCQEgEN/vAQAAAAAAAAAAAAAAAAAAAAAhAP8CAAAAAAAAAAAAAAAAAAAAAAAAAAD/AAAAAQAAAAQAAAAFAAAABgAAAAQAAAAEAAAABAAAAAQAAAADAAAAAwAAAAMAAAADAAAAAwAAAAMAAAACAAAAAwAAAAIAAACnAAH+AAAAAAAAAAAAAAAAAQAAAAAhAP8CAAAAAgAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAABQAAAAUAAAAFAAAABQAAAAQAAAADAAAABAAAAAMAAAADAAAAAwAAAAMAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAP4CAAAAAgAAAAIAAP6eAAH+ASEA/wQAAAAEAAAABgAAAAQAAAACAAAAAAAAAAIAAAAAAAAAAAMAAAAFAAAABQAAAAUAAAAEAAAABAAAAAQAAAADAAAAAwAAAAMAAAADAAAAAwAAAAMAAAACAAAAAwAAAAIAAAACAAAAAwAA/gIAAAACAAD8AgAA/AIAAPwCAAD8BAAAAAgAAAALAAAADgAAAAkAAAAFAAAAAgAAAAIBAAAABAAAAAUAAAAFAAAABAAAAAUAAAADAAAABAAAAAMAAAADAAAAAwAAAAMAAAADAAAAAgAAAAMAAAACAAAAAwAAAAIAAAACAAD+AwAAAAIAAPwCAAD7AQAA9wMAAPMBAAD2BAAAAAv/B/8X/hf+HQH+ABIA/QEIAP8AAwMAAAIF/wAABQAAAAX/AAEFAAAABP8AAAT/AQADAAAAA/8AAAQAAAAD/wAAAgAAAAP/AP8D/wAAAgAAAAP/AAAC/wAAAv8AAAP/AQAC/wAAAv8A/gIAAPwC/gD2AvoA7gD+AOQAAADqBAIAAAj0YfYs9Xr1hwIDAQ0C/QEAB/0BAQr8AQAB/AEAA/sBAAT7AQAE/AEABPsBAAX6AAAE+wEAA/sBAAT6AQAD+wAAA/oBAAP5AQAD+QEAAvkAAAP4AQAD+AEAAvcBAAP2AQAC9AAAAvIBAAPvAf4E6wD6/fv+9PvxAn776QHGBAEAAAL/8vIFA8P62AX+EfkF+wAECP0BAAj9AQIG/QAABvwBAQX7AQEE+wECBfoAAQT8AQID/AAAA/0B/wL+AP8C/QH+Af4A/gH8Af8B+wAAAfsBAAH7AAAA+gH+AfkAAAD5AQAA9wAAAPUBAADyAP398gH69g/xB/wGAQQDABEABAAAAPr/9fZ8BqPwFha4H94EAAADBAAA/gQAAAAEAAAFBAAAAwUAAPQGAADsAwAA/wEDACgE/gDoA/8A8gAAAAcBAAAPAQAACQIAAAABAAD9AQAA/gAAAAAAAAAA/wAA//8AAAD/AAAA/gAAAP0AAAH/AAD87gflJAYFECUKABGVBAAAAPsEC/n0AAT2DgYAANICAAD2BAAA9wQAAAQFAAAJBgAA4wMXAPf1AgDf9F8AHc1HADEx7wCy9RUAHhPhABEhcwBsA+kAIwAAACUCAAAkAgAACgIAAAACAAAAAgAA+gIAAAAAAAAA/wAABv4AAAkAAAAJ+gr3HQEECvP+AADuBAUAAPwIBfz2/QD4+AcAAM0BAADuBAAA8QQAAAUGAAALBgAAycqxAJ70/AAdFekA+QrxAAzn+wBz6/IABuYcAPP8lwASAf0A78pVAaRjAP8KAQAAHAIAABECAAAAAQAAAAAAAAD+AAAA/gAAB/4AABcCAAAZ+wv3RQMD+/n9AADxBAgAAAD+Af79/AL9/QcAAO7/AADiBAAA+QYAABb9EgDT56cAAA3qAAP29AAT+esAARLyAAIAAAALEwsAAP4UAAzWGwDE9RIA8jOo/zidWAHsAAAA2mgA/woBAAAKAAAAAP0AAAD+AAAA/gAACf4AAPkAAAAA/Af8/fwD/v39AAAABAcAAAD8/gEAAf4AAAUAAPn/AAAABAAAAAIAAPjjjABQ1Q4AahXgAAQQ4AABCuQA/wz1AO4BAAD98QsAEvP4AAf5CgAHHf0A4s1YAewAAAAAAAAAAJgAAfZnAP8A/gAAAP4AAAD+AAAA/gAACf4AAP7/AAAA/QX/AP0D/wD8AAAAAgUAAAAF/QAABP0AAAUAAAAEAAAABAAADgIAAPkJBgDFFPEA+gDyAAcH6QAAGfIAzikBAC8s+gAoIPcAtwrmAP8K6gAB8f4AHh7D/6gAAAAAAAAAAAAAAACZAAH2/QAAAP0AAAD7AAAK/AAA9QAHAP4HAwAHAQoBAv0EAAD9AAAAAgUAAAAE/AEABP0BAAQAAAAEAAAABAAAAAQAAPn5EgApBfkAAAP4AAEF9gD8EwgAi6SgAeygpwH2EwYAewn6APgB9gAB8gIAD+IMADQmtf8KAAAAAAAAAAAAAAAAngAB9gEKAAUSKAD/Gj4ABxU2AAQNJwAMAAgBAf0EAAP8AAAAAgUAAAAE/QEABP0AAAQAAAAEAAAABAAAAAYAAPniFQBc5wwAEP0FAAD+AgAD+gAALAAAAAAAAAAA+gIAL/oBAAX7BQABFvgA7jbZAFTaSwH2AAAAAAAAAAAAAAAAAIT/CtFeAAALOQAFChwABgAJAAT7/wAA/QIAAP0EAAD8AAAABAQAAAAE/AAA/f0BAAQAAAD+AAAAAwAA6QAAAAIk4wBc9wAAjeYKAEL2FQAD4uYAckll/xoBAwDx3/kAY/MZAAb2EQAA9hYAEgn7AHEewP+d6RAARhDIAJDpaAHsAPMAAM4eAAQW5QD6LPEACP0CAAUFFwAMAQ0BAfzx/wD7AAAABAQAAAAE/AEA/f0AAAQAAAD9AAD5AwAA+gMAAAnNUgHaCsj/JPYOAAIB/AAA/AUADvHwAGX/AAAA9hYAA+8fAAAQDwD0+f0A7wrxAOPXHQCdABQAIA0dAArp1f8iAPUAyQCtAJu7KAD+JRAAAxYCAPQD9wAKAvkBAvz0AAD8AAAABAQAAAAD/AEAA/4B/gMAAAAAAAAAAwAA+QIAAARmAP8UuvsAwAL/AB7yGQA05xEAEAnyAAH7AAAC/ggA/v4XAALwDQAAAPEAE9f9AHMA1wAEAAEAA9wKAG4ACwABABYAMABNAJv9+wARL6REA/hfmAAr7+QD0/AIAAPwDAAL7AAAIBAQAAAAE/AAA+/0AAAMAAAAAAAAAAwAA/AIAAO/9AAAE4D0BaQAAAAACzP/bAAAACBXmAOHiGgAoF+0A3Aj8ANv1+wAFBu4AMObrABkT2AD/CvkA/eobAAP5AgAAExIA7O0IACMA/gDu3wYAACT8AAkBAAAR/QQBAvsCAAD6AAAAAgMAAAAD+wEAA/wBAAMAAAADAAAAAgAAAAEAAPgDAQD9aBT/DAAAAAAn3QBqKd4AZBLlAF4P/QDIEPYAk+FGAVD8AAAL5ggAFA7eAAAj3QDpPukASiXiAPEA4wAB7RQAMgAsALQAAAD++fsAAfoCAAb8BgAE/QQBAfsCAAD6AAAABAQAAAAC+wAAA/0BAgMAAAAAAAAACAoAABQgAAUNEAD+/Q0ADzso/wbF0QDNEPYA+AoKAAr8uwBI4D4ACgKy/x3wGgAqAPYABP/9AAAA/QADAAEACP/+AAIA/QAAAPcA/gDrANwA7QAABPkA+/wAAAP9/wD/+gIAAvkC/wAAAAAABAMAAAAD+QEAA/8BAAsBAAcKJQAOFCAA+QwQAPwAAAD8+vkA9UXhAALzIQD20iQA/fEQAAgAOgAJ/wgACQARAAAd4gBNAPkAoOMlACfa9wAV5fkAsOYdAAEAIQAAAP8A7wDQAF8A/gABEfgAB/wAAAQCCQAC/f4BAfgDAAMCAAAABAMAAAAD+QIDCAYDAxYpABIEEQAAA/8AAPjyAPX+AgD2AAYAChMNAPJfBQABvgwA87ceAPH+/wADAP4ABwDyAALjFQDmABwAEwAXAADwEQD/8AEAAgALAP4AIwD/AB0ADQDtABQV+QDuHwgAGwMKAA4HAwAa/+oCAvgAAQAKAAAHBAIAAAAD9wEAAgAEAwEAABL89gAAAAEABQcSAPsIFAAFBA4A+gAHAPcIAwDoR9wA8yfoAOW3IwD11xcA6wD4AAkA3gAHAB4AlQQCADEYFwAA5CkASwDxAOIB7AB+//wAGCvtAPE3+gAVDwkAGf4AADr9+wAT//8CAf8AAAIAAAAABAMAAAAD8gECAPwBAQkTAAoEEQAKCRUA9gQMAAD/BAAA/fgABP34AAD8AQAAAgEA7B/wAPJe6QD26AkA1t4OAO7iDgD97+QAlQP7AAYMEwASF+gAuhDzAOcX8gD4CQMAAAwGADAHCQD9/gUAQgD+ABsB+wAAAv4AAAH/AAAAAAD5BAMAAP4D/QL+/Qn9ENgP0Vj+Bf4C/vX//v76///+BAAA/gMAAP4EAAH/BAAC/gMB5f8DAAT+/gDp/fsAAQL0APUb6P8IFwEB/QEFAvYC6wPyAAAD8v4DAR7rBQAJ/Qb+Gvr8/Rf89/4n//gBAwH/AQECAAEA8wb4C/8GDvsAAAD4BP4AAP4IABi7+QT+F/X0/wb++gD+/gf/AP4F/wH+BQAA/QUAAP4EAAD+A//+/gQAG/4DAAD9A/8X/QMA//4DAAD9AgEB/gIBAf79AAH9+QEB/AEBAPsD/wD7BP7++QQBAvkDA/79AgL8AAAA/AAAAAEAAQD//gMU8wnaG739AADxAWcA/wj/AAA2AAAAD/4AAAj+AAAH/QAAAP4AAAD+AAAA/QAAAP4AAAD9AAAA/QAABf0AAAD9AAAA/QAAAP0AAAD8AAAA/QAAAPsAAAf8AAAA+wAAAPsAAAD7AAAA/QAAAAEAAPkBAAAAAAAAAP8AAAABAAD7AQAA8f0AAPH/AADoBP0AAPz+AADf/wAAE/0AAAD+AAAH/gAAAP4AAAD9AAAA/gAAAP0AAAD9AAAA/gAAAP0AAAD9AAAA/AAAAP0AAAD8AAAA/AAAAPwAAAf7AAAA+wAAAPsAAAD+AAAAAAAAAP8AAPkAAAAAAAAAAAAAAAAAAAAAAAAA+QAAAO0AAAD3AQAAAABgAP8K/gAAAP0AAAr+AAAA/gAAAP0AAAD+AAAA/QAAAP4AAAD9AAAA/QAAAPwAAAD9AAAA/QAAAPwAAAD8AAAA+wAAAPsAAAD7AAAA/AAAAP8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPbfAAH2AQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKgD/CvoAAAD9AAAAAAAAAAAAAAAAAAAAAAAAAN8AAfYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAATgW8lClXJMwAAAAASUVORK5CYII"

global trayinit,handle,pid,thispname,ttl,deftrayico,item_ar,newaddition,resindex,gb64
resindex:=0
return,

WMAllow() 
{ ; function to allow lower elevation based window messages to be delivered here
		DllCall( "ChangeWindowMessageFilter", uInt, 0x4a, uint, 1)
		return, Errorlevel
}
Open_ScriptDir:
toolTip %a_scriptFullPath%
z=explorer.exe /select,%a_scriptFullPath%
run %comspec% /C %z%,, hide
sleep 1250

ToolOff:
toolTip,
return