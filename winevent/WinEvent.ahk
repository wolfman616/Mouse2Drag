;      >...Ev3n7hOOkz...<      ;
;  (;-- p1nh34d-buZ1n355 --;)  ;
;--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝----;

global A_SS:= A_Now, TickSS:= a_tickcount
, a_time_scriptstart:= time4mat((a_now),"H:mm  -  d\M")

Setworkingdir,% (aHkeXe:= splitpath(A_AhkPath)).dir

#NoEnv
#NoTrayicon
#Singleinstance,Force
#IfTimeout,			200
#keyhistory,		20

DetectHiddenWindows,On
DetectHiddenText,		On
SetTitleMatchMode,Slow
SetTitleMatchMode,2
SetTitleMatchMode,regex
SetBatchLines,	-1
SetWinDelay,		-1
SetControlDelay,-1
CoordMode,Tooltip,Screen
Coordmode,Mouse,	Screen

WMPSkin_X:= 2934, WMPSkin_Y:= 736, WMPSkin_tcol:= 061119
  ;;	Aero-b^w-|ist	;;

AEBlackCl:= "TaskListThumbnailWnd,no_glass,"

AEWhiteCl:= "#32769,DropDown,MozillaDropShadowWindow,Class,Net UI Tool Window Layered
,FileTypesMan,ConsoleWindowClass,Notepad++,Notepad,gdkWindowToplevel,Net UI Tool Window,FM,"

(!AEahkWhite? AEahkWhite:= "WM_SIFTer.ahk,-AHK-P|p3-,AHK-Rare_,Event-Hooks,-SIFT,Cur@")

TVfixListPN:= "MMC.exe,AutoHotkeyU64_UIA.exe," ;fix ComCtls TreeView double-buffering extended style-flag.

;OnExplorerRestart;; workercheck()
WorkerWpathchkRun	:= 	"m2eye,K3y2eye,anitray,psy"
WorkerWpathRun		:=	"BrightnessFloater"

;Other Options;
ContextBG			:= "AeroGlass"
MSGB_KiLLTARGET:= "Information"

AHkAeroDbg:= DbgTt:= Dbg:= True, DIconZ:= false
RichEdit_WkRnd:= Dicon_Lablz:= TTFocCTL:= False

;;	1nit-Label-Sequence	;;

iNiT_SeQ:= "Varz>RegReads>hOOkz_init>TRAYicons_init>Menu_Tray_Init>Menu_Style_Init>IncLdz"

gosub,init_Matt

listlines on
return,

;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;End Of AutoExec;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;
; ~lbutton::tt("bum"),
; hotkey,~lbutton,on
; return,

#^f::
postMessage,0x0404,65304,,,% "gay.ahk ahk_Class AutoHotkey"
return,

;-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~-=-=-~☻~#~
;									functions & subroutines etc
;-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~-=-=-~=~#~


WorkerCheck() {
	global WorkerWLbl,WorkerWpathRun,WorkerWpathChkRun,DiConLblz
	static Dtop:= 0
	listlines off
	(Dtop=0? Dtop:= Desktop() : ((De:= Desktop())!=Dtop)? (Dtop:= De, Restarted:=True))
	if(Restarted) {
		loop,parse,% WorkerWpathRun,`,
			WorkerWpathRun(a_loopfield) ;run,% %a_loopfield%
			sleep,1200
		loop,parse,% WorkerWpathChkRun,`,
			WorkerWpathChkRun(a_loopfield)
			settimer,Diconlablz_reinit,-2000
;		loop,parse,% WorkerWLbl,`,
		;	settimer,% a_loopfield,% -100+(a_index*16) ;loop,parse,% workerwFunc,`,
}	}

		Diconlablz_reinit:
		msgbox
		if(!DiConLblz)
			loop,2
				gosub("Diconlablz_Toggle")
		return,

WorkerWpathChkRun(Chki) {
	static ID_TRAY_RELOADSCRIPT:= 0XFF17
	listlines off
	switch,Chki {
		case,"m2eye"	: Chk:= "C:\Script\AHK\Mouse_input-log-ui.ahk"
		case,"K3y2eye"	: Chk:= "C:\Script\AHK\KeyHistory_input-log-uiSCI.ahk"
	;	case,"brightnessFloater" : Chk:= "C:\Script\AHK\GUi\DisplayBrightnessSlider.ahk"
		;return,WorkerWpathRun(Chk)
		case,"anitray"	: gosub,TRAYicons_init
		case,"psy" : Chk:= "C:\Script\AHK\GDI\Psychosis_UIBand.ahk"
	}	if Chk {
		if(winexist(k2:=Chk " ahk_class AutoHotkey")) {
			PostMessage,0x0111,ID_TRAY_RELOADSCRIPT,,,% Chk " ahk_class AutoHotkey"
		} else,run,%CHK%
	}
}

WorkerWpathRun(script) {
	listlines off
	if(hWnd:= winexist(script)) {
		winget,pid,pid,Ahk_id %hWnd%
		while,(WineXist("ahk_pid " pid)!=0) {
			((A_INDEX>2)?tt("killing PID: " pid "`n" A_INDEX " attempts."))
			sleep,1700
			Try,process,close,ahk_pid %pid%
			catch,
				sleep,150 ;Try,WinKill,ahk_pid %pid%
			if(WineXist("ahk_pid " pid))
				Continue,
		} run,% script
}	}

Diconz_Toggle:
dicon_fade((diconz?"out":"in"))
menu,Exp_DTop,% ((diconz:=!diconz)?"check":"uncheck"),% "Desktop Iconz"
return,

		;--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝-->>
		;--p1Nh34d-bU51n355;-^-^-^-^-^-^-^-^-^-^-^>>
		;--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝-->>
		;-^-^-^-^-^-^-^-^-^-^-^--hOOkz--...--🪝 )-->>
		;--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝-->>

74iLHo0k(wParam,lParam,c="",hwnd="",e="") { ; // SHELLHOOK \\; ( aka WinH00K ) ;
	global Tray_FullCount,TVfixListPN,Clas5_list,pName_list,ttt
	listlines off
	static init_complete:= 0
	if(init_complete=0) {
		DetectHiddenWindows,On
			DetectHiddenText,	On
			SetTitleMatchMode,2
			SetTitleMatchMode,Slow
			setbatchlines,		-1
			init_complete:=		true
	}

	WinGet,pName,% "ProcessName",% (hw_Wttl:= ("ahk_id " . (hWnd:= (Format("{:#x}",lParam)))))
	;tt(pname " `n" Format("{:#x}",lParam) "`n" Format("{:#x}",d) "`n" e)
	wingetClass,Class,%		hw_Wttl
	winget,pid,pid,%		hw_Wttl
	wingettitle,TitleLast,% hw_Wttl
	switch,wParam {
		case,"1": if(instr(TVfixListPN,pName . ",")) {
				sendmessage,0x112D,0,0,SysTreeView321,ahk_id %lParam%
				sendmessage,0x112C,0,errorlevel|0x404,SysTreeView321,ahk_id %lParam%
				ControlGet,id,hWnd,,SysTreeView321,ahk_id %lParam%
				winset,style,+0x200,ahk_id %id%
			}
			switch,pName { ; ---🪝HSHELL_WINDOWCREATED🪝--
				case,"explorer.exe": settimer,workercheck,-1000 ;winget,cl,list,% hw_Wttl
				case,"notepad++.exe":	Aero_BlurWindow(lParam),notepadPlus() ;winget,cl,list,% hw_Wttl
				case,"notepad.exe": pName_list.=Format("{:#x}",lParam),
									return,Aero_BlurWindow(lParam)
				case,"regedit.exe": return,aerogchkREGEDIT(lParam)
				case,"ExecTI.exe","Pr0c355_h4X4r.exe","ResourceHacker.exe"
					,"AutoHotkey_dpi.exe", "slsk2.exe","J COLOR PICKER.exe"
					,	"Windows Style Builder.exe", "WinaeroTweaker.exe"
					,	"mmc.exe" : return,Aero_BlurWindow(lParam)
				;case,"discord.exe" : run,% "C:\Script\AHK\discord, taskbar inject.ahk"
				;return,
				case,"Outlook.exe":overlay_(lParam,0x180699),shadesactivelist.= "," . lParam
				case,"mame.exe","retroarch.exe","mame32.exe","mame64.exe","mameui.exe" :
					m:= func("mamed0p").bind(ll:=lParam)
					settimer,% m,-80
					;VarSetCapacity(rect0,16,0xff)
					;DllCall("dwmapi\DwmExtendFrameIntoClientArea","uint",lParam,"uint",&rect0)
			}
			switch,Class {
				case,"WMP Skin Host":	winget,tcol,transcolor,ahk_id %lParam%
					;if(tcol!=WMPSkin_tcol)
					;	winset,transcolor,%WMPSkin_tcol% 254,ahk_id %lParam%
					if (!wmpViewTrig || !instr(hWnd,wmpskinhwndlist)) {
						VarSetCapacity(rect0,16,0xff)
						DllCall("dwmapi\DwmExtendFrameIntoClientArea","uint",lParam,"uint",&rect0)
						wmpskinhwndlist.=hWnd ","
					} controlget,CListWnd,hwnd,,ATL:SysListView321,ahk_id %lParam%
					winget,style,style,ahk_id %CListWnd%
					if(style&0x300000)
						winset,style,-0x300000,ahk_id %CListWnd%
					else,if(style&0x200000)
						winset,style,-0x200000,ahk_id %CListWnd%
					else,if(style&0x100000)
						winset,style,-0x100000,ahk_id %CListWnd%
					win_move(lParam,WMPSkin_X,WMPSkin_Y,"","")
					uiband_set(lParam) ; case,"#32770": (!Class_List?Class_List:= Format("{:#x}",lParam) : Class_List .=(Format("{:#x}",lParam)))
				case,"MainWindowClassName" : Aero_BlurWindow(lParam) ;	<---( "Pr0c355_h4X4r.exe":)
				case,"AutoHotkey" : (TitleLast=1?return())
			}
		case,"2","10": ; --🪝HSHELL_WINDOWDESTROYED🪝--
			instr(pName_list,(Format("{:#x}",lParam)))? pName_list:= StrReplace(pName_list,(Format("{:#x}",lParam),""))
		:	instr(Clas5_list,(Format("{:#x}",lParam)))? Clas5_list:= StrReplace(Clas5_list,(Format("{:#x}",lParam),""))
			;	switch,Class {
			;	case,"AutoHotkey" : tt("AHK Terminated.","tray",0.4)

		;if(pName="AutoHotkeyU64_UIA.exe")
			;menu,Tools_main,icon,% "Debug *.*",% "C:\Icon\256\ICON22_1.ico",,48
	}	; 	default: ; return,;TT(quote(Title_Last) __ quote(lParam) __ quote(wParam) __, 2000)
	; if ll {
		; ll:=false
		; listlines,% ll off
		; }
			if !a_listlines
		listlines,off
		return,
}	;	//END_74iLHo0k ; 🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝

word_lay:
excel_lay:
outlook_lay:
switch,a_thislabel {
	case,"outlook_lay":overlay_init("ahk_Class rctrl_renwnd32","3300aa") ;#include C:\Script\AHK\outlook_overlay.ahk
	case,"excel_lay": overlay_init("ahk_Class XLMAIN","3300aa")	;#include C:\Script\AHK\excel_overlay.ahk
	case,"word_lay": overlay_init("ahk_Class OpusApp","3300aa") ;#include C:\Script\AHK\word_overlay.ahk
} return,

UEventHook(UProc,Event,hWnd,idObject,idChild) { ;,dwEventThread,dwmsEventTime
	msgbox frrrsr3343
	global winevents,sidebar,32770ttlARR,dbgtt
	for,index,element in winevents
		element:= Format("{:#x}",event)? evt:= Index : ()
	dbgtt? ttp(( "Event: " evt "`nhandle: " hWnd "`nOBJ: " idObject ), "800"):()
} ;--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝
;	;	;	;	;	;	;	;	;	;	;	;	;	;	;	;	;	;	;	;	;
onCntMen(aa,bb,hWnd,idObject,idChild,dwEventThread) { ;-🪝--🪝--🪝--🪝
	listlines off
	;postmessage,0x10,,,,ahk_id %hwnd%
	winget,pn,processname,ahk_id %hWnd%
;	if(!instr(pn,"explorer"))
	;	return,
	;menp:= wingetpos(hwnd)
;	winSet,Region,% "0-0 w" menp.w+1 " h" menp.h+1 " R2-2",ahk_id %hwnd%
;	winset,redraw,,ahk_id %hwnd%
	Aero_BlurWindow(hWnd)
	winset,top,,ahk_id %hwnd%
	return,DllCall("SetWindowPos","uint",hWnd,"uint",-1,"int","","int","","int","","int","","uint",0x13)
}	;--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝>>
;~lbutton::
;mousegetpos,,,hw,cw,2
;wingetclass,cvl,ahk_id %hw%
;if(cvl="#32770")
;errOrH4nglah(hw)
;return
errOrH4nglah(ErrhWnd="") { ; Still WiP
	global oldscript
	listlines off
	static _q:= Chr(34)
	((spth:= ScriptPath(pidget(ErrhWnd)))=oldscript)? return():()
	oldscript:=spth,Timer("Oldscript_reset",-6000)
	static needL_sc____	:= "([CDS]*\:\\[\\\w\d\s\.\-\_.]*\.[\w]{3})"
	, needL_basic_	:= "(^OK\r\nError\:)"
	, needL_arrow_	:= "(?:[--->\t]*)([\d]*)"
	, needL_Line__	:= "((?:--->	)[\d]*)(?:\: )([\w\d\,\(\)\[\]\..])"
	, needL_LinErr	:= "(Error at line )([\d]*)"
	, needL_nofunc	:= "(?:exe" . _q . ")([\w\s\: \\\.\-\d\(\>]*)"
	, needL_srcunc	:= "(?:exe" . _q . " /CP65001 )([" . _q . "\w\s\: \\\.\-\d\(\\)>]*)"
	, needL_TernEr	:=("Error\:  A \" . _q . "\:\" . _q
	, 			. "is missing its \" . _q . "\?\" . _q)
	, needleinc	:="(?:Error in #include file " . _q
				. ")([\w:\\\s\.\d\-\((\)\<\>\;\,]*\" . _q . ")"
	sleep,1000 ; Give notepad a chance to get it's act together. ;
	;(_:=RegEXMatch(TxTWin,needL_basic_,iserr,1)? msgb0x(err1:= True " " iserr))
	;(_:=RegEXMatch(TxTWin,needL_basic_,iserr)? msgb0x(err1:= True " " iserr))
	WinGetText,TxTWin,ahk_id %ErrhWnd%
	_:= RegEXMatch(TxTWin,needL_LinErr,err_line,1)
	if(err_line:=regexreplace(err_line,"i)[\D]")){

	return,needle(err_line,ErrhWnd,needL_srcunc)
	}
;	( 	!StrLen(TxTWin)? return()), ((!instr(TxTWin,"Error at")
	;||	!inStr(TxTWin,"Error: Target label does not exist.")
	;||	!inStr(TxTWin,"#include file")? return()
	;||	!inStr(TxTWin,"Error:  Missing" . _q)? return()
	;||	!inStr(TxTWin,"Call to nonexistent function."))? return() : err2:= True)

	(_:= RegEXMatch(TxTWin,needL_LinErr,err_line)? (msgb0x(err_line),needle(err_line,ErrhWnd,needL_srcunc))
	: (RegEXMatch(TxTWin,needL_TernEr,2))? err2:= True : (RegEXMatch(TxTWin,needL_Line__,lin,2)? err2:= true))
	
	RegEXMatch(TxTWin,needL_Line__,lin,2) 
	if(err_line:=regexreplace(lin,"i)[\D]")){
	return,needle(err_line,ErrhWnd,needL_srcunc)
	}

	if(err1) {
		tt("err1 errorline: " err_line,1,"center")
		Goto,FindErrorStage1
	}

	if(err2) {
		if(!err_line)
			return,
		tt("err2 errorline: " err_line,1,"center")
		Goto,FindErrorStage2
	} return,"End"

	FindErrorStage1:
	WinGet,pid,PID,ahk_id %ErrhWnd%
	wmi:= ComObjGet("winmgmts:"), queryEnum:= wmi.ExecQuery(""
.	"Select * from Win32_Process where ProcessId=" . pid)._NewEnum()
,	try,(R:= queryEnum[process])? (CommandLine:= process.CommandLine
,	(RegEXMatch(CommandLine,needL_sc____,scrunc)))
	(_:= RegEXMatch(CommandLine,needL_arrow_,err_line)? msgb0x(err1:= True " " err_line "`n" err_line1))
		if !_:= RegEXMatch(CommandLine,needL_sc____,err_line)
			;msgbox,% err1:= True " " err_line "`n" err_line1
return,
	FindErrorStage2: 
;msgb0x("error1 " err_line)

	(RegEXMatch(TxTWin,needL_nofunc,scrunc)?msgb0x("SRcFunc`nMIA" A_LineNumber " " scrunc))
	if((RegEXMatch(TxTWin,needL_Line__,err_line,2))) 
	
					;msgb0x("FAILED-2-FIND-MK " match " 1`n" wanl " 2")
		return,
	else,(wanl:= RegEXMatch(TxTWin,needleinc,match,2)? msgb0x("wgs " A_LineNumber " " match "`n" wanl))

	FindErrorStage3:
	WinGet,pid,PID,ahk_id %ErrhWnd%
	wmi:= ComObjGet("winmgmts:"), queryEnum:= wmi.ExecQuery(""
.	"Select * from Win32_Process where ProcessId=" . pid)._NewEnum()
,	try,(R:= queryEnum[process])? (CommandLine:= process.CommandLine
, ( 	ScriptPath:= StrSplit(CommandLine,"""")),needle(err_line,ErrhWnd,needL_srcunc) ) :
, ( (RegEXMatch(CommandLine,needL_nofunc,scrunc)? (err_:= strReplace(err_line,"--->	")
, (		cuntass?(RUNc(quote(npplus) . " " . quote(scrunc1))) :RUNc(quote(npplus) . " " . scrunc1))
,		ScintillaNP(2024,err_,0))), sSleep(1000),winactivate("ahk_class Notepad++"), return() )
}

needle(err_,errhn,needL) {
	static global npplus
	listlines off
	WinGet,pid,PID,ahk_id %errhn%
	wmi:= ComObjGet("winmgmts:"), queryEnum:= wmi.ExecQuery(""
.	"Select * from Win32_Process where ProcessId=" . pid)._NewEnum()
,	try,(R:= queryEnum[process])? (CommandLine:= process.CommandLine
, (_:= RegEXMatch(CommandLine,needL,scrunc)? (ngh:= runc((quote(npplus) . " " . scrunc1))
,	sSleep(600),ScintillaNP(2024,err_,0), winactivate(_:= ("ahk_id " . errhn)))))
,	sSleep(1000)
	return,
}

;																						}
;--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝
;																						}

ScintillaNP(WM="",wParam="",lParam=0){
	listlines off
	sSleep(50)
	winget,ll,list,ahk_class Notepad++
	loop,% ll {
		ControlGet,CtrlHand,hWnd,,Scintilla1,% "ahk_id " ll%A_Index%
		winget,PN,processname,ahk_id %CtrlHand%
		switch,PN {
			case,"notepad++.exe" : NPphWnd:= CtrlHand
				continue,
	}	} if(!(isint(wParam)))
		StringTrimRight,LineN,wParam,3
	else,LineN:= wParam
	LineN--
	Sendmessage,% WM,% LineN,% lparam,,ahk_id %CtrlHand%
}

runC(byref CommandStr,onPath="",dontHide="",byref pid="") {
	run,% CommandStr,% onPath,,pid
	return,
} ;--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝

; uEventz(HookM,eventcr,hWnd,idObject,idChild,dwEventThread) {
; }

onObjCreate(HookCr,eventcr,hWnd,idObject,idChild,dwEventThread) { ;-🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝
	global wmp_init_trigger,AEWhiteCl,xcent,ycent,32770ttlARR,rtf_count
	listlines off
	wingetClass,Class,% hW_ttl:= ( "ahk_id " . (Format("{:#x}",hWnd)))
	wingettitle,Title_Last,% hW_ttl
	winget,pName,ProcessName,% hW_ttl
	fandN=%hWnd%
	switch,Class {
		case,"ShellTabWindowClass":
			switch,title_last {
				case,"Control Panel": win_move(o:= DllCall("GetParent","uint",hWnd),xcent,ycent,1186,606,0x4001)
			}
		case,"CabinetWClass": 1999:= hW_ttl
				settimer,1999,-700 ;WinGetText, wtxt ,% hW_ttl
			return,Aero_BlurWindow(hWnd)
		case,"Static","CLIPBRDWNDCLASS","sysdragimage" : return,
		case,"MozillaDropShadowWindowClass" : wingetpos,xx,xy,xw,xh,ahk_id %hwnd%
		if (xw>0) {
			winSet,Region,% "0-0 w" xw-1 " h" xh-1 " R15-15",ahk_id %hwnd%
			winset,redraw,,ahk_id %hwnd%
		}	return,
		;DllCall("dwmapi\DwmSetWindowAttribute", "ptr", hwnd
		;, "uint", DWMWA_NCRENDERING_POLICY := 2, "int*", DWMNCRP_DISABLED := 1, "uint", 4)
	 ; BlurGl(hWnd) ;winSet,Region,% "0-0 w" po.w-1. " h" po.h-1 " R16-16",ahk_id %hwnd%
		case,"AutoHotkey" : Aero_BlurWindow(hWnd)
		case,"AutoHotkeyGUI" : (strlen(Title_Last)<2)? return()
			if (_:=!instr(Title_Last,"animate_target"))
			|| if (instr(Title_Last,""))
			|| if (instr(Title_Last,".ahk")) {
			   if (instr(AEahkWhite,Title_Last ","))
					Aero_BlurWindow(hWnd)
				WinGetText,textw,% hW_ttl
				loop,parse,% "-AHK-P|p3-,AHK-Rare_,Event-Hooks,-SIFT,Cur@",`,
					instr(textw,a_loopfield)? Aero_BlurWindow(hWnd) : ()
				return,
			}
		case,"#32770": Aero_BlurWindow(hWnd)
			switch,pName { ;if(!EndofList) ;r:= Send_WM_COPYDATA("JumpNext","wmp_Matt.ahk ahk_class AutoHotkey")
				case,"WMPlayer.exe" : w:= wingetpos(hwnd)
					if(w.h<359)
						winclose,ahk_id %hWnd%
				case,"SndVol.exe": controlget,cwnd1,hwnd,, #327701,ahk_id %hwnd%
					if(cwnd1) {
						controlget,cwnd2,hwnd,,msctls_trackbar321,ahk_id %hwnd%
						try (cwnd2? styleset(cwnd2,"+0x08000000")) ;winset,style,+0x08000000,ahk_id %cwnd2%
					} return,
			} switch,Title_Last {
				case,"Open","save","save as" : settimer,32770Fix,-10
					return,
			} ((instr(pName,"AutoHotkey"))? errOrH4nglah(hWnd),return())
			if((pName="notepad++.exe")&&(Title_Last="Create new file")){
				loop,50 {
					tt(a_now), sSleep(350), winclose,ahk,_id %hWnd%, sSleep(350)
					(hn:= WinExist("ahk_class #32770","Create new file")? msgb0x(hn) :())
			}	}
		case,"NppProgressClass" : return,Aero_BlurWindow(hWnd)
		case,"gdkWindowTempShadow"	: return,Aero_BlurWindow(hWnd)
		case,"SysShadow" : winset,transparent,1,ahk_id %hWnd%
			return,
		case,"HH Parent" : return,WIN_move(hWnd,2460,502,1024,636)
		case,"Notepad" : TT(IsWindowVisible(hWnd) " usually  0 (invis)")
		case,"RegEdit_RegEdit" : aerogchkREGEDIT(hWnd)
		case,"gdkWindowToplevel","Net UI Tool Window","FM":
			(IsWindow(hWnd))? Aero_BlurWindow(hWnd), (Title_Last="Save Image"?sendki("Right"))
		case,"DropDown","Net UI Tool Window Layered": (IsWindow(hWnd)? Aero_BlurWindow(hWnd),DllCall("SetWindowPos","uint",hWnd,"uint",-1,"int","","int","","int","","int","","uint",0x413 ))
		case,"#32769","#32768" : return
				return,% (pName!="firefox.exe")? "": Aero_BlurWindow(hWnd)
			;DllCall("dwmapi\DwmSetWindowAttribute","ptr",hwnd ; #2: Disable DWM rendering of the window's frame.
			 menp:= wingetpos(hWnd)
			winSet,Region,% "0-0 w" menp.w+1 " h" menp.h+1 " R2-2",ahk_id %hwnd%
			winset,redraw,,ahk_id %hwnd%			; , "uint", DWMWA_NCRENDERING_POLICY := 2, "int*", DWMNCRP_DISABLED := 1, "uint", 4)
		case,"BaseBar" : uiband_set(hwnd) ;WinSet,AlwaysOnTop, %a%, ahk_id %hwnd%
			WinSet,exstyle,-0x100+0x9,ahk_id %hwnd% ;WinSet, exstyle, , ahk_id %hwnd%
			WinSet,style,-0x400000,ahk_id %hwnd%
			Aero_BlurWindow(hWnd) ; dllCall("dwmapi\DwmSetWindowAttribute", "ptr", hwnd
			; , "uint", DWMWA_NCRENDERING_POLICY := 2, "int*", DWMNCRP_DISABLED := 1, "uint", 4)
			; DllCall("SetWindowPos","uint",hWnd,"uint",-1,"int","","int","","int","","int","","uint",0x413) ;winSet,Region,% "0-0 w" po.w-0 " h" po.h-0 " R8-8",ahk_id %hwnd%
			return,
		case,"MMCMainFrame" : string=wm0x112C,0,0x4,ahk_id %hWnd%
			Eee:= Send_WM_COPYDATA(string,ttt:= ("ADhKi.ahk  ahk_class AutoHotkey"))	; CBEM_SETEXTENDEDSTYLE
		case,"OperationStatusWindow": Aero_BlurWindow(hWnd)
			if((Title_Last="Replace or Skip Files")||(Title_Last="Confirm Folder Replace")||(Title_Last="Folder In Use")) {
				return,		; disabled still ; disabled still ; disabled still ; disabled still ; disabled still
				msgbox,% " test 5 ",,,4
				DEBUGTEST_FOC := True, DEBUGTEST_hWnd:= WinExist("A")
				winset,exStyle,+0x08000080,% hW_ttl
				winset,Style,  +0x80000000,% hW_ttl
				win_move((Format("{:#x}"),hWnd),3000,900,"","",""), TT("Preparing...",1000)
				msgbox,% ("old1" old_focus1 "`nold2" old_focus2 "`nold3" old_focus3 "`nol4g1" old4gnd1 "`nol4g2" old4gnd2 "`nol4g3" old4gnd3)
				winactivate,% ("ahk_id " . old_focus1)Title_Last,% hW_ttl
				settimer,tooloff,-128
			} return,
		 case,"MozillaDialogClass" : if( instr(Title_Last,"opening")) {
				ffoxisgay.=hwnd ","
				, p:=wingetpos(hwnd), win_move(hwnd, p.x,p.y,p.w,p.h-1,"")
			} else {
					winget,Style,Style,% hW_ttl
					winget,exStyle,exStyle,% hW_ttl
					If((STYLE=0x16CE0084)&&(EXSTYLE=0x00000101)) ; identifying popout window
						winset,Style,0x16860084,% hW_ttl
			} return,
		case,"TaskListThumbnailWnd","Net UI Tool Window Layered": winset,ExStyle,-0x00000100,% hW_ttl
			winset,Style,0x94000000,% hW_ttl
			winget,stylee,style,% hW_ttl
			return,
		case,"TaskListThumbnailWnd","FileTypesMan","ConsoleWindowClass","Notepad++" : ;return,Aero_BlurWindow(hWnd)
			1999:= hW_ttl,Timer("1999",-700), return,Aero_BlurWindow(hWnd)
		case,"WMP Skin Host" : if !wmp_init_trigger {
				run,% "C:\res\WMP_theme\psychosis\psychosis.wms"
				ssleep(300), wmp_init_trigger:= True
				winset,style,-0x480000,% hW_ttl
				win_move(lParam,WMPSkin_X,WMPSkin_Y,"","",""), uiband_set(hwnd)
			} return,
		case,"MsiDialogCloseClass": if(id:= WinExist("ahk_class MsiDialogCloseClass"))
				txt:= "dialog", c_ntrolName:= "Static1"
			if(mainc_nt=Format("{:#x}",(WinExist("ahk_exe msiexec.exe",txt)))) {
				ControlGet,c_ntHandle,hWnd,,%c_ntrolName%,ahk_id %mainc_nt%
				StyleMenu_Showindow(c_ntHandle,!IsWindowVisible(c_ntHandle))
				tt("ProcdEvent: " . MsiDialogCloseClass . "`n" . id " yes..." . mainc_nt . " main " . hWnd . "`n" . c_ntHandle)
			} return,
		case,"#32770": ;msgbox % Title_Last
			if(e:=winexist("Information")) {
				if(Title_Last="Information") {
					winActivate,ahk_id %e%
					winwaitActive,ahk_id %e%
					sendki("N")
					return,
				}
			} if(Title_Last="Windows Media Player") {
				if(stylecompare(hWnd,0x94C808DC,0x00010101))
					winclose,ahk_id %hWnd%
			} else,if(Title_Last="Delete Multiple Items") {
				msgbox
				controlget,cw,hwnd,,static1,ahk_id %hwnd%
				SetImg(cw,ico2hicon("C:\Icon\alert.ico"))
				return,
			} else {
				winget,pn,processname,ahk_id %hWnd%
				if(pn="regedit.exe"){
					controlget,cw,hwnd,,static2,ahk_id %hwnd%
					anisyringe:= DllCall("LoadImage","Int",0
													, "Str", "C:\Icon\- Icons\- CuRS0R\_ ani\cubez_48x256_f.ani"
													, "Int", 2 ;IMAGE_CURSOR
													, "Int", 48,"Int",48
													, "UInt",0x10,"Ptr")
					SetImg(cw,anisyringe)
					return,
				} else,if(pn="werfault")
					win_move(hwnd,410,245,"","","")
					return,
			}
			for,index,element in 32770ttlARR ;explorer Open/SaveDialog bgBrush mitigation attempts ='(
				((Title_Last=element)? (stylecompare(hWnd,0x86CC02C4,0x00010101), tr9g:= True))
				(tr9g?Timer("32770Fix",-1),tr9g:= False)
			(instr(Title_Last,"Volume Mixer")? TT("Vol32 detected"))
			if(pName="explorer.exe")
				if(Title_Last="Folder In Use") {
					WinGetText,testes,% hW_ttl
					TT("File handle open")
				} return,
		case,"Notepad++" : return

		(!np? Aero_BlurWindow(hWnd), np:= True)
			if(!WinExist(sem:= "Notepad++ Insert AHK Parameters.ahk - AutoHotkey"))
			run,% "C:\Script\AHK\- Script\Notepad++ Insert AHK Parameters.ahk",,hide
			np:= True
		;case,"RICHEDIT50W" : RichEdit_WkRnd? return( ) : ( ) ; this hits numerous controls eg: explorer preview pane.
		;	if(RTFCooldown&&!pName="prevhost.exe")
		;		return,
		;	rtf_count++, Timer("RTFCooldown_reset",-2000), RTFCooldown:= True
		;	sendmessage,0x0030,0,1,,% hW_ttl ; #define WM_SETFONT null
		;	return,

		;	RTFCooldown_reset:
		;	RTFCooldown:= False
		;	return,
		default : if(!(IsWindow(hWnd)))
				return,
	} (instr(AEWhiteCl,(Class . ","))? Aero_BlurWindow(hWnd):(a:= UIBANDCLASS_CHECK(Class)
	? (rThread:="", A_new_hWnd:="Static1", gosub("UIBandSet"))))
	(TTcr?ttp(("OBJ_CREATE EVENT: " pName "`nTitle: " Title_Last "`nAHK_Class: " Class "`nAHK_ID: " hWnd)))
	StyleDetect(hWnd,Style_ClassnameList2,Class,Array_LClass)
	StyleDetect(hWnd,Style_procnameList2, pName,Array_LProc)
	StyleDetect(hWnd,Style_wintitleList2, Title_Last,Array_LTitle)
	switch,pName {
		case,"sndvol.exe","RegistryChangesView.exe" : Aero_BlurWindow(hWnd)
	}
	switch,Title_Last {
		case,"Razer Synapse Account Login" : Timer("RZ_LOG",-1)
	} pushclsl_(Class), pushclsh_(hWnd)	;Iconchange_Check(hWnd, C las5, pName);
} ;--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝-🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝

test2:
tooltip,delete me
	return,

; ~^h::
; mousegetpos,,,hwnd
; menp:=wingetpos(hwnd)
; tt(menp.w " " menp.h)
; win_move(hwnd,menp.x,menp.y,menp.w-8,menp.H-8)
; winSet,Region,% "4-4 w" menp.w-8 " h" menp.h-8 " R12-12",ahk_id %hwnd%
; winset,redraw,,ahk_id %hwnd%
; Aero_BlurWindow(hWnd)
; sleep,1000
; sendmessage,0x212,,,,ak_id %hwnd%
; return,

on4Gnd(hook4g,event4g,hWnd) { ; initated from taskbar or minimize restore etc
	global ahkpos, alert64
	static EM_SETSEL:= 0x00B1
	old4gnd3:= old4gnd2, old4gnd2:= old4gnd1, old4gnd1:= hWnd
	UIBPROCESS()
	Timer("SteamIconChkTEST",-10000)
	4gnd_hWnd:= ("ahk_id " . hWnd)
	wingetClass,Class,%			4gnd_hWnd
	wingettitle,Title_Last,%	4gnd_hWnd
	if(instr(Title_Last,"Delete Multiple Items")) {
		loop,2
			mbiconset(hwnd,alert64)
		winset,top,,%	4gnd_hWnd
		mbiconset(hwnd,alert64)
	}

	winget,pName,ProcessName,%	4gnd_hWnd
	(TT4g? tT("4Ground EVENT:`n" pName "`n" Title_Last "`nAHK_Class " Class "`nAHK_ID " hWnd))
	switch,Class {
		case,"WorkerW": r:=DllCall("PostMessage", "ptr", hWnd, "uint", 0x0128, "ptr", 0x00010001, "ptr", 0)
		case,"WMP Skin Host" : if(!instr(wmpskinhwndlist,hWnd ",")) {
				winget,tcol,transcolor,ahk_id %hWnd%
				if(!wmpViewTrig || !instr(hWnd,wmpskinhwndlist)) {
					VarSetCapacity(rect0,16,0xff)
					DllCall("dwmapi\DwmExtendFrameIntoClientArea","uint",hWnd,"uint",&rect0)
					wmpskinhwndlist.=hWnd ","
				} win_move(hWnd,WMPSkin_X,WMPSkin_Y,"","","")
				uiband_set(hWnd) ;if(tcol!=WMPSkin_tcol) {	; winset,transcolor,%WMPSkin_tcol% 1,ahk_id %hWnd% ;}
			}
		case,"notepad++" : winget,xstyle,exstyle,ahk_id %hWnd%
		if(xstyle &0x8) {
			ToggleNPPOnTop:= func("ToggleNPPOnTop").bind(hwnd)
			settimer,% ToggleNPPOnTop,-50
		}
		case,"AutoHotkey" : if(instr(Title_Last," - AutoHotkey v1.1"))
				w:= wingetpos(hWnd), (w.w>500||w.h>350)?
				win_move(hWnd,ahkpos.X,ahkpos.Y,ahkpos.W,ahkpos.H,"")
		case,"MainWindowClassName":  ; ProcessHacker: when activating main window, auto hoghlighting of search box
			if !(IsWindowEnabled(hWnd) && IsWindowVisible(hWnd))
				sleep,230	 ; chinkdent
			controlGet,PH_edit1_cHnd,hWnd,,Edit1,ahk_id %hWnd%
			controlClick,Edit1,ahk_id %hWnd%
			sleep,150
			SendMessage,% EM_SETSEL,0,-1,Edit1,ahk_id %hWnd%
;	/* Select a range of characters in an edit control. Start 0 and end -1 = all text selected. Start -1, = selection deselected. */
		case,"#32770" : if(Title_Last="Information") {
				DllCall("DestroyWindow", "int", hWnd)
				winactivate,% 4gnd_hWnd ;winactivate, Information ;sleep,400
				sleep,10
				sendinput,N
		} else,if(pname="regedit.exe"){
					controlget,cw,hwnd,,static2,ahk_id %hwnd%
					anisyringe:= DllCall("LoadImage","Int",0, "Str", "C:\Icon\- Icons\- CuRS0R\_ ani\cubez_48x256_f.ani"
					,"Int",2,"Int", 48,"Int",48,"UInt",0x10,"Ptr")  ;2-IMAGE_CURSOR
				SetImg(cw,anisyringe)
				win_move(cw,10,20,"","","")
				tt("hello")
				}
		case,"ApplicationFrameWindow","Chrome_WidgetWin_1","WINDOWSCLIENT":
			ttt:= "M2Drag.ahk - AutoHotkey", result:= Send_WM_COPYDATA("status",ttt)
			wingettitle, Title_Last,% 4gnd_hWnd
			ttt:= "M2Drag.ahk - AutoHotkey", result:= Send_WM_COPYDATA("status", "M2Drag.ahk - AutoHotkey")
			settimer,tooloff,-2220
	}	switch,pName {
		case,"firefox.exe":	if(Title_Last="Incoming Connection") {
				_:=uiband_set(hwnd)
				winset, alwaysontop,on,ahk_id %hWnd%
			}
		case,"ShellExperienceHost.exe" :
		if instr(Title_Last,"New notification") {
			po:= wingetpos(hwnd)
			, DllCall("dwmapi\DwmSetWindowAttribute","ptr",hwnd,"uint",DWMWA_NCRENDERING_POLICY:= 2,"int*",DWMNCRP_DISABLED:= 1,"uint",4)
			;	winSet,Region,% "0-1 w" po.w-200 " h" po.h-200 " R20-20",ahk_id %hwnd%
				winSet,Region,% "30-110 w" po.w-55 " h" po.h-155 " R16-16",ahk_id %hwnd%
				win_move(hwnd,po.x-1,po.y-10,po.w-55,po.h-1,2)
			}
		case,"SndVol.exe" : WindowIconSet(hWnd,ico_sndvol:= "C:\Icon\48_24\sndvol_48_24_4.ico") ;Aero_BlurWindow(hWnd)
			winclose,ahk_class #32768
			return,
		case,"RzSynapse.exe" : settimer,RZ_LOG,-10
		case,"RetroArch": ffs:= func("mamed0p").bind(hWnd)
			settimer,% ffs,-100
		case,"GoogleDriveFS.exe" : if(Title_Last!="Share item")
			;VarSetCapacity(rect0,16,0xff) ;DllCall("dwmapi\DwmExtendFrameIntoClientArea","uint",hWnd,"uint",&rect0)
				return,
		case,"Windows Style Builder.exe":if (Title_Last="New Property") {
			ControlFocus,ComboBox2,ahk_id %hWnd%
		}
	}	switch,Title_Last { ;case,"Google Drive Sharing Dialog":;msgbox
		case,"Razer Synapse Account Login" : Timer("RZ_LOG",-1)
	}	Iconchange_Check(hWnd,Class,pName)
}

;--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝-🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝

onCntFocus(HookFc,eventfc,hWnd)	{ ;old_focus2 := old_focus1 ;	old_focus1 := hWnd
	global alert64
	(TTFocCTL?(TT(Log_CNTActive(hWnd)),Timer("Log_CNTActive",-100)))
	settimer,SteamIconChkTEST,-1000
	wingetClass,Class,% hnd_:= ("ahk_id " . hWnd)
	winget,pName,ProcessName,% hnd_
	wingetTitle,Title_Last,% hnd_
	(TTFoc? TT("FOCUS EVENT:`n" pName "`n" Title_Last "`nAHK_Class " Class "`nAHK_ID " hWnd))
	pushclsl2_(Class), pushclsh2_(hWnd)
	switch,pName {
		case,"RzSynapse.exe" : settimer, RZ_LOG, -1
		case,"GoogleDriveFS.exe": return,
			; if !triggeredGFS {	;return,;disabled
				; triggeredGFS := True ;sleep, 1000 ;msgbox % hWnd "asdsads"
				; IsWindowEnabled(hWnd) && IsWindowVisible(hWnd) ? InvertCol(hWnd) : sleep, 3000
				;;InvertCol(hWnd)
				; TT("GOATSE", 1000)
				;}
				;}
	}

	switch,Title_Last {
		case,"Razer Synapse Account Login" : settimer,RZ_LOG,-1
		case,"Delete Multiple Items" : mbiconset(hwnd,alert64)
	}

	switch,Class {
		case,"WMP Skin Host" : if(!instr(wmpskinhwndlist,hWnd ",")) {
				controlget,CListWnd,hwnd,,ATL:SysListView321,Ahk_id %hwnd%
				(!CListWnd? return())
				if (!wmpViewTrig || !instr(hWnd,wmpskinhwndlist)) {
					VarSetCapacity(rect0,16,0xff)
					DllCall("dwmapi\DwmExtendFrameIntoClientArea","uint",hWnd,"uint",&rect0)
				;	winget,tcol,transcolor,ahk_id %hWnd%
				;	if(tcol!="001500") {
				;		winset,transcolor,%WMPSkin_tcol% 254,ahk_id %hWnd%
					wmpskinhwndlist.=hWnd ","
			}	}
			win_move(Hwnd,wmpskin_x,wmpskin_y,"","","")
			winget,style,style,ahk_id %CListWnd%
			sleep,100
			if(style&0x300000)
				winset,style,-0x300000,ahk_id %CListWnd%
			else,if(style&0x200000)
				winset,style,-0x200000,ahk_id %CListWnd%
			else,if(style&0x100000)
				winset,style,-0x100000,ahk_id %CListWnd%
			uiband_set(hWnd)
		case,"MozillaDialogClass": winget,Style,Style,% hnd_
			If (STYLE=0x16CE0084) { ;&& (EXSTYLE-0x00000101)
				Youtube_Popoutwin:= hnd_
				wingetPos,X,Y,,EdtH,% hnd_
				WinMove,% hnd_,,,,,EdtH -39
				winset,Style,0x16860084,ahk_id %hWnd%
				send,{SPACE}
			} else,if(instr(title_last,"opening")) {
				p:= wingetpos(hwnd)
				if(!instr(ffoxisgay, hwnd ",")) {
					ffoxisgay.=hwnd ","
					, win_move(hwnd, p.x,p.y,p.w,p.h-1,"")
				}
			}
		case,"#32770" : if(Title_Last="Information") {
				ssleep(20)
				send,N
				TT("trigtaeradwg . . .")
			}
		case,"BaseBar" : 	tt("Cocks")
		return,DllCall("SetWindowPos","uint",hWnd,"uint",-1,"int","","int","","int","","int","","uint",0x413) ;uiband 0x0013  0x0010 0x0002
	} return,
}

;--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝-🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝

#e::run,%PsYch0%

;--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝-🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝--🪝

cntdninit(asa="") {
	static last:=0
	if(last!=0&&2000>a_tickcount-last) {
			last:= a_tickcount
			return,
	} ;tt(Title_Last "`n " HookMb " " hWnd  " " eventmb ):()
	controlget,OutputVar,Hwnd ,,% "Static1",ahk_id %asa%
	controlgetText,tx,,ahk_id %OutputVar%
	if(!RegExMatch(tx, "(\d+)(?!.*\d)", d_, 1) )
		return,
	(last=0?last:=A_tickcount)	;run,C:\Program Files\Autohotkey13404\AutoHotkeyU64_UIA - admin.exe C:\Script\AHK\countmedown.ahk %asa%
	;return,
	fn:= Func("Countdown").Bind(asa)
	settimer,% fn,-1000
	return,
}

ToggleNPPOnTop(hwn){
	local xstyle
	winget,xstyle,exstyle,ahk_id %hWn%
	if(xstyle &0x8) ;fix workround np++ taking topmost option;
		send,{blind}{f6} ;configured to toggling ontop ness in np++
}

mbiconset(hw,imgvar) {
	static handle
	if(!handle)
		handle:= hw
	else,if(hw=handle)
		return,
	else {
		handle:= hw
		controlget,cw,hwnd,,static1,ahk_id %hw%
		win_move(cw,"","",60,60)
		sleep 50
		return,SetImg(cw,b64_2_hicon(imgvar))
	}
}

Overlay_(Win_ID,colour=0x110617) {
	static handles:="", cnt:= 0
	if(colour="removeall")
		loop,parse,% handles,`,
			try,gui,cover%a_loopfield%,destroy
	else,if(colour="remove"){
		gui,cover%win_id%:hide
		gui,cover%win_id%:destroy
		return
	}else,if(instr(win_id,"ahk_")) {
		winget,handle,id,% win_id
	} else,handles.=(handle:= win_id) . ",", cnt++
	switch,win_id {
		case,"ahk_Class rctrl_renwnd32" : bh:= 29
	}
	gui,cover%handle%:new,-dpiscale -Caption +hwndcover_hwnd%cnt% +e0x40020 +0x840000
	gui,cover%handle%:color,% colour
	gui,cover%handle%:show,na w%a_screenwidth% h%a_screenheight%
	oulk:= wingetPos(handle), covp:= wingetPos(cover_hwnd%cnt%)
	Success:= DllCall("SetParent","uint",cover_hwnd%cnt%,"uint",handle)
	winset,transparent,40,% "ahk_id " cover_hwnd%cnt%
	win_move(cover_hwnd%cnt%,-8,-8,covp.w+10,covp.h+bh+10)
}

Countdown(cwnd="") {
	static _cwnd_2
	(cwnd=_cwnd_? return())
	(cwnd!=""? _cwnd_2:= cwnd)
	controlget,_cwnd_,Hwnd ,,% "Static1", ahk_id %_cwnd_2%	;msgbox %_cwnd_%
	controlgetText,tx,,ahk_id %_cwnd_%
	(!(RegExMatch(tx, "(\d+)(?!.*\d)", d_, 1) )? msgb0x(" regex fail"), return())
	if((d_2:= Format("{:d}", d_) )--)>-1 {
		tx:= strreplace(tx,d_,(d_2))
		controlSetText,,%tx%,ahk_id %_cwnd_%
		if(!(d_2="0")||d_2="") {
			fn:= Func("Countdown").Bind(_cwnd_2)
			settimer,%fn%,-1000
		} else,winclose ahk_id %_cwnd_2%
	}
}

onMsgbox(HookMb, eventmb, hWnd) {
	global wmpabortions
	wingetTitle, Title_Last,%   h_Wd:=("ahk_id " . Format("{:#x}",hWnd))
	;(instr(Title_Last,"Modified script: ")? cntdninit(hWnd))
	winget pName, ProcessName,% h_Wd
;	if(instr(pName,"autohot")) {
	;		 	hSmIcon:= LoadPicture("C:\Icon\24\ey3y3 24.ico","w24 Icon" . Index,ErrorLevel)
	;		, 	hLgIcon:= LoadPicture("C:\Script\AHK\- Script\WinSpy\Resources\eyeopen48.ico","w48 Icon" . Index,ErrorLevel)
	;			SendMessage,0x80,0,hSmIcon,,% h_Wd ; WM_SETICON,ICON_SMALL
	;			SendMessage,0x80,1,hLgIcon,,% h_Wd ; WM_SETICON,ICON_LARGE
;			}
	wingetClass Class,% h_Wd ;(TTmb? TT( "MSGBOX EVENT:`n" pName "`n" Title_Last "`nAHK_Class " Class "`nAHK_ID " hWnd ) )
	switch,Title_Last {
		case,"Information": winactivate,% "Information"  ;winwaitactive,% "Information"
			ssleep(200)
			send,N
			return,
		case,"Windows Media Player":
			settimer,wmpabortionsReset,10000 ;10sec  cooldown
			wmpabortions++
			if(!(wmpabortions>3)) {
				winclose,ahk_id %hWnd%
				result:= Send_WM_COPYDATA("PauseToggle", "wmp_Matt.ahk ahk_class AutoHotkey")
			} return,
	} (_:= WinExist("Reminder")? MSGB_KiLLTARGET:="Reminder", WIN_TARGET_DESC:=MSGB_KiLLTARGET)
	If(WinExist(KILLSWITCH)) {
		tt("Shutting Down Scripts",(A_ScreenWidth*.5),(A_ScreenHeight*.5))
		Timer("m2_Status_Req33",-2800)
		return,
	  m2_Status_Req33:
		exitApp()
	} Aero_BlurWindow(hWnd)

	wmpabortionsReset:
	wmpabortions:= 0
	return,
}

;onObjDeath(HookOD, eventod, hWndOd) {
;	return,
;	wingetClass, Class, (hndDS := ("ahk_id " . Format("{:#x}"mhWndOd)))
;	wingettitle, Title_Last,% hndDS
;	winget pName, ProcessName,% hndDS
;	(!(TTds="")?(TT("OBJ_DESTROY EVENT:`n" pName "`n" Title_Last "`nAHK_Class " Class "`nAHK_ID " hndDS)):())
;}
; end of event hooks funcs  <<<---------------------------------------

; binds				<<<---------------------------------------
~esc:: ; check ADh_K3Y		; ~#z:: ; testing
;send,{escape up}			; gosub,quotE
if(!guic_trig)				; return,
	settimer,guic_,-1		; while getkeystate("escape","p")	; sleep, 3
loop,3
	sleep,10
return,

guic_:
guic_trig:= True
try,gui,ttt: destroy
try,gui,eventgui: destroy
return,
	;	<------------< [ End of Script ] <------------------<

	;	>------------> [ Begin ... Functions ] >------------>
AtExit() {
	menu,tray,noicon
	(!(hgui="")? dllcall("magnification.dll\MagUninitialize"))
	;splitpath a_ScriptFullPath,,,, OutNameNoExt
;	pap := "`n", Script_Title=%OutNameNoExt%.txt
	;if !fileexist(Script_Title)
;		pap := ""
	;fileAppend,% ("`n" . EventLogBuffer . ", " . Script_Title)
	DestroyAnims()
	gosub,hOOkz_Remove
}

hOOkz_init:
gosub,EVENT_HOOK
gosub,WINT_HOOK
gosub,onMSgz

EVENT_HOOK:
hOOkz:= "UProc,Proc4g_,hook4g,ProcMb_,HookMb,ProcCr_HookCr
		,ProcOD_,HookOD,procFc_,HookFc,ProcCx_,HookCx"
loop,Parse,% hOOkz,`,
	global (%a_loopfield%):= ""
;WINEVENT_OUTOFCONTEXT = 0	WINEVENT_SKIPOWNTHREAD = 1	 WINEVENT_INCONTEXT= 4	;
;WINEVENT_SKIPOWNPROCESS=2	EVENT_SYSTEM_FOREGROUND= 3
hook4g:=  dllcall("SetWinEventHook","Uint",OBJ4g,"Uint",OBJ4g,"Ptr",0,"Ptr"
, Proc4g_:= RegisterCallback("on4Gnd",""),"Uint",0,"Uint",0,"Uint",OoC|SkpO)
HookFc:=  dllcall("SetWinEventHook","Uint",OBJFc,"Uint",OBJFc,"Ptr",0,"Ptr"
, procFc_:= RegisterCallback("onCntFocus", ""),"Uint",0,"Uint",0,"Uint",OoC|SkpO)
HookMb:=  dllcall("SetWinEventHook","Uint",0x0010,"Uint",0x0010,"Ptr",0,"Ptr"
, ProcMb_:= RegisterCallback("onMsgbox",""),"Uint",0,"Uint",0,"Uint",OoC)
HookCr:=  dllcall("SetWinEventHook","Uint",OBJCR,"Uint",OBJCR,"Ptr",0,"Ptr"
, ProcCr_:= RegisterCallback("onObjCreate",""),"Uint",0,"Uint",0,"Uint",OoC|SkpO)
;HookOD:=  dllcall("SetWinEventHook","Uint",OBJDS,"Uint",OBJDS,"Ptr",0,"Ptr"
;, ProcOD_:= RegisterCallback("onObjDeath",""),"Uint",0,"Uint",0,"Uint",OoC|SkpO)
Hookcx:=  dllcall("SetWinEventHook","Uint",0x0006,"Uint",0x0006,"Ptr",0,"Ptr"
, Proccx_:= RegisterCallback("onCntMen","turd"),"Uint",0,"Uint",0,"Uint",OoC)
;, HookM:= dllcall("SetWinEventHook","Uint",0x0006,"Uint",0x0006,"Ptr",0,"Ptr",UProc := RegisterCallback("ueventz",""),"Uint",0,"Uint",0,"Uint",0x0000|0x0002)
;	, initt:= dllcall("SetWinEventHook","Uint",0x0007,"Uint",0x0007,"Ptr",0,"Ptr", UProc,"Uint",0,"Uint",0,"Uint",0x0000|0x0002)
loop,parse,% (a:="OBJ4g,OBJFc,0x0010,OBJCR,OBJDS"),`,
	hooked_events.push(a_loopfield)
return,

WINT_HOOK:
gui,Slav3:New,+hWnd_Hw1nd -DPIScale ,% "no_glass" ; WM_reg Dummy gui ; (Hw1nd := WinExist() also works) ; gui,Slav3:+LastFound
gui,Slav3:Show,% "na hide x-10 y" a_screenheight+10 " w10 h10",% "SHELLH00K"
;Winset,transcolor,000000
s_Msg_id:= dllcall("RegisterShellHookWindow","UInt",_Hw1nd)
u_Msg_id:= dllcall("RegisterWindowMessage",  "Str" ,"SHELLHOOK")
UProc 	:= RegisterCallback("UEventHook","")
return,

onMSgz:
OnExit("AtExit")
run,% "C:\Script\AHK\winevent_WMHANDLA.ahk"
wm_allow()
OnMessage(0x4a,"Receive_WM_COPYDATA")
OnMessage(0x0404,"AHK_NOTIFYICON")
OnMessage(u_Msg_id,"74iLHo0k")
return,

hOOkz_Remove: ;
hOOkz:= "UProc,Proc4g_,hook4g,ProcMb_,HookMb,ProcCr_HookCr,ProcOD_,HookOD,procFc_,HookFc,ProcCx_,HookCx"
loop,Parse,% hOOkz,`,
{	dllcall("UnhookWinEvent","Ptr",a_loopfield)
	sleep,20
	dllcall("GlobalFree",    "Ptr",a_loopfield,"Ptr")
	(%a_loopfield%) := ""
} return,

Diconlablz_Toggle:
dICON_labelz:= !dICON_labelz

Dicon_Check:
_:= DesktopInfo(dICON_labelz)
SendMessage,0x1037,0,0,,ahk_id %_%	; 0x1037 - LVm_GeteXstyle ;
lv_ex_style:= errOrlevel
if(!lv_ex_style &0x10000)
	SendMessage,0x1036,lv_ex_style &0x00010000,0,,ahk_id %_%	;0x1037 --> LVm_seteXstyle
sleep,10
return,

1999:
ControlGet,CtrlHandL,hWnd,,SysTreeView321,% 1999
Chwn_:= ("ahk_id " .  CtrlHandL)
Timer("chWnd",-1200)
return,

chWnd:
TT(a_now " sdsdsamm")
winset,Style,-0x00000004,% Chwn_ ; TVM_SETEXTENDEDSTYLE := 0x112C = tvmX
winset,Style,-0x00100000,% Chwn_ ;           0x00000020  - Auto X-Scroll
SendMessage,0x112C,0,0x00003C75,% Chwn_
return,

1998:
ControlGet,CtrlHandL,hWnd,,SysTreeView321,% 1998
winset,Style, +0x00000202,%  "ahk_id " . CtrlHandL
return,

GoGoGadget_Cl0ck: ; sidebar-clock click-thru
winget,Time_hWnd,iD,% "HUD Time",
if(errOrlevel)
	msgbox,% errOrlevel " err0r"
else,winset,ExStyle,0x000800A8,% ("ahk_id " . Time_hWnd) ; winset, ExStyle, 0x000800A8, M oon P hase I I
return,

;-~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_

Toggle_M2Drag_Bypass:
; ttt:= "ADhKI.ahk - AutoHotkey", result:= Send_WM_COPYDATA("Bypass_Last_Dragged_GUI",ttt)
hADhKIwnd:=winexist("ADhKI.ahk ahk_class AutoHotkey")
result:= Send_WM_COPYDATA("BypassDragclass_" New_CL,"ahk_id " hADhKIwnd)
result:= Send_WM_COPYDATA("Parsebypassclass","ahk_id " hADhKIwnd)
return,

;-~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_

MiDiRun:
run,% MiDiRun
return,

;-~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_~_

toggle_sysmenu:
toggle_DLGFRAME:
toggle_thickframe:
toggle_modalframe:
toggle_border:
toggle_raisededge:
toggle_sunkenedge:
toggle_staticedge:
toggle_3dedge:
toggle_MinBox:
toggle_Maxbox:
toggle_hscroll:
toggle_vscroll:
toggle_LeftScroll:
toggle_Clickthru:
toggle_RightAlign:
toggle_RightoLeft:
toggle_AppWindow:
msgbox % a_thislabel
switch,a_thislabel {
	case,"toggle_sysmenu","toggle_DLGFRAME","toggle_thickframe"
	,"toggle_border","toggle_MinBox","toggle_Maxbox"
	,"toggle_hscroll","toggle_vscroll": winset,Style,stylearr[ a_thislabel ],% ("ahk_id " . A_new_hWnd )
	case,"toggle_modalframe","toggle_raisededge","toggle_sunkenedge"
	,"toggle_staticedge","toggle_3dedge","toggle_LeftScroll"
	,"toggle_Clickthru","toggle_RightAlign","toggle_RightoLeft"
	,"toggle_AppWindow": winset,ExStyle,stylexarr[ a_thislabel ],% ("ahk_id " . A_new_hWnd )
} goto,ResetMenu

PushNewSave:
if TProcName	;regKey contains unique combo of info picked by user as a search key allowing for combinations of style & extended, classnamed, title and procname.====--------====
	regWrite,REG_SZ,HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag\Styles\procname
	,% Style . "»" . exStyle . "»" . "µ" . savePN . "µ" . save_new_Title . "µ" . save_new_cl,% savePN
if TTitle
	regWrite,REG_SZ,HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag\Styles\wintitle
	,% Style . "»" . exStyle . "»" . "µ" . savePN . "µ" . save_new_Title . "µ" . save_new_cl,% save_new_Title
if TClass
	regWrite,REG_SZ,HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag\Styles\classname
	,% Style . "»" . exStyle . "»" . "µ" . savePN . "µ" . save_new_Title . "µ" . save_new_cl,% save_new_Class
return,

SaveGUISubmit:
gui,SaveGuI: Submit,nohide
return,

SaveGUIDestroy:
gui,SaveGuI: Destroy
TProcName:= TTitle:= TClass := ""
return,

isClassBypass(testClass) {
	static RegBase:= "HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag"
	regRead,Bypass_ClassList,%	RegBase,Blacklist_ClassList
	return,(instr(Bypass_ClassList,"," testClass))? True : False
}

;------------==========================++++++++++++++++++++*+*+*+*

;~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~

;------------==========================++++++++++++++++++++*+*+*+*

RegReads: ; -=-==-=====-= REG READZ =-=-=---2232-==--@~@'''~~--__
gosub,jewclawread
gosub,UIBandGet
regRead,AEWhiteCl,HKEY_CURRENT_USER\Software\_MW\blacklist\AEWhiteCl, AEBlackCl
regRead,AEBlackCl,HKEY_CURRENT_USER\Software\_MW\blacklist, AEBlackCl
regRead,AEahkWhite,HKEY_CURRENT_USER\Software\_MW\blacklist, AEahkWhite
regRead,AEahkblack,HKEY_CURRENT_USER\Software\_MW\blacklist, AEahkblack
;msgbox % "b " AEBlackCl "`nw" AEWhiteCl;msgbox %  AEWhiteCl ;gosub,	reg_tray_read
AhkPath	:= errOrlevel ? "" : AHKdir "\AutoHotkey.exe",.
keys	:= "HKCU\SOFTWARE\_MW\Icons\cl,HKCU\SOFTWARE\_MW\Icons\pn,HKCU\SOFTWARE\_MW\mousewheel"
loop parse, keys, `,
{
	key_:= A_Loopfield
	Loop,Reg,% key_,KV
	{
		keyN_:= A_LoopRegName
		regRead, v_
		StringTrimLeft,db,key_,24
		icon_%db%_arr[keyN_]:= v_
}	}
Loop,Reg,% wintitlekey
{
	if(A_LoopRegType="REG_SZ") {
		Value1:= A_LoopRegKey . "\" . A_LoopRegSubKey
		regRead,Value2,%Value1%,% A_LoopRegName
		Style_wintitleList2:= Style_wintitleList2 . Value2 . "‡"
		retpos:= RegEXMatch(A_LoopRegName,"^0.{9}",       ret_style,  p0s:= 1)
		retpos:= RegEXMatch(A_LoopRegName,"(\»)\K(.{10})",ret_exstyle,p0s:= 1)
		Array_wintitleList.push(ret_style . "»" . ret_exstyle . "»" . "µ" . Value2)
}	}
Loop, Reg,% procnamekey
{
	if(A_LoopRegType="REG_SZ") {
		Value1:= A_LoopRegKey . "\" . A_LoopRegSubKey
		regRead,Value2,%Value1%,% A_LoopRegName
		Style_procnameList2:= Style_procnameList2 . Value2 . "‡"
		retpos:= RegEXMatch(A_LoopRegName, "^0.{9}" ,ret_style,p0s:= 1)
		retpos:= RegEXMatch(A_LoopRegName, "(\»)\K(.{10})",ret_exstyle,p0s:= 1)
		Array_ProcnameList.push(ret_style . "»" . ret_exstyle . "»" . "µ" . Value2)
}	}
Loop,Reg,% classnamekey
{
	if(A_LoopRegType="REG_SZ") {
		Value1:= A_LoopRegKey . "\" . A_LoopRegSubKey
		regRead,Value2,%Value1%,% A_LoopRegName
		Style_ClassnameList2:= (Style_ClassnameList2 . Value2 . "‡")
		retpos:= RegEXMatch(A_LoopRegName,"^0.{9}" , ret_style,p0s:= 1)
		retpos:= RegEXMatch(A_LoopRegName,"(\»)\K(.{10})" , ret_exstyle,p0s:= 1)
		Array_LClass.push(ret_style . "»" . ret_exstyle . "»" . "µ" . Value2)
}	}

UIBandGet:
ouruibc:=	[], UIB_Handl:=	[]
keys:= "HKCU\SOFTWARE\_MW\uiband"
loop,parse,keys,`,
{
	key_:= A_Loopfield
	loop,Reg,% key_,KV
	{
		loopn:= A_LoopRegName
		regRead,v_
		ouruibc.PUSH(v_)
		WinGet,uiblist,List,ahk_class %V_%
		loop,% uiblist {
			bum:= uiblist%a_iNdex%
			UIB_Handl.PUSH(bum)
			A_new_hWnd:= bum
			sleep,3000
			rThread:= ""
			gosub,UIBandSet
			sleep,300
		}
		UIBPROCESS()
}	} return,

reg_tray_read: ;; disabled
Loop,Reg,% (reg_tray_key:= "HKCU\SOFTWARE\_MW\Icons\Tray")
{
	if(A_LoopRegType="REG_SZ") {
		regRead,Value2,% ( A_LoopRegKey . "\" . A_LoopRegSubKey),% A_LoopRegName
		  tray_icon_pName_loaded:=  Value2
		(!detect_tray_pNames? detect_tray_pNames:= (Value2 . ",")
		: detect_tray_pNames:= detect_tray_pNames . Value2 . ",")
		TrayIconArr[tray_icon_pName_loaded]:= Value2
}	} return,

jewclawread:
loop,parse,% "HKCU\SOFTWARE\_MW\mousewheel", `,
{
	key_:= A_Loopfield
	loop,Reg,% key_,KV
	{
		regRead,v_
		mwheeldrag[A_LoopRegName]:= v_
}	}
regRead,Log1RZ,HKEY_CURRENT_USER\Software\_Mouse2Drag\Login,rz
if Log1RZ {
	loop,parse,Log1RZ, `,
	{
		switch,a_iNdex {
			case,"1" : Log1_RZ:= A_LoopField
			case,"2" : Pa5s_RZ:= A_LoopField
}	}	}
return,

;~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`~`

getTxTWin:
WinGetText,TxTWin,ahk_id %A_new_hWnd%
TT(((TxTWin . "`nWintext" )))
, clipboard:= TxTWin, TxTWin:= ""
return,

last_classes_handles:
for,index,element in classhwlast
	concat .= "`n" . element
tt("e " concat " "  clst_max_I " "  clht_max_I), concat:= ""
return,

last_classes_names:
for,index,element in classeslast
	concat .= "`n" . element
tt("e " concat " "  clst_max_I " "  clht_max_I), concat:= ""
return,

last_classes_handles2:
for,index,element in clsShWnd_L2
	concat .= "`n" . element
tt("e " concat " "  clst2_max_I " "  clht2_max_I), concat:= ""
return,

last_classes_names2:
for,index,element in CLsS_Last
	concat .= "`n" . element
tt("e " concat " "  clst2_max_I " "  clht2_max_I), concat:= ""
return,

;------------=========================++++++++++++++++++++*+*+*+*
; ^!j::
; Shell_Restart()
; return,
;------------==========================++++++++++++++++++++*+*+*+*

ServiceRRestart:  ;0 = OK
SvcRestartSound:
SvcRestartWacom:
switch,a_thislabel {
	case,"SvcRestartWacom" : Target_Service:= "WTabletServicePro"
	case,"SvcRestartSound" : Target_Service:= "Audiosrv"
} run,%AHKdir%\AutoHotkeyU64_UIA - admin.exe C:\Script\AHK\z_ConTxt\servicerestart.ahk %Target_Service%
return,

ServiceChkRResult:
if result {
	tries += 1
	if(tries>5) {
		msgbox,% ("unable to Restart the " . Target_Service . " service")
		exit,
	} TT("Restarting " Target_Service)
	sleep,2000
	result:= service_Restart("WTabletServicePro")
} else,ttp(("Success..`nThe" Target_Service " Restarted succesfully" A_now))
return,

;------------==========================++++++++++++++++++++*+*+*+*
32770Fix:
;return,; mitigations disabled atm
wingetClass,Cls_A,a
if !(Cls_A="#32770") {	; "Save as" & "Open" dlgs called from the eventHook.
	winwaitActive,% "ahk_class #32770" ;  * takesawhile to visually materialise ui,hence prev.
	wingetClass,Cls_A,a
} if(Cls_A="#32770")  {	; "Active" is not actually ready to be drawn over.
	WinGetActiveStats,Tata,W_idth,H_eight,sex,sexx
	if((W_idth<800)||(H_eight<700)) {
		TT("Saved annoyance for later`n" Tata "`n" W_idth "`n" H_eight "`n" sex "`n" sexx,200)
		return,
	} Fix32700list.= (FixTargethW:= WinExist("A")) . ","
	while,(!(IsWindowVisible(FixTargethW))) {
		sleep,300
		if(a_iNdex>50)
			return,
	} sleep,170

	gdipfix_start:
	loop,1 { ;tries:= 1
		Nnn:= Gdip_Startup(), dcC:= GetDC(FixTargethW)
		,mDC:= Gdi_CreateCompatibleDC(0)
		,mBM:= Gdi_CreateDIBSection(mDC,1,1,32)
		,oBM:= Gdi_SelectObject( mDC,mBM )
		a:=dllcall("gdi32.dll\SetStretchBltMode","Uint",dcC,"Int",5)
		loop,2 ; winset,exstyle,+0x02080000,ahk_id %FixTargethW%
			b:=dllcall("gdi32.dll\StretchBlt","Uint",dcC,"Int",0,"Int",0
		,	"Int",a_screenwidth,"Int",a_screenheight,"Uint",mdc,"Uint",0
		,	"Uint",0,"Int",1,"Int",1,"Uint","0x00CC0020")
		Gdip_Shutdown(Nnn) ;if (a=0 || b=0 || tries< 8){; tries += 1,
}	} return,

DpiAwareset:	; dpiinject(A_new_hWnd)
TT("currently disabled`n(NOT HOOKED)",4)
return,

DPIhw:
mousegetpos,x,y
msgbox,% DpiAwareset "CUNT!"
try,gui,DPIhw:	destroy
gui,DPIhw:New, -Caption +toolwindow +owner -SysMenu +hWndhWnd_DPIhw,
gui,DPIhw:Add,	Button,w80 y1 x1 gDPIhw_perform,OK (Enter)
gui,DPIhw:Add,	Button,x88 y1 w80 gCancel,Cancel (Esc)
gui,DPIhw:Add,	DropDownList,w232 x175 y1 vChoice,% Choices
gui,DPIhw:Show,x-600 y-400
gui,DPIhw:Submit,Hide
win_move(hWnd_DPIhw,x-300,y-30,"","","")
Win_Animate(hWnd_DPIhw,"activate hneg slide",500)
gui,DPIhw:+0x00840000
gui,DPIhw:Submit,Nohide
return,

DPIhw_perform:
gui,DPIhw:Submit,Nohide
return,

Baggy: ;Magnifier-thru-msg;
fad3out:
switch,A_Thislabel {
	case,"fad3out" :SendWM_CoPYData("fad3out","M2DRAG_MAG.AHK AutoHotkeyGUI")
	case,"baggy" : run,% Mag_Path ;:= "C:\Program Files\Autohotkey\AutoHotkeyU64_UIA.exe C:\Script\AHK\Working\M2DRAG_MAG.AHK"
} return,

#5::
Desktop_areaCheck:
VarSetCapacity(D_Rekt, 16)
success:= DllCall("SystemParametersInfo","uint", 0x0030,"uint",0,"uint",&D_Rekt,"uint",0)
vWinY  := NumGet(&D_Rekt,4,"Int")
if(vWinY>70) {
	desktop_custom_enabled:= true
	menu,Exp_DTop,check,%   "Desktop Area Custom"
} else {
	desktop_custom_enabled := false
	menu,Exp_DTop,uncheck,% "Desktop Area Custom"
} return,

FolderContentsInfoTiptoggl:
ExpFolderContentTT:= !ExpFolderContentTT
regWrite,REG_DWORD,% "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",% "FolderContentsInfoTip",% ExpFolderContentTT
sleep,200

ExpFolderContentTT:
regki:=""
regRead, ExpFolderContentTT,% "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced", FolderContentsInfoTip
menu,Exp_main,% (ExpFolderContentTT? "check":"uncheck"),%   "Folder-Content Tooltip"
return,

WM_COPYDATA_1:
if((_nu:=substr(CopyOfData,1,1))="q") {
	Cata:= LTrim(CopyOfData,"q")
	res2:= invokeverb(Cata,"Enqueue")
	return,
} else,if(instr(CopyOfData,"Þ")) {
	if !FileListStr {
		FileListStr:=CopyOfData, FileCount:=1
	} else, FileListStr:=(FileListStr . CopyOfData), FileCount:=(FileCount + 1)
	FileListStrGen(Delimiter:="Þ")
} else,switch,CopyOfData {
	case,"StyleMenu" : settimer,Stylemenu_init,-1
	case,"Tray_" : settimer,Trayiconmenu,-1
	case,"trayremove" : minHoldr_pid_Found(CopyOfData)
	case,"mag_" : gosub,% mag_
	default : if(islabel(CopyOfData))
		SetTimer,% CopyOfData,-1
} return,

WM_COPYDATA_2:
Cata:= LTrim(CopyOfData,"x")
sleep,40
cata:= ""
return,

ThemeTestFileChk:
ThemeTest_File1:=    fileexist("C:\windows\resources\themes\test.theme")
if(!ThemeTest_File1:=fileexist("C:\windows\resources\themes\test.theme"))
||(!ThemeTest_File2:=fileexist("C:\windows\resources\themes\test\test.msstyles"))
	 msgbox,%	"Test.Msstyles MiA"
else,traytip,%	"File attrib query",% "Test.msstyles and Test.theme present & correct! OK"
return,

BrightnessFloater:
run,% BrightnessFloater:= "C:\Script\AHK\GUi\DisplayBrightnessSlider.ahk" ;tt(CTRL + Win + Click -> on the desired brightness Slider position,3000)
return,

ApplyMSStyles: ; or Basic / Aero ;
cmd=
(LTrim
	C:\Windows\system32\rundll32.exe C:\Windows\system32\shell32.dll,Control_RunDLL C:\Windows\system32\desk.cpl desk,@Themes /Action:OpenTheme /file "C:\Users\ninj\AppData\Local\Microsoft\Windows\Themes\p00p.theme"
)
return,

AeroTheme_Set:
if(!fileexist("c:\windows\resources\themes\test\test.msstyles"))
	msgbox,% "Test.Msstyles MiA"
else {
	regwrite,REG_SZ,% (HKCUCV . "\ThemeManager"),DllName,% test_aero_style
	regwrite,REG_SZ,% (HKCUCV . "\Themes\Personalize"),CurrentTheme,% test_aero_style2
	regwrite,REG_SZ,% (HKCUCV . "\Themes"),CurrentTheme,% test_aero_theme
} return,

PIPEEXEC:
runc(quote("C:\Program Files\Autohotkey13602\AutoHotkeyU64.exe") . " " quote(PIPEEXEC))
sleep,4000
Aero_BlurWindow(s:= winexist("-AHK-P|p3-"))
return,

Window_Kidnap() ;Window_Kidnap:
Control_kidnap()

dtop_WinKidnap:
(!instr(dtopchildren,A_new_hWnd)? ((dtopchildren.=A_new_hWnd ","), dtopWinKidnap(A_new_hWnd), dtopchildren.= A_new_hWnd . "," ) )
return,

DTop_WinRelease:
 (!instr(dtopchildren,A_new_hWnd)?msgb0x("not in list anyway"))
dtopchildren:= strreplace(dtopchildren,A_new_hWnd "," ), dtopWinRelease(A_new_hWnd)
return,

AE_ADD2WL:
if(instr(new_PN,"AutoHotkey")){
	scriptUnc:= scriptpath(new_Pid) . ","
	if(instr(AEahkBLack,scriptUnc)) {
		strreplace(AEahkBLack,scriptUnc)
		regwrite,REG_SZ,HKEY_CURRENT_USER\Software\_MW\Blacklist,AEahkBLack,% AEahkBLack
	} if(!instr(AEahkWhite,scriptUnc)) {
		msgbox not instr %A_LineNum%
		AEahkWhite.=scriptUnc
		regwrite,REG_SZ,HKEY_CURRENT_USER\Software\_MW\blacklist,AEahkWhite,% AEahkWhite
	} else,msgb0x(scriptUnc " already in list")
} else {
	if(instr(AEBlackCl, _:= ( new_cl . "," ))) {
		strreplace(AEBlackCl,(new_cl . ","),"")
		regwrite,REG_SZ,HKEY_CURRENT_USER\Software\_MW\Blacklist,AEBlackCl,% AEBlackCl
	} else,if(!instr(AEWhiteCl, _:= ( new_cl . "," ))) {
		AEWhiteCl.=_
		regwrite,REG_SZ,HKEY_CURRENT_USER\Software\_MW\blacklist,AEWhiteCl,% AEWhiteCl
}	} Aero_BlurWindow(A_new_hWnd)
return,

AE_ADD2BL:
if(instr(AEWhiteCl,_:= ( new_cl . "," ))) {
	strreplace(AEWhiteCl,(new_cl . ","),"")
	regwrite,REG_SZ,HKEY_CURRENT_USER\Software\_MW\blacklist,% AEWhiteCl,% AEWhiteCl
} else,if(!instr(AEBlackCl,_:= ( new_cl . "," ))) {
	AEBlackCl.=%_%
	regwrite,REG_SZ,HKEY_CURRENT_USER\Software\_MW\blacklist,% AEBlackCl,% AEBlackCl
} return,

aero2ahktoggle:
aero2ahk:= !aero2ahk
if(!aero2ahk) {
	strreplace(AEWhiteCl,"AutoHotkey,")
	strreplace(AEWhiteCl,"AutoHotkeyGUI,")
	menu,Script_main,	uncheck,%	"toggle aero on ahk ",
} else {
	AEWhiteCl.="AutoHotkey,AutoHotkeyGUI,"
	menu,Script_main,	check,%	"toggle aero on ahk ",
} msgbox,% "aewh" AEWhiteCl
return,

StyleMenu_Show: ;l=[][][][[[]l=[][][][[[]l=[][][][[[]
global Handle:= MenuGetHandle("F")
menu,F,Show
return,

;`~	;`~	;`~	;`~	;`~	;`~	;`~	;`~
UIBandSet:
UIBandSet2:
UIB_Handl.push(A_new_hWnd)
rThread:= ""
Process,Exist,explorer.exe
pid_:= errOrlevel
dllFile:= FileExist("AutoHotkeyMini.dll") ? "C:\Program Files\AHK\LiB\minhook\x64\AutoHotkeyMini.dll"
		: (A_PtrSize = 8) ? "C:\Program Files\AHK\LiB\minhook\x64\AutoHotkeyMini.dll"
		: "C:\Program Files\AHK\LiB\minhook\x32\AutoHotkey.dll"
uibcode:= "
(LTrim
	SetWorkingDir,%A_ScriptDir%
	#Include C:\Program Files\AHK\LiB\minhook\x64\MinHook.ahk
	address_SetWindowBand:= dllcall(""GetProcAddress"",""Ptr"",dllcall(""GetModuleHandle"",Str,""user32"",""Ptr""),AStr,""SetWindowBand"",""Ptr"")
	hook1:= New MinHook("""",address_SetWindowBand,""SetWindowBand_Hook"")
	hook1.Enable()
	send,{LWin}
	return,
	SetWindowBand_Hook(hWnd,hWndInsertAfter,dwBand)
	{
	global  hook1
	return,dllcall(hook1.original,""ptr"",%A_new_hWnd%,""ptr"",0,""uint"",%ZBID_UIACCESS%)
	}
)" ;rThread:=InjectAhkDll(pid_,dllFile,"") ;rThread.Exec(uibcode)
AppVisibility:= ComObjCreate(CLSID_AppVisibility:= "{7E5FE3D9-985F-4908-91F9-EE19F9FD1514}",IID_IAppVisibility := "{2246EA2D-CAEA-4444-A3C4-6DE827E44313}")
if(a_thislabel="UIBandSet2")
	return,
LABElA(lbl:= a_thislabel)
return,

LABElA(LbL) {
	listlines off
	switch,LbL	{
		case,"AdHkRun": msgbox cuntguh
		settimer,reload_orload_admhk,-1
		default: run,% (%LbL%)
			TT("Launching " LbL "...")
			trayTip,% ":AHK_L	",% %LbL% " - " id3Ttl,.5,0x31
}	}

;	LAbeL Ladder ; Idea had b4 realised switch,case,handler func doh
AdHkRun: ; menu, tray, check,% "Launch " a_thislabel ; swap wih a dictionary for titles ;
mDWM2:	; []()<>()[]()<>()[]()<>()[]()<>()[]()<>()[]()<>()[]()<>()[]()<>()[]()<>
wm_sift:	; []()<>()[]()<>()[]()<>()[]()<>()[]()<>()[]()<>()[]()<>()[]()<>()
Mag_:		; []()<>()[]()<>()[]()<>()[]()<>()[]()<>()[]()<>()[]()<>
MiDi_:		; []()<>()[]()<>()[]()<>()[]()<>()[]()<>()[]()<>
CleanME:	; []()<>()[]()<>()[]()<>()[]()<>()[]()<>()[](
NPInsert:	; []()<>()[]()<>()[]()<>()[]()<>()[]()<>()
DWMFixS:	; []()<>()[]()<>()[]()<>()[]()<>()[]()<>
PConfig:	; []()<>()[]()<>()[]()<>()[]()<>()[
clsids:		; []()<>()[]()<>()[]()<>()[]()<>(
WMPRun:		; []()<>()[]()<>()[]()<>()[]()<
M2dRun:		; []()<>()[]()<>()[]()<>()[]
YT_DL:		; []()<>()[]()<>()[]()<>()
ahk_rare:	; []()<>()[]()<>()[]()<>()
syscols:
SysMetr:
LABElA((Your_Label_Sir:= a_thislabel))
return,

Cntdn:
winget,asa,id,% "Modified script:"
clipboard:= asa,TT(asa),CarolVorderman(asa)
return,

countdownmymsgbox:
settimer,cntdn,-500
return,

;--=---=--=--=--=--=--=taskbar / window icons-=---=--=--=--=--=--=

TRAYicons_init:
(_:= WinExist("C:\Script\AHK\anitray.ahk")? gosub("TRAYicons_destroy"))
runc("C:\Program Files\Autohotkey\AutoHotkey.exe C:\Script\AHK\anitray.ahk")
return,

TRAYicons_Destroy:
if(!_:=WinExist("anitray.ahk"))
	return,
winget,anipiid,pid,ahk_id %_%
SendMessage,0x0111,65307,,,ahk_pid %anipiid% ;,% (anitray.ahk " - AutoHotkey") ; ID_TRAY_EXIT=65307
sleep,1100
errOrlevel? msgb0x(errOrlevel " `nBest to manually kill anitray and all animate_targets"):()
WinExist("anitray.ahk")? (msgb0x("trouble closing anitray",3), ProcessClose(_)):()
return,

Window_Icon_New:
window_UIBAND_New:
wingettitle,tt_,% New_hW_TlStr
winGet,pn_,processname,% New_hW_TlStr
wingetClass,Cl_,% New_hW_TlStr
switch,a_thislabel {
	case,"Window_Icon_New"   : regkeyname:= "Icons"
	case,"window_UIBAND_New" : regkeyname:= "UIBand", New_Icon_Path := Cl_
} if(a_thislabel="Window_Icon_New") {
	fileSelectFile,New_Icon_Path,Options,C:\ICON\,% pn_ "Icon Selector" ,% "Icun (*.ico)"
	if fileexist(New_Icon_Path) {
		WindowIconSet(A_new_hWnd,New_Icon_Path)
		msgbox,% ("ok Icon will be saved for " . pn_)
	} else {
		msgbox,% New_Icon_Path ". error with selected file."
		return,
}	}

if(!IProcName&&!ITitle&&!IClass) {
	if(!(a_thislabel="Window_Icon_New")) {
		msgbox,% "this time then..."
		gosub,UIBandSet
		return,
	} else,WindowIconSet(A_new_hWnd,New_Icon_Path)	;one off change	; apply the new icon else; check the saved critera field
} else,((!IProcName && ITitle && !IClass)? action_:= "tt" : ((!IProcName && !ITitle && IClass)? action_:= "cl" :
, ((IProcName && !ITitle && !IClass)? action_:= "pn" : action_:= "pn", New_Icon_Path:= (New_Icon_Path . " *"))))
typeid=%action_%_
icon_%action_%_arr[%typeid%] := New_Icon_Path		; set array member up for current session
if(a_thislabel="Window_Icon_New") {
	regWrite,% "REG_SZ",% ("HKEY_CURRENT_USER\SOFTWARE\_MW\" . regkeyname . "\" . action_),% %typeid%,% New_Icon_Path
	WindowIconSet(A_new_hWnd,New_Icon_Path)			; apply the new icon
} else {
	regWrite,% "REG_SZ",% ("HKEY_CURRENT_USER\SOFTWARE\_MW\" . regkeyname),% %typeid%,% New_Icon_Path
	gosub,UIBandGet
	gosub,UIBandSet
} return,

windowiconRem:
WindowIconSet(A_new_hWnd,Ppath)
loop,parse,% "new_cl,new_Pn,new_tt",`,
{
	icon_Path_temp_:= a_loopfield
	stringTrimLeft,iid_grp,icon_Path_temp_,4
	regdelete,% ("HKEY_CURRENT_USER\SOFTWARE\_MW\Icons\" . iid_grp),% (%icon_Path_temp_%)
	tem=icon_%iid_grp%_arr
	%tem%.pop(%icon_Path_temp_%)
} icon_Path_temp_:= ""
winget,ppath,ProcessPath,% New_hW_TlStr
return,

windowuibandRem:
re:= mnbmUIB_Handl.delete(new_cl)
return,

window_iconset_guiDestroy:
gui,window_iconset_gui:destroy
return,

window_iconset_guiSubmit:
gui,window_iconset_gui:Submit
gosub,Window_Icon_New
return,

window_UIBand_GuiSubmit:
gosub,UIBandGet

gui,window_iconset_gui:Submit
goto,window_UIBAND_New

iconspacing:
SPI_ICONSPACINGSET(64,53)
return,

;--=---=--=--=--=--=--=tray-=---=--=--=--=--=--=;';';'
Tray_new_icon:
Tray_new_anicon: ;gosub TRAYicons_refresh
(a_thislabel="Tray_new_anicon"? browsestartpath:= "C:\Icon\animations"  : browsestartpath:=	"C:\Icon\32")
fileSelectFile,New_Icon_Path,Options,% BrowseStartPath,% pn_ "Icon Selector" ,% "Icun (*.ico)"
(!(fileexist(New_Icon_Path))? return())
try,hHh:= Tray_IconInfoArr[Tray_target_pos].hWnd
catch,
	sleep,60
try,uuU:= Tray_IconInfoArr[Tray_target_pos].uid
catch,
	sleep,60
if (a_thislabel="Tray_new_anicon") {
	tray_target_PN:= "Ani" . tray_target_PN
	msgbox,% "hw not used " trayhw "`ndffdf " uuu "`nd  " hHh
	run,"C:\Program Files\Autohotkey\AutoHotkey.exe" "C:\Script\AHK\stixman_runnin\animate_target.ahk" "%New_Icon_Path%;%hHh%;%uuu%",,hide,anipidNEW
	regWrite,REG_SZ,HKEY_CURRENT_USER\SOFTWARE\_MW\Icons\Tray,% (tray_target_PN . "»" . tray_target_uid .  "µ" . tray_target_title ),% New_Icon_Path
	ANIPID.PUSH(anipidNEW)
	return,
} Tray_Target_hicon:= ICO2hicon(New_Icon_Path)
TrayIcon_Set(hHh,uuU,Tray_Target_hicon)
tray_new_hicon:= ICO2hicon(New_Icon_Path)
regWrite,REG_SZ,HKEY_CURRENT_USER\SOFTWARE\_MW\Icons\Tray,% (tray_target_PN . "»" . tray_target_uid .  "µ" . tray_target_title ),% New_Icon_Path
traytip,% "Success",% ("Icon will be saved for " . Tray_Target_PN)
return,

SteamIconChkTEST:
loop,4 {
	if(CLsS_Last[RES:=((clst2_max_I-5)+a_iNdex)] = "SDL_app")
		Iconchange_Check(Format("{:#x}",clsShWnd_L2[RES]),"","steamwebhelper.exe") ;settimer,
	sleep,35
}
return,

TRAYicons_refresh: ;return
cnt:=""
(a_thislabel="TRAYicons_refresh")? allowedtray:= True : allowedtray:= False
Tray_IconInfoArr:= TrayIcon_GetInfo()
loop,parse,% "Shell_TrayWnd,NotifyIconOverflowWindow", `,
{
	idxTB:= TrayIcon_GetTrayBar(a_loopfield)
	wintitlec =ahk_class %a_loopfield%
	switch a_index {
		case "1":
			SendMessage,0x0418,0,0,ToolbarWindow32%idxTB%,% wintitlecc
			global Tray_MainCount:= ErrorLevel
		case "2":
			SendMessage,0x0418,0,0,ToolbarWindow32%idxTB%,% wintitlecc
			global Tray_OverflowCount:= ErrorLevel
}	}
Tray_FullCount:= Tray_OverflowCount +Tray_MainCount
loop,%Tray_FullCount% {
	_PN_:= Tray_IconInfoArr[a_index].process
	Tray_Target_PN:= _PN_
	global FullCnt_index:= a_index
	for,index,element in TrayIconArr
	{
		trayarr_index:= index
		if( nt03:= instr(trayarr_index,"Ani_")) {
			n15:= strreplace(trayarr_index,"Ani_","")
			if !instr(ani_concats,n15 ) {
				if (n15=_PN_) {
					if	!ani_concats
						 ani_concats:=	 n15
					else,ani_concats .= "," n15
					ass:= Tray_IconInfoArr[FullCnt_index].process
					hhh:= Tray_IconInfoArr[FullCnt_index].hwnd
					UuU:= Tray_IconInfoArr[FullCnt_index].uid
					if hhh and allowedtray
					{
						TrayIconArr[ tray_icon_pName_loaded ]:= Tray_IconInfoArr[trayarr_index]
						pnt:= Tray_IconInfoArr[FullCnt_index].process
						bbh:= TrayIconArr[trayarr_index]
						run, "C:\Program Files\Autohotkey\AutoHotkey.exe" "C:\Script\AHK\stixman_runnin\animate_target.ahk" "%bbh%;%hhh%;%UuU%",,hide,AniPidNEW
						AniPid.push(AniPidNEW)
	}	}	}	}	}
	if(instr(detect_tray_pNames, Tray_Target_PN)) {
		hHh := Tray_IconInfoArr[a_index].hwnd
		uuU := Tray_IconInfoArr[a_index].uid
		hick:= TrayIconArr[Tray_Target_PN]
		Tray_Target_hicon:= ICO2hicon(hick)
		if(allowedtray)
			TrayIcon_Set( hHh, uUu, Tray_Target_hicon)
		msgbox,pakt
}	}
return,

Tray_FullCount() {
	listlines,off
	loop,
		if (ldoc:= Tray_IconInfoArr[a_iNdex].tray) {
		 if(ldoc= "NotifyIconOverflowWindow")
			_maXiNdeX:=a_iNdex,(!Tray_MainCount? Tray_MainCount:=a_iNdex-1,)
		} else,break,
	return,_maXiNdeX
}

TrayiconMenu:
gosub,trayicons_refresh
MouseGetPos,tx,ty,trayhw
wingetclass,tray_target_Parent,% ("ahk_id " . trayhw)
tray_target_hWnd:= Format("{:#x}",trayhw)
if ((tray_target_Parent="Shell_TrayWnd")||(tray_target_Parent="NotifyIconOverflowWindow")) { ;compensate array member for which tray is host to target
	if !(tray_target_Parent	 = "NotifyIconOverflowWindow") {
		tray_target_tloc	:= Tray_target_Parent
		Tray_target_pos		:= ((TrayIcon_GetHotItem()) + 1)
		Tray_arr_target_pos	:= Tray_target_pos
		try,tray_target_pn	:= (Tray_IconInfoArr[Tray_target_pos].process )
	} else,if (tray_target_Parent = "NotifyIconOverflowWindow") {
			tray_target_tloc:= tray_target_Parent
		Tray_arr_target_pos	:= (Tray_target_pos:= (( res:= (TrayIcon_GetHotItem()) + 1) +Tray_MainCount))
		try,tray_target_pn	:= Tray_IconInfoArr[Tray_arr_target_pos].process
	}	wingettitle,tray_target_title,ahk_id %tray_target_hWnd%
	tray_target_uid:= Tray_IconInfoArr[Tray_arr_target_pos].uid
	tray_target_idx:= Tray_IconInfoArr[Tray_arr_target_pos].idx
	tray_target_idc:= Tray_IconInfoArr[Tray_arr_target_pos].idCmd
	tray_target_hw := Tray_IconInfoArr[Tray_arr_target_pos].hWnd
	global 			ZZZ:= Tray_IconInfoArr[Tray_arr_target_pos].hicon
	TrayMen(tray_target_pn)
} return,

Tray_HiddenList:
TT("bicker digger dugdigs")
return,

Tray_TargetHide:
msgbox,% "c" tray_target_idc "`n" tray_target_tloc
TrayIcon_Hide(tray_target_idc,tray_target_tloc,True)
return,

tray_targetremove:		;TrayIcon_Remove(tray_target_hWnd,tray_target_uid)
TrayIcon_Hide(tray_target_idc,tray_target_tloc,True)
msgbox,% tray_target_hWnd "`n" tray_target_uid "`n" tray_target_idx "`n" tray_target_tloc
TrayIcon_Delete(tray_target_idx,tray_target_tloc)
return,

TrayItem_ExplorerLoc:
tray_target_hWnd:= Tray_IconInfoArr[Tray_arr_target_pos].hWnd
WinGet,tray_target_UNCPath,ProcessPath,ahk_id %tray_target_hWnd%
TT(tray_target_UNCPath)
OpenContaining(tray_target_UNCPath)
return,

Tray_Tooltip_edit:
tray_target_tt:= Tray_IconInfoArr[Tray_arr_target_pos].tooltip
gui,TTT:New,+hWndTTTParent -DPIScale +toolwindow +owner -SysMenu +AlwaysOnTop +0x94C60000,% ("Set tooltip for " . Tray_Target_PN)
hModuleME := dllcall("kernel32.dll\LoadLibrary",Str,"msftedit.dll",Ptr)
Gui,	Add,Custom,% " ClassRICHEDIT50W r1 vsn0bby"
ControlSetText,RICHEDIT50W1,% tray_target_tt,% "ahk_id " TTTParent
gui,TTT:Add,CheckBox,Checked vSaveTTT,% "Save as default"
Gui,TTT:Add,Button,gTTTsubmit Default w80,OK
Gui,TTT:Add,Button,gTTTcancel w80,Cancel
tx +=-50
ty +=30
Gui,TTT: Show,x%tx% y%ty% w400 h200 noactivate
Aero_BlurWindow(TTTParent)
return,

TTTsubmit: ; sn0bby
Gui,TTT: Submit
tray_target_hWnd:= Tray_IconInfoArr[Tray_arr_target_pos].hWnd
tray_hWnd := WinExist(("ahk_class " . tray_target_tloc))
Tray_newTT:= "test1cl3s"
Tray_Modify( tray_target_hWnd,tray_hWnd,"",Tray_newTT )
Gui,TTT: Destroy
msgbox,% "not implemented in unicode 64bit"
return,
TTTcancel:
Gui,TTT: Destroy
return,
TrayItemProperties:
switch,tray_target_tloc {
	case,"Shell_TrayWnd" : tray_target_tlocm:= "Systray(Main)"
	case,"NotifyIconOverflowWindow" : tray_target_tlocm:= "Systray(Overflow)"
}
try,tray_target_hWnd:= (Format("{:#x}",tray_target_hWnd))
catch,
	sleep,40
wingettitle,tray_target_title,% "ahk_id " tray_target_hWnd
details =% (("Location: " tray_target_tlocm "`niDx (0 based position): ") . ZZZ:=Tray_IconInfoArr[Tray_arr_target_pos].idx "`nProcName: " . ZZZ:=Tray_IconInfoArr[Tray_arr_target_pos].process "`nWinClass: " . ZZZ:=Tray_IconInfoArr[Tray_arr_target_pos].class "`nWinTitle: " tray_target_title "`nTrayToolTip: " . tray_target_tt:=Tray_IconInfoArr[Tray_arr_target_pos].tooltip) "`nPID: " . ZZZ:=Tray_IconInfoArr[Tray_arr_target_pos].pid    "`nWindow Handle: " tray_target_hWnd "`niDcmd: " . ZZZ:=Tray_IconInfoArr[Tray_arr_target_pos].idcmd   "`nIcon Handle: " Format("{:#x}",ZZZ:=Tray_IconInfoArr[Tray_arr_target_pos].hicon) "`nIconUID: " . ZZZ:=Tray_IconInfoArr[Tray_arr_target_pos].uid ;
msgbox,% " details  " details
details:= ""
return,

reload_orload_admhk: ; reload_orload_admhk:
if(!aasa:=check_ADMHOTKEY()) {		; (!(aasa:=check_ADMHOTKEY())? run(AdHkRun) : Timer("admhotkey_reload_",-1))
	run,% comspec " /c " AdHkRun
} else,settimer,admhotkey_reload_,-1
return,

admhotkey_reload_:
PostMessage,0x0111,65303,,,% "ADhKi.ahk - AutoHotkey" ;msgbox % errOrlevel
return,

resetbothdragsarrays:
mwheeldrag:= []
gosub,mouselockdrag
gosub,MDrag_Wh
return,

mouselockdrag:
if(!mouselockdrag) {
	regwrite,REG_SZ,% "HKEY_CURRENT_USER\SOFTWARE\_MW\mousewheel",% new_PN,% "mouselockdrag"
	mwheeldrag[new_PN]:="mouselockdrag"
} else {
	regdelete,% "HKEY_CURRENT_USER\SOFTWARE\_MW\mousewheel",% new_PN
	mwheeldrag.delete(new_PN)
} Eee:= Send_WM_COPYDATA(s:= "rereadwhreg",ttt:= ("ADhKi.ahk  ahk_class AutoHotkey"))
return,

MDrag_Wh:
if(!MDrag_Wh) {
	regwrite,REG_SZ,% "HKEY_CURRENT_USER\SOFTWARE\_MW\mousewheel",% new_PN,% "MDrag_Wh"
	mwheeldrag[new_PN]:="MDrag_Wh"
} else {
	regdelete,% "HKEY_CURRENT_USER\SOFTWARE\_MW\mousewheel",% new_PN
	mwheeldrag.delete(new_PN)
} Eee:= Send_WM_COPYDATA(s:= "rereadreg",ttt:= ("ADhKi.ahk  ahk_class AutoHotkey"))
return,

_window_mintraynew:
TrayHolderExE:= """C:\Program Files\Autohotkey\AutoHotkey.exe"""
,minohlderSloc:= """C:\Script\AHK\stixman_runnin\trayholder.ahk"""
,s:= new_path . ";" . A_new_hWnd . ";" . new_PiD . ";" . new_tt
s="%s%"
run,%TrayHolderExE% %minohlderSloc% %s%,,,minholdernew
sSleep(330)
minholder.push({ "pid" : minholdernew ,"hWnd" : A_new_hWnd ,"pth" : new_path })
winhide,ahk_id %A_new_hWnd%
return,

_window_mintraycombine:
for,i in minholder
	if(minholder[i].pth=new_path) {
		if(pid_Found:= minholder[i].PiD)
			s:= new_path . ";" . A_new_hWnd . ";" . new_PiD . ";" . new_tt
		Send_WM_COPYDATA(s,t:= ("trayholder.ahk ahk_pid " . pid_Found))
		winhide,ahk_id %A_new_hWnd%
	} return,

AHKexploraInit:
AHKexploraInit:= WinExist("Explorer.ahk")
return,

Cancel:
DPIhwGuiClose:
DPIhw_GuiClose:
submittedok:= True
gui,DPIhw: Destroy
TT("dstroid")
return,
	mousegetpos,,,mhwnd
	winget,pid,pid,ahk_id %mhwnd%
	if(pid=r_pid)
		return,
Stylemen_Kilwin: ; Process,Close,% new_PiD
switch,new_PN {
	case,"steamwebhelper.exe" : winget,new_PiD,pid,% "ahk_exe steam.exe"
}
Process,Close,% new_PiD
sleep,1000
(WinExist(New_hW_TlStr)?msgb0x("fail2close"))
return,

ResetMenu:
StyleMenDel()
return,

StyleMenDel() {
	global
	listlines,off
	loop,parse,% "F,S0,S1,S2,S3,stylDPiMen,P0,P1",`,
		try,menu,%A_loopfield%,Deleteall
	loop,parse,% "mousedragwh,mindetected,mouselockdra,new_hW_TLsTr,style",`,
		(%A_loopfield%):= False
}

$^rbutton:: ; TT("Style Init:`n" . quote("ready") . "..." . sSleep(300) . " .... ",sSleep(100))
while(getkeystate("LCtrl","P"))
	sleep,5
return,

TTFocCTL_Toggle:
((TTFocCTL:= !TTFocCTL)? ("menu","SubMenu0","check","ctl focus tip")
: ("menu","SubMenu0","icon","ctl focus tip","C:\Icon\32\INFO_32.ico",,32))
Timer("Menu_Tray_Init",-1)
return,

TrayMen(T_pName) {
	if(TrayMen)
		try,menu,TrayMen,deleteall
	if(T_pName) {
		menu,TrayMen,Add,%T_pName%,% "DoNothing"
		(!zzz? zzz:= Icon_Load2(a_Path,sResName,nWidth) : menu("TrayMen","icon"
		,T_pName,"HICON: " Format("{:#x}",ZZZ)),menu("TrayMen","disable",T_pName))
	}
	menu,TrayMen,Add,,		;Separator;
	menu,TrayMen,Color,%	"0x002233"
	menu,TrayMen,Add,%		"Properties",%				"TrayItemProperties"
	menu,TrayMen,Icon,%		"Properties",%				"C:\Icon\24\info.ico"
	menu,TrayMen,Default,%	"Properties"
	menu,TrayMen,Add,%		"Open process location",%	"TrayItem_explorerloc"
	menu,TrayMen,Icon,%		"Open process location",%	"C:\Icon\24\explorer24.ico"
	menu,TrayMen,Add,,		;Separator;
	if(!(instr(T_pName,"AutoHotkey"))) {
		menu,TrayMen,Add,%	"Set icon /& save",%	"Tray_new_icon"
		menu,TrayMen,Icon,%	"Set icon /& save",%	"C:\Icon\24\AF_Icon.ico"
		menu,TrayMen,Add,%	"Set icon ( Animation seq )",% "Tray_new_anicon"
		menu,TrayMen,Icon,%	"Set icon ( Animation seq )",% "C:\Icon\24\head_fk_a_24_c2b.ico"
		menu,TrayMen,Add,%	"Reset icon",%			"DoNothing"
		menu,TrayMen,Icon,%	"Reset icon",%			"C:\Icon\24\unndoo3_0.ico"
	}
	menu,TrayMen,Add,,	;Separator;
	if(!(instr(T_pName,"AutoHotkey"))) {
		menu,TrayMen,Add,%	"Edit tooltip", %		"Tray_Tooltip_edit"
		menu,TrayMen,Icon,%	"Edit tooltip", %		"C:\Icon\24\dwm24.ico"
	}
	menu,TrayMen,Add,%	"Save item location",% "DoNothing"
	menu,TrayMen,Icon,%	"Save item location",% "C:\Icon\24\save.ico"
	menu,TrayMen,Add,%	"Add Hidden / save",% "Tray_TargetHide"
	menu,TrayMen,Icon,%	"Add Hidden / save",% "C:\Icon\24\no_entry.ico"
	menu,TrayMen,Add,%	"Delete",%						"tray_targetremove"
	menu,TrayMen,Icon,%	"Delete",%						"C:\Icon\32\32.ico"
	menu,TrayMen,Add,%	"Hidden list",%				"tray_HiddenList"
	menu,TrayMen,Icon,%	"Hidden list",%				"C:\Icon\24\no_entry.ico"
	menu,TrayMen,Show,	 ; tooltip,% A_EventInfo " "
	sleep,180 ; tooltip,% GuiContextMenu(GuihWnd,CtrlhWnd,EventInfo,IsRightClick,X,Y)
	; menu,TrayMen,DeleteAll
}

$^RButton up::
StyleMenu_Init: ; TT("Analyzing,please wait")
A_New_cname:=isahktarget:=""
StyleMenDel() ;(!Inited_StyleMen?	StyleMenDel())
MouseGetPos,,,,A_New_cname
MouseGetPos,x,y,A_new_hWnd,A_New_McTLhW,2
Inited_StyleMen:= _Fx:= True
New_hW_TlStr:= 		"ahk_id " . A_new_hWnd
wingetClass,		New_CL,% New_hW_TlStr
wingetTitle,		TargetTitle,% New_hW_TlStr
(!TargetTitle? 		(r:="",return,) : new_tt:=TargetTitle)
winget,new_PN,		ProcessName,%New_hW_TlStr%
winget,new_PiD,		pid,% New_hW_TlStr
WinGet,new_path,	ProcessPath,%New_hW_TlStr%
winget,new_style,	Style,% New_hW_TlStr
winget,new_exstyle,	ExStyle,% New_hW_TlStr
controlget,neWCstyle,style,,ahk_id %A_New_McTLhW%
controlget,neWeXCstyle,exstyle,,ahk_id %A_New_McTLhW%0.
 if(isahktarget:= (instr(new_PN,"AutoHotkey"))) {
	wmi:= ComObjGet("winmgmts:")
	try,((R:= ( queryEnum:= wmi.ExecQuery("" .	"Select * from Win32_Process where ProcessId=" . new_PiD)._NewEnum)[process])
	? (CommandLine:= process.CommandLine, 	scc:=strreplace(CommandLine,(ExePath:= Process.ExecutablePath))))
	loop,parse,% "/CP65001,/restart,/script",`,
		scc:=strreplace(scc,a_loopfield)
	try,if(RegEXMatch(CommandLine,needL_sc____,scrunc))
			ass:=ass ;msgbox,%  scc "`nscrunc1 " scrunc1  "`nscrunc2    " scrunc2 "`n adsas" Process.ExecutablePath;msgbox % isahktarget
} mousegetpos,,,,neWCname

if(minholder)
	for,i,element in minholder,{
		if(minholder[i].pth=new_path) {
			mindetected:= True
			continue,
	}	}

menu_Style_main:
try {
switch,new_PN {
	case,"ApplicationFrameHost.exe" : if((new_PN="ApplicationFrameHost.exe") && new_TT)
			switch,new_tt {
				case,"Camera": new_PN:= "WindowsCamera.exe", new_path:= "C:\Program Files\WindowsApps\Microsoft.WindowsCamera_2021.105.10.0_x64__8wekyb3d8bbwe\WindowsCamera.exe"
				case,"Snip & Sketch": new_PN:= "ScreenSketch.exe", new_path:= "C:\Program Files\WindowsApps\Microsoft.ScreenSketch_10.2008.2277.0_x64__8wekyb3d8bbwe\ScreenSketch.exe"
			}
	case,"sidebar.exe" : menu,F,Add,%	"trans sbar",StyleHandla

}
menu,p0,Add,%	_:=("&Open > " . add:=(isahktarget? "script's path":  new_PN . "'s path")),% "StyleHandla"

menu,F,Add,%	"> " new_PN " >",:p0
if(new_hicon:= ICO2hicon(new_path)) { ; 10% of icons not pulling
	copy:= dllcall("CopyIcon","Ptr",new_hicon,"Ptr")
	try,menu,F,icon,% "> " new_PN " >",% "HICON: " copy,,48
	try,menu,p0,icon,%  _,% "HICON: " new_hicon,,48
 } else {
	try,menu,F,icon,% "> " new_PN " >",% "C:\Icon\48\ss_48.ico",,48
	try,menu,p0,icon,% shit,% "C:\Icon\48\ss_48.ico",,48
}
; menu,spunk,add,send to Desktop 1,StyleHandla
; menu,spunk,add,send to Desktop 2,StyleHandla
; menu,spunk,add,send to Desktop 3,StyleHandla
; menu,spunk,icon,send to Desktop 1,% "C:\Icon\48_24\iff.bmp",,48
; menu,spunk,icon,send to Desktop 2,% "C:\Icon\48_24\iff.bmp",,48
; menu,spunk,icon,send to Desktop 3,% "C:\Icon\48_24\iff.bmp",,48

; menu,F,add,%	"Send-to secondary Desktop",:spunk
; menu,F,icon,%	"Send-to secondary Desktop",% "C:\Icon\48_24\iff.bmp",,48

menu,F,add,%	"Close Window",StyleHandla
menu,F,icon,%	"Close Window",% "C:\Icon\256\Oxygeclose.ico",,48

if(!instr(AEWhiteCl,(new_cl . ","))) {
	menu,F,Add,	Enable AeroGlass,StyleHandla
	menu,F,icon,Enable AeroGlass,C:\Icon\256\fav.ico,,48
} else,if(instr(AEWhiteCl,(new_cl . ","))) {
	tt("ttt " aewhitecl "`n`n`n" new_cl)
	menu,F,Add,% "Disable AeroGlass",StyleHandla
	try menu,F,icon,% "Disable AeroGlass",C:\Icon\256\fav.ico,,48
}	menu,F,Add,% "Taskbar Item toggle",StyleHandla
	menu,F,icon,% "Taskbar Item toggle",C:\Icon\48\traybar.ico,,48
if(!instr(shadesactivelist,a_new_hwnd)) {
	menu,F,Add,% "apply window-shader",StyleHandla
	menu,F,icon,% "apply window-shader",C:\Icon\48\iii (3).ico,,48
} else {
	menu,F,Add,% "remove window-shader",StyleHandla
	menu,F,icon,% "remove window-shader",C:\Icon\48\na_48.ico,,48
} for,index,element in mwheeldrag
	if(index=new_PN)
		if(mwheeldrag[index]="mouselockdrag") {
			mouselockdrag:= True
			menu,F,Add,%  "Remove mouselockdrag wheel",	StyleHandla
			menu,F,icon,% "Remove mouselockdrag wheel",% "C:\Icon\256\undo.ico",,48
		} else,if(!mouselockdrag) {
			menu,F,Add,%  "Add mouselockdrag wheel",	StyleHandla
			menu,F,icon,% "Add mouselockdrag wheel",%	"C:\Icon\256\fav.ico",,48
}

for,index,element in mwheeldrag
	(index=new_PN? ((mwheeldrag[index]="MDrag_Wh")? MDrag_Wh:= True))

menu,F,Add,% m_MDragWh_Ttl:=(MDrag_Wh? "Remove mousedrag wheel" : "Remove mousedrag wheel"),StyleHandla
menu,F,icon,% m_MDragWh_Ttl,% "C:\Icon\256\undo.ico",,48
}
menu,S0,Add,% StyleMenArr["Sys_Menu"],StyleHandla
try,if(new_style &0x00080000)
	 try,menu,S0,	check,%	  StyleMenArr["Sys_Menu"]
else,menu,S0,	uncheck,% StyleMenArr["Sys_Menu"]
	 menu,S0,	add,%	  StyleMenArr["Clickthru"],StyleHandla
try,if (new_exstyle &0x00000001)
	menu, S0,	check,%	StyleMenArr["Clickthru"]
else,menu,S0,	icon,%	StyleMenArr["Clickthru"],%  "C:\Icon\256\APP_COG.ico",,48
	 menu,S0,	add,%	StyleMenArr["AppWindow"],StyleHandla
try,if (new_exstyle &0x00040000)
	 menu,S0,	check,%	StyleMenArr["AppWindow"]
else,menu,S0,	icon,%	StyleMenArr["AppWindow"],%  "C:\Icon\256\progRe55752_2.ico",,48
goto,menus_subitem

remoteahkedit:

return,

Submenus:
try,{
	if(isahktarget) {
		menu,p0,	add,%	"Edit-script",	StyleHandla
		menu,p0,	icon,%	"Edit-script",% "C:\Icon\256\Oxygen-Icons.org-Oxygen-Actions-dialog-close.ico",,48
		;menu,p0,	add,%	"Open-script-dir",	openniggerdir
		;menu,p0,	icon,%	"Open-script-dir",% "C:\Icon\256\Oxygen-Icons.org-Oxygen-Actions-dialog-close.ico",,48
	}
	menu,p0,	add,%	"Hide Window",StyleHandla
	menu,p0,	icon,%	"Hide Window",% "C:\Script\AHK\- Script\WinSpy\Resources\iiiclo48.ico",,48
	menu,p0,	add,%	"Kill Process",	StyleHandla
	menu,p0,	icon,%	"Kill Process",% "C:\Icon\256\Oxygen-Icons.org-Oxygen-Actions-dialog-close.ico",,48
	if mindetected { ;if (TRAYPIDpRESENT(new_PiD)) ||  {
		menu,p0,add,%	"Minimize Window 2 existing Tray",StyleHandla
		menu,p0,icon,%	"Minimize Window 2 existing Tray",% "C:\Icon\256\sort.ico",,48
	} else {
		menu,p0,add,%	"Minimize Window 2 new Tray",StyleHandla
		menu,p0,icon,%	"Minimize Window 2 new Tray",% "C:\Icon\256\sort.ico",,48
	}
}
try,{
 menu,p0,add,%	"Kidnap " (A_New_cname? "control":"window") ,StyleHandla
 menu,p0,icon,%	"Kidnap " (A_New_cname? "control":"window")
 ,% "C:\Icon\256\Oxygen-Icons.org-Oxygen-Actions-dialog-close.ico",,48
 dtopdocked:= (!instr(dtopchildren,A_new_hWnd ",")? False : True)
 menu,p0,add,%	m_dtdocked_ttl:= (dtopdocked? "Undock from DTop": "dOck-2-dToP"),StyleHandla
 menu,p0,icon,%	m_dtdocked_ttl,% "C:\Icon\256\Oxygen-Icons.org-Oxygen-Actions-dialog-close.ico",,48
 menu,S0,add,	Frame / & X Controls,:S1
 menu,S0,icon,	Frame / & X Controls,%	"C:\Icon\256\previewpane.ico",,48
 menu,S0,add,	Scrollbars,	:S2
 menu,S0,icon,	Scrollbars,%	"C:\Icon\64ribbon\updown3264.ico",,48
 menu,S0,add,	Layout,	:S3
 menu,S0,icon,	Layout,%	"C:\Icon\256\Tetris.ico",,48
}
goto("menus_other")
return,

menus_subitem:
try,{
	 menu,S1,	add,% "DLG Frame",% "StyleHandla"
if(new_style	&0x00400000)
	menu,S1,	check,%	"DLG Frame"
else,menu,S1,	uncheck,% "DLG Frame"
	menu,S1,	Add,%	"THICK Frame",% "StyleHandla"
if(new_style	&0x00040000)
	menu,S1,	check,%	"THICK Frame"
else,menu,S1,	icon,%	"THICK Frame",% "C:\Icon\256\APP_COG.ico",,48
	menu,S1,	Add,%	"Modal Frame",% "StyleHandla"
if(new_exstyle	&0x00000001)
	menu,S1,	check,%	"Modal Frame"
else,menu,S1,	uncheck,% "Modal Frame"
	menu,S1,	Add,%	"Static edge",% "StyleHandla"
if(new_exstyle	&0x00020000)
	menu,S1,	check,%	"Static edge"
else,menu,S1,	uncheck,% "Static edge"
	menu,S1,	Add,%	StyleMenArr["Maxbox"],% "StyleHandla"
if(new_style	&0x00010000)
	menu,S1,	check,%	StyleMenArr["Maxbox"]
else,menu,S1,	uncheck,% StyleMenArr["Maxbox"]
	menu,S1,	Add,%	StyleMenArr["MinBox"],% "StyleHandla"
if(new_style	&0x00020000)
	menu,S1,	check,%	StyleMenArr["MinBox"]
else,menu,S1,	uncheck,% StyleMenArr["MinBox"]
	menu,S2,	Add,% "HScroll",% "StyleHandla"
if(new_style	&0x00100000)
	menu,S2,	check,%	"HScroll"
else,menu,S2,	icon,%	"HScroll"
	menu,S2,	Add,%	"VScroll",% "StyleHandla"
if(new_style	&0x00200000)
	menu,S2,	check,%	"VScroll"
else,menu,S2,	uncheck,% "VScroll"
	menu,S2,	Add,%	StyleMenArr["LeftScroll"],% "StyleHandla"
if(new_exstyle	&0x00004000)
	menu,S2,	check,%	StyleMenArr["LeftScroll"]
else,menu,S2,	uncheck,% StyleMenArr["LeftScroll"]
	menu,S3,	Add,%	StyleMenArr["RightAlign"],% "StyleHandla"
if(new_exstyle	&0x00001000)
	menu,S3,	check,%	StyleMenArr["RightAlign"]
else,menu,S3,	uncheck,% StyleMenArr["RightAlign"]
	menu,S3,	Add,%	StyleMenArr["RightoLeft"],% "StyleHandla"
if(new_exstyle	&0x00002000)
	menu,S3,	check,%	StyleMenArr["RightoLeft"]
else,menu,S3,	uncheck,% StyleMenArr["RightoLeft"]
c:= dllcall("GetAwarenessFromDpiAwarenessContext","int"
, dllcall("GetWindowDpiAwarenessContext","int",A_new_hWnd,"ptr"),"int")
menu,stylDPiMen,Add,% c_old:= c,% "DPIhW"
;-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]-]
c1:= "DPI_AWARENESS_UNAWARE" ; :=0"~GDIDPISCALING DPIUNAWARE/DPIUNAWARE"= Override high-DPI scaling-behavior
	; ( System Enhanced/ system)"
c2:= "DPI_AWARENESS_SYSTEM_AWARE" ; :=1"~HIGHDPIAWARE" = Override high-DPI scaling behavior
	; ( Application managed scaling)
c3:= "DPI_AWARENESS_PER_MONITOR_AWARE" ; :=2~HIGHDPIAWARE" = Override high-DPI scaling behavior
	; ( Application managed scaling) (Newer))
	switch,c {
		case,"-1" :	currentDPIhWnd:= "DPI_AWARENESS_INVALID = -1"
				try,menu,stylDPiMen,rename,% c_old,% currentDPIhWnd ;i cant rem what this is 4
				return,
		case,"0" :	currentDPIhWnd:= "DPI_AWARENESS_UNAWARE = 0"
				Choices=%c1%|%c2%|%c3%
		case,"1" :	currentDPIhWnd:= "DPI_AWARENESS_SYSTEM_AWARE = 1"
				Choices=%c1%|%c2%||%c3%
		case,"2" :	currentDPIhWnd:= "DPI_AWARENESS_PER_MONITOR_AWARE = 2"
				Choices=%c1%|%c2%|%c3%||
	}
}
try,menu,stylDPiMen,rename,% c_old,% currentDPIhWnd
menu,stylDPiMen,Add,% "Set awareness context'->",StyleHandla
menu,stylDPiMen,Add,% "registry:'DPI Layers'->",StyleHandla
goto("Submenus")
return,

Menus_Other: ; (below submenus)
try,{
	menu,F,add,% _:=isClassBypass(New_CL)? "+M2Drag WhiteList: " New_CL : "+M2Drag BlackList: " New_CL,				StyleHandla
	menu,F,Icon,% _,% "C:\Icon\48\m248.ico",,48
	if(neWCname="SysTreeView321") {
		menu,F,add,% "Tree " . (instr(TVfixListPN,new_pn . ",")? "unCompose" : "Compose"),StyleHandla
		menu,F,icon,% "Tree " . (instr(TVfixListPN,new_pn . ",")? "unCompose" : "Compose"),C:\Icon\256\Tree-2-256.ico,,48
	}
	menu,F,add,	DPI Behaviour,					:stylDPiMen
	menu,F,Icon, DPI Behaviour,%	"C:\Icon\256\progRe55752_2.ico",,48
	menu,F,add,% "Style &`& &ExStyle",	:S0
	menu,F,icon,% "Style &`& &ExStyle",% "C:\Icon\48\ss_48.ico",,48
} try {
	menu,zaxis,add,%  "Remove Z-Align UI-Band",	StyleHandla
	menu,zaxis,Icon,% "Remove Z-Align UI-Band",% "C:\Icon\256\undo.ico",,48
	if(UIBANDCLASS_CHECK(new_cl)) {
		menu,zaxis,add,%  "Remove Z-Align UI-Band",	StyleHandla
		menu,zaxis,Icon,% "Remove Z-Align UI-Band",% "C:\Icon\256\undo.ico",,48
	} else {
		menu,zaxis,add,%  "Z Align UI-Band",		StyleHandla
		menu,zaxis,Icon,% "Z Align UI-Band",% "C:\Icon\256\#8611.ico",,48
	}
	menu,zaxis,add,% "Z-Align Top",	StyleHandla
	menu,zaxis,icon,% "Z-Align Top",C:\Icon\48\updown48.ico,,48

	menu,zaxis,add,% "Z-Align Bottom",	StyleHandla
	menu,zaxis,icon,% "Z-Align Bottom", C:\Icon\48\updown48.ico,,48

	menu,F,add,%  "Window Z-Axis policy",:zaxis
	menu,F,icon,% "Window Z-Axis policy",C:\Icon\48\updown48.ico,,48

	menu,F,Add,% ((icon_PN_arr[new_PN])||(icon_cl_arr[new_cl]))
	? "Remove &icon":"Set &icon",StyleHandla
	menu,F,Icon,% ((icon_PN_arr[new_PN])||(icon_cl_arr[new_cl]))? "Remove &icon"
	: 	"Set &icon",% ((icon_PN_arr[new_PN])||(icon_cl_arr[new_cl]))? "C:\Icon\256\undo.ico"
	:	"C:\Icon\48\decepadm_48.ico",,48

	menu,F,add,%	"&Save changes",	StyleHandla
	menu,F,icon,%	"&Save changes",%	"C:\Icon\128\kixtart2022.ico",,48
	menu,F,add,%	"Get window text",	StyleHandla
	menu,F,icon,%	"Get window text",%	"C:\Icon\48\ren48.ico",,48
	gosub,StyleMenu_Show
}
return,

StyleHandla(Men="") {
	global ; ; Style-menu ITEM ; - ; Style-menu TARGET ;
	listlines off
	if (instr(a_thismenuitem,"+M2Drag BlackList: ")||instr(a_thismenuitem,"+M2Drag WhiteList: ")){
		settimer,toggle_m2drag_bypass,-100

		return,
		}
	switch,a_thismenuitem {
		case,		"open"		: open:= "&Open > " new_PN "'s path"
		case,"&Open > " . new_PN . "'s path": gosub,APP_OpenCnt
		case,"trans sbar"			: 7Sidebar_ApplyTrans()
		case,"GDI-PEng"				: run,% "C:\Program Files\Autohotkey13500\AutoHotkeyU64_UIA.exe " quote("C:\Script\AHK\GUi\GDI_Plus_Paint\GDI_Plus_Paint.ahk")
		case,"calc"						: run,% _q "C:\Program Files\Autohotkey13500\AutoHotkeyU64_UIA.exe" _q " " _q "C:\Script\AHK\GUi\Calc.ahk"
		case,"Start/Restart"	: settimer,TRAYicons_init,-10
		case,"Stop anims"			: settimer,TRAYicons_destroy,-10
		case,"Launch AdHkRun"	: run,% comspec " /c " AdHkRun,% "C:\Program Files\Autohotkey13500\"
		case,"dOck-2-dToP"		: gosub,dtop_WinKidnap
		case,"Undock from DTop"	: gosub,DTop_WinRelease
		case,"Kidnap window"	: fun:= func("Window_Kidnap").bind(A_New_hwnd)
									settimer,% fun,-20
		case,"Kidnap control"	: fuku:= func("control_Kidnap").bind(A_New_McTLhW)
									settimer,% fuku,-20
		case,"m2-Drag bypass"	: gosub,toggle_m2drag_bypass
		case,"kill process"		: settimer,Stylemen_Kilwin,-10
		case,"Close Window"		: _windowclose(New_hW_TlStr)
		case,"Hide Window"		: winhide,% New_hW_TlStr
		case,"Enable AeroGlass"		: settimer,AE_ADD2WL,-10
		case,"Disable AeroGlass"	: settimer,AE_ADD2BL,-10
		case,"Taskbar Item toggle": _:=func("tbitem_toggle").bind(A_New_hwnd)
			settimer,%_%,-10
		case,"apply window-shader"	: return,overlay_(a_New_hwnd,0x110617),shadesactivelist.= "," . a_New_hwnd
		case,"remove window-shader"	: return,overlay_(a_New_hwnd,"remove"),shadesactivelist:=strreplace(shadesactivelist, ("," . a_New_hwnd))
		;tray menu items; ;tray menu items; ;tray menu items; ;tray menu items;
		case,"edit-script" : run,% "edit " scriptpath(new_PiD) ;;ffnn:= (r:=splitpath(scriptpath(new_PiD)).fn . r.ext) . " ahk_class Autohotkey" ;postMessage,0x0404,65304,,,% r
		case,"Remote-AHk-Vars(Gui)"		: DebugVarsGui()
		case,"DWMAccentFix"			: DWMAccentFix()
		case,"PsYch05i5"				: run,% PsYch0
		case,"AHK_Pip3_eXEcut0r": settimer,PiPeExec,-20
		case,"1mgvi3w-4"				: run,% ImgVi3w4
		case,"Colour picker"		: run,% "C:\Script\AHK\Working\color2.ahk"
		case,"SysColours view"	: run,% GuiSysCols
		case,"Explorahk"				: run,% "C:\Script\AHK\- _ _ LiB\CGUI_Examples-master\Explorer.ahk"
										settimer,AhkExploraInit,-10000
		case,"K3y2eye": run,% K3y2eye:= "KeyHistory_input-log-uiSCI.ahk"
			sleep,2000
		case,"m2eye"	: run,% m2eye:= "C:\Script\AHK\Mouse_input-log-ui.ahk"
			sleep,2000
		case,"MAME64" : return,MameLaunch()
		case,"tree uncompose": TVfixListPN:= strreplace(TVfixListPN,new_pn . ",")
		case,"tree compose" : (!instr(TVfixListPN, new_pn)? TVfixListPN .=new_pn . ",")
			opencontaining(scriptpath(new_PiD))		;hooks;
			case,"Vignette on","Vignette off":
			vv:=Winexist("C:\Script\AHK\__TESTS\vignette.ahk ahk_class AutoHotkey")
				v:=strreplace(a_thismenuitem," ","_")
				h:=	Send_WM_COPYDATA(v,"ahk_id " . (h:=Winexist("C:\Script\AHK\ADhKI.ahk ahk_class AutoHotkey")))
		menu,Script_main,rename,% a_thismenuitem,% vv? "vignette on" :"vignette off"
		case,"Contxt menu hook" : menu,SubMenu0,% (hKToolTip32768:= !hKToolTip32768? "Check" : "Uncheck"),% "Contxt menu hook"
			if(hKToolTip32768)
				menu,SubMenu0,icon,Contxt menu hook,% "C:\Icon\32\INFO_32.ico",,32
		default: if(!instr(a_thismenuitem,".exe's")) {
				hg:= getkeystate("LShift","p"), gh:= getkeystate("LCtrl","P") ;(GH="1"||HG="1")?
				(HG? clipboard:= scriptPath(new_PiD) : opencontaining(scriptpath(new_PiD)))
			} else,{ ;msgbox % hg "`n" GH ;(GH="1"||HG="1")?
				hg:= getkeystate("LShift","p"), gh:= getkeystate("LCtrl","p") ;clipboard:= scriptPath(new_PiD) : open_containing(scriptpath(new_PiD))
				winget,pp,processpath,ahk_pid %new_PiD% ;settimer,%a_thismenuitem%,-10
				(HG? clipboard:= (splitpath(pp) ).dir)
				opencontaining(pp)
			} Inited_StyleMen:= False, StyleMenDel()
	}	return,1
}

MameLaunch() {
	global MAME64unc
	listlines off
	static MameMane:= ({"w" : w:= 999,	"h" : h:= 999
										,	"x" : (a_screenwidth *.5)-(w*.5)
										,	"y" : (a_screenheight *.5)-(h*.5)})
	path:= (splitpath(MAME64unc)).dir
	run,% MAME64unc,% path,,mame_pid
	ssleep(666)
	winwait,% "ahk_pid " mame_pid
	try,hWnd:= winexist("ahk_pid " mame_pid),	ssleep(666)
	win_move(hWnd,MameMane.x,MameMane.y,MameMane.w,MameMane.h,"")
}
TTB_LOAD_RELOAD:
return,
; ~`~`~~`~;`~`~`~`~		~`~`~`~		~`~`~`~		~`~`~`  ~`~`~` ~`~`~	`~` ~`~ `~  ~`~`	~`~	`~`~`~	`~	`~`
;`~					  ~`~`~~`~`~`~`~`~``~`~``~`~`~`~`~`~`~`~`~`~`~`~`~
Menu_Tray_Init: ;=---- `~
;~~~~~~~^^;   ~@ []
try,menu,Tray,Deleteall ; menu,tray,new
menu,tray,NoStandard ; menu,tray,icon,% TrayIconPath ;menu,tray,	add,%	"Open Script Dir",		S_OpenDir
menu,tray,Icon
menu,tray,Icon,% "C:\Icon\64ribbon\home3264.ico",,48
menu,tray,add,%	"&Events (HookGui)",	EVENTHOOKGUI
menu,tray,icon,% "&Events (HookGui)",%	"C:\Icon\64ribbon\home3264.ico",,48
gosub,submenuz
menu,tray,add,	,	; ~ ~ ~ ~ split; ~ ~ ~ ~ split; ~ ~ ~ ~ split; ~ ~ ~ ~ split
menu,tray,add,	Hooks,		:SubMenu0
menu,tray,icon,	Hooks,%		"C:\Icon\64ribbon\updown3264.ico",,48
menu,tray,add,	Services,	:SubMenu1
menu,tray,icon,	Services,%	"C:\Icon\cog4.ico",,48
menu,tray,add,	Settings,	:settings
menu,tray,icon,	Settings,%	"C:\Icon\cog4.ico",,48
menu,tray,add,	Tools,		:Tools_main
menu,tray,icon,	Tools,%		"C:\Icon\cog4.ico",,48
menu,tray,add,	Explorer,	:Exp_main, ;+Break
menu,tray,icon,	Explorer,%	"C:\Icon\48\EXPLORER_48.ico",,48
menu,tray,add,	Scripts,	:Script_main
menu,tray,icon,	Scripts,%	"C:\Icon\48\w33_48.ico",,48
menu,tray,add,	,	; ~ ~ ~ ~ split; ~ ~ ~ ~ split; ~ ~ ~ ~ split; ~ ~ ~ ~ split
gosub,ExpFolderContentTT
menu,tray,Add ,%	"Open",				ID_VIEW_VARIABLES
menu,tray,Icon,%	"Open",%			"C:\Icon\64ribbon\regview3264.ico",,48
menu,tray,Add ,%	"Open Containing",	S_OpenDir
menu,tray,Icon,%	"Open Containing",%	"C:\Icon\256\#86_2.ico",,48
menu,tray,Add ,%	"Edit Script",		ID_TRAY_EDITSCRIPT
menu,tray,Icon,%	"Edit Script",%		"C:\Icon\256\np++Hackjob.ico",,48
menu,tray,Add ,%	"Reload",			ID_TRAY_RELOADSCRIPT
menu,tray,Icon,%	"Reload",%			"C:\Icon\256\IDI_ICON1.ico",,48
menu,tray,Add ,%	"Suspend VKs",		ID_TRAY_SUSPEND
menu,tray,Icon,%	"Suspend VKs",%		"C:\Icon\256\invert_goatse_256.ico",0,48
menu,tray,Add ,%	"Pause",			ID_TRAY_PAUSE
menu,tray,Icon,%	"Pause",%			"C:\Icon\24\head_fk_a_24_c2b.ico",,48
menu,tray,Add ,%	"Exit",				ID_TRAY_EXIT
menu,tray,Icon,%	"Exit",%			"C:\Icon\256\DOO0m.ico",,48
refresh_uptime_()
return,

b64_2_hBitmap(B64in,NewHandle:= False) {
	listlines off
	hBitmap:= 0
	(NewHandle? hBitmap:= 0)
	If(hBitmap)
		Return,hBitmap
	VarSetCapacity(B64,3864 <<!!A_IsUnicode)
	If(!DllCall("Crypt32.dll\CryptStringToBinary","Ptr",&B64in,"UInt",0,"UInt", 0x01,"Ptr",0,"UIntP",DecLen,"Ptr",0,"Ptr",0))
		Return,False
	VarSetCapacity(Dec,DecLen,0)
	If(!DllCall("Crypt32.dll\CryptStringToBinary","Ptr",&B64in,"UInt",0,"UInt",0x01,"Ptr",&Dec,"UIntP",DecLen,"Ptr",0,"Ptr",0))
		Return,False
	hData:= DllCall("Kernel32.dll\GlobalAlloc","UInt",2,"UPtr",DecLen,"UPtr"), pData:= DllCall("Kernel32.dll\GlobalLock","Ptr",hData,"UPtr")
	DllCall("Kernel32.dll\RtlMoveMemory","Ptr",pData,"Ptr",&Dec,"UPtr",DecLen), DllCall("Kernel32.dll\GlobalUnlock","Ptr",hData)
	DllCall("Ole32.dll\CreateStreamOnHGlobal","Ptr",hData,"Int",True,"PtrP",pStream)
	hGdip:= DllCall("Kernel32.dll\LoadLibrary","Str","Gdiplus.dll","UPtr"), VarSetCapacity(SI,16,0), NumPut(1,SI,0,"UChar")
	DllCall("Gdiplus.dll\GdiplusStartup","PtrP",pToken,"Ptr",&SI,"Ptr",0)
	, DllCall("Gdiplus.dll\GdipCreateBitmapFromStream","Ptr",pStream,"PtrP",pBitmap)
	, DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap","Ptr",pBitmap,"PtrP",hBitmap,"UInt",0)
	, DllCall("Gdiplus.dll\GdipDisposeImage","Ptr",pBitmap), DllCall("Gdiplus.dll\GdiplusShutdown","Ptr",pToken)
	DllCall("Kernel32.dll\FreeLibrary","Ptr",hGdip), DllCall(NumGet(NumGet(pStream +0,0,"UPtr") +(A_PtrSize *2),0,"UPtr"),"Ptr",pStream)
	Return,hBitmap
}
b642hBitmap(B64in,NewHandle:= False) {
	hBitmap:= 0
	(NewHandle? hBitmap:= 0)
	If(hBitmap)
		Return,hBitmap
	VarSetCapacity(B64,3864 <<!!A_IsUnicode)
	If(!DllCall("Crypt32.dll\CryptStringToBinary","Ptr",&B64in,"UInt",0,"UInt", 0x01,"Ptr",0,"UIntP",DecLen,"Ptr",0,"Ptr",0))
		Return,False
	VarSetCapacity(Dec,DecLen,0)
	If(!DllCall("Crypt32.dll\CryptStringToBinary","Ptr",&B64in,"UInt",0,"UInt",0x01,"Ptr",&Dec,"UIntP",DecLen,"Ptr",0,"Ptr",0))
		Return,False
	hData:= DllCall("Kernel32.dll\GlobalAlloc","UInt",2,"UPtr",DecLen,"UPtr"), pData:= DllCall("Kernel32.dll\GlobalLock","Ptr",hData,"UPtr")
	DllCall("Kernel32.dll\RtlMoveMemory","Ptr",pData,"Ptr",&Dec,"UPtr",DecLen), DllCall("Kernel32.dll\GlobalUnlock","Ptr",hData)
	DllCall("Ole32.dll\CreateStreamOnHGlobal","Ptr",hData,"Int",True,"PtrP",pStream)
	hGdip:= DllCall("Kernel32.dll\LoadLibrary","Str","Gdiplus.dll","UPtr"), VarSetCapacity(SI,16,0), NumPut(1,SI,0,"UChar")
	DllCall("Gdiplus.dll\GdiplusStartup","PtrP",pToken,"Ptr",&SI,"Ptr",0)
	, DllCall("Gdiplus.dll\GdipCreateBitmapFromStream","Ptr",pStream,"PtrP",pBitmap)
	, DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap","Ptr",pBitmap,"PtrP",hBitmap,"UInt",0)
	, DllCall("Gdiplus.dll\GdipDisposeImage","Ptr",pBitmap), DllCall("Gdiplus.dll\GdiplusShutdown","Ptr",pToken)
	DllCall("Kernel32.dll\FreeLibrary","Ptr",hGdip), DllCall(NumGet(NumGet(pStream +0,0,"UPtr") +(A_PtrSize *2),0,"UPtr"),"Ptr",pStream)
	Return,hBitmap
}
submenuz:
ttbb64:="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"
menu,tranimen,add,% "Start/Restart", 	StyleHandla ;anitrayrestart
menu,tranimen,icon,% "Start/Restart",% 	"C:\Icon\256\#1444.ico"
menu,tranimen,add,% "Stop anims",		StyleHandla
menu,tranimen,icon,% "Stop anims",% 	"C:\Icon\256\#5329.ico"
menu,expSystray,add,TrAnIconz,	:tranimen
menu,expSystray,icon,TrAnIconz,% 		"C:\Icon\256\DOO0m.ico",,32
menu,expTaskbar,add,% "Translucent TB Load/reload",	TTB_LOAD_RELOAD
menu,expTaskbar,icon,% "Translucent TB Load/reload",% "HBITMAP:* " b642hBitmap(ttbb64),,24

;-=submenus-=submenus-=submenus-=submenus-=submenus-=submenus-=submenus-=submenus
menu,SubMenu0,add,%	"4ground hook tip",	TT4g,+Right
menu,SubMenu0,icon,% "4ground hook tip",% "C:\Icon\32\INFO_32.ico",,32
menu,SubMenu0,add,%	"focus hook tip",	TTFoc
menu,SubMenu0,icon,% "focus hook tip",% "C:\Icon\32\INFO_32.ico",,32
menu,SubMenu0,add,%	"ctl focus tip",	TTFocCTL_Toggle
menu,SubMenu0,% TTFocCTL?"check":"icon",ctl focus tip
,% TTFocCTL?():"C:\Icon\32\INFO_32.ico",,% !TTFocCTL?32:()
menu,SubMenu0,add,%	"obj_create tip",	TTcr
menu,SubMenu0,icon,% "obj_create tip",% "C:\Icon\32\INFO_32.ico",,32
menu,SubMenu0,add,%	"obj_destroy tip",	TTds
menu,SubMenu0,icon,% "obj_destroy tip",% "C:\Icon\32\INFO_32.ico",,32
menu,SubMenu0,add,%	"msgbox hook tip",	TTmb
menu,SubMenu0,icon,% "msgbox hook tip",% "C:\Icon\32\INFO_32.ico",,32
menu,SubMenu0,add,%	"Contxt menu hook",	StyleHandla
menu,SubMenu0,icon,% "Contxt menu hook",% "C:\Icon\32\INFO_32.ico",,32

menu,SubMenu0,add,%	"Toggle debug",		SvcRestartWacom
menu,SubMenu0,icon,% "Toggle debug",%	"C:\Icon\32\INFO_32.ico",,32
menu,SubMenu1,add,%	"Restart sound",	SvcRestartSound
menu,SubMenu1,icon,% "Restart sound",%	"C:\Icon\48_24\sndvol_48_24_4.ico",,48
menu,SubMenu1,add,%	"Restart wacom",	SvcRestartWacom
menu,SubMenu1,icon,% "Restart wacom",%	"C:\Icon\cog4.ico",,48
menu,Exp_DTop,add,% "Desktop Area Custom",%	"Desktop_area_Set"
menu,Exp_DTop,add,% "Desktop Iconz",%	"Diconz_Toggle"
menu,Exp_DTop,add,%	"Icon spacing", 	IconSpacing
menu,Exp_DTop,icon,% "Icon spacing",%	"C:\Icon\256\chem1.ico"
menu,Exp_DTop,add,% "Desktop Icon Labels",%				"Diconlablz_Toggle"
menu,submenu_explorer_cntxt,add,% "AeroGlass",%			"StyleHandla"
if(ContextBG="AeroGlass")
	try,menu,submenu_explorer_cntxt,icon,% "AeroGlass",% "C:\Icon\256\ticAMIGA.ico",,48
menu,submenu_explorer_cntxt,add,% "Glass",%				"StyleHandla"
if(ContextBG="Glass")
	try,menu,submenu_explorer_cntxt,icon,% "Glass",% 	"C:\Icon\256\ticAMIGA.ico",,48
menu,submenu_explorer_cntxt,add,% "Default",%			"StyleHandla"
if((ContextBG="default")||!ContextBG)
try,menu,submenu_explorer_cntxt,icon,% "Default",% 		"C:\Icon\256\ticAMIGA.ico",,48
menu,Exp_main,add,%	"ContextMenu BG",	:submenu_explorer_cntxt
menu,Exp_main,icon,% "ContextMenu BG",% 				"C:\Icon\256\#80_1.ico",,48
menu,Exp_main,add,%	"Desktop",			:Exp_DTop
menu,Exp_main,add,%	"Folder-Content Tooltip",%	"FolderContentsInfoTiptoggl"
menu,Exp_main,icon,% "Folder-Content Tooltip",%	"C:\Script\AHK\2.ico",,48
menu,Exp_main,icon,% "Desktop",% 				"C:\Icon\- Icons\32\Recycle Bin - Envelope (full).ico",,48
menu,Exp_main,add,%	"Restart Explorer",%		"Explorer_Restart"
menu,Exp_main,icon,% "Restart Explorer",%		"C:\Icon\256\taskbar_network.ico",,32
menu,Exp_main,add,%	"SysTray", 			:expSystray
menu,Exp_main,icon,% "SysTray",%				"C:\Icon\256\taskbar_network.ico",,32
menu,Exp_main,add,%	"Taskbar", 			:expTaskbar
menu,Exp_main,icon,% "Taskbar",% "HBITMAP:* " b642hBitmap(taskbarb64),,32

;-=endExplorer-=endExplorer-=endExplorer-=endExplorer-=endExplorer-=endExplorer-=endExplorer
menu,Tools_main,add,%	"Colour picker",		StyleHandla
menu,Tools_main,icon,% "Colour picker",%		"C:\Icon\256\pixelpisser.ico",,48
menu,Tools_main,add,%	"CLSIDS Folders",%		"CLSIDS"
menu,Tools_main,icon,% "CLSIDS Folders",%		"C:\Icon\32\INFO_32.ico",,48
menu,Tools_main,add,%	"AHK_Pip3_eXEcut0r",	StyleHandla
menu,Tools_main,icon,% "AHK_Pip3_eXEcut0r",% 	"C:\Icon\256\Autism5.ico",,48
menu,Tools_main,add,%	"K3y2eye",				StyleHandla
menu,Tools_main,icon,% "K3y2eye",%				"C:\Icon\256\8ee.ico",,48
menu,Tools_main,add,%	"m2eye",				StyleHandla
menu,Tools_main,icon,% "m2eye",%				"C:\Icon\256\8ee.ico",,48
menu,Tools_main,add,%	"Remote-AHk-Vars(Gui)",	StyleHandla
menu,Tools_main,icon,% "Remote-AHk-Vars(Gui)",%	"C:\Icon\256\ICON22_1.ico",,48
menu,Tools_main,add,%	"SysMetr",%				"SysMetr"
menu,Tools_main,icon,% "SysMetr",%				"C:\Icon\256\Simple(WShadow)256.7.ico",,48
menu,Tools_main,add,%	"WM_Sifter",%			"wm_sift"
menu,Tools_main,icon,% "WM_Sifter",% 			"C:\Icon\256\tabsearc4h.ico",,48
;-=endTools-=endTools-=endTools-=endTools-=endTools-=endTools-=endTools-=endTools-=endTools
menu,settings,add,%	"Toggle Sidebar off",		Toggle_sbar
menu,settings,icon,% "Toggle Sidebar off",%		"C:\Icon\256\previewpane.ico",,48
menu,settings,add,%	"DWMAccentFix",				StyleHandla
menu,settings,icon,% "DWMAccentFix",%			"C:\Icon\256\trusted.ico",,48
menu,settings,add,%	"LoadAeroRegKeyz",			AeroTheme_Set
menu,settings,icon,% "LoadAeroRegKeyz",%		"C:\Icon\256\#19722.ico",,48
menu,settings,add,%	"Launch PowerConfig",		pconfig
menu,settings,icon,% "Launch PowerConfig",% 	"C:\Icon\256\ICON321_1.ico",,48
menu,settings,add,%	"Launch MattDWM",			mDWM2
menu,settings,icon,% "Launch MattDWM",%			"C:\Icon\256\#272.ico",,48
menu,settings,add,%	"monitor brightness ",		BrightnessFloater
menu,settings,icon,% "monitor brightness ",%	"C:\Icon\256\#1491.ico",,48
if(h:=Winexist("C:\Script\AHK\__TESTS\vignette.ahk ahk_class AutoHotkey"))
	vignette_enabled:=true
menu,settings,add,%	_:= vignette_enabled? "vignette off" : "vignette on",	StyleHandla
menu,settings,icon,% _,% "HICON: " b64_2_hicon(vig48),,48

menu,settings,add,%	"toggle aero on ahk",		aero2ahktoggle
menu,settings,% (!aero2ahk?"uncheck":"check"),% "toggle aero on ahk"
menu,settings,add,%	"SetSysCols",				syscols
menu,settings,icon,% "SetSysCols",%				"C:\Icon\256\pixelpisser.ico",,48
menu,settings,add,%	"SysColours view",			StyleHandla
menu,settings,icon,% "SysColours view",%		"C:\Icon\256\pixelpisser.ico",,48
;-=endsettings-=endsettings-=endsettings-=endsettings-=endsettings-=endsettings-=endsettings
menu,Script_main,add,%	"GDI-PEng",	StyleHandla
menu,Script_main,icon,% "GDI-PEng",% "C:\Icon\48\gimp-tool-ink.ico",,48
menu,Script_main,add,%	"np++ param insert",	NPInsert
menu,Script_main,icon,% "np++ param insert",% 	"C:\Icon\24\path55h.ico",,48
menu,Script_main,add,%	"aHk_RaR3",				ahk_rare
menu,Script_main,icon,% "aHk_RaR3",% 			"C:\Icon\256\lament cube hellraiser box COMP.ico",,48
menu,Script_main,add,%	"calc",					StyleHandla
menu,Script_main,add,%	"PsYch05i5",			StyleHandla
menu,Script_main,icon,% "PsYch05i5",% 			"C:\Icon\256\Psy0wl.ico",,48
menu,Script_main,add,%	"1mgvi3w-4",			StyleHandla
menu,Script_main,icon,% "1mgvi3w-4",%			"C:\Icon\256\eydeye.ico",,48
menu,Script_main,add,%	"Launch WMP_MATT",		WMPRun
menu,Script_main,icon,% "Launch WMP_MATT",%		"C:\Icon\256\wmp_zbuFS.ico",,48
menu,Script_main,add,%	"Explorahk",			StyleHandla
menu,Script_main,icon,% "Explorahk",% 			"C:\Icon\256\explorer.ico",,48
menu,Script_main,add,%	"Launch midi_in_out",	MiDi_
menu,Script_main,icon,% "Launch midi_in_out",%	"C:\Icon\256\apc40.ico",,48
menu,Script_main,add,%	"Launch AdHkRun",		StyleHandla
menu,Script_main,icon,% "Launch AdHkRun",%		"C:\Icon\256\trusted.ico",,48,,48
menu,Script_main,add,%	"Launch YouTube_DL",	YT_DL
menu,Script_main,icon,% "Launch YouTube_DL",%	"C:\Script\AHK\Working\YouTube_2.ico",,48
menu,Script_main,add,%	"Launch screen clean!",	CleanME
menu,Script_main,icon,% "Launch screen clean!",% "C:\Icon\256\total recall eye pop.ico",,48
menu,Script_main,add,%	"MAME64",	StyleHandla
menu,Script_main,icon,% "MAME64",%	"C:\Icon\256\m4m3.ico",,48
return,

;  TRAY WM_Handler	;~~~~~~~^^;  ; 0x00A5:; WM_nclRBUTTONUP ; 0x206:; WM_RBUTTONDBLCLK
AHK_NOTIFYICON(wParam, lParam) { ; 0x201: ; WM_LBUTTONDOWN   ; 0x202:; WM_LBUTTONUP
	global	;Thread,Priority,0 || ;Thread,Priority,7 ; 0x020B:; WM_XBUTTONDOWN
	listlines off
	switch,lParam {
		case,0x0200: return,timer("refresh_uptime_",-13) ;settimer,refresh_uptime_,-300
		 ; WM_MOUSEmove
			; return,% Refresh_uptime_(True)
		case,0x203 : TT("Loading...") ; Timer("ID_VIEW_VARIABLES",-1);	WM_LBUTTONDBLCLK
			PostMessage,0x0111,%ID_VIEW_VARIABLES%,,,% A_ScriptName " - AutoHotkey"
			winget,h,id,WinEvent.ahk - AutoHotkey
			Aero_BlurWindow(h)
		case,0x204 : settimer,MENSpunction,-30
			return, ; WM_RBUTTONDN
			;MENSpunction()
		case,0x205 : return,(trayActiv?MENSpunction()) ;WM_RBUTTONUPcase,0x0208:; WM_MBUTTONUP ;;Timer("ID_TRAY_RELOADSCRIPT",-1); TT("Reloading... 1 sec",900); sleep,900; reload ; return
	}
	return,
}
;  TRAY WM_ ;^^^^^;
ID_TRAY_EXIT:
ID_TRAY_PAUSE:
ID_TRAY_SUSPEND:
ID_VIEW_VARIABLES:
ID_TRAY_EDITSCRIPT:
ID_TRAY_RELOADSCRIPT:
PostMessage,0x0111,(%a_thislabel%),,,% A_ScriptName " - AutoHotkey"
return,
; END / TRAY MENU / END / TRAY MENU / END / TRAY MENU / END / TRAY ;

Explorer_Restart:
Shell_Restart()
settimer,Desktop_Init,-5000
return,

Desktop_Area_Set:
gosub,desktop_areacheck
  run,% "C:\Program Files\Autohotkey13602\AutoHotkeyU64_UIA.exe C:\Script\AHK\Desktop_Set-Workarea.ahk"
return,

S_OpenDir:
APP_OpenCnt:
switch,a_thislabel {
	case,"APP_OpenCnt"	: target:= new_path
	case,"xd"			: target:= "d:\new folder (2)"
	default				: target:= a_thislabel
} Success:= Opencontaining(target)
sleep,900
return,

Oldscript_reset:
Oldscript:= ""
return,

FF4:
winactivate,ahk_id %expOpenDirMatch%
SplitPath,target,,,OutExtension,OutNameNoExt
sleep,500 ; Flami := (OutNameNoExt . "." . OutExtension)
controlsend,DirectUIhWnd3,% (OutNameNoExt . "." . OutExtension),ahk_id %expOpenDirMatch%
return,

Menu_Style_Init:		;		Init Style/eXstyle Menu < way to visualise menus? >
_x:= ("|"),_y:= "£"	;			DeLimiterriNg
str_aL:= (	"Sys_Menu"	 . _y .	"""Title (+ & X Conrols) (SysMenu)"""
.	 _x .	"Maxbox"	 . _y .	"""Maximise Button (□)"""
.	 _x .	"MinBox"	 . _y .	"""Minimise Button (_)"""
.	 _x .	"LeftScroll" . _y . """Left Scroll Orientation"""
.	 _x .	"ClickThru"  . _y .	"""Click-through"""
.	 _x .	"RightAlign" . _y .	"""Generic Right-alignment"""
.	 _x .	"RightoLeft" . _y .	"""Right-to-Left reading"""
.	 _x .	"AppWindow"  . _y .	"""Taskbar Item (not 100%)"""
.	 _x .	"Save"		 . _y .	"""Save window style preferences"""
.	 _x .	"Reset"		 . _y .	"""Reset window style preferences""")
loop,	 parse,str_aL,%	   _x  ; -Parse
	loop,parse,A_loopfield,% _y
		switch,a_iNdex {
		  case,"1": LAyeBall:= A_loopfield				 ; label segment

		  case,"2": StyleMenArr[LAyeBall] := A_loopfield ; menu-txt segment
		}
		; for, index, element in StyleMenArr ; msgbox % index "`n" element
		; bum="sysmenu"  ;  msgbox % StyleMenArr["sys_menu"]
Return	; END
;	^-=___=-^				^-=___=-^				^--___=-^   ^   ~   ~   _   ¬   ¬   ¬   ¬   ¬   ¬   ¬   ¬   _
Varz:   ; 01010101010 ' ` ' `' `':C\Root\`'`'''`'      `''`0101'`'`'```''`'`'     ``'010101`''`'0xFFEEDD`'`'`'`'``'`'     			`''`''KILL!'`'` `'`
global AHKdir,a_time_scriptstart,TickSS,AF,AF2,AutoFireScript,Scr_,dbgtt,AutoFireScript2,TargetScriptTitle,TargetScriptTitle2,AF_Delay
,SysShadowStyle_New,SysShadowExStyle_New,toolx,offsett,XCent,YCent,starttime,text,X_X,Last_Title,autofire,RhWnd_old,MouseTextID,DMT,NPInsert
,roblox,toggleshift,Norm_menuStyle,Norm_menuexStyle,Title_Last,dcStyle,classname,tool,tooly,EventLogBuffer_Old,Roblox_hWnd,Time_Elapsed
,SBAR_2berestored_True,Sidebar,TT,TT4g,TTFoc,TTcr,TTds,TTmb,dbg,TClass,TTitle,TProcName,delim,delim2,TitleCount,style2,new_exstyle,ArrayProc
,ArrayClass,ArrayTitle,Array_LProc,Array_LTitle,Array_LClass,Style_ClassnameList2,Style_procnameList2,Style_wintitleList2,Youtube_Popoutwin
,Script_Title,np,m2dstatus,crashmb,8skin_crash,A_new_hWnd,F,s1,s2,s3,FileListStr,oldlist,FileCount,ADELIM,hTarget,hTargetprev,hgui,xPrev
,yPrev,hPrev,logvar,ADM_TtL,triggeredGFS,Matrix,Maxbox,MinBox,LeftScroll,ClickThru,RightAlign,RightoLeft,AppWindow,Save,Reset,MiDiRun,wmpViewTrig

global MattDWMRun,Quoting,mmenuListTtl,MenuLablAr,MenuLablTitlAr,mmenuListLbl,Desk_Wi,Desk_Hi,FileListStr_Ar,wPrev,hidegui,q_dlim,quotes
,DEBUGTEST_hWnd,hook4g,HookMb,HookCr,HookOD,HookFc,DEBUGTEST_FOC,hook4g,Proc4g_,AhkPath,HookMb,ProcMb_,ProcCr_,ProcDstroyd,procFc_,nnd
,1998,1999,SkpO,old_focus1,old_focus2,old_focus3,old4gnd1,old4gnd2,old4gnd3,qstr,mDWM2,wm_sift,SBarPath,Path_PH,AHK_Rare,CleanME,Schd_T
,HKCUCV,styleKi,AdHkRun,PConfig,YT_DL,M2dRun,Mag_,DWMFixS,WMPRun,MiDiRun,MiDi_,adh,ScpW,MiDir,winevents,winevents_i,Split_Tail,Split_Head
,RiPpLe,ripoldm,t_x,t_Y,lo0,StyleMenArr,mouse24,wintitlekey,procnamekey,classnamekey,OBJ4g,OBJFc,OBJCR,OBJDS,MNPPS,WIN_TARGET_DESC
,MSGB_KiLLTARGET,WINEVENT_SkpOROCESS,WINEVENT_OUTOFCONTEXT,OoC,Desktop_Margin,hooked_events,newhook,firefoxhandles,classeslast,clst_max_I
,Clss_,pNamee_,AHkold,SysMetr,Contextmenu,sys32,srcunc,imgvi3w4,Choice,Chwn_,oldscript,A_New_McTLhW
global New_hW_TlStr,old_classfocus2,old_classfocus1,old_classfocus3,old_classfocus4,hWnd4st,classhwlast,CLsS_Last,clsShWnd_L2,clht_max_I
,clht2_max_I,TBBUTTON,vCount,extension_set,alignment,Gui_W,GuiRolled,met_desc,copy,Gui_lastclass_W,Gui_lastclass_H,Gui_extended,Windle
,hookreadonly,count23,list_death,icon_clhw_arr,icon_cl_arr,icon_PN_arr,icon_tt_arr,icon_style_arrnew_PN,new_style,onlytt,onlypn,onlycl
,syscols,action_,act,typeid,IProcName,IClass,ITitle,pn_,cl_,tt_,mpos_rect,savePN,saveTT,saveCL,guic_trig,GUISYS_TB_Y,eventcr,eventfc
,event4g,eventmb,eventod,traycl,MAX_INDEX,st34m3n_hicon,aids,S_OpenDir,phtreehWnd,shit,NPphWnd,contextBG,psych0
global a_Path,RTFCooldown,desktop_icon_labels,dICON_labelz,desktop_custom_enabled,DESKTOP_AREA_REMOVE,desktop_area_Set,ExpFolderContentTT
,32770ttlARR,tr9g,mwheeldrag,clst2_max_I,new_path,oldcnt,ZBID_UIACCESS,UIB_Handl,ouruibc,ANIPID,ani_concats,fff,TrayHolderExE,WMPSkin_X,WMPSkin_Y,WMPSkin_tcol, vignette_enabled

global Tray_IconInfoArr,TrayIconArr,detect_tray_pNames,mattinit,Tray_arr_target_pos,Tray_FullCount,tray_hWnd,tray_icon_pName_loaded
,tray_icon_Title_loaded,tray_icon_uid_loaded,Tray_MainCount,Tray_newTT,Tray_OverflowCount,Tray_Target_hicon,tray_target_hWnd
,tray_target_Parent,Tray_Target_PN,Tray_target_pos,tray_target_title,tray_target_tloc,tray_target_tlocm,tray_target_tt,tray_target_uid
,tray_target_UNCPath,trayhw,TTTParent,T_pName,new_PiD,minholder,mindetected,npplus,Choices,__,hparent,i_handle,Handle ; YOU HANDLE BRADE ;
global ahkrare,AEahkWhite,AEahkBlack,TTFocCTL,trayActiv,clockTT,AEWhiteCl,AEBlackCl,wmpabortions,aero2ahk,ahkaerodbg,LineNum,err_line,TVfixListPN,dtopchildren:="",a_SS,ffoxisgay,taskbarb64,vig48
, ID_VIEW_VARIABLES:=65407,ID_TRAY_EDITSCRIPT:=65304,ID_TRAY_SUSPEND:=65305,ID_TRAY_PAUSE:=65306,ID_TRAY_EXIT:=65307, ID_TRAY_RELOADSCRIPT:= 65303,ahkpos,PiPeExec,ds,WorkerWpathRun,WorkerWpathchkRun,_Fx,BrightnessFloater,Cata,CopyOfData,diconz,ocl,New_hW_TlStr,isahktarget,Fix32700list,hKToolTip32768,A_New_cname, DiConLblz
, MameMane:= object()
try,MameMane:= ({ "w" : w:= 999
				, "h" : h:= 999
				, "x" : (a_screenwidth *.5) -(w*.5)
				, "y" : (a_screenheight *.5)-(h*.5)})
 ;	^-=___=-^ 	 ;-=-=;'`'``''`'`'``''`'`'``''`'`'`
INITArrays:= "ArrayProc,ArrayClass,ArrayTitle,Array_LProc,Array_LTitle,Array_LClass,MenuLablAr,MenuLablTitlAr,FileListStr_Ar
,quotes,winevents_i,winevents,hooked_events,StyleMenArr,firefoxhandles,classeslast,classhwlast,CLsS_Last,clsShWnd_L2,Icon_clhw_arr,Icon_cl_arr
,Icon_PN_arr,Icon_tt_arr,Icon_style_arr,TrayIconArr,Tray_IconInfoArr,shit,32770ttlARR,mwheeldrag,ANIPID,minholder,ouruibc,sysmetric,met_desc"
loop,parse,% INITArrays, `,
	(%A_loopfield%):= [] ; array_inits:
UIB_Handl:=[{}]
global INITArrays:="",shadesactivelist:=""
stylearr:= []								 ,stylexarr:= []
stylearr["toggle_sysmenu"]    :="^0x00080000", stylexarr["toggle_modalframe"]:="^0x00000001"
stylearr["toggle_DLGFRAME"]   :="^0x00400000", stylexarr["toggle_raisededge"]:="^0x00000100"
stylearr["toggle_thickframe"] :="^0x00040000", stylexarr["toggle_sunkenedge"]:="^0x00000100"
stylearr["toggle_border"]     :="^0x00040000", stylexarr["toggle_staticedge"]:="^0x00020000"
stylearr["toggle_MinBox"]     :="^0x00020000", stylexarr["toggle_3dedge"]    :="^0x00020000"
stylearr["toggle_Maxbox"]     :="^0x00010000", stylexarr["toggle_LeftScroll"]:="^0x00004000"
stylearr["toggle_hscroll"]    :="^0x00100000", stylexarr["toggle_Clickthru"] :="^0x00000020"
stylearr["toggle_vscroll"]    :="^0x00200000", stylexarr["toggle_RightAlign"]:="^0x00001000"
stylexarr["toggle_RightoLeft"]:="^0x00002000", stylexarr["toggle_AppWindow"] :="^0x00040000"
ahkpos:= {} ; listlines open script win-pos
ahkpos:= ({"X":1994, "Y":68, "W":1556, "H":985})
ahkpos:= ({"X":1994, "Y":68, "W":1556, "H":985})
clht_max_I:= clst_max_I:= clht2_max_I:= clst2_max_I:= 0
FormatTime,clockTT,A_now,% "dd MMMM yyyy`ndddd" ; clock tooltprecreation 4id sub
VarSetCapacity(mpos_rect,16)
Gui_lastclass_W	:= 1010, Gui_lastclass_H:= 1077
Gui_extended	:= True
marginSz		:= 11 ; gui rel
ZBID_UIACCESS	:= 2
aero2ahk:=aids	:= 1
Fix32700list:=""
loop, 22 {			; -=-=;'`'``''`
	v1:= ("hChldMag" . a_iNdex)
	global	(%v1%)
	v2:= ("hgui" 	 . a_iNdex)
	global	(%v2%)
	v3:= ("hWndhgui" . a_iNdex)
	global	(%v3%)	; -=-=-;'`'``''`
}
;`'``''`'`'``''`'`'``''`'`'`'``;
;"!!!     vARi4bl3z !!!!" ...  ; ^-=___=-^	>>>>>>>>>>>>;??? ;	~@4w@~
;`'``''`'`'``''`'`'``''`'`'`'``;

global Desk_Wi,Desk_Hi,Desktop_Margin
,__ := _n :=  "`n", _s:=" ", _q:= CHR(34)
, XCent:= floor(0.5*Desk_Wi), YCent:= floor(0.5*Desk_Hi)
, HKCUCV:= "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion", styleKi:= "HKEY_CURRENT_USER\SOFTWARE\_Mouse2Drag\Styles"
, AHKdir:= "c:\program files\AutoHotkey", AHk64:= (AHKdir . "\AutoHotkey.exe "), AHkold:= "c:\program files\ahk\Autohotkey.exe "
, ScpW:= "C:\Script\AHK\Working", AHK_Rare:= ((Scr_ := ("C:\Script\AHK")) . ("\- Script\AHK-Rare-master\AHKRareTheGui.ahk"))
, mDWM2:= "C:\Script\autoit\_MattDwmBlurBehindWindow.au3" ;Wrong dir envVar launched?, ahkrare:=  "C:\Script\ahk2\AHK-Rare-master\AHKRareTheGui.ahk"
, wm_sift:= "C:\Program Files\Autohotkey\AutoHotkeyU64_UIA.exe C:\Script\AHK\GUI\WM_SIFTer.ahk"
, SBarPath:= "C:\Program Files\Windows Sidebar\sidebar.exe", Path_PH:= "C:\Apps\Ph\processhacker\x64\ProcessHacker.exe"
, NPInsert:= "C:\Script\AHK\- Script\Notepad++ Insert AHK Parameters.ahk"
, MAME64unc:= "S:\games\OLDIES\EMU\MAME\mame64.exe"
, CleanME:= ( Scr_ . "\white_full-screen_gui.ahk"), npplus:="C:\Apps\np++_x86\notepad++.exe"

, Schd_T:= ((sys32 := ("C:\Windows\system32")) . ("\schtasks.exe")), syscols:= "C:\Script\AHK\- Script\syscolors.ahk"
, Mag_Path:= (quote("C:\Program Files\Autohotkey\AutoHotkeyU64_UIA.exe") . _s . quote("C:\Script\AHK\Working\M2DRAG_MAG.AHK"))
, explorer_opensave_DLG:= "Open,Save,Save Image,Save As,Change Icon"
loop,parse,% explorer_opensave_DLG,`,
	32770ttlARR[ a_iNdex ] := a_loopfield
; menulbl; menulbl; menulbl; menulbl; menulbl; menulbl; menulbl; menulbl; menulbl
S_OpenDir:=  a_scriptFullPath
AdH:= "aDHKi.ahk" ;||ADhKi.ahk_407642875;
AdHk_R:= AdHkRun	:= (sched_tsk:=(Schd_T . " /run /tn __nuss"))
PConfig	:= (sched_tsk . "cmd_output_to_msgbox.ahk_407642875")
YT_DL:= (( (AHkU64Uia:= (AHKdir . "\AutoHotkeyU64_UIA.exe ")) . ScpW . "\YT.ahk" ))
Mag_:= ( "C:\Program Files\Autohotkey\AutoHotkeyU64_UIA.exe" . " " . ScpW . "\M2DRAG_MAG.AHK")
; DWMFixS:= ( AHkU64UiaaDM := ((AHKdir . "\AutoHotkeyU64_UIA - admin.exe ")) . (Scr_ . "\Working\dwm_accentcolour.ahk"))
DWMFixS="%AHKdir%\AutoHotkeyU64_UIA - admin.exe" %Scr_%"\Working\dwm_accentcolour.ahk"
WMPRun:= ( "C:\Program Files\Autohotkey13404\AutoHotkeyU64.exe " . Scr_ . "\Z_MIDI_IN_OUT\wmp_Matt.ahk"), ;WMPRun:=(AHkU64 . Scr_ . "\Z_MIDI_IN_OUT\wmp_Matt.ahk")
PiPeExec:= "C:\Script\AHK\execut0r.ahk", guisyscols:= "C:\Script\AHK\GUi\GUIgetSysColour.ahk"
Psych0:= (p:=quote("C:\Program Files\Autohotkey\AutoHotkeyU64_UIA.exe") . _s . pp:=quote("C:\Script\AHK\GDI\Psychosis_UIBand.ahk"))
MiDiRun:= ( AHKdir . "AutoHotkeyU64.exe " . Scr_ . MiDir) ;DESKTOP_AREA_REMOVE:= desktop_area_Set . "reset"

ADM_TtL	:= ( Scr_ . "\" . adh . " - AutoHotkey v1.1"), YTdL_TtL:= ( Scr_ . "\" . YT.ahk . " - AutoHotkey v1.1")
YT_DL	:= (((AHkU64Uia:= (AHKdir . "\AutoHotkeyU64_UIA.exe ")) . ScpW . "\YT.ahk"))
MiDi_	:= (AHkU64 . Scr_ . (MiDir:=("\Z_MIDI_IN_OUT" . "\z_in_out.ahk")))
SysMetr	:="C:\Script\AHK\sysget_(GUI).ahk", imgvi3w4:=AHk64 . "C:\Script\AHK\z_ConTxt\imag3view4.ahk"
M2dRun	:= ( AHkU64Uia . Scr_ . "\Working\M2Drag.ahk"), clsids:= ( AHkU64 . Scr_ . "\Explorer_CLSIDs_W10.ahk")
desktop_area_Set := "C:\Program Files\Autohotkey13602\AutoHotkeyU64_UIA.exe " "C:\Script\AHK\Desktop_Set-Workarea.ahk"
BF:=	"Roblox_Rapid.ahk", BF2:= "Roblox_Bunny.ahk", af_1:= ("\" . BF),   Bun_:= ("\" . BF2)
AF:=	(Scr_ . af_1), AF2:= (Scr_ . Bun_), AutoFireScript:= BF, AutoFireScript2:= BF2
TargetScriptTitle := (AutoFireScript . " ahk_class AutoHotkey"), contextBG:="AeroGlass"
TargetScriptTitle2:= (AutoFireScript2 . " ahk_class AutoHotkey"), AF_Delay:= 10
SysShadowStyle_New:= 0x08000000, SysShadowExStyle_New := 0x08000020, toolx:= "-66"
offsett:= 40, delim:= "Þ", delim1:= "µ", delim2:= "»",KILLSWITCH:= "kill all AHK procs.ahk"
mouse24:= "C:\Script\AHK\Working\mouse24.ico", OBJ4g:= 0x0003, OBJFc:=0x8005, OBJCR:= 0x8000
OBJDS:= 0x8001, MNPPS:= 0x0006, WIN_TARGET_DESC:= "Information", MSGB_KiLLTARGET:= WIN_TARGET_DESC,
WINEVENT_SkpOROCESS:= 0x0002, SkpO:= WINEVENT_SkpOROCESS, WINEVENT_OUTOFCONTEXT:= 0x0000,
OoC:= WINEVENT_OUTOFCONTEXT, wintitlekey:= (styleKi . "\wintitle"),
procnamekey:= (styleKi . "\procname"), classnamekey:= (styleKi . "\classname")
;REGeX-NeedLZ;
global needL_sc____	:= "i)([CDS]*\:\\[\\\w\s\.\-\_.]*\.[\w]{3})"
;needL_sc____:="(?:^\" . _q . "([\w\" . _q . "\d\s\\\:\_\-\^\@\(\)\}\{\#\`\>\<\,\..]*)\" . _q . ")"
;needL_sc____:="([CDS]*\:\\[\\\w\d\s\.\-\_.]*\.[\w]{3})"
,needL_basic_:= "(^OK\r\nError\:)", needL_arrow_:= "(?:[--->\t]*)([\d]*)"
,needL_Line__:= "((?:--->	)[\d]*)(?:\: )([\w\d\,\(\)\[\]\..])"
,needL_nofunc:= "(?:exe" . _q . ")([\w\s\: \\\.\-\d\(\>]*)"
,needL_srcunc:= "(?:exe" . _q . " /CP65001 )([" . _q . "\w\s\: \\\.\-\d\(\\)>]*)"
	, needL_TernEr	:=("Error\:  A \" . _q . "\:\" . _q
	, 			. "is missing its \" . _q . "\?\" . _q)
	, needleinc	:="(?:Error in #include file " . _q
				. ")([\w:\\\s\.\d\-\((\)\<\>\;\,]*\" . _q . ")"
,needL_LinErr:= "((?:Error at line )[\d]+)"
gosub,Base64vars
donothing:
return,

Base64vars:
taskbarb64:="iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAADAFBMVEUAAAAAAAAAAAAAAAAAAAUAAAUFAAkGAAsHAAwHAA0HAA0HAA0HAA0GAA0GAAwFAAwGBAwEAAsFAwsDAAoEAgkDAAkOABAODhAOABATAAgAABsSAB4UACAUCCAfDTNLJXpeLppmMqhXrOJC1OBB1uBA1+A/2eA+2uA84eA64+A65eA45+A46OA36uA27OA17eA17uA07+A08N8z8d8y8t8v/d8u/d8t/d8u/d8u/N8u+98v+t8v+d8w998x9N8y898y8t893uA93eA93OA92+A92+A92+BD0uBE0eFE0OFFz+FGzeFGzOFIyuFJyOFJx+FLxOFMweFMwOFNv+FNvuFOveFOvOFOu+FPu+FPuuFPueFQuOFRt+FRtuFSteFSteFTtOFTs+FUseJVsOJVr+JWr+JYquJapeJcouJdoOJdoOJdoOJen+JenuJfnOJhmuJiluJklONlkeNmjeNnjONpiONph+Nqh+NqhuNqheNqheNsg+NtgeNuf+NvfeNwe+NxeuNyd+Nyd+NzdeN0dON0c+R1cuR1cuR2cOR3b+R4beR5auR7Z+R8ZeR/YOSAXeSBW+SDV+OCWeSDV+ODV+ODV+ODVeKDU+KGTOGETd+FSd6FR92FQ9uFQ9uFQtuFQtuFQtqFQtqEQtmDQdiCQdaBQNSAQNJ+P9B9Ps17Psp4PcZ2PMJ1O8JyOr1zO75yOb1yOb1zOr1yOr1yOr1yOr1yOLtxObpwOLlvN7duN7ZtNrRtNrNsNbFrNbFqNK5pNK1oM6tnM6llMqZkMaVkMaNiMKBiMKBgLp5gLp1fMJpcLZZcMJVWK45XLoxSKYZSLYJMLnZDI21BK2I4HVs6K1QtGUgzK0ApJi4YESEiHikdFyYZEB4ZESMaEiQGFCEZER8UACIFFCEOAB4VACIKDh8JDh4IDRwFABoQARcVABwRDw8RAAwQDwsQDwgPABQUEw4UFA0UFAwTAAwUEwsTAAoUEwkTAAoTEwgTEwgTEwgTAAgAAAgTAAgTAAgAABUAAAAofiyYAAAANXRSTlMAABEQMD9lgp6yxdXg6PDz+fr9/f7+/v7+/v7+9P3b5/3+/P78+/z9/f35/Pz9/f37/f7+/hw7M44AAAFHSURBVDjLlZA9a8JAGIDvt1RatNam6JIaErVDRBRjwICQITiEFiqVFkunLl26d3Ltx9RB6JAxXetSKEh/wU33J+7txXxgXoWjz3DDPc9x7x3Z8/2x57mjoT2w+t1Ou7BP8vjLDT4bR0sTB5CHt1Awjvft88TzIgq89f70eJV4XtoObr7nd++p52UUuAAzd3otbBAEUVBBwQiANUqr9DxnCgqGwlDGHS/xrIoCe335w+lb4lkTBQOAOfu5v0o9M1BgAUwuZpNfzsWQwlMdBX2AL8V6Sc9TWkdBV0zw8coyT1UUdLL3xX4raEN0eZh5qqGgACwECIUW3a7ggKcBjcGvMHl0NMw8xf/Q2phvZ1BEntZQcFiuKNWmoddVVdN0w6idkH9yJoGoEogrgVzmcBwHreQ2R6/XQyt5zGGaJlrJkwTyLIEsJPwBN56p1LmtzlcAAAAASUVORK5CYII"
vig48:="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"
alert64:="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"
return,

DtopMetricCurrent:
sysget,Desktop_Margin,MonitorWorkArea
sysget,Desk_Wi,78
sysget,Desk_Hi,79
return,
;------------=========================++++++++++++++++++++*+*+*+*;------------=========================++++++++++++++++++++*+*+*+*
;------------=========================++++++++++++++++++++*+*+*+*;------------=========================++++++++++++++++++++*+*+*+*

Init_Matt:
gosub,DtopMetricCurrent
FuncClass_Inits()
loop,parse,INIT_SEQ,>
	gosub,% A_loopfield
gosub,Desktop_init
Refresh_Uptime_()
WM_Allow()
return,

Desktop_Init:
if(diconz){
	dicon_fade("init")
	menu,Exp_DTop,check,% "Desktop Iconz"
} if(!DiConLblz)
	loop,2
		gosub("Diconlablz_Toggle")
gosub,Desktop_AreaCheck
(!(Desktop_Custom_Enabled="")? (gosub("Desktop_Area")))
Timer("Desktop_areaCheck",-300)
;7Sidebar_ApplyTrans()
return,

IncLdz:  ; #include <TrayIcon>;#include *i WinEvent_func.ahk;#include<Struct>
sleep,20 ; #include C:\Script\AHK\- _ _ LiB\Open_Containing.ahk
#include	C:\Program Files\AutoHotKey\LIB\GDI+_All.ahk
#include	C:\Script\AHK\WinEvent_func.ahk
#include	<Quote_gen>
#include	<AERO_LIB>
#include	<TB>
#include	<control_Kidnap>
return,

eventhookgui:
settimer,evnthookguiinit,-1
ssleep(100)
winexist("A")
Aero_BlurWindow("")
return,

MamEd0p(hWn) {
	static MameMane:= ""
	,des_W:= 1288, des_H:= 1120
	MameMane:= ({ "W": W:= des_W
			,	  "H": H:= des_H
			,	  "X": (a_screenWIDTH  *.5)-(W*.5)
			,	  "Y": (a_screenHEIGHT *.5)-(H*.5) +28})
 	sleep,450
	try,{
		loop,{
			MameP:= wingetPOS(hWn)
			if((MameP.W=a_screenWIDTH)||(MameP.W!=des_w)||(MameP.H=a_screenHEIGHT)||(MameP.H!=des_H)){
				win_MOVE(hWn,MameMane.x,MameMane.y,MameMane.w,MameMane.h,"")
				sleep,250
				winRESTORE,ahk_id %hwn%
				win_MOVE(hWn,MameMane.x,MameMane.y,MameMane.w,MameMane.h,"")
			}else,if((MameP.W!=des_W)||(MameP.H!=des_H)) {
				sleep,300
			} else,break,
			sleep,300
			logfiledata:= file2var("S:\games\OLDIES\EMU\RetroArch\content_history.lpl",logfiledata)
			loop,parse,logfiledata,`n
			if (a_index=1)
				RomFilePathFull:= a_loopfield
			else,if (a_index=2) {
				cur_title:= a_loopfield
				break,
			} cur_rom:= splitpath(RomFilePathFull)
			wingettitle,title,ahk_id %hwn%
			if(title!=cur_title)
				SetTitleHammer(hwn,cur_title,RomFilePathFull)
		}	return,
		winset,style,-0x800000,ahk_id %hWn%
		winset,exstyle,+0x80,ahk_id %hWn%
		wingetTITLE,T,ahk_id %hWn%
		sleep,400
		loop,5 {
			If(STRLEN(T)) {
				wingetTITLE,T,ahk_id %hWn%
				if(instr((T),"No Driver Loaded")||instr((T),"RetroArch")) {
					MameMane:= ({"W": W:= des_W
							,	 "H": H:= des_H
							,	 "X": (a_screenWIDTH  *.5)-(W*.5)
							,	 "Y": (a_screenHEIGHT *.5)-(H*.5) +28})
					win_MOVE(hWn,MameMane.x,MameMane.y,MameMane.w,MameMane.h,"")
					sleep,250
					win_MOVE(hWn,MameMane.x,MameMane.y,MameMane.w,MameMane.h,"")
					MameCheckLog:= func("MameGameCheckLog").bind(p:=hWn,cur_title,RomFilePathFull)
					settimer,%MameCheckLog%,-900
					return,
				} else {
					sleep,700
					wingetTITLE,T,ahk_id %hWn%
					loop,2
						sizewin("x4",hWn,True)
					TT(T,"CENTER")
					MameCheckLog:= func("MameGameCheckLog").bind(p:=hWn,cur_title,RomFilePathFull)
					settimer,%MameCheckLog%,-900
					return,
				}
			} else,hWn:= winEXIST("ahk_class MAME")
					,wingetTITLE,T,ahk_id %hWn%
		} sleep,1000
		wingetTITLE,T,ahk_id %hWn%
		(instr(T,"No Driver Loaded"||instr((T),"RetroArch"))
		? (win_MOVE(hWn,MameMane.x,MameMane.y,MameMane.w,MameMane.h,""))
		: (sizewin("x4",hWn,True),TT(T,"CENTER")))
	}	catch,
		sleep,280
}

SetTitleHammer(hw="",title="",path2rom="") {
	WinSetTitle,ahk_id %hw%,,% title
	if winexist("ahk_id " hw) {
		fun:=func("SetTitleHammer").bind(h:=hw,t:=title,tr:=path2rom)
		path2rom:=splitpath(path2rom)
		((fileexist(icon:="S:\games\OLDIES\EMU\RetroArch\system\mame2010\icons\" . path2rom.fn . ".ico"))?	WindowIconSet(hW,icon))
		settimer,% fun,-50
	}
}

evnthookguiinit:
#include %a_scriptdir%\wineventgui.ahk
return,
#h::NotepadPlus()
; debug tooltip message TRAY-MENU toggles ;
TT4g: ;TT4g := !TT4g debug tooltip message TRAY-MENU toggles
TTFoc: ;TTFoc := !TTFoc
TTcr: ;---------------------=======;TTcr := !TTcr
TTds: ;TTds := !TTds
TTmb: ;TTmb := !TTmb-
%a_thislabel%:=!%a_thislabel%
; if !%a_thislabel% {
	; %a_thislabel% := True
	; menu, tray, check,%    MenuLablTitlAr[a_thislabel]
; } else {
	; %a_thislabel% := False
	; menu, tray, UNcheck,%  MenuLablTitlAr[a_thislabel]
; }
TT_Off:
tooloff:
tooltip,
return,