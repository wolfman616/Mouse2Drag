winevent_func(){
	(DBgTt?TT("Initialising structs / registering h00kz ..."))
}

funcClass_inits() {
	 return,t0k0m(),QOTEG3N(),icon_(),Aero_Lib(),Aero_StartUp()
}

TimeScriptStart() {
	global a_scriptstarttime,tickss
	return,msgb0x(ahkexe:= (ahkexe:= splitpath(A_AhkPath)).fn
,	(_:= splitpath(A_scriptfullpath).fn " started @`n" a_scriptstarttime " in "
.	_:= a_tickcount -tickss " Ms"),4)
}

Refresh_Uptime_() {
	static sysup
	(!sysup? sysup:= Bootup_TImeDate(2))
	menu,tray,tip,% s:= "Sys-Uptime: " sysup "`nScript-Uptime: " scruptime:= TimeSub(a_now,A_SS)
	return,
}

Bootup_TImeDate(string1or2=1) {
	global SysUptime:= ""
	static _,
	regexneedle1:= "([\d\/]*)\,.([\d\:]*)"
	, regexneedle2:= "([\d\/]*)(?:\.[\d]*\+[\d]*)"
	, CMD1:= "systeminfo | find " . chr(34) . "System Boot Time" . chr(34)
	, Cmd2:= "wmic path Win32_OperatingSystem get LastBootUpTime"
	try,rxx:= stdOutStream(cmd%string1or2%,"StrmCallbk")
	rxx:= strreplace(rxx:= strreplace(rxx,"`r"),"`n")
		if(i:=(regexmatch(rxx,regexneedle%string1or2%,out)))
			return,SysUptime:= (TimeSub(A_now,out1))
		return,rxx
}

TimeSub(T_Post,T_Pre) {
	EnvSub,T_Pre,%T_Post%,Seconds ;System up time;
	p:=abs(T_Pre), res_str:=""
	((p>86400)? ( (p-=(daysecs:= (Days:= floor(p/86400)) *86400)), res_str .= Days . "Days, "))
	((p>3600)? ((p-=(hrsecs := (Hours:= floor((p)/3600))*3600)), res_str .= Hours . " Hours, "))
	((p>60)?( (p-=(minsecs:= (Mins:= floor((p)/60))*60)),res_str .= Mins . " Mins") : res_str.= p " Seconds.")
	return,res_str
}

pidGet(hwnd) {
	winget,pid,pid,Ahk_id %hwnd%
	return,pid
}

TopmostSET(hwnd) {
	listlines off
	return,DllCall("SetWindowPos","uint",hWnd,"uint",-1,"int","","int","","int","","int","","uint",16388)
}

CtlColor(Color, Handle) {
	Static CtlColorDB := {}
	((CtlColorDB[Handle])? hBM:= CtlColorDB[Handle]	: hBM:= DllCall("Gdi32.dll\CreateBitmap"
	,"Int",1,"Int",1,"UInt",1,"UInt", 24,"Ptr",0,"Ptr")	, hBM:= DllCall("User32.dll\CopyImage"
	,"Ptr",hBM,"UInt",0,"Int",0,"Int",0,"UInt",0x2008,"Ptr"), CtlColorDB[Handle]:= hBM)
	VarSetCapacity(BMBITS,4,0), Numput("0x" . Color,&BMBITS,0,"UInt")
	DllCall("Gdi32.dll\SetBitmapBits","Ptr",hBM,"UInt",3,"Ptr",&BMBITS)
	DllCall("User32.dll\SendMessage","Ptr",Handle,"UInt",0x172,"Ptr",0,"Ptr",hBM)
}

NotepadPlus(hw="",pid="") { ;proc on event of new created window the exact opposite of the past months
	listlines off
	if(!pid) {
		process,exist,notepad++.exe
		if(!pid:= Errorlevel) {
				winget,ll,list,ahk_class Notepad++
			if(!pid)
				winget,pid,pid,ahk_id %ll%
			if(!pid||ll1) {
				run,% "C:\Apps\np++_x86\notepad++.exe",,min,pid
				winwait,ahk_pid %pid% 10000
	}	}	}
	loop {
		winget,ll,list,ahk_class Notepad++
		if(ll)
			break,
		else,sleep,20
	}	winget,NPHw,id,pid %Pid%
	StatusBarWait,length,200000,2,ahk_id %NPHw%
	loop,{
		loop,% ll {
			ControlGet,ctrlhand,hWnd,,SysTabControl325,% "ahk_id " ll%A_Index%
			nPtabBar:= ctrlhand, parent:= ll%A_Index%
			if(!NPtabBar)
				sleep,20
			else,break
 		} if(!NPtabBar)
			tooltip,no ctrl handle %Pid%
		else,break,
	} p:= {},	p.ListTabs:= ""
	if(p.NPTabsOpen:= ControlGetTabs(NPtabBar)) {
	  Loop,% p.NPTabsOpen.Length()
		p.ListTabs.=p.NPTabsOpen[A_Index] ","
	} styleSet(parent,"-0x00400000"),	styleSet(parent,"+0x80800000")
	styleSet(NPtabBar,"-0x2000"),	styleSet(NPtabBar,"+0x40")
	ControlGet,Sci,hWnd,,Scintilla1,ahk_id %Parent%,Tab
	ControlGet,SBarhnd,hWnd,,msctls_statusbar321,ahk_id %Parent%,Tab
	;winget,stylep,style,ahk_id %parent%
	;winget,styletab,style,ahk_id %NPtabBar%
	;winget,stylesbar,style,ahk_id %sbarhnd%
	;winget,stylessci,style,ahk_id %sci%
	;winget,exstylep,exstyle,ahk_id %parent%
	;winget,exstyletab,exstyle,ahk_id %NPtabBar%
	;winget,exstylesbar,exstyle,ahk_id %sbarhnd%
	;winget,exStylessci,exStyle,ahk_id %sci%
	p.MainhWnd:=parent,			p.MainStyle:=		Stylep,		p.MainexStyle:=		exStylep
	,p.TabhWnd:=	NPtabBar,	 p.TabStyle:=		Styletab,	 p.TabexStyle:=		exStyletab
	, p.SbarhWnd:=sbarhnd,		p.SbarStyle:=	Stylesbar,	p.SbarexStyle:=	exStylesbar
	,  p.ScihWnd:=	sci,			 p.SciStyle:=	Stylessci,	 p.SciexStyle:=	exStylessci
	return,p ;	styleSet(NPtabBar,"+0x00000040")	;msgbox %  NPtabBar 
}

FireFoxCloseMenus() {
	listlines off
	Settitlematchmode,	2
	Settitlematchmode,	Slow
  DetectHiddenWindows,	On
	 DetectHiddenText,	On
	ass:=""
	Winget,li,list,ahk_exe firefox.exe ahk_class MozillaDropShadowWindowClass
	loop %li% {
		winclose,ahk_id 3li%a_index%
		max_i:= a_index
	} return,max_i
}

7Sidebar_ApplyTrans() {
	listlines off
	process,exist,% "sidebar.exe"
	spid:= errorlevel
	winget,hwnd,list,% "ahk_class 7 Sidebar ahk_pid" spid
	loop,% hwnd {
		trans(hwnd%a_index%,1)
		winset,exstyle,+0x00000020,% "ahk_id " hwnd%a_index%
		winset,style,-0x10000000,% "ahk_id " hwnd%a_index%
		winset,transparent,250,% "ahk_id " hwnd%a_index%
	}
	winget,hw0,id,% "ahk_class 7 SidebarMain ahk_pid" spid
	exstyle(hw0,+0x20) ; win_move(hw0,-10,-10,1,1) ;
	return,% errorlevel
}

SetAlpha(hwnd, alpha) { ;-- set alpha to a layered window 
    DllCall("UpdateLayeredWindow","uint",hwnd,"uint",0,"uint",0
	,"uint",0,"uint",0,"uint",0,"uint",0,"uint*",alpha<<16|1<<24,"uint",2)
}


Log_CNTActive(h) {
	listlines off
	ControlGetFocus,CF,ahk_id %h% ; 	return,!(CF="")? CF:"Null"
	return,CF? CF:"Null " WinClass("A")
}

SeXS(hwnd,style,exstyle) {
	listlines off
	loop,parse,% "Style,exStyle",`,
		winSet,% a_loopfield,% (%a_loopfield%)
	,% (!_:=instr(hwnd,",")? "ahk_id " hwnd : hwnd)
}

winTextSet( tXt,hWnd ) {
	listlines off
	if(IsChild(hWnd))
		 ControlSetText,,% tXt,ahk_id %g_hWnd%
	else,WinSetTitle,ahk_id %g_hWnd%,,% tXt
	return,errOrlevel
}

Iconchange_Check(handle,cl="",Pn="",TTl="") {
	global
	listlines,off
	if(icon_cl_arr[cl])&&!(icon_PN_arr[Pn])&&!(icon_tt_arr[TTl])
		(cl? act:= "cl")
	(Pn? act:= "pn")
	(ttl? act:= "tt")
	tt23=icon_%act%_arr
	if(%tt23%[%act%]) {
		Ico_arr_temp_:= %tt23%[%act%]
		if(instr(Ico_arr_temp_, " *") )
			StringTrimRight,filename,Ico_arr_temp_,2
		else,filename:= Ico_arr_temp_
		WindowIconSet(handle,filename)
		icon_clhw_arr.push(handle)
	}	return,
}

DWMAccentFix() {
	global
	listlines off
	return,mattdwmfix()
}

ShowBorder(hWnd,Duration:= 500,Color:= "0x3FBBE3", r:= 3) {  ; adopted from Winspy
	Local x,y,w,h,Index
	listlines off
	WinGetPos,x,y,w,h,ahk_id %hWnd%
	if !w
		return,
	g_Borders:= [] 	; round the corners, and add another brush*
	Loop,4 {
		Index:= A_Index + 90
		Gui,%Index%: +hWndhBorder -Caption +ToolWindow +AlwaysOnTop -dpiscale
		Gui,%Index%: Color,% Color
		g_Borders.Push(hBorder)
	}
	Gui,91:Show,% "NA x" (x - r) " y" (y - r) " w" (w + r + r) " h" r ; Top
	Gui,92:Show,% "NA x" (x - r) " y" (y + h) " w" (w + r + r) " h" r ; Bottom
	Gui,93:Show,% "NA x" (x - r) " y" y " w" r " h" h ; Left
	Gui,94:Show,% "NA x" (x + w) " y" y " w" r " h" h ; Right
	if (Duration != -1) {
		Sleep %Duration%
		Loop,4 {
			Index:= A_Index +90
			Gui,%Index%:Destroy
}	}	}

UIBANDCLASS_CHECK(class) {
	listlines off
	white:= class
	for,index,element in ouruibc
		if(element=white)
			return,1
	return,0
}

TRAYPIDpRESENT(PID_){
	listlines off
	FOR, I, IN  (TII  := TrayInfoGet())
		if ( PID_ = TII[i].PID)
			return,PID_ "Present @ pos " TII[i].idx " in " TII[i].sTray
		if ( new_PN = TII[i].process)
			return,new_PN " Present @ pos " TII[i].idx " in " TII[i].sTray
	return,0
}

TrayInfoGet(sExeName="") {
	listlines off
	oTrayInfo:= [] ;_:= A_DetectHiddenWindows ;DetectHiddenWindows,On; Needed if not present! ;DetectHiddenWindows,%_% at end
	For,key,sTray in ["Shell_TrayWnd", "NotifyIconOverflowWindow"]
	{
		WinGet,pidTaskbar,PID,ahk_class %sTray%
		hProc	:= dllcall("OpenProcess","UInt",0x38,"Int",0,"UInt",pidTaskbar)
		pRB		:= dllcall("VirtualAllocEx","Ptr",hProc,"Ptr",0,"uPtr",20,"UInt",0x1000,"UInt",0x04)
		szBtn	:= VarSetCapacity(btn,(A_Is64bitOS? 32 : 20),0)
		szNfo	:= VarSetCapacity(nfo,(A_Is64bitOS? 32 : 24),0)
		szTip	:= VarSetCapacity(tip,128 *2,0)
		idxTB	:= TrayIcon_GetTrayBar(sTray)
		SendMessage,0x0418,0,0,ToolbarWindow32%idxTB%,ahk_class %sTray% ;TB_BUTTONCOUNT=0x0418;
		Loop,% TB_BUTTONCOUNT:= errOrlevel {
			SendMessage,0x0417,a_iNdex-1,pRB,ToolbarWindow32%idxTB%,ahk_class %sTray% ;TB_GETBUTTON=0x0417;
			dllcall("ReadProcessMemory","Ptr",hProc,"Ptr",pRB,"Ptr",&btn,"uPtr",szBtn,"uPtr",0)
			dwData	:= NumGet(btn,(A_Is64bitOS? 16 : 12),"UPtr")
			iString	:= NumGet(btn,(A_Is64bitOS? 24 : 16),"Ptr" )
			dllcall("ReadProcessMemory","Ptr",hProc,"Ptr",dwData,"Ptr",&nfo,"uPtr",szNfo,"uPtr",0)
			uId		:= NumGet(nfo,(A_Is64bitOS?  8 :  4),"UInt")
			msgId	:= NumGet(nfo,(A_Is64bitOS? 12 :  8),"UPtr")
			hIcon	:= NumGet(nfo,(A_Is64bitOS? 24 : 20),"Ptr" )
			hWnd	:= NumGet(nfo,0,"Ptr")
			WinGet,sPN,ProcessName,	ahk_id %hWnd%
			WinGetClass,sClass,		ahk_id %hWnd%
			WinGet,nPid,PID,		ahk_id %hWnd%
			if(!sExeName || sExeName==sPN || sExeName==nPid) {
				dllcall("ReadProcessMemory","Ptr",hProc,"Ptr",iString,"Ptr",&tip,"uPtr",szTip,"uPtr",0)
				oTrayInfo.Push({"idx"	:a_iNdex-1
							, "idcmd"	:idCmd
							, "pid"		:nPid
							, "uid"		:uId
							, "msgid"	:msgId
							, "hicon"	:hIcon
							, "hWnd"	:hWnd
							, "class"	:sClass
							, "process"	:sPN
							, "tooltip"	:StrGet(&tip,"UTF-16")
							, "tray"	:sTray })
		}	}
		dllcall("VirtualFreeEx","Ptr",hProc,"Ptr",pRB,"UPtr",0,"UInt",0x8000)
		dllcall("CloseHandle","Ptr",hProc)
	}
	return,oTrayInfo
}

StyleDetect(hwnd,Style_xList,XTitle,XtitlesArray) {
	listlines off
	if (InStr(Style_xList, XTitle)) {
		for index, value in XtitlesArray
		{
			if (InStr(value, XTitle)) {
				retpos	:= RegExMatch(value, "(\µ)\K(.*)",	ret_class,   p0s := 1)
				retpos	:= RegExMatch(value, "^0.{9}",		ret_style,   p0s := 1)
				retpos	:= RegExMatch(value, "(\»)\K(.{10})",ret_exstyle, p0s:= 1)
				winset,Style,  % ret_style,  % "ahk_id" hwnd
				winset,ExStyle,% ret_exstyle,% "ahk_id" hwnd
				msgbox,% ( XTitle . " detected`n" . ret_style . "`n" . ret_exstyle )
				return,1
	}	}	}
	return,0
}

runlabel(VarString, hide="") {
	listlines off
	static hidestatic := "Hide"
	if hide	;  "Mag_CleanME\/DWMFixS\/PConfig\/WMPRun" etc
		hid := hidestatic
	if (InStr(VarString, "\/")) {
		loop, parse, VarString, "\/",
		{
			run,% VarString,,% hid
			if errOrlevel
				return,0
		}
		return,1
	} else {
		run,% VarString,,% hid
		if   !errOrlevel
			 return,1
		else,return,0
}	}
														; stylecompare(hwnd,styl,xstyl) {
stylecompare(hwnd,styl,xstyl) {							;   winget, style,   style,   ahk_id %hwnd%
	listlines off
	winget,style,  style,  ahk_id %hwnd%				;   winget, exstyle, exstyle, ahk_id %hwnd%
	winget,exstyle,exstyle,ahk_id %hwnd%				;   if  !(  style  = styl)
	(!(style=styl) ? sm1:= True : sm1:= False)			;		sm1   := False
	(!(style=sty2) ? sm2:= True : sm2:= False)			;   else,	sm1   := True
	if   !(sm1||sm2)									;   if  !(exstyle  = xstyl)
		 return,False									;   		sm2   := False	 ; if !(sm1||sm2)
		 return,True									;   else,	sm2   := True	  ;	return,False
}														; } -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--

styleget(hwnd) {
	listlines off
	winget,style,  style,  ahk_id %hwnd%
	return,style
}

BlurGl(hWnd) {
	listlines off
	ACCENT_DISABLED:= 0, ACCENT_ENABLE_GRADIENT:= 1, ACCENT_ENABLE_TRANSPARENTGRADIENT:= 2
	ACCENT_ENABLE_BLURBEHIND:= 3, ACCENT_INVALID_STATE:= 4, WCA_ACCENT_POLICY:= 19

	accentStructSize := VarSetCapacity(AccentPolicy, 4*4, 0)
	NumPut(ACCENT_ENABLE_BLURBEHIND, AccentPolicy, 0, "UInt")

	padding := A_PtrSize == 8 ? 4 : 0
	VarSetCapacity(WindowCompositionAttributeData, 4 + padding + A_PtrSize + 4 + padding)
	NumPut(WCA_ACCENT_POLICY, WindowCompositionAttributeData, 0, "UInt")
	NumPut(&AccentPolicy, WindowCompositionAttributeData, 4 + padding, "Ptr")
	NumPut(accentStructSize, WindowCompositionAttributeData, 4 + padding + A_PtrSize, "UInt")

	DllCall("SetWindowCompositionAttribute", "Ptr", hWnd, "Ptr", &WindowCompositionAttributeData)
}

ChildWindowFromPoint(hWnd,x,y) { ;;https://msdn.microsoft.com/en-us/library/windows/desktop/ms632676(v=vs.85).aspx
	return Format("{:#x}", DllCall("ChildWindowFromPoint", "int", hWnd, "int", x, "int", y))
}

InvertCol(hw)                  { ; not working
	listlines off
	hTarget 	:= hw
	if (hTarget = hTargetPrev)  {
		hTargetPrev := ""
		count--
		return,
	}
	count++
	hTargetPrev := hTarget
	if (hgui = "") {
		DllCall("LoadLibrary", "str", "magnification.dll")
		DllCall("magnification.dll\MagInitialize")

		VarSetCapacity(MAGCOLOREFFECT, 100, 0)
		Loop, Parse, Matrix, |
		NumPut(A_LoopField, MAGCOLOREFFECT, (A_Index - 1) * 4, "Float")
		loop 2     {
			if (A_Index = "2")
				gui, %A_Index%: +AlwaysOnTop ; needed for ZBID_UIACCESS
			gui, %A_Index%: +hwndhgui%A_Index% -DPIScale +toolwindow -Caption +E0x02000000 +E0x00080000 +E0x20 ; WS_EX_COMPOSITED := E0x02000000 WS_EX_LAYERED := E0x00080000 WS_EX_CLICKTHROUGH := E0x20
			hChildMagnifier%A_Index% := DllCall("CreateWindowEx", "Uint", 0, "str", "Magnifier", "str", "MagnifierWindow", "Uint", WS_CHILD := 0x40000000, "Int", 0, "Int", 0, "Int", 0, "Int", 0, "ptr", hgui%A_Index%, "Uint", 0, "Ptr", DllCall("GetWindowLong" (A_PtrSize=8 ? "Ptr" : ""), "Ptr", hgui%A_Index%, "Int", GWL_HINSTANCE := -6 , "Ptr"), "Uint", 0, "Ptr")
			DllCall("magnification.dll\MagSetColorEffect", "Ptr", hChildMagnifier%A_Index%, "Ptr", &MAGCOLOREFFECT)
	}	}
	gui, 2: Show, NA ; needed for removing flickering
	hgui := hgui1
	hChildMagnifier := hChildMagnifier1
	loop, {
		if (count != 1) { ; target window changed
			if (count = 2)
				count--
			WinHide, ahk_id %hgui%
			return,
		}
		VarSetCapacity(WINDOWINFO, 60, 0)
		if ((DllCall("GetWindowInfo", "Ptr", hTarget, "Ptr", &WINDOWINFO) = 0) and (A_LastError = 1400)) { ; destroyed
			count--
			WinHide, ahk_id %hgui%
			return,
		}
		if ((NumGet(WINDOWINFO, 36, "Uint") & 0x20000000) or !(NumGet(WINDOWINFO, 36, "Uint") & 0x10000000)) { ; minimized or not visible
			if (wPrev != 0) {
				WinHide, ahk_id %hgui%
				wPrev := 0
			}
			sleep, 2
			continue
		}
		x:= NumGet(WINDOWINFO, 20, "Int")
		y:= NumGet(WINDOWINFO, 8, "Int")
		w:= NumGet(WINDOWINFO, 28, "Int") - x
		h:= NumGet(WINDOWINFO, 32, "Int") - y
		if (hgui = hgui1) and ((NumGet(WINDOWINFO, 44, "Uint") = 1) or (DllCall("GetAncestor", "Ptr", WinExist("A"), "Uint", GA_ROOTOWNER := 3, "Ptr") = hTarget)) ; activated
		{
			hgui := hgui2
			hChildMagnifier := hChildMagnifier2
			WinMove, ahk_id %hgui%,, x, y, w, h
			WinMove, ahk_id %hChildMagnifier%,, 0, 0, w, h
			settimer 1, -20
			settimer 2, -20
			settimer 3, -20
			hidegui := hgui1
		} else, 
		if (hgui = hgui2) and (NumGet(WINDOWINFO, 44, "Uint") != 1) and ((hr := DllCall("GetAncestor", "Ptr", WinExist("A"), "Uint", GA_ROOTOWNER := 3, "ptr")) != hTarget) and hr ; deactivated
		{
			hgui:= hgui1
			hChildMagnifier:= hChildMagnifier1
			WinMove, ahk_id %hgui%,, x, y, w, h
			WinMove, ahk_id %hChildMagnifier%,, 0, 0, w, h
			DllCall("SetWindowPos", "ptr", hgui, "ptr", hTarget, "Int", 0, "Int", 0, "Int", 0, "Int", 0, "Uint", 0x0040|0x0010|0x001|0x002)
			DllCall("SetWindowPos", "ptr", hTarget, "ptr", 1, "Int", 0, "Int", 0, "Int", 0, "Int", 0, "Uint",    0x0040|0x0010|0x001|0x002) ; some windows can not be z-positioned before setting them to bottom
			DllCall("SetWindowPos", "ptr", hTarget, "ptr", hgui, "Int", 0, "Int", 0, "Int", 0, "Int", 0, "Uint", 0x0040|0x0010|0x001|0x002)
			settimer,1,-20
			settimer,2,-20
			settimer,3,-20
			hidegui := hgui2 
		} else,if(x!=xPrev)||(y!=yPrev)||(w!=wPrev)||(h!=hPrev) { ; location changed
			WinMove,ahk_id %hgui%,,x,y,w,h
			WinMove,ahk_id %hChildMagnifier%,,0,0,w,h
			settimer,1,-20
			settimer,2,-20
			settimer,3,-20
		}
		if (A_PtrSize=8) {
			VarSetCapacity(RECT,16,0)
			NumPut(x,RECT,0,"Int")
			NumPut(y,RECT,4,"Int")
			NumPut(w,RECT,8,"Int")
			NumPut(h,RECT,12,"Int")
			DllCall("magnification.dll\MagSetWindowSource", "ptr", hChildMagnifier, "ptr", &RECT)
		} 
		else, 	DllCall("magnification.dll\MagSetWindowSource", "ptr", hChildMagnifier, "Int", x, "Int", y, "Int", w, "Int", h)
		xPrev := x, yPrev := y, wPrev := w, hPrev := h
		if hidegui {
			WinHide, ahk_id %hidegui%
			hidegui := ""
	}	}
	return,
	
	1:
	gui, 2:  Show, NA ; needed for removing flickering
	return,
	2:
	WinShow, ahk_id %hChildMagnifier%
	return,
	3:
	WinShow, ahk_id %hgui%
	return,
}

SzWin(sZ,hWn="",center="") {
	static MidX:= a_screenwidth *.5, MidY:= a_screenheight *.5
	,HAg_Tsk:= A_screenheight -54
	siZ:= sZ, (hWn=""?hWn:= WinExist("A"))	;(instr(sZ,"center"))? sZ:= strreplace(sZ,"center",""):()
	;(!(center="")? Center:= True)
	try,WActive:= wingetpos(hWn)
	if(!WActive)
		msgb0x("add")
	WActive.w-=12, WActive.h-=46
	switch,sZ {
		case,"quad","x4": (((WActive.h*4)<HAg_Tsk)
			?	(win_move(hWn,(center? (MidX-(((WActive.W *4)+12)*.5))
			:	(WActive.X)), (center? (MidY-(((WActive.h *4)+12)*.5))
			:	WActive.Y), (WActive.W *4)+12, (WActive.H *4) +46,""))
			:	retval:= "x3")
			return,((retval)? SzWin(retval,hWn,(center?True)):0)
		case,"triple","x3": (((WActive.h*3)<HAg_Tsk)
			?	(win_move(hWn,(center? (MidX-(((WActive.W*3)+12)*.5))
			:	(WActive.X)), (center? (MidY-(((WActive.h*3)+12)*.5))
			:	WActive.Y), (WActive.W*4)+12,  (WActive.H*4)+46,""))
			:	retval:= "x2")
			return,((retval)? SzWin(retval,hWn,(center?True)):0)
		case,"double","x2","2/1" : (((WActive.h*3)<HAg_Tsk)
			?	(win_move(hWn,((instr(siZ,"center")? (MidX-(((WActive.W*2)+12)*.5))
			:	(WActive.X))), (instr(siZ,"center")? (MidY-(((WActive.h*2)+12)*.5))
			:	WActive.Y), (WActive.W*2)+12, (WActive.H*2)+46,""))
			:	(instr(siZ,"center")? (retval:= "+50%") : (retval:= "x2")))
			return,(retval? SzWin(retval,hWn):0)
		case,"halve","half","1/2": (!(WActive.W<300||WActive.H<300)
			?	(win_move(hWn,((instr(siZ,"center")? (MidX-(((WActive.W*.5)+12)*.5))
			:	(WActive.X))), (instr(siZ,"center")? (MidY-(((WActive.h*.5)+12)*.5))
			:	WActive.Y), (WActive.W*.5)+12, (WActive.H*.5)+46,""))
			:	(instr(siZ,"center")? (retval:= "x3center") : (retval:= "x3")))
			return,
		case,"+10%" : win_move(hWn,WActive.X,WActive.Y,(WActive.W*1.1)+12,(WActive.H*1.1)+46,"")
		case,"-10%" : win_move(hWn,WActive.X,WActive.Y,(WActive.W*0.9)+12,(WActive.H*0.9)+46,"")
		case,"+50%" : win_move(hWn,WActive.X,WActive.Y,round(WActive.W*1.5)+12,round(WActive.H*1.5)+46,"")
		case,"-33%" : win_move(hWn,WActive.X,WActive.Y,round(WActive.W*0.777)+12,round(WActive.H*0.777)+46,"")
	} ratio_Longest:= (WActive.W>WActive.H
	? "Landscape" . ratio_Longest:= WActive.H/WActive.W
	: "portrait" . ratio_Longest:= WActive.W/WActive.H)
	loop,{
		 ((Accuracy:= (raw:= a_index *(1/ratio_Long)) -(rounded:= round(raw)))
		, < 0.05? denominator:= a_index, msgb0x("demoninatoir: " a_index "`nacc: " Accuracy))
		if(denominator||(a_index>20))
			return,(Denomintator? Denomintator:0)
}	}

DebugVarsGui() {
	(winexist("DebugVars.ahk")? winactivate("Running scripts") : runc(quote("C:\Program Files\Autohotkey13404\AutoHotkeyU64_UIA.exe") . " " . quote("C:\Script\AHK\- _ _ LiB\DebugVars.ahk")))
	try,menu,Tools_main,icon,% "AHK_Pip3_eXEcut0r",% "C:\Icon\256\ICON16802_1.ico",,48
}

menuTrayUndermouse() {
	global
	listlines off
	mousegetpos,x,y,hWnd
	wingetclass,Mclass,ahk_id %hWnd%
	if (Mclass="#32768") {
	TT("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy") ;lol
		return,1
}	}

MENSpunction() {
	global
	listlines off
	trayActiv:= True
	Menu,Tray,Show
	trayActiv:= False
}

fuckoff(ic0p4th="") {
	listlines off
	StringTrimLeft,icop4th,CopyOfData,2
	winWaitActive,ahk_class #32770
	Was_icOn2gui:=icon2msgb0x(icop4th)
	loop, parse,Was_icOn2gui,% ";",
		switch A_index {
			case "1":
				hParent :=a_loopfield
			case "2":
				i_handle:=a_loopfield
		}
	controlget,static1pos,hwnd,,static1,ahk_id %hParent%
	controlget,static2pos,hwnd,,static2,ahk_id %hParent%
	;sleep,300
	return,Was_icOn2gui
}

aerogChkREGEDIT(h) {
	listlines off
	if !(IsWindow(h))
		return,False
	(_:= Aero_BlurWindow(h)? a:= True)
	(regedit_dope(h)? d:= True)
	if (a && !d)
		return,"a not d"
	if (!a && d)
		return,"d not a"
	else if(!a&&!d)
		return,False
	return,True
}

aeroChk(h) {
	listlines off
	if(!(IsWindow(h)))
		return,False
	if(_:= Aero_BlurWindow(h))
	return,a:= True
}

regedit_dope(h) { ; tt(a_now "testing")
	Aero_BlurWindow(h)
	ControlGet,ctrlhand,hwnd,,SysListView321,ahk_id %h% 
	SendMessage, 0x1036, 0, 0x00000020,,ahk_id %ctrlhand% ; Fullrow Styleflag
	ControlGet,ctrlhand2,hwnd,,SysTreeView321,ahk_id %h%
	winset,Style,+0x00000200,ahk_id %ctrlhand2% ; Doublebuff Exstyleflag
}

ttp(TxT="",Ti="") {
	global dbgtt
	listlines off
	if(dbgtt) {
		tooltip,% TxT,
		if(!ti)
			 settimer,TT_Off,% ("-" . tt),
		else,settimer,TT_Off,% ("-" . ti),
}	}

FileListStrGen(abc="") {
	global
	listlines off
	adelim:= abc
	oldlist:= (!oldlist? FileListStr : oldlist.=FileListStr)
	settimer,FileListStrGen2,-500
	return,

	FileListStrGen2:
	if(oldlist=FileListStr) {
		Loop,parse,FileListStr,% ("ø")
			(A_Index=1? action:= A_LoopField : FileListStr:= A_LoopField)
		FileListStr_ar:= (StrSplit(FileListStr,"%adelim%"))
		, FileListStr:="", oldlist:="", FileCount:=""
		return,
	} else,oldlist:= FileListStr
	return,
}

pushclsl_(cls="") {
		global
	listlines off
		clst_max_I+= 1
	if (clst_max_I> 20)	{
		clst_max_I-= 1
		classeslast.removeat(1)	; pop da' head
	}
	return,classeslast.push(cls)
}

pushclsh_(hw_="") {
		global
	listlines off
		clht_max_I	+= 1
	if( clht_max_I	> 20 )	{
		clht_max_I	-= 1
		classhwlast.removeat(1)	;	pop da' head
	}
	return,classhwlast.push(hw_)
}

pushclsl2_(cls2="")	{
		global
	listlines off
	clst2_max_I	 += 1
	if( clst2_max_I > 20 )	{
		clst2_max_I -= 1
		CLsS_Last.removeat(1)	;	pop da' head
	}
	CLsS_Last.push(cls2)
}

pushclsh2_(hw_2="")	{
		global
	listlines off
		clht2_max_I	+= 1
	if( clht2_max_I > 20 )	{
		clht2_max_I -= 1
		clsShWnd_L2.removeat(1)	;	pop da' head
	}
	return,clsShWnd_L2.push(hw_2)
}

StripChars(str2strip) {
	listlines off
	(!instr(strpt, ";"))? () : return,ret:=0
	strpt:= StrReplace(str2strip, ".exe")
	(instr(strpt, ":")? strpt:= StrReplace(strpt, ":" , "c0L"))
	(instr(strpt, "+")? strpt:= StrReplace(strpt, "+" , "Plus"))
	(instr(strpt, ".")? strpt:= StrReplace(strpt, "." , "dot"))
	(instr(strpt, "-")? strpt:= StrReplace(strpt, "-" , "dash"))
	(instr(strpt, " ")? strpt:= StrReplace(strpt, " " , "_"))
	return,strpt
}

DPIMen() {
	listlines off
	static EM_SETSEL:= 0x00B1 ;editmode set selection (regedit address)
	if(!(s:= WineXist("ahk_Class RegEdit_RegEdit"))) {
		run,regedit
		try,s:= WineXist("ahk_Class RegEdit_RegEdit")
		catch,
			sleep,150
	}
	winactivate,ahk_id %s%
	sleep,330
	ControlGet,edithandle,hWnd,,Edit1,ahk_id %s%
	ControlClick,Edit1,ahk_id %s% ; working
	SendMessage,% EM_SETSEL,0,-1,Edit1,ahk_id %s%
	sleep,100
	sendinput,Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers{enter}
	return,
}

IsDPIAware() {
	listlines off
	mousegetpos,x,y,win
	success0:= dllcall("GetAwarenessFromDpiAwarenessContext","int", dllcall("GetThreadDpiAwarenessContext", "int", win, "ptr"),"int")
	success1:= dllcall("GetAwarenessFromDpiAwarenessContext","int", dllcall("GetWindowDpiAwarenessContext", "int", win, "ptr"),"int")
	success2:= dllcall("GetWindowDpiHostingBehavior", "int", win, "ptr")
	loop,parse,% "success0,success1",`,
	{	; success1 := dllcall("EnableNonClientDpiScaling", "int", win, "ptr")
		c:= a_loopfield
		switch %c% {
			Case -1 : %c%:= "DPI_AWARE_INVALID =-1"
			Case 0  : %c%:= "DPI_UNAWARE = 0"
							Choices=%c1%||%c2%|%c3%
			Case 1  : %c%:= "DPI_AWARENESS_SYS = 1"
						Choices=%c1%|%c2%||%c3%
			Case 2  : %c%:= "DPI_AWARENESS_PERMON = 2"
							Choices=%c1%|%c2%||%c3%
}	}	}

Toggle_SBar() {
	global SBAR_DISABLE
	listlines off
		SBAR_DISABLE:= !SBAR_DISABLE
		msgb0x("Sidsebar will be " (SBAR_DISABLE? "disabled" : "enabled") "ingame",3)
}

sbardisabletoggle()  {
	listlines off
	if(!SBAR_DISABLE) {
		if(winexist("ahk_exe sidebar.exe")) {
			run,% "C:\Apps\Kill.exe sidebar.exe",,hide
			SBAR_2berestored_True:= True, Sidebar:= False, Roblox:= True
		}
		SBAR_DISABLE:= True
		return,1
	} else {
		SBAR_Restore:
		if SBAR_DISABLE { ; if SBAR_2berestored_True {
			run,% SBarPath,, hide,
			timer("BEadZ",-1000)
			return,

			BEadZ:
			winget,SideBar_Handle,ID,% "HUD Time"
			Sidebar:= 1,SBAR_2berestored_True:= False
			winset,ExStyle,+0x20,% "ahk_id " SideBar_Handle
		}
		return,2
}	}

UIBPROCESS() {
	global
	listlines off
	for,index,element in ouruib_handles
	{
		if !Element
			return,
		if (DllCall(NumGet(NumGet(AppVisibility+0)+4*A_PtrSize), "Ptr", AppVisibility, "Int*", fVisible) >= 0) {
			if !(fVisible = 1)
				return,
			sleep,10
			send,{LWin}
			loop {
				if (DllCall("GetWindowBand", "ptr", element, "uint*", pdwBand) = 1)
				  if (pdwBand = ZBID_UIACCESS)
					break,
				else,tt(pdwBand)
				sleep,10
	}	}	}
	return,
}

mattdwmfix() {
	listlines off
	dllcall("dwmapi.dll\DwmEnableComposition","UInt",1,"int")
	dllcall("dwmapi.dll\DwmEnableComposition","UInt",0,"int")
	RegWrite,REG_DWORD,HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM,ColorizationColor,    0xff000000
	RegWrite,REG_DWORD,HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM,ColorizationAfterglow,0xff000000
	RegWrite,REG_DWORD,HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent,AccentColorMenu,0xff000000
	RegWrite,REG_DWORD,HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent,StartColorMenu, 0xff000000
	dllcall("dwmapi.dll\DwmEnableComposition","UInt",1,"int")
	dllcall("dwmapi.dll\DwmEnableComposition","UInt",0,"int")
	return,tt("DWM FIX")
}

Shell_Restart() {
	listlines off
	(A_DetectHiddenWIndows="")? oldDetect:= A_DetectHiddenWIndows,DetectHiddenWIndows,on
	PostMessage,0x12,,,,ahk_class Progman ; WM_QUIT
	loop,{
		Process,Exist,explorer.exe
		 pid:= errOrlevel
		(pid||(a_iNdex>40))=""? break
		while,(WineXist("ahk_pid " pid) != 0) {
			WinKill,ahk_pid %pid%
			sleep,200
			bBreak:= (a_iNdex>40)? break
		}
		ifNotEqual,bBreak,0,break
	}
	(oldDetect? (DetectHiddenWIndows,%oldDetect%))
	Run,explorer.exe,,,pid
	WinWait,ahk_class Shell_TrayWnd
	send,{SHIFT down}	;Disable start up group by holding shift.
	sleep,190
	send,{SHIFT up}
}

SetAcrylicGlassEffect(hwnd) {
	listlines off
	Static Init, accent_state:= 4
	Static Pad:= A_PtrSize=8 ? 4 : 0, WCA_ACCENT_POLICY:= 19
	accent_size:= VarSetCapacity(ACCENT_POLICY,200,0)
	NumPut(accent_state,ACCENT_POLICY,0,"Int")
	NumPut(0x77400020,ACCENT_POLICY,8,"Int")
	VarSetCapacity(WINCOMPATTRDATA,4 + Pad + A_PtrSize + 4 + Pad, 0)
	&& NumPut(WCA_ACCENT_POLICY,WINCOMPATTRDATA,0,"Int")
	&& NumPut(&ACCENT_POLICY,WINCOMPATTRDATA,4 + Pad,"Ptr")
	&& NumPut(accent_size,WINCOMPATTRDATA,4 + Pad + A_PtrSize, "Uint")
	if !(DllCall("user32\SetWindowCompositionAttribute","Ptr",hwnd,"Ptr",&WINCOMPATTRDATA))
		return,0
	return,1
}

Desktopinfo(byref a_labelz:="",byref main_hwnd:="",byref itemcount:="") { ; desktop List view returned by function
	listlines off
	WinGet,LL,List,ahk_class WorkerW
	loop,%LL% {  ; how many workerW classes, only one is DTOP-LVM
		controlget,desklistviewhnd,hwnd,,SysListView321,% "ahk_id " LL%A_Index%
		SendMessage,0x1004,0,0,,Ahk_ID %desklistviewhnd% ; get count of lvm
		if !(errOrlevel="FAIL") {
			itemcount:=  errOrlevel
			main_hwnd:=  LL%A_Index%
			SendMessage,x1037,0,0,,Ahk_ID %desklistviewhnd% ; 0x1037 lvm_get ex style
			lv_ex_style:= errOrlevel
			if (lv_ex_style &0x00020000) ; 0x00020000 = hidelabels
				desktop_icon_labels := False
			else,desktop_icon_labels:= True

			if !(a_labelz &&  desktop_icon_labels) {
				lv_ex_style += 0x00030000
				a_labelz:= "False" ;  False / 0 wouldnt show a discernable result
			}
			else,if(a_labelz && !desktop_icon_labels)
				lv_ex_style -= 0x00030000
			else {
				a_labelz:= "False"
				return,desklistviewhnd
			}
			a_labelz:= "False"
			SendMessage,0x1036,0,lv_ex_style,,ahk_id %desklistviewhnd%  ;set lvm ex style#
			return,desklistviewhnd ;, ;main_hwnd, itemcount, a_labelz
}	}	}

RZ_LOG() {
	listlines off
	coord_old:= A_CoordModePixel
	CoordMode,pixel,window
	WinGet, list_rzexe, List,ahk_exe RzSynapse.exe
	Loop,% (list_rzexe) {
		ss:= ("ahk_id " . list_rzexe%A_index%)
		winGet,Style,Style,% SS
		winGet,ExStyle,ExStyle,% SS
		if ((Style="0x16080000") && (ExStyle = "0x000C0000")) {
			winactivate,% ss
			send,^{a}
			send,%Log1_RZ%
			send,{tab}
			send,^{a}
			send,%Pa5s_RZ%
			PixelGetColor,color,219,326
			(!color=0x02DD02? def:="default snot saved" : SendKiLongnanme("{enter}"))
	}	}
	CoordMode,% coord_old ; !! below not used see anitray.ahk !!
} ; send a WM restart message to anitray.ahk after each logon +10 secs as the handles are swapped over the lengthy period of windows 10 post-login lag as it changes theme colors etc. ;

DPIhw_perform() { ;not working
	global	;global DPIhw__choic3
	listlines off
	gui,DPIhw: Submit,
	gui,DPIhw: Destroy,
	switch choice {
		Case "DPI_AWARENESS_UNAWARE" : DPIhw__choic3:= 0
		Case "DPI_AWARENESS_SYSTEM_AWARE" : DPIhw__choic3:= 1
		Case "DPI_AWARENESS_PER_MONITOR_AWARE" : DPIhw__choic3:= 2
	}
	code =
	(LTrim
		SetWorkingDir,%A_ScriptDir%
		#Include c:\script\ahk\Lib\MinHook.ahk
		value = %DPIhw__choic3%
		address_SetProcessDpiAwareness:= dllcall("GetProcAddress","Ptr",dllcall("GetModuleHandle","Str","Shcore","Ptr"),AStr,"SetProcessDpiAwareness","Ptr")
		hook1:= New MinHook("",address_SetProcessDpiAwareness,"SetProcessDpiAwareness_Hook")
		hook1.Enable()
		send,{LWin}
		return,
		SetProcessDpiAwareness_Hook(value) { ; dllcall("SetProcessDpiAwarenessContext","int",c,"int")
			global hook1
			return,dllcall(hook1.original,"int",value,"int") ; this wont work as there is no 3rd party setting-of dpi to procs function LOL
		}	
	)		
	msgbox,% -/8-9choice " Saved pref to Registry..."
	return,
}

check_ADMHOTKEY() {
	GLOBAL ADH
	listlines off
	if uiu:= wineXist(adh) ;"adminhotkeys.ahk - AutoHotkey"
		return,1
	return,0
}

aHkAeroDbg(method="") {
	global ahkaerodbg,Title_Last
	listlines off
	method=""? method:= "mb" : ()
	switch method {
		Case "mb" : msgb0x("AuthotkeyGUIClass`nTitlemaybelol: " Title_Last)
		Case "tt" : TT("aeroglass blacklist")
}	}

Taskbar_GetHandle() {
	listlines off
	ControlGet,hParent,hWnd,,MSTaskSwWClass1, ahk_class Shell_TrayWnd
	ControlGet,h,List ,Count,ToolbarWindow322,ahk_id %hParent%
	return,h
}

eXstyleset(hWNd,eXstyle) {
	listlines off
	winset,eXstyle,%eXstyle%,ahk_id %hWNd% 
	return,!errorlevel
}

styleset(hWNd,style) {
	listlines off
	winset,style,%style%,ahk_id %hWNd%
}

exstyle(hwnd,exstyle) {
	listlines off
	winset,exstyle,%exstyle%,ahk_id %hwnd%
}

transpset(hWNd,val) {
	listlines off
	winset,transparent,%val%,ahk_id %hWNd%
}

StyleMenu_Showindow(hWnd,nCmdShow:= 1) {
	listlines off
	return,dllcall("StyleMenu_Showindow","Ptr",hWnd,"Int",nCmdShow)
}

GetClassLong(hWnd, Param) {
	listlines off
	Static GetClassLong:= A_PtrSize==8? "GetClassLongPtr" : "GetClassLong"
	return,DllCall(GetClassLong, "Ptr", hWnd, "Int", Param)
}

GetWindowLong(hWnd, Param) { ;GetWindowLong:= A_PtrSize==8? "GetWindowLongPtr" : "GetWindowLong"
	listlines off
	return,DllCall("GetWindowLong", "Ptr", hWnd, "Int", Param)
}

GetAncestor(hWnd,gaFlags="2") {						   ;GA_PARENT	= 1 (Ret parent. same as GetParent() func.)
	listlines off
	return,DllCall("GetAncestor","int",hWnd,"uint",gaFlags,"uint") ;GA_ROOT	  = 2 (Ret walking the chain of parent windows -> 2-root-window) :DEFAULT:
}														 ;GA_ROOTOWNER = 3 (Ret owned root window by fully descending the tree of Ancestry)

IsChild(hWnd) {
	listlines off
	winget,Style,Style,ahk_id %hWnd%
	return,Style &0x40000000 ;WS_Child
}

GetParent(hWnd) {
	listlines off
	return,dllcall("GetParent","Ptr",hWnd,"Ptr")
}

IsWindow(hWnd) {
	listlines off
	return,dllcall("IsWindow","Ptr",hWnd)
}

IsWindowEnabled(hWnd) {
	listlines off
	return,dllcall("IsWindowEnabled","Ptr",hWnd)
}

IsWindowVisible(hWnd) {
	listlines off
	return,dllcall("IsWindowVisible","Ptr",hWnd)
}

WinActivate(byref wintitleliteral="") {
	listlines off
	winactivate,% wintitleliteral
}

_windowclose(hWnd) {
	listlines off
	winclose,% h:= (instr(hwnd,"ahk_")? hwnd : "ahk_id " hwnd)
}

dtopWinKidnap(Child="") {
	global A_new_hWnd,dtopchildren
	listlines off
	( Child=""? Child:= A_new_hWnd ) ; stylemen invoked
	WinGetPos,ChildX,ChildY,Child_W,Child_H,ahk_id %Child%
	;winget,style,style,ahk_id %Child%
	;winget,exstyle,exstyle,ahk_id %Child%
	; Surrogate:= "" 
	;winset,style, -0x80000000,ahk_id %Child%
	winset,exstyle,-0x90088,ahk_id %Child%
	DllCall("SetParent","ptr",Child,"ptr",	Surrogate:= DesktoP())
	ssleep(120)
	WinMove,ahk_id %Child%,%ChildX%,%ChildY%,%Child_W%,%Child_H%
	win_move(child,"","",child_w+1,Child_h+1)
	winset,exstyle,-0x90088,ahk_id %Child%
	winset,style,+0xc0000000,ahk_id %Child%
	winset,style,-0x4c0000,ahk_id %Child%
}

Window2Dtop2(byref Child=""){
	global hgui,dtopchildren
	listlines off
	( !Child? Child:= hgui ) ; stylemen invoked
	WinGetPos,ChildX,ChildY,Child_W,Child_H,ahk_id %Child%
	Surrogate:= DesktoP()
	winset style,0x16AC0000,ahk_id %Child%
	winset exstyle,0x000C4195,ahk_id %Child%
	DllCall("SetParent","ptr",Child,"ptr",Surrogate)
	WinMove,ahk_id %Child%,,(%ChildX%)+1,%ChildY%,%Child_W%,%Child_H%
	;win_move(child,"","",child_w+10,Child_h+10)
	return,
}

DTopWinRelease(byref Child="") {
	listlines off
	DllCall("SetParent","ptr",Child,"ptr",0,"uint")
	; DllCall("SetParent","ptr",Child,"str","HWND_MESSAGE")
	winset,style,+0xcc0000,ahk_id %Child%
	winrestore,ahk_id %Child%
}

; ICO2hicon(Desired_ico) {
	; VarSetCapacity(fileinfo,A_PtrSize + 688)
	; if dllcall("shell32\SHGetFileInfoW","WStr",Desired_ico,"UInt",0,"Ptr",&fileinfo,"UInt",A_PtrSize+688,"UInt",0x100)
		; return,NumGet(fileinfo,0,"Ptr")
; }

Icon_Load2(sBinFile,sResName,nWidth) {
	listlines off
	if (sBinFile<0)
		hLib:= 0
	else {	; if DLL isn't already loaded, load it as a data file.
		if(!hLib:= DllCall( "GetModuleHandle","Ptr",(sBinFile?&sBinFile:0))) {
			if( !hLib:= DllCall( "LoadLibraryEx","Str",sBinFile,"Ptr",0,"UInt",0x2 ))
				return,-1, errOrlevel:= "LoadLibraryEx error`nreturn value = " hLib "`nLast error = " A_LastError
			bLoaded:= 1
	}	}
	try {
		if(DllCall("LoadIconWithScaleDown","Ptr",hLib,"Ptr",sResName+0==sResName? sResName : &sResName
			, Int,nWidth,Int,nWidth,PtrP,hIcon) != 0 ) ; S_OK = 0
			return,-1,errOrlevel:= "LoadIconWithScaleDown error`nreturn value = " e
	}
	finally,
		(!bLoaded=""? DllCall("FreeLibrary",Ptr,hLib) : ())
	return,hIcon
}

minHoldr_pid_Found(str) {	;need2 do a minholdr class
	global minholdr
	listlines off
	loop,parse,str,% ";",
		switch a_index  {
			case "2" : minHoldr_DELETE(a_loopfield)
}		}

minHoldr_DELETE(unc) {
	global minholdr
	listlines off
	for,i,element in minholdr
		if (unc=minholdr[i].pth)
		 minholdr.delete(i)
}

minholdr_predel(str) {
	global minholdr
	listlines off
	loop,parse,str,% ";",
		switch a_iNdex {
			Case "2" : minholdr_del(a_loopfield)
}		}

minholdr_del(unc) {
	global minholdr
	listlines off
	for,i,element in minholdr
		if (unc=minholdr[i].pth)
		 minholdr.delete(i)
}

sendKi(key) {
	listlines off
	send,% key
}

Send_WM_COPYDATA(ByRef StringToSend, ByRef TargetScriptTitle) {
	listlines off
	VarSetCapacity(CopyDataStruct,3* A_PtrSize,0)
	SizeInBytes:= (StrLen(StringToSend) +1) *(A_IsUnicode? 2:1)
	NumPut(SizeInBytes,CopyDataStruct,A_PtrSize)
	NumPut(&StringToSend,CopyDataStruct,2*A_PtrSize)
	Prev_DetectHiddenWindows:= A_DetectHiddenWindows,	Prev_TitleMatchMode := A_TitleMatchMode
	DetectHiddenWindows,On
	SetTitleMatchMode,2
	TimeOutTime:= 2700
	SendMessage,0x4a,0,&CopyDataStruct,,% TargetScriptTitle,,,,% TimeOutTime
	DetectHiddenWindows %Prev_DetectHiddenWindows%
	SetTitleMatchMode %Prev_TitleMatchMode%
	return,errOrlevel
}

; Receive_WM_COPYDATA(byref wParam,byref lParam) {
	; global minholdr
	; ((!(CopyOfData:= StrGet(NumGet(lParam+2*A_PtrSize)))? msgb0x("Empty wm rec copydata")))
	;;tt("RX:`n" CopyOfData ) ; tooltip % (CopyOfData " recvd")
	; if(instr(CopyOfData,"Þ")) {
		; if(!FileListStr) {
			; FileListStr:=CopyOfData, FileCount:=1
		; } else,FileListStr:= (FileListStr . CopyOfData), FileCount:= (FileCount +1)
		; FileListStrGen(Delimiter:="Þ")
	; }
	; else,if(CopyOfData = "StyleMenu")
		; settimer,Stylemenu_init, -1
	; else,if(instr(CopyOfData,"Tray_"))
		; settimer,Trayiconmenu,-1
	; else,if(instr(CopyOfData,"TrayRemove"))
		; minHoldr_pid_Found(CopyOfData)
	; else,(islabel(CopyOfData)? Timer((CopyOfData),-1))
	; return,True
; }


Receive_WM_COPYDATA(byref wParam,byref lParam) {
	global minholder,Cata,CopyOfData
	listlines off
	CopyOfData := (StrGet(NumGet(lParam + 2*A_PtrSize)))
	settimer,WM_COPYDATA_1,-1
	return,1
}

SPI_ICONSPACINGSET(hx,vy) { ;To set this value, set uiParam to the new value and set pvParam to NULL. You cannot set this value to less than SM_CXICON.
	listlines off
	DetectHiddenWindows,On
	SetTitleMatchMode,2
	a:= DllCall("SystemParametersInfoA","UInt",0x000D,"UInt",hx,"UInt",0,"UInt",1,"UInt") ;144dpi
	b:= DllCall("SystemParametersInfoA","UInt",0x0018,"UInt",vy,"UInt",0,"UInt",1,"UInt") ;vertical
	if(!a||!b)
		return,0
	return,1
}

Toggle_dbg() {
	global  dbg
	listlines off
		if(!dbg) {
			dbg:= True
			#KeyHistory 900
			menu,tray, check,% "Toggle debug"
		} else {
			#KeyHistory 0
			menu,tray,uncheck,% "Toggle debug"
			dbg:= False
		}
		return,
}

DestroyAnims() {
	global AniPid
	listlines off
	for,index,element in AniPid
		Process,Close,% element
}

Acc_Init() {
	listlines off
	static h
	(!h? h:=DllCall("LoadLibrary","Str","oleacc","Ptr"))
}

Acc_ObjectFromWindow(hWnd, idObject:=0) {
	listlines off
	Acc_Init()
	if DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd, "UInt", idObject&=0xFFFFFFFF, "Ptr", -VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0
	return,ComObjEnwrap(9,pacc,1)
}

Acc_Query(Acc) {
	listlines off
	try,return,ComObj(9, ComObjQuery(Acc,"{618736e0-3c3d-11cf-810c-00aa00389b71}"), 1)
}

Acc_Children(Acc) {
	listlines off
	if ComObjType(Acc,"Name") != "IAccessible"
		errOrlevel:="Invalid IAccessible Object"
	else {
		Acc_Init(), cChildren:=Acc.accChildCount, Children:=[]
		if DllCall("oleacc\AccessibleChildren", "Ptr",ComObjValue(Acc), "Int",0, "Int",cChildren, "Ptr",VarSetCapacity(varChildren,cChildren*(8+2*A_PtrSize),0)*0+&varChildren, "Int*",cChildren)=0 {
			Loop %cChildren% ; lOOP over Children
				i:=(A_Index-1)*(A_PtrSize*2+8)+8, child:=NumGet(varChildren,i), Children.Insert(NumGet(varChildren,i-8)=9?Acc_Query(child):child), NumGet(varChildren,i-8)=9?ObjRelease(child):
			return Children.MaxIndex()?Children:
		} else, errOrlevel := "AccessibleChildren DllCall Failed"
}	}

SetImg(hwnd,hBitmap) { ; Example:Gui,Add,Text,0xE w500 h300 hwndhPic 	 ;STM_SETIMAGE=0x172 ;SS_Bitmap=0xE
	listlines off
	Static Ptr := "UPtr" ;sendmessage,0x172,1,hBitmap,,ahk_id %hwnd% ; msgbox,% hwnd ;sendmessage,0x0170,0xE,,,ahk_id %hParent%
	((!hBitmap||!hwnd)? return()) ; sendmessage,0x172,hBitmap,,,ahk_id %hwnd% ;msgbox % errorlevel " test"
	E := DllCall("SendMessage", "Ptr", hwnd, "UInt", 0x172, "UInt", 0x1, "Ptr", hBitmap)
	DelObj(E)
	return,e
}

DelObj(hObject) {
	listlines off
	return,DllCall("DeleteObject", "UPtr", hObject)
}

	; if !dbg {
	; dbg	:=	True
	; listlines on
	; #KeyHistory 900
	; menu, tray, check,   Toggle debug,
; } else {
	; listlines off
	; #KeyHistory 0
	; menu, tray, uncheck, Toggle debug,
	; dbg	 :=	 False
; }
; return,

; 	A string may be sent via wParam or lParam by specifying the address of a variable.
;	The following example uses the address operator (&) to do this:
; 	SendMessage, 0x000C, 0, &MyVar, ClassNN, WinTitle  ; 0x000C is WM_SETTEXT

	;;--=---=--=--=--=--=--=Gui Movement-=---=--=--=--=--=--=
; WM_LBUTTONDOWN(wParam, lParam) 						{
	; global
	; static init := OnMessage(0x201, "WM_LBUTTONDOWN")
	; WinGetActiveStats, Title, rw, rh, wXs, wYs
	; coord_old := A_CoordModeMouse
	; coordmode,  mouse, relative
	; xs := lParam & 0xffff
	; ys := lParam >> 16
		; While	GetKeyState("lbutton","P") {
		; DllCall("GetCursorPos","Uint",&mpos_rect)
		; vWinX := (NumGet(&mpos_rect, 0, "Int") - xs - 29)
		; vWinY := (NumGet(&mpos_rect, 4, "Int") - ys - 36)
		; win_move(windle, vWinX, vWiny, rw, rh)
 	; }
	; rc:=""
	; coordmode, mouse,% coord_old
; }
	;--=---=--=--=--=--=--=Gui Movement-=---=--=--=--=--=--=

; WM_RBUTTONDOWN(wParam, lParam) {
; global
; static init := OnMessage(0x0204, "WM_RBUTTONDOWN")
	; WinGetActiveStats, Title, rw, rh, wXs, wYs
	; coord_old := A_CoordModeMouse
	; coordmode,  mouse, relative
	; xs := lParam & 0xffff
	; ys := lParam >> 16
	; While	GetKeyState("rbutton","P") {
		; DllCall("GetCursorPos","Uint",&mpos_rect)
		; vWinX := (NumGet(&mpos_rect, 0, "Int") - xs - 29)
		; vWinY := (NumGet(&mpos_rect, 4, "Int") - ys - 36)
		; win_move(windle, vWinX, vWiny, rw, rh)
 	; }
	; rc:=""
	; coordmode, mouse,% coord_old
; }
;------------==========================++++++++++++++++++++*+*+*+*

;------------==========================++++++++++++++++++++*+*+*+*

; /*  ; Notes for popup: NP++; ahk_id 0x2e1120 PID: 8332; process name AutoHotkey.exe; Title Get Parameters; AHK_Class AutoHotkeyGUI; Style / ExStyle 0x940A0000 - 0x00000088; Control Edit1 C_hwnd: 0x130c78 ; Style / ExStyle 0x50010080 - 0x00000200
; ID_TRAY_OPEN := 65300
; ID_FILE_RELOADSCRIPT := 65400 ;ID_TRAY_RELOADSCRIPT := 65303
; ID_FILE_EDITSCRIPT := 65401 ;ID_TRAY_EDITSCRIPT := 65304
; ID_FILE_WINDOWSPY := 65402 ;ID_TRAY_WINDOWSPY := 65302
; ID_FILE_PAUSE := 65403 ;ID_TRAY_PAUSE := 65306
; ID_FILE_SUSPEND := 65404 ;ID_TRAY_SUSPEND := 65305
; ID_FILE_EXIT := 65405 ;ID_TRAY_EXIT := 65307
; ID_VIEW_LINES := 65406
; ID_VIEW_VARIABLES := 65407
; ID_VIEW_HOTKEYS := 65408
; ID_VIEW_KEYHISTORY := 65409
; ID_VIEW_REFRESH := 65410
; ID_HELP_USERMANUAL := 65411 ;ID_TRAY_HELP := 65301
; ID_HELP_WEBSITE := 65412
; */

;Modify as necessary: 	Uncomment the appropriate line below or leave them all commented to reset to the default of the current build.
;	codepage := 0		; System default ANSI codepage
;	codepage := 65001	; UTF-8
;	codepage := 1200	 ; UTF-16
;	codepage := 1252	 ; ANSI Latin 1; Western European (Windows)
;	if (codepage != "")
;		codepage := " /CP" . codepage
;	cmd="%A_AhkPath%"%codepage% "`%1" `%*
;	key=AutoHotkeyScript\Shell\Open\Command
;	if A_IsAdmin	; Set for all users.
;		RegWrite, REG_SZ, HKCR, %key%,, %cmd%
;	else,			; Set for current user only.
;	 RegWrite, REG_SZ, HKCU, Software\Classes\%key%,, %cmd%
;	;----;

; DllCall("kernel32.dll\SetProcessShutdownParameters", "Uint", 0x4FF, "Uint", 0)
; OnMessage(0x0011, "WM_QUERYENDSESSION")
; return,	; The above DllCall is optional: it tells the OS to shut down this script first (prior to all other applications).

; WM_QUERYENDSESSION(wParam, lParam){
	; ENDSESSION_LOGOFF := 0x80000000
	; if (lParam & ENDSESSION_LOGOFF)  ; User is logging off.
		; EventType := "Logoff"
	; else,  ; System is either shutting down or restarting.
		; EventType := "Shutdown"
	; try { ; Set a prompt for the OS shutdown UI to display.  We do not display		; our own confirmation prompt because we have only 5 seconds before		; the OS displays the shutdown UI anyway.  Also, a program without		; a visible window cannot block shutdown without providing a reason.
		; BlockShutdown("Example script attempting to prevent " EventType ".")
		; return,false
	; }	catch	{
		; MsgBox, 4,, %EventType% in progress.  Allow it?; ShutdownBlockReasonCreate is not available, so this is probably
		; IfMsgBox Yes		; Windows XP, 2003 or 2000, where we can actually prevent shutdown.

			; return,true  ; Tell the OS to allow the shutdo
			;n/logoff to continue.
		; else
			; return,false  ; Tell the OS to abort the shutdown/logoff.
; }   }

; isdir(path) {
	; return,% (((fileexist(path))="D")?1:0)
; }

; isContainingPathopen(FullPath) { ; check containing folder of target, if target is folder result is the folders parent,
	; winget,Flist,list,ahk_Class CabinetWClass
	  ; if  !Flist
	   ; return,0
	; SplitPath,FullPath,,OutDir
	  ; ( isdir(FullPath) ? P:=OutDir : P:=FullPath )
		; loop,%Flist% {
		; id:=( Flist%a_index% )
		; ControlGetText, Txt,ToolbarWindow323,AHK_ID %id% ; explorer crumbs
		; if(p=strReplace(Txt,"Address: "))
			; return,id
		; }
	; return,0
; }

; go2File(hwnd,filename) {
	; ControlGet,cwnd,hwnd,,DirectUIHWND3,A
	; Acc:=Acc_ObjectFromWindow(cwnd)
	; For Each, child in Acc_Children(Acc) {	;; NONE=0, TAKEFOCUS=1, TAKESELECTION=2,
		 ;;   EXTENDSELECTION=4, ADDSELECTION=8,
		   ; if ((n:=child.accName(0))=filename)
		   ; {
				; child.accSelect(2,0)					;; REMOVESELECTION=16
				; msgb0x("success")
				; return,1
			; }
	; }	;}
	; return,0
; }

; OpenContaining(target_uncpath, HighlightDisabledonFile="") { ;-==-=-=-=-=^^^@::@::@^^^
	; if (fileExist(target_uncpath)) {  ; if !OutExtension
		; SplitPath, target_uncpath, OutFileName, OutDir, OutExtension
		; (isdir(target_uncpath) ? P:=OutDir : P:=FullPath)
		; (!HighlightDisabledonFile ? highlight_file := "/select ")
		; if (found:=isContainingPathopen(P) ) {
			; winactivate, ahk_id %found%
			;;WinWaitActive
			; go2File(found,OutFileName) ; takefocus-flag.needs elevation or uiaccess
		; }
		; else,run,% comspec " /C explorer.exe " . highlight_file . target_uncpath,, hide
		; winwait, ahk_Class CabinetWClass
		; e:=errOrlevel
		; found:=winexist()
		; wingettitle,Title,ahk_id %found%
		;;;(((OutDir=Title)&&(DllCall("IsWindowVisible","Ptr",found)))?(try,SendKiLongnanme("f5","")))
	; }
	; return,"Path?"
; }

; #a::
; gosub, ApplyMSStyles ; does nothing atm
; return,
; +#a::
; gosub, AeroTheme_Set ; does nothing atm
; return,

; BlockShutdown(Reason) { ; if your script has a visible gui, use it instead of A_Scripthwnd.
	; DllCall("ShutdownBlockReasonCreate", "ptr", A_Scripthwnd, "wstr", Reason)
	; OnExit("StopBlockingShutdown")
; }
; StopBlockingShutdown(){
	; OnExit(A_ThisFunc, 0)
	; DllCall("ShutdownBlockReasonDestroy", "ptr", A_Scripthwnd)
; }

;_window_mintraynew:
; s:="mintraynew;" . new_path . ";" . res_strutVarWin . ";" . new_PiD . ";" . new_tt
; eee:= Send_WM_COPYDATA(s, ttt:= ("anitray.ahk  ahk_class AutoHotkey"))
; sleep, 330
; minholdr.push({"pid" : minholdrnew : "hwnd" : res_strutVarWin, "pth" : new_path})
; winhide, ahk_id %res_strutVarWin%
; return,
; _window_mintraycombine:
; s:=""
; for, i in minholdr
	; if (minholdr[i].pth = new_path) {
		; if pid_Found := minholdr[i].PiD
			; s:="mintraycombine;" . new_path . ";" . res_strutVarWin . ";" . new_PiD . ";" . new_tt
			; eee:= Send_WM_COPYDATA(s, ttt:= ("anitray.ahk  ahk_class AutoHotkey"))
			; winhide, ahk_id %res_strutVarWin%
	; }
; return,


; splitpath a_ScriptFullPath,,,, OutNameNoExt
; pap := "`n", Script_Title=%OutNameNoExt%.txt
; if !fileexist(Script_Title)
; 	pap := ""
; fileAppend,% ("`n" . EventLogBuffer . ", " . Script_Title)
; (!desktop_custom_enabled ? gosub,DESKTOP_AREA)
; settimer,Desktop_areaCheck, -300
; return,

; DESKTOP_AREA:
; gosub, Desktop_areaCheck
; !desktop_custom_enabled ? run, %DESKTOP_AREA%, : run, %DESKTOP_AREA_REMOVE%,
; return,

;_window_mintraynew:
; s:="mintraynew;" . new_path . ";" . res_strutVarWin . ";" . new_PiD . ";" . new_tt
; eee:= Send_WM_COPYDATA(s, ttt:= ("anitray.ahk  ahk_class AutoHotkey"))
; sleep, 330
; minholdr.push({"pid" : minholdrnew : "hwnd" : res_strutVarWin, "pth" : new_path})
; winhide, ahk_id %res_strutVarWin%
; return,
; _window_mintraycombine:
; s:=""
; for, i in minholdr
	; if (minholdr[i].pth = new_path) {
		; if pid_Found := minholdr[i].PiD
			; s:="mintraycombine;" . new_path . ";" . res_strutVarWin . ";" . new_PiD . ";" . new_tt
			; eee:= Send_WM_COPYDATA(s, ttt:= ("anitray.ahk  ahk_class AutoHotkey"))
			; winhide, ahk_id %res_strutVarWin%
;   }
; return,
;;--=---=--=--=--=--=--=Gui Movement-=---=--=--=--=--=--=
; WM_LBUTTONDOWN(wParam, lParam) 						{
	; global
	; static init := OnMessage(0x201, "WM_LBUTTONDOWN")
	; WinGetActiveStats, Title, rw, rh, wXs, wYs
	; coord_old := A_CoordModeMouse
	; coordmode,  mouse, relative
	; xs := lParam & 0xffff
	; ys := lParam >> 16
		; While	GetKeyState("lbutton","P") {
		; DllCall("GetCursorPos","Uint",&mpos_rect)
		; vWinX := (NumGet(&mpos_rect, 0, "Int") - xs - 29)
		; vWinY := (NumGet(&mpos_rect, 4, "Int") - ys - 36)
		; win_move(windle, vWinX, vWiny, rw, rh)
 	; }
	; rc:=""
	; coordmode, mouse,% coord_old
; }
;--=---=--=--=--=--=--=Gui Movement-=---=--=--=--=--=--=
; WM_RBUTTONDOWN(wParam, lParam) {
; global
; static init := OnMessage(0x0204, "WM_RBUTTONDOWN")
	; WinGetActiveStats, Title, rw, rh, wXs, wYs
	; coord_old := A_CoordModeMouse
	; coordmode,  mouse, relative
	; xs := lParam & 0xffff
	; ys := lParam >> 16
	; While	GetKeyState("rbutton","P") {
		; DllCall("GetCursorPos","Uint",&mpos_rect)
		; vWinX := (NumGet(&mpos_rect, 0, "Int") - xs - 29)
		; vWinY := (NumGet(&mpos_rect, 4, "Int") - ys - 36)
		; win_move(windle, vWinX, vWiny, rw, rh)
 	; }
	; rc:=""
	; coordmode, mouse,% coord_old
; }
;------------==========================++++++++++++++++++++*+*+*+*
	;   case "MozillaDialogClass":
			; Escape_TargetWin = ahk_id %Youtube_Popoutwin%
			; winget, Style, Style,% hnd_
			; winget, exStyle, exStyle,% hnd_
			; IF((STYLE = 0x16CE0084) && (EXSTYLE = 0x00000101) ) {
				; Youtube_Popoutwin := hWnd
				; winclose,
				; wingetPos, X, Y, , EdtH,% hnd_
				; WinMove,% hnd_,, , , , (EdtH - 39)
				; winset, Style, 0x16860084,% hnd_
				; MSGBOX,% (Youtube_Popoutwin . "`nAhk_id: " . hWnd)
			; }
	;	case "Notepad++":
	; 	case "CabinetWClass":;{ ;winset, transparent, 130,% hnd_;msgbox;}
;------------==========================++++++++++++++++++++*+*+*+
; 	A string may be sent via wParam or lParam by specifying the address of a variable.
;	The following example uses the address operator (&) to do this:
; 	SendMessage, 0x000C, 0, &MyVar, ClassNN, WinTitle  ; 0x000C is WM_SETTEXT

/*  ; Notes for popup: NP++; ahk_id 0x2e1120 PID: 8332; process name AutoHotkey.exe; Title Get Parameters; AHK_Class AutoHotkeyGUI; Style / ExStyle 0x940A0000 - 0x00000088; Control Edit1 C_hwnd: 0x130c78 ; Style / ExStyle 0x50010080 - 0x00000200
ID_TRAY_OPEN := 65300
ID_VIEW_LINES := 65406
ID_FILE_RELOADSCRIPT := 65400 ;ID_TRAY_RELOADSCRIPT := 65303
ID_FILE_EDITSCRIPT := 65401 ;ID_TRAY_EDITSCRIPT := 65304
ID_FILE_WINDOWSPY := 65402 ;ID_TRAY_WINDOWSPY := 65302
ID_FILE_PAUSE := 65403 ;ID_TRAY_PAUSE := 65306
ID_FILE_SUSPEND := 65404 ;ID_TRAY_SUSPEND := 65305
ID_FILE_EXIT := 65405 ;ID_TRAY_EXIT := 65307
ID_VIEW_VARIABLES := 65407
ID_VIEW_HOTKEYS := 65408
ID_VIEW_KEYHISTORY := 65409
ID_VIEW_REFRESH := 65410
ID_HELP_USERMANUAL := 65411 ;ID_TRAY_HELP := 65301
ID_HELP_WEBSITE := 65412
*/
;	Modify as necessary:   Uncomment the appropriate line below
;   or leave them all commented to reset to the defaults.
;	codepage := 0		; System default ANSI codepage
;	codepage := 65001	; UTF-8
;	codepage := 1200	 ; UTF-16
;	codepage := 1252	 ; ANSI Latin 1; Western European (Windows)
;	if (codepage != "")
;		codepage := " /CP" . codepage
;	cmd="%A_AhkPath%"%codepage% "`%1" `%*
;	key=AutoHotkeyScript\Shell\Open\Command
;	if A_IsAdmin	; Set for all users.
;		RegWrite, REG_SZ, HKCR, %key%,, %cmd%
;	else,			; Set for current user only.
;	 RegWrite, REG_SZ, HKCU, Software\Classes\%key%,, %cmd%
;;----;
; DllCall("kernel32.dll\SetProcessShutdownParameters", "Uint", 0x4FF, "Uint", 0)
; OnMessage(0x0011, "WM_QUERYENDSESSION")
; return,	; The above DllCall is optional: it tells the OS to shut down this script first (prior to all other applications).
; WM_QUERYENDSESSION(wParam, lParam){
;	 ENDSESSION_LOGOFF := 0x80000000
;	 if (lParam & ENDSESSION_LOGOFF)  ; User is logging off.
;		 EventType := "Logoff"
;	 else,  ; System is either shutting down or restarting.
;		 EventType := "Shutdown"
;	 try { ; Set a prompt for the OS shutdown UI to display.  We do not display		; our own confirmation prompt because we have only 5 seconds before		; the OS displays the shutdown UI anyway.  Also, a program without		; a visible window   cannot block shutdown without providing a reason.
;		 BlockShutdown("Example script attempting to prevent " EventType ".")
;		 return,false
;	 } catch {
;		 MsgBox, 4,, %EventType% in progress.  Allow it?; ShutdownBlockReasonCreate is not available, so this is probably
;		 IfMsgBox Yes		; Windows XP, 2003 or 2000, where we can actually prevent shutdown.
;			return,true  ; Tell the OS to allow the shutdo
;		  n/logoff to continue.
;		 else; ; return,false  ; Tell the OS to abort the shutdown/logoff.
; }   }
; BlockShutdown(Reason) { ; if your script has a visible gui, use it instead of A_Scripthwnd.
; 	DllCall("ShutdownBlockReasonCreate", "ptr", A_Scripthwnd, "wstr", Reason)
; 	OnExit("StopBlockingShutdown")
; }
; StopBlockingShutdown(){
; 	OnExit(A_ThisFunc, 0)
; 	DllCall("ShutdownBlockReasonDestroy", "ptr", A_Scripthwnd)
; }

; ^!V:: ; paste clipboarded img data in the form of an uploaded imgur url.
; if clipboard {
; TT("No Img-Data")
; send, {! UP}
; send,% clipboard
; } else {
; _:=Upload2Imgur()
; if _ {
	; send, {! UP}
	; sendinput,% clipboard:=_
; }
; _:=""
; }
; return,
;	winget,NPphWnd,id,ahk_Class Notepad++
	; send this here SCI_GOTOLINE

	;controlSend,ahk_parent,^g,ahk_id %NPphWnd%
	;winwaitActive,% "Go To..."
	;npplus_A:= WineXist("A")
	;ControlSetText,Edit1,% match,ahk_id %npplus_A%
	;sleep(40)
	;controlSend, Button3,{enter},ahk_id %npplus_A%	;--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝

; winget ll,list,ahk_class Notepad++
; loop,% ll {
	; ControlGet,ctrlhand,hwnd,,Scintilla1,% "ahk_id " ll%A_Index%
	; winget,pn,processname,ahk_id %ctrlhand%
	; switch pn {
		; case "notepad++.exe": NPphWnd :=  ctrlhand
		; continue
	; }
; }
; wingettitle, ttl,% "ahk_id " ErrhWnd
; winget, piddle,pid,ahk_id %ErrhWnd%
; wmi:= ComObjGet("winmgmts:"), queryEnum:= wmi.ExecQuery(""
; .	"Select * from Win32_Process where ProcessId=" . piddle)._NewEnum()
; ((R:= queryEnum[piddle])? (CommandLine:=process.CommandLine, ScriptPath:=StrSplit(CommandLine,"""").4) :())
;;	send this here SCI_GOTOLINE
	; ScriptPath:=StrSplit(CommandLine,"""")
	; msgbox % ScriptPath
	; FUCKME=%comspec% /C "%npplus%" "%ScriptPath%" ;RUN
	; MSGBOX % FUCKME
	; sleep(1100)
	; sendmessage,2024,10,0,,ahk_id %NPphWnd%) ; SCI_GOTOLINE:=2024

	;controlSend,ahk_parent,^g,ahk_id %NPphWnd%
	;winwaitActive,% "Go To..."
	;npplus_A:= WineXist("A")
	;ControlSetText,Edit1,% match,ahk_id %npplus_..
	;controlSend, Button3,{enter},ahk_id %npplus_A%