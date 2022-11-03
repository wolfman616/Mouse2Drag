#NoEnv
;#notrayicon
;#include <GDI+>									;	ninjMag by Matt Wolff
#include C:\Script\AHK\- _ _ LiB\GDI+_All.ahk									;	ninjMag by Matt Wolff
#include C:\Script\AHK\- _ _ LiB\win_move.ahk									;	ninjMag by Matt Wolff
#include C:\Script\AHK\- _ _ LiB\return.ahk									;	ninjMag by Matt Wolff
#include C:\Script\AHK\- _ _ LiB\isint.ahk									;	ninjMag by Matt Wolff
#include C:\Script\AHK\- _ _ LiB\msgb0x.ahk									;	ninjMag by Matt Wolff
#include C:\Script\AHK\- _ _ LiB\Send_WMCOPYDATA.ahk									;	ninjMag by Matt Wolff
#include C:\Script\AHK\- _ _ LiB\SendWM_COPYDATA.ahk									;	ninjMag by Matt Wolff
#include C:\Script\AHK\- _ _ LiB\ico2hicon.ahk									;	ninjMag by Matt Wolff
#include C:\Script\AHK\- _ _ LiB\Open_ScriptDir.ahk									;	ninjMag by Matt Wolff
#SingleInstance force							;	+#M::	Shif And M
Setcontroldelay -1								;	suggested to init from elevated script for hotkeys as below
SetBatchLines -1								;	suggested to init from elevated script for hotkeys as below
SetWinDelay -1
ListLines,Off									;	run % Mag_Path,
DetectHiddenWindows,On
DetectHiddenText,	On
SetTitleMatchMode,	2
SetTitleMatchMode,	Slow
SendMode,Input									;	return,
;SetWorkingDir %A_ScriptDir%						;	2022.
CoordMode,Mouse,Screen
IniRead,LastScaleFactor,zoom.ini,LastScaleFactor,LastScaleFactor,4
icondll:= "C:\Script\AHK\Z_MIDI_IN_OUT\icons.DLL"
Img_UnC:= "C:\Script\AHK\GDI\images\GDI_Raster_(899).png"
menu,tray,noStandard
menu,tray,Icon,	C:\Script\AHK\Working\search_32.ico
menu,tray,add,	Open script location, Open_ScriptDir
menu,tray,icon,	Open script location,% icondll,7
menu,tray,Add,	Inverted, invert,
menu,tray,icon,	Inverted, C:\Icon\32\9047532_2.ico,,32
menu,tray,Add,	TrayKillIcon, TrayKillIcon,
menu,tray,standard
OnMessage(0x4a,"Receive_WM_COPYDATA")
onexit, guifade_tst
gosub,Varz
optfollowcaret:= true
; UIBAND Z PLACEMNT WITH AHK UiA 1.33+ +wa_topmost	NinjMagiD := DllCall("CreateWindowInBand", "uint", 0, "str", "Autohotkey", "str", "title", "uint", 0, "int", 0, "int", 0, "int", 200, "int", 200, "ptr", 0, "ptr", 0, "ptr", 0, "ptr", 0, "int", ZBID_UIACCESS := 2, "ptr")
mouseGetPos,x,y
OFFSet_:= (zoom *1.5)		;bodge to keep gui out of viewports gaze

Init_gui:
Visible:= True
gui,BackMain:	New,-DPIScale +toolwindow +owner -SysMenu +AlwaysOnTop ;+e0x20
gui,BackMain: 	+LastFound +HwndMainhWnd -Caption +AlwaysOnTop 
gui,BackMain:	color,99ccff
winSet,Region,	0-0 W%MagSize% H%MagSize% R%MagSize%-%MagSize%,
gui,BackMain: 	Show,na x-300 y-300 w%magsize% h%magsize%
gui,pic: New,-DPIScale +hwndhpic +parentBackMain +E0x80000 +AlwaysOnTop +ToolWindow
	gui,pic:+LastFound -Caption -SysMenu +OwnDialogs
	gui,pic: color,0f00f0
gui,VP:new, +LastFound +HwndvphWnd -DPIScale -Caption -SysMenu +E0x20
gui,VP:	color,000204
winSet,	Transcolor,f00000
gui,ss:new,	+LastFound -Caption +hwndsswnd +parentBackMain -SysMenu +OwnDialogs
gui,ss:	color,ff00ff
winSet, Transcolor,ff00ff 
gui,lens: new, -Caption -DPIScale +e0x20
gui,lens:+LastFound +hWndNinjMagiD	+disabled +AlwaysOnTop -SysMenu +ToolWindow +owndialogs
winSet,Region,0-0 W%MagSize% H%MagSize% R%MagSize%-%MagSize%,
gui,lens: color,800000
winset, transcolor,000000
winset,transparent,255,ahk_id %MainhWnd%
(!Resize_complete? gsub("Region_set"))
Init:
mouseGetPos,x,y
global OFFSet_:= Zoom*1.5
DesktopDC:=	DllCall("GetDC","UInt",maindevicecontextblabla)
HDC_Frame:=	DllCall("GetDC","UInt",NinjMagiD)
VP_Frame:=	DllCall("GetDC","UInt",vphwnd)

if !Init_complete {
	pToken:= Gdip_Startup()
	img_[(i>img_maxi? i:= 1 : i)]
	mouseGetPos,x, y
	_x_:= round(Area_offset+(x-magoffset))
	_y_:= round(Area_offset+(y-magoffset))
	(_x_<0? _x_:=0),			(_y_<0? _y_:=0)
	(_y_<0.5*magsize? _x_-=30)
	(_x_<0? ((_x_>(x-(0.5*magsize+(0.5*magsize/4))))
	? (_x_:= abs(_x_ -30),		_y_:= abs(_y_))))
	Zx:=Zy:= 300/Zoom,			ViewX:= 2*Zx, ViewY:= 2*Zy
	(ViewY<0? ViewY:= 0),		(ViewX<0? ViewX:= 0)
	ViewPos_X:= x-zx,			ViewPos_Y:= y-zy
	(ViewPos_X<0? ViewPos_X=0),	(ViewPos_Y<0? ViewPos_Y=0)
	Initial_X:=_x_, Initial_Y_y_:=_y_
	Win_Move(MainhWnd, _x_, _y_, MagSize, MagSize ,"" ) ; SWP_NOZORDER + SWP_NOACTIVATE
	testmaskDC:= DllCall("GetDC","UInt",hpic)
	mdc:= DCStuff(Img_UnC) 
	hSS_Frame:=	DllCall("GetDC","UInt",sswnd)
	fade_decr:= 0x0
	gui,VP:		show,na x-150 y-150 w%ViewX% h%Viewy%
	gui,ss:		show,na x0 y0 w%magsize% h%magsize%
	gui,pic:	show,na x0 y0 w%magsize% h%magsize%
	gui,ss:		hide
	gui,pic:	hide
	DllCall("UpdateLayeredWindow","Uint",ninjmagid,"Uint",0,"Uint",0,"int64P",magsize|magsize<<32
	,		"Uint",mDC,"int64P",0,"Uint",0,"intP",1<<16|1<<24,"Uint",3) 
	DllCall("gdi32.dll\SetStretchBltMode","Uptr",HDC_Frame,"UInt",3)
	DllCall("gdi32.dll\SetStretchBltMode","Uptr",Hss_Frame,"UInt",3)
	DllCall("gdi32.dll\SetStretchBltMode","Uptr",VP_Frame,"UInt",3)
}

Init_complete:= 1
settimer,guiClose,-144000
StartTime:= A_TickCount
SetStretchBltMode(HDC_Frame,iStretchMode:=1)
SetStretchBltMode(mdc,iStretchMode:=1)
SetStretchBltMode(Hss_Frame,iStretchMode:=1)
SetStretchBltMode(vp_Frame,iStretchMode:=1)
	DllCall("UpdateLayeredWindow","Uint",vphwnd,"Uint",0,"Uint",0,"int64P"
 ,viewx|viewy<<32,"Uint",DesktopDC,"int64P",ViewPos_X,"Uint",y,"intP",1<<16|1<<24,"Uint",2)
 win_move(vphwnd,"","","","","NOSIZE,NOZORDER,NOACTIVATE,R,A")
 			CaretXold:= A_CaretX,CaretYold:= A_CaretY
 
loop {
	((toggling || Paused)? return())
	(!Resize_complete? gsub("Region_set"))
	mouseGetPos,x, y

	if !(CaretXold=A_CaretX && CaretYold=A_CaretY) {
		if !(A_CaretX=0 || A_CaretX="")&&!(A_CaretY=0 || A_CaretY="") 
		&& if A_timeidlemouse > 50 {
		xold:= x, yold:= y, koons:= true
		, mpos:= wingetpos(winexist("a"))
		c_x:= mpos.x -80, c_y:= mpos.y -172
}	}
	_x_:= round((x-magoffset) + Area_offset), _y_ := round((y-magoffset) + Area_offset)
	(_x_ < 0? _x_:= 0)
	if ( _y_ < 0 ) {
		_y_ = 0
		if (_x_	> (x -(magsize+(magsize/3))))
			_x_ := _x_ -30
			if _x_	< 0
				_x_ = 0
	}
	Zx:= Zy:= 300/Zoom,		ViewX:= 2*Zx, ViewY:= 2*Zy
	(ViewY<0? ViewY:= 0),	(ViewX<0? ViewX:= 0)
	(ViewPos_X<0? ViewPos_X=0),	(ViewPos_Y<0? ViewPos_Y=0)
	if koons && optfollowcaret {
	tt(a_priorkey "`n" a_timesincepriorkey)
		CaretXold:= A_CaretX, 	CaretYold:= A_CaretY
	, 	ViewPos_X:= c_x+A_CaretX, ViewPos_Y:= c_x+A_CaretY
} else,	ViewPos_X:= x-zx, 		ViewPos_Y:= y-zy

 (!(x=xold || y=yold)? koons:= false)
	SetWinDelay,-1

	; _x_:=round(Area_offset +(x-(magoffset *0.5))) -200 
	; _y_:=round(Area_offset +(y-(magoffset *0.5))) -200
	; (_x_<0? _x_:=0),		(_y_<0? _y_:= 0)
	; (_y_<0.5*magsize? _x_-= 30)
	; (_x_<0? ((_x_>(x-(0.5*magsize +(0.5*magsize/4))))
	; ? (_x_:= abs(_x_ -30),	_y_:= abs(_y_))))


;SS_BITMAP:= 0xE,SS_ICON:= 0x3,STM_SETIMAGE:= 0x172,IMAGE_BITMAP:= 0x0,SRCCOPY:= 0x00CC0020,BLACKNESS:= 0x00000042,NOTSRCERASE:= 0x001100A6,NOTSRCCOPY:= 0x00330008,SRCERASE:= 0x00440328,DSTINVERT:= 0x00550009,PATINVERT:= 0x005A0049,SRCINVERT:= 0x00660046,SRCAND:= 0x008800C6,MERGEPAINT:= 0x00BB0226,MERGECOPY:= 0x00C000CA,SRCCOPY:= 0x00CC0020,SRCPAINT:= 0x00EE0086,PATCOPY:= 0x00F00021,PATPAINT:= 0x00FB0A09,WHITENESS:= 0x00FF0062,CAPTUREBLT:= 0x40000000,NOMIRRORBITMAP:= 0x80000000,
;	DllCall("UpdateLayeredWindow","Uint",vphwnd,"Uint",0,"Uint",0,"int64P"
;,viewx|viewy<<32,"Uint",DesktopDC,"int64P",ViewPos_X,"Uint",y,"intP",0xFF<<16|1<<24,"Uint",2)
;	DllCall("UpdateLayeredWindow","Uint",vphwnd,"Uint",0,"Uint",0,"int64P"
;,viewx|viewy<<32,"Uint",vp_Frame,"int64P",ViewPos_X,"Uint",y,"intP",0xFF<<16|1<<24,"Uint",2)

;	DllCall("gdi32.dll\StretchBlt",UInt,vp_Frame,Int,ViewPos_X,Int,ViewPos_Y,Int
;,	ViewX,Int,Viewy,UInt,DesktopDC,UInt)
;winSet,EXStyle,	+0x00200000, ahk_id %VPhwnd%
	;DllCall("UpdateLayeredWindow","Uint",vphwnd,"Uint",0,"Uint",0,"int64P", ViewX|Viewy<<32

	Win_Move(MainhWnd, _x_, _y_, MagSize, MagSize, "" ) ; SWP_NOZORDER + SWP_NOACTIVATE
	;,	"Uint",vp_Frame,"int64P",0,"Uint",0,"intP",0x8<<16|1<<24, "Uint", 2) ;msgbox % _nx " " _nY	;	
;;	winset transparent,1,ahk_id %MainhWnd%
	BitBlt(vp_Frame,0,0,ViewX,Viewy,DesktopDC,ViewPos_X,ViewPos_y,srccopy)
;;	winset transparent,254,ahk_id %MainhWnd%
DllCall("gdi32.dll\StretchBlt","UInt",Hss_Frame,"Int",0,"Int",0,"Int"
,	magsize,"Int",magsize,"UInt", vp_Frame,"UInt"
,	0,"UInt",0,"Int",ViewX,"Int",ViewY,"UInt",srccopy)
;	DllCall("UpdateLayeredWindow","Uint",MainhWnd,"Uint",0,"Uint",0,"int64P"
; ,magsize|magsize<<32,"Uint",DesktopDC,"int64P",500,"Uint",500,"intP",1<<16|1<<24,"Uint",2)
; sleep,60

	;BitBlt(vp_Frame,0,0,ViewX,Viewy,DesktopDC,ViewPos_X,ViewPos_y,srccopy)
;	DllCall("UpdateLayeredWindow","Uint",MainhWnd,"Uint",0,"Uint",0,"int64P", ViewX|Viewy<<32
;;	,	"Uint",vp_Frame,"int64P",0,"Uint",0,"intP",0x2<<16|1<<24, "Uint", 2) ;msgbox % _nx " " _nY	;	
;msgbox 1

;	msgbox 2
;winSet,EXStyle,	-0x00200000, ahk_id %VPhwnd%

;	DllCall("UpdateLayeredWindow","Uint",vphwnd,"Uint",0,"Uint",0,"int64P", ViewX|Viewy<<32
;	,	"Uint",vp_Frame,"int64P",0,"Uint",0,"intP",0xff<<16|1<<24, "Uint", 2) ;msgbox % _nx " " _nY	;	
;	msgbox 3
	;BitBlt(Hss_Frame,0,0,MagSize*2,MagSize*2,vp_Frame,0,0,srccopy )
;DllCall("UpdateLayeredWindow","Uint",MainhWnd,"Uint",0,"Uint",0,"int64P", ViewX|Viewy<<32
;	,	"Uint",vp_Frame,"int64P",0,"Uint",0,"intP",0xff<<16|1<<24, "Uint", 2) ;msgbox % _nx " " _nY	;		;BitBlt(Hss_Frame, 0, 0, MagSize, MagSize, mdc, 0, 0,srcand^notsrccopy) ;srcand^mergecopy
 	;BitBlt(HDC_Frame, 0, 0, MagSize, MagSize, vp_Frame, 0, 0, srccopy ) srcand^mergepaint
	; Win_Move(sswnd, _x_, _y_, "", "", "" ) ; SWP_NOZORDER + SWP_NOACTIVATE
	;Win_Move(vphwnd, ViewPos_X, ViewPos_y, ViewX, ViewY, "" ) ; SWP_NOZORDER + SWP_NOACTIVATE


	if !the_end {
		gui,ss:		show,na x0 y0 w%magsize% h%magsize%
		gui,pic:	show,na x0 y0 w%magsize% h%magsize%	
		mouseGetPos,x, y
		; _x_:=round(Area_offset+(x-magoffset))
		; _y_:=round(Area_offset+(y-magoffset))
		; (_x_<0? _x_:=0),			(_y_<0? _y_:=0)
		; (_y_<0.5*magsize? _x_-=30)
		; (_x_<0? ((_x_>(x-(magsize+(0.5 *magsize*0.25))))
		; ? (_x_:= abs(_x_ -30),		_y_:= abs(_y_))))
		Zx:= Zy:= 300/Zoom,			ViewX:= 2*Zx, ViewY:= 2*Zy
		(ViewY<0? ViewY:= 0),		(ViewX<0? ViewX:= 0)
	;	ViewPos_X := x-zx,			ViewPos_Y := y-zy
	;	(ViewPos_X<0? ViewPos_X=0),	(ViewPos_Y<0? ViewPos_Y=0)
		DllCall("UpdateLayeredWindow","Uint",hpic,"Uint",0,"Uint",0,"int64P", magsize|magsize<<32
	,	"Uint",mDC,"int64P",0,"Uint",0,"intP",255<<16|1<<24, "Uint", 2)
		fade_decr:= 1
		winset,transparent,%fade_decr%,ahk_id %MainhWnd%
		Win_Move(MainhWnd,_x_,_y_,MagSize,MagSize,"") ; SWP_NOZORDER + SWP_NOACTIVATE

		loop 255 	{
			DllCall("UpdateLayeredWindow","Uint",hpic,"Uint",0,"Uint",0,"int64P",magsize|magsize<<32
		,	"Uint",mDC,"int64P",0,"Uint",0,"intP",Format("{:#x}",fade_decr)<<16|1<<24, "Uint", 2)
			winset transparent,%fade_decr%,ahk_id %MainhWnd%
			DllCall("UpdateLayeredWindow","Uint",sswnd,"Uint",0,"Uint",0,"int64P",magsize|magsize<<32
		,	"Uint",mDC,"int64P",0,"Uint",0,"intP",Format("{:#x}",fade_decr)<<16|1<<24, "Uint", 3)
			mouseGetPos,x, y
			;_x_:=Area_offset+(x-magoffset),	;_y_:=Area_offset+(y-magoffset)
			Win_Move(MainhWnd,_x_,_y_,MagSize,MagSize,"") ; SWP_NOZORDER + SWP_NOACTIVATE
			fade_decr++
		}
	the_end:= 1
	}
}
return,

DCStuff(Img) {
	global
	pBitmap:= Gdip_CBitmapFromFile(Img), CURRENT_W:= Gdip_GetImage_W( pBitmap)
	CURRENT_H:= Gdip_GetImage_H(pBitmap), pImage:= Gdip_CreateBMP(CURRENT_W*wscale:=1
	, CURRENT_H *hscale:=1), G2:= Gdip_GfxFromImage(pImage)
	Gdip_DrawImgfast(G2,pBitmap,0,0)
	Gdip_Set_InterpolationMode(G2,1), Gdip_Set_SmoothingMode(G2,1), mDC:= Gdi_CreateDC(0)
	mBM:=	Gdi_Create_DIB((mDC), CURRENT_W,CURRENT_H,32), oBM:= Gdi_Select_Obj(mDC, mBM)
	pGFX:=	Gdip_Pgfx_From_HDC(mDC)
	try,	Gdip_DrawImgRect(pGFX,pImage,0,0,CURRENT_W,CURRENT_H)
		DllCall("UpdateLayeredWindow","Uint",hpic,"Uint",0,"Uint",0,"int64P",magsize|magsize<<32
,	"Uint",mDC,"int64P",0,"Uint",0,"intP",0xFF<<16|1<<24,"Uint",2) ;msgbox % _nx " " _nY
	return,mDC
}

gui(byref guiname="",byref command1="",byref command2="") {
	global
	( !command1? command1:= guiname : guiname:= "_")
	(  !guiname?  guiname:= "_" : ("") )
	gui,% guiname ": " command1 (!(command2="")?(,command2:="_") : (""))
	return, 
}

t_t(TxT="",x:="",y="",dur="") {
	listlines,off
	(TxT=""? TxT:= A_now)
	if (x && !isint(x)) { ; allow2declare a_LocStr
		isint(y)? (y? dur:= y) ; transpose potential dur arg
		somethingElseThatMightBeDeclarableLater:= dur? dur : () 
		switch (tt_loc:= X)	{
			case "center" : x:=	(A_screenwidth*.5)-80,	y:= (A_screenheight*.5)-35
			case "tray"	  : x:= A_screenwidth-10, 		y:=	45
			case "!tray"  : x:=	A_screenwidth-10, 		y:= A_screenheight-10
		}
	} else (!y&&!dur? dur:= (x? x : -880)) ; def t_o 880ms 
	((dur&&!dur=0)? (dur<100&&-100<dur)? (dur *=1000)) ; (t_o as param.2 (int||str))
	ToolTip,% TxT,% (x&&y? x : ""),% (x&&y? y : ""), 1 ; (y="center"? y:= (A_screenheight*.5)-35)
	SetTimer,t_o,% ((instr(dur,"-")||(dur<0))? dur : ("-" . dur))
	return,~errOrlevel
} ; (x="center"?Dur:=y, x:=(A_screenwidth*0.5)-80, y:=(A_screenheight*.5)-35,)

t_o:
listlines,off
tooltip,
return,

;~F15 & Mbutton::
;return,
;~F15 & Mbutton up::

Cleanup:
menu, tray, NoIcon
visible := false
toggling := ( Paused:= true )
gui,lens: hide
RETURN
Region_set:
sleep,100
winSet, Region, 0-0 W%MagSize% H%MagSize% R%MagSize%-%MagSize%, ahk_id %NinjMagiD%
Resize_complete:= 1
return,

T_det:
if (ElapsedTime:= A_TickCount -StartTime)>1000
	if KeyIsDown:= GetKeyState("LWin","P")
		if (KeyIsDown:= GetKeyState("m","P"))
			Paused:= 1, Resize_complete:= False
			,gui("lens","Hide"), toggling:= True ;gui,2:Hide
return,

TrayKillIcon:
menu,tray,NoIcon
visible:= !(toggling:= Paused:= true)
return,

guiClose:
gui,ss:hide
gui,BackMain:hide
gsub("Clear_up_gdi") ; IniWrite,%Zoom%,zoom.ini,LastScaleFactor,LastScaleFactor
exitapp,

Clear_up_gdi:
DllCall("gdi32.dll\DeleteDC", UInt,HDC_Frame )
DllCall("gdi32.dll\DeleteObject", UInt,HDC_Frame)
DllCall("gdi32.dll\DeleteDC", UInt,DesktopDC )
DllCall("gdi32.dll\DeleteObject", UInt,DesktopDC)
exitapp
return,

guifade_tst: ;DllCall("SetParent","uint",hpic,"uint",MainhWnd) ;gui,ss: hide
loop 255 	{		
	winset transparent,%fade_decr%,ahk_id %MainhWnd%
		DllCall("gdi32.dll\SetStretchBltMode","Uptr",HDC_Frame,"UInt",3)
		DllCall("gdi32.dll\SetStretchBltMode","Uptr",Hss_Frame,"UInt",3)
		DllCall("UpdateLayeredWindow","Uint",hpic ,"Uint",0,"Uint",0,"int64P", magsize|magsize<<32
	,	"Uint",mDC,"int64P",0,"Uint",0,"intP",(ssds:=Format("{:#x}",fade_decr))<<16|1<<24, "Uint", 3)
		sleep -1
		DllCall("UpdateLayeredWindow","Uint",hpic ,"Uint",0,"Uint",0,"int64P", magsize|magsize<<32
	,	"Uint",mDC,"int64P",0,"Uint",0,"intP",(aaa:=Format("{:#x}",fade_decr))<<16|1<<24, "Uint", 3) 
		DllCall("UpdateLayeredWindow","Uint",hpic ,"Uint",0,"Uint",0,"int64P", magsize|magsize<<32
	,	"Uint",mDC,"int64P",0,"Uint",0,"intP",(ssds:=Format("{:#x}",fade_decr))<<16|1<<24, "Uint", 3)
		sleep -1
		DllCall("UpdateLayeredWindow","Uint",hpic ,"Uint",0,"Uint",0,"int64P", magsize|magsize<<32
	,	"Uint",mDC,"int64P",0,"Uint",0,"intP",(aaa:=Format("{:#x}",fade_decr))<<16|1<<24, "Uint", 3)
		DllCall("UpdateLayeredWindow","Uint",hpic ,"Uint",0,"Uint",0,"int64P", magsize|magsize<<32
	,	"Uint",mDC,"int64P",0,"Uint",0,"intP",(ssds:=Format("{:#x}",fade_decr))<<16|1<<24, "Uint", 3)
		sleep -1
		DllCall("UpdateLayeredWindow","Uint",hpic ,"Uint",0,"Uint",0,"int64P", magsize|magsize<<32
	,	"Uint",mDC,"int64P",0,"Uint",0,"intP",(aaa:=Format("{:#x}",fade_decr))<<16|1<<24, "Uint", 3) 
		DllCall("UpdateLayeredWindow","Uint",hpic ,"Uint",0,"Uint",0,"int64P", magsize|magsize<<32
	,	"Uint",mDC,"int64P",0,"Uint",0,"intP",(ssds:=Format("{:#x}",fade_decr))<<16|1<<24, "Uint", 3)
		sleep -1
		DllCall("UpdateLayeredWindow","Uint",hpic ,"Uint",0,"Uint",0,"int64P", magsize|magsize<<32
	,	"Uint",mDC,"int64P",0,"Uint",0,"intP",(aaa:=Format("{:#x}",fade_decr))<<16|1<<24, "Uint", 3)
		fade_decr--
		}
exitapp,
;========================================================================================

~#B:: ;inverted colour toggle
 Invert:
(Invert:= !Invert)? SRCCOPY:=NOTSRCCOPY : SRCCOPY:="0x00CC0020"	;
return,

#z::
t_t(aa)
	nnnnn := "C:\Script\AHK\Working\GDI_Raster_(15).png"
	(aa<img_maxi?():(aa:=1))
mdc:=DCStuff(Img_[aa++])

return,
#,::
Numm--
mode1:=blitmodes[Numm]
tooltip % mode1 " " Numm
settimer, tooloff, -500
return,

#.::
Numm++
mode1:=blitmodes[Numm]
tooltip % mode1 " " Numm
settimer, tooloff, -500
return,

; In(x,a,b)	{
	; IfLess x,%a%, return, a
	; IfLess b,%x%, return, b
	; return, x
; }

^+Up::
^+Down::				; 	CTRL-&-SHIFT-&-M_WHEEL_UP / DOWN
^+p:: ; ^+WheelUp::		; 	;		OR	KB_ARROW L/R to Zoom
^+d:: ; ^+WheelDown::	;#ifWinExist("ninjMag")
if (Zoom<24 and ( A_ThisHotKey = "^+p" or A_ThisHotKey = "^+Up" )) { 
	Zoom:= round(Zoom *= 1.189)		; cube root of 2))
	switch Zoom {
		case 3 : Zoom = 4
		case 5 : Zoom = 6
		case 7 : Zoom = 8
		case 9 : Zoom = 10
	}
} else if (Zoom>1.0 && ( A_ThisHotKey = "^+d" || A_ThisHotKey = "^+Down" )) {
	Zoom:= round(Zoom /= 1.189)
	switch Zoom {
		case 3 : Zoom = 4
		case 5 : Zoom = 4
		case 7 : Zoom = 6
		case 9 : Zoom = 8
}	}
Area_offset:= 1.2*zoom
return,

^+Left::(MagSize:= (MagSize + 4), MagOffset:= (MagOffset + 4),Resize_complete:= "") ; settimer, Repaint2, -1
;return,

^+Right:: (MagSize:= (MagSize - 4), MagOffset:= (MagOffset - 4), Resize_complete:= "") ; settimer, Repaint2, -1
;return, ; #if; return,

Receive_WM_COPYDATA( wParam, lParam ) {
	StringAddress:= NumGet(lParam +(2*A_PtrSize))
	CopyOfData:= StrGet(StringAddress)
	gosub,% CopyOfData
	return,True
}

gsub(label){ ;obviously.
	if (strlen(label)<1)
		return, msgb0x("bad label")
	else
		if islabel(label)
			gosub, %label%
		else,return,msgb0x("bad label: " label)
		return
}

Gdip_CBitmapFromFile(sFile, IconNumber:=1, IconSize:="", useICM:=0) {
	pBitmap := 0, pBitmapOld := 0, hIcon := 0

	SplitPath sFile,,, Extension
	if RegExMatch(Extension, "^(?i:exe|dll)$")
	{
		Sizes := IconSize ? IconSize : 256 "|" 128 "|" 64 "|" 48 "|" 32 "|" 16
		BufSize := 16 + (2*A_PtrSize)

		VarSetCapacity(buf, BufSize, 0)
		For eachSize, Size in StrSplit( Sizes, "|" )
		{
		DllCall("PrivateExtractIcons","str",sFile,"int",IconNumber-1,"int",Size,"int"
		,		Size,"UPtr*",hIcon,"UPtr*",0,"uint",1,"uint",0)
		if !hIcon
			continue,

		if !DllCall("GetIconInfo", "UPtr", hIcon, "UPtr", &buf) {
			DestroyIcon(hIcon)
			continue,
		}

		hbmMask:= NumGet(buf,12 + (A_PtrSize - 4))
		hbmColor:= NumGet(buf,12 + (A_PtrSize - 4) + A_PtrSize)
		if !(hbmColor && DllCall("GetObject","UPtr",hbmColor,"int",BufSize,"UPtr",&buf))
		{
			DestroyIcon(hIcon)
			continue
		}
		break,
		}
		if !hIcon
		return,-1

		Width := NumGet(buf, 4, "int")
		Height := NumGet(buf, 8, "int")
		hbm := CreateDIBSection(Width, -Height)
		hdc := CreateCompatibleDC()
		obm := SelectObject(hdc, hbm)
		if !DllCall("DrawIconEx", "UPtr", hdc, "int", 0, "int", 0, "UPtr", hIcon, "uint", Width, "uint", Height, "uint", 0, "UPtr", 0, "uint", 3)
		{
		SelectObject(hdc, obm)
		DeleteObject(hbm)
		DeleteDC(hdc)
		DestroyIcon(hIcon)
		buf := ""
		return,-2
		}

		VarSetCapacity(dib, 104)
		DllCall("GetObject", "UPtr", hbm, "int", A_PtrSize = 8 ? 104 : 84, "UPtr", &dib) ; sizeof(DIBSECTION) = 76+2*(A_PtrSize=8?4:0)+2*A_PtrSize
		Stride := NumGet(dib, 12, "Int")
		Bits := NumGet(dib, 20 + (A_PtrSize = 8 ? 4 : 0)) ; padding
		pBitmapOld := Gdip_CreateBMP(Width, Height, 0, Stride, Bits)
		pBitmap := Gdip_CreateBMP(Width, Height)
		_G := Gdip_GfxFromImage(pBitmap)
		Gdip_DrawImage(_G, pBitmapOld, 0, 0, Width, Height, 0, 0, Width, Height)
		SelectObject(hdc, obm)
		DeleteObject(hbm)
		DeleteDC(hdc)
		Gdip_DeleteGraphics(_G)
		Gdip_DisposeImage(pBitmapOld)
		DestroyIcon(hIcon)
		dib := "", buf := ""
	} else
	{
		function2call := (useICM=1) ? "ICM" : ""
		gdipLastError := DllCall("gdiplus\GdipCreateBitmapFromFile" function2call, "WStr", sFile, "UPtr*", pBitmap)
	}

	return pBitmap
}

Gdip_CreateBMP(Width, Height, PixelFormat:=0, Stride:=0, Scan0:=0) {
; By default, this function creates a new 32-ARGB bitmap.
; modified by Marius Șucan

	pBitmap := 0
	If !PixelFormat
		PixelFormat := 0x26200A	; 32-ARGB

	DllCall("gdiplus\GdipCreateBitmapFromScan0"
		, "int", Width
		, "int", Height
		, "int", Stride
		, "int", PixelFormat
		, "UPtr", Scan0
		, "UPtr*", pBitmap)
	Return pBitmap
}


Gdip_GetImage_W(pBitmap) {
	Width := 0
	gdipLastError := DllCall("gdiplus\GdipGetImageWidth", "UPtr", pBitmap, "uint*", Width)
	return Width
}

Gdip_GetImage_H(pBitmap) {
	Height := 0
	gdipLastError := DllCall("gdiplus\GdipGetImageHeight", "UPtr", pBitmap, "uint*", Height)
	return Height
}

Gdip_GfxFromImage(pBitmap, InterpolationMode:="", SmoothingMode:="", PageUnit:="", CompositingQuality:="") {
	pGraphics := 0
	gdipLastError := DllCall("gdiplus\GdipGetImageGraphicsContext", "UPtr", pBitmap, "UPtr*", pGraphics)
	If (gdipLastError=1 && A_LastError=8) ; out of memory
		gdipLastError := 3

	If (pGraphics && !gdipLastError)
	{
		If (InterpolationMode!="")
		Gdip_Set_InterpolationMode(pGraphics, InterpolationMode)
		If (SmoothingMode!="")
		Gdip_Set_SmoothingMode(pGraphics, SmoothingMode)
		If (PageUnit!="")
		Gdip_SetPageUnit(pGraphics, PageUnit)
		If (CompositingQuality!="")
		Gdip_SetCompositingQuality(pGraphics, CompositingQuality)
	}
	return pGraphics
}
gdip_DrawImg(pGraphics, pBitmap, dx:="", dy:="", dw:="", dh:="", sx:="", sy:="", sw:="", sh:="", Matrix:=1, Unit:=2, ImageAttr:=0) {
	Static Ptr := "UPtr"
	If !ImageAttr
	{
		if !IsNumber(Matrix)
		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
		else if (Matrix!=1)
		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")
	} Else usrImageAttr := 1

	If (dx!="" && dy!="" && dw="" && dh="" && sx="" && sy="" && sw="" && sh="")
	{
		sx := sy := 0
		sw := dw := Gdip_GetImageWidth(pBitmap)
		sh := dh := Gdip_GetImageHeight(pBitmap)
	} Else If (sx="" && sy="" && sw="" && sh="")
	{
		If (dx="" && dy="" && dw="" && dh="")
		{
		sx := dx := 0, sy := dy := 0
		sw := dw := Gdip_GetImageWidth(pBitmap)
		sh := dh := Gdip_GetImageHeight(pBitmap)
		} Else
		{
		sx := sy := 0
		Gdip_GetImageDimensions(pBitmap, sw, sh)
		}
	}

	_E := DllCall("gdiplus\GdipDrawImageRectRect"
			, Ptr, pGraphics
			, Ptr, pBitmap
			, "float", dX, "float", dY
			, "float", dW, "float", dH
			, "float", sX, "float", sY
			, "float", sW, "float", sH
			, "int", Unit
			, Ptr, ImageAttr ? ImageAttr : 0
			, Ptr, 0, Ptr, 0)

	if (ImageAttr && usrImageAttr!=1)
		Gdip_DisposeImageAttributes(ImageAttr)

	return _E
}

Gdip_DrawImgFast(pGraphics, pBitmap, X:=0, Y:=0) {
; This function performs faster than Gdip_DrawImage().
; X, Y - the coordinates of the destination upper-left corner
; where the pBitmap will be drawn.

	return DllCall("gdiplus\GdipDrawImage"
			, "UPtr", pGraphics
			, "UPtr", pBitmap
			, "float", X
			, "float", Y)
}
Gdip_Set_InterpolationMode(pGraphics, InterpolationMode) {
; InterpolationMode options:
; Default = 0
; LowQuality = 1
; HighQuality = 2
; Bilinear = 3
; Bicubic = 4
; NearestNeighbor = 5
; HighQualityBilinear = 6
; HighQualityBicubic = 7
	If !pGraphics
		Return 2
	Return DllCall("gdiplus\GdipSetInterpolationMode", "UPtr", pGraphics, "int", InterpolationMode)
}

Gdip_Set_SmoothingMode(pGraphics, SmoothingMode) {
; SmoothingMode options:
; Default = 0
; HighSpeed = 1
; HighQuality = 2
; None = 3
; AntiAlias = 4
; AntiAlias8x4 = 5
; AntiAlias8x8 = 6
	If !pGraphics
		Return 2
	Return DllCall("gdiplus\GdipSetSmoothingMode", "UPtr", pGraphics, "int", SmoothingMode)
}

Gdip_DrawImgRect(pGraphics, pImage, nL, nT, nW, nH) {
	Return	DllCall("gdiplus\GdipDrawImageRectI", "Uint", pGraphics, "Uint", pImage, "int", nL, "int", nT, "int", nW, "int", nH)
}

Gdip_Pgfx_From_HDC(hDC) {
	DllCall("gdiplus\GdipCreateFromHDC", "Uint", hDC, "UintP", pGraphics)
	Return	pGraphics
}

Gdi_Create_DIB(hDC, nW, nH, bpp = 32, ByRef pBits = "") {
	NumPut(VarSetCapacity(bi, 40, 0), bi)
	NumPut(nW, bi, 4)
	NumPut(nH, bi, 8)
	NumPut(bpp, NumPut(1, bi, 12, "UShort"), 0, "Ushort")

	Return	DllCall("gdi32\CreateDIBSection", "Uint", hDC, "Uint", &bi, "Uint", DIB_RGB_COLORS:=0, "UintP", pBits, "Uint", 0, "Uint", 0)
}

Gdi_Select_Obj(hDC, hGdiObj) {
	Return	DllCall("gdi32\SelectObject", "Uint", hDC, "Uint", hGdiObj)
}

Gdi_Del_Obj(hGdiObj) {
	Return	DllCall("gdi32\DeleteObject", "Uint", hGdiObj)
}

Gdi_Del_DC(hDC) {
	Return	DllCall("gdi32\DeleteDC", "Uint", hDC)
}

Gdi_CreateDC(hDC = 0) {
	Return DllCall("gdi32\CreateCompatibleDC", "Uint", hDC)
}

;====----
;=======----
varz:	;=-------
;=======----
Img_:= []
loop,files,	C:\Script\AHK\GDI\images\*.png,
global the_end,CaretXold,CaretYold,xold,yold,koons
	img_maxi:= a_index, img_.push(A_LoopFileLongPath)
Area_offset:= (1.2 *(Zoom:= LastScaleFactor? LastScaleFactor : 8))
RefreshInterval:=(1000/(FPS:=60)), MagOffset:=(48+(MagSize:=w:=h:=300))
Numm:= 1, R_DPI:= A_ScreenDPI/96, aa:=1, icondll:= "C:\Script\AHK\Z_MIDI_IN_OUT\icons.DLL"
fade_decr:= 255

l:="Antialias_on,Zoom,FPS,Zoom,MagSize,RefreshInterval,R_DPI,MagOffset,x,y,Area_offset,magoffset,NinjMagiD,MagSize,rim_,Init_complete,OFFSet_,w,h,mode1,Numm,visible,Paused,toggling,i,aa,c_x,c_y,optfollowcaret,fade_decr"
loop, parse,% l, `,
	global (%A_loopfield%)
global SS_BITMAP:= 0xE,SS_ICON:= 0x3,STM_SETIMAGE:= 0x172,IMAGE_BITMAP:= 0x0,SRCCOPY:= 0x00CC0020,BLACKNESS:= 0x00000042,NOTSRCERASE:= 0x001100A6,NOTSRCCOPY:= 0x00330008,SRCERASE:= 0x00440328,DSTINVERT:= 0x00550009,PATINVERT:= 0x005A0049,SRCINVERT:= 0x00660046,SRCAND:= 0x008800C6,MERGEPAINT:= 0x00BB0226,MERGECOPY:= 0x00C000CA,SRCCOPY:= 0x00CC0020,SRCPAINT:= 0x00EE0086,PATCOPY:= 0x00F00021,PATPAINT:= 0x00FB0A09,WHITENESS:= 0x00FF0062,CAPTUREBLT:= 0x40000000,NOMIRRORBITMAP:= 0x80000000,

global Rastas:=[]
rastas[IMAGE_BITMAP]:= 0x0,rastas[SRCCOPY]:=	0x00CC0020,rastas[BLACKNESS]:= 0x00000042,
rastas[NOTSRCERASE]:= 0x001100A6,rastas[PATINVERT]:= 0x005A0049,rastas[MERGECOPY]:= 0x00C000CA
rastas[NOTSRCCOPY]:= 0x00330008,rastas[SRCERASE]:= 0x00440328,rastas[DSTINVERT]:= 0x00550009,
rastas[SRCINVERT]:= 0x00660046,rastas[SRCAND]:= 0x008800C6,rastas[MERGEPAINT]:= 0x00BB0226,
rastas[SRCCOPY]:= 0x00CC0020,rastas[SRCPAINT]:= 0x00EE0086,rastas[PATCOPY]:= 0x00F00021,
rastas[PATPAINT]:= 0x00FB0A09,rastas[WHITENESS]:= 0x00FF0062,rastas[CAPTUREBLT]:= 0x40000000,
						rastas[NOMIRRORBITMAP]:= 0x80000000,

blitmodes:= [], blitmodes:= [BLACKNESS, NOTSRCERASE, NOTSRCCOPY, SRCERASE, DSTINVERT, PATINVERT, SRCINVERT, SRCAND, MERGEPAINT, MERGECOPY, SRCCOPY, SRCPAINT, PATCOPY, PATPAINT, WHITENESS, CAPTUREBLT, NOMIRRORBITMAP]

return,
Open_ScriptDir()
