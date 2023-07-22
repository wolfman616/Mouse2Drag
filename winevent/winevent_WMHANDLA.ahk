;(MW:2022) (MW:2022) script purpose: to direct wms and verbs from an unelevated and not UI system based Instance of ahk
#NoEnv 
#notrayicon
#persistent 
#Singleinstance,	Force
DetectHiddenWindows,On
DetectHiddenText,	On
SetTitleMatchMode,	2
SetTitleMatchMode,	Slow
Setworkingdir,% (splitpath(A_AhkPath)).dir
SetBatchLines,		-1
SetWinDelay,		-1
global CopyOfData,cata
wm_allow()
OnMessage(0x4a,"Receive_WM_COPYDATA")
return,

;~LButton::~LButton

WM_COPYDATA_1:
switch,_:=substr(CopyOfData,1,1) {
	case,"q":res2:= invokeverb(Cata:= LTrim(CopyOfData,"q"),"Enqueue")
		return,
	case,"a":msgbox % CopyOfData
	loop,parse,CopyOfData,% "\"
		switch,a_loopfield {
			case,1:
			case,2: hwnd:=a_loopfield
			case,3: type:=a_loopfield
			case,4:time:=a_loopfield
		}
	
	default: switch,CopyOfData {
			default : if(islabel(CopyOfData)||isfunc(CopyOfData))
			SetTimer,% CopyOfData,-1
		}

}

return,

WM_COPYDATA_2:
Cata:= LTrim(CopyOfData,"x")
ssleep(40), cata:= ""
return,

Receive_WM_COPYDATA(byref wParam,byref lParam) {
	global minholder,Cata,CopyOfData
	msgbox % CopyOfData:= (StrGet(NumGet(lParam+2 * A_PtrSize)))
	settimer,WM_COPYDATA_1,-1
	return,0
}