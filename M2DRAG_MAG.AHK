#NoEnv
#include C:\Script\AHK\- _ _ LiB\GDI+_All.ahk ;ninjMag, Matthew Wolff c.[2019-2022];
;#include C:\Script\AHK\- _ _ LiB\WinMove.ahk
;#include C:\Script\AHK\- _ _ LiB\msgb0x.ahk
;#include C:\Script\AHK\- _ _ LiB\Send_WMCOPYDATA.ahk
;#include C:\Script\AHK\- _ _ LiB\SendWM_COPYDATA.ahk
#include C:\Script\AHK\- _ _ LiB\ico2hicon.ahk	
#include C:\Script\AHK\- _ _ LiB\Open_ScriptDir.ahk
#MaxThreads 5
 
#SingleInstance force	;	+#M:: Shif And M
Setcontroldelay -1		;	suggested to init from elevated script for hotkeys as below
SetBatchLines -1		;	suggested to init from UIA script for uiband as below
SetWinDelay -1			;	run % Mag_Path,
;ListLines,Off
DetectHiddenWindows,On
DetectHiddenText,	On
SetTitleMatchMode,	2
SetTitleMatchMode,	Slow
SendMode,Input
CoordMode,Mouse,Screen
CoordMode,Pixel,Screen
CoordMode,caret,Screen
IniRead,LastScaleFactor,Zoom.ini,LastScaleFactor,LastScaleFactor,4
IconDLL:= "C:\Script\AHK\Z_MIDI_IN_OUT\icons.DLL"
Img_UnC:= "C:\Script\AHK\GDI\images\GDI_Raster_(899).png"
menu,tray,NoStandard
menu,tray,Icon,	C:\Script\AHK\Working\search_32.ico
menu,tray,Add,	Open script location,Open_ScriptDir
menu,tray,Icon,	Open script location,% icondll,7
menu,tray,Add,	Inverted,invert
menu,tray,Icon,	Inverted,C:\Icon\32\9047532_2.ico,,32
menu,tray,Add,	TrayKillIcon,TrayKillIcon
menu,tray,Standard
OnMessage(0x4a,"Receive_WM_COPYDATA")
wm_allow()

FPStest:= True
optfollowcaret:= True 

gosub,Varz

onexit("guifade_tst")
mouseGetPos,x,y
OFFSet_:= (zoom *1.5)

Init_gui:
Visible:= True
gui,BackMain:	New,-DPIScale +toolwindow +owner +E0x08000008  ;+e0x20
gui,BackMain:	+LastFound +HwndMainhWnd -Caption -SysMenu +AlwaysOnTop 
WinSet,Transparent,1,ahk_id %MainhWnd%
WinSet,Region,	0-0 W%MagSz% H%MagSz% R%MagSz%-%MagSz%
winshow,ahk_id %MainhWnd%
gui,pic: 		New,-DPIScale +hwndhpic +parentBackMain +E0x8080000 +ToolWindow
gui,pic:	+LastFound -Caption -SysMenu +OwnDialogs +AlwaysOnTop 
gui,pic:	color,00ff00
gui,BackMain: 	Show,na hide x-300 y-300 w%MagSz% h%MagSz%
gui,pic: 		Show,na hide x-300 y-300 w%MagSz% h%MagSz%
gui,VP:			New,+LastFound +HwndvphWnd -DPIScale -SysMenu +E0x8080020 +AlwaysOnTop 
gui,ss:			New,+LastFound -Caption +hwndsswnd +parentBackMain +OwnDialogs
gui,ss:		color,0000f0 
WinSet,transcolor,0000f0
gui,lens: 		New,-Caption -DPIScale -SysMenu +E0x8000020 +disabled 
gui,lens:+LastFound +hWndNinjMagID +AlwaysOnTop +ToolWindow +owndialogs
WinSet,			Region,0-0 W%MagSz% H%MagSz% R%MagSz%-%MagSz%,
gui,lens:	color,ff0000
WinSet,Transparent,1,ahk_id %NinjMagID%
(!Resize_complete? gsub("Region_set"))

Init_Dc:
mouseGetPos,x,y
OFFSet_:= Zoom*1.5
, DesktopDC:=	DllCall("GetDC","UInt",maindevicecontextblabla)
, HDC_Frame:=	DllCall("GetDC","UInt",NinjMagID)
, VP_Frame:=		DllCall("GetDC","UInt",VPhWNd)
if(!Init_complete) {
	mouseGetPos,x,y
	pToken:= Gdip_Startup()
	, img_[(i>img_maxi? (i:= 1):i)]
	, _X_:= round(Area_offset +(x-magoffset)), _Y_:= round(Area_offset +(y-magoffset))
	(_X_<0? _X_:=0), (_Y_<0? _Y_:=0)
	(_Y_<0.5*MagSz? _X_-=30)
	(_X_<0? ((_X_>(x-(0.5*MagSz +(0.5*MagSz*0.25))))
	? (_X_:= abs(_X_ -30), _Y_:= abs(_Y_))))
	Zx:= Zy:= 300/Zoom, aView_W:= 2*Zx, aView_H:= 2*Zy
	(aView_H<0? aView_H:= 0), (aView_W<0? aView_W:= 0)
	aView_X:= X-ZX, aView_Y:= Y-ZY
	(aView_X<0? aView_X=0),	(aView_Y<0? aView_Y=0)
	, Initial_X:= _X_, Initial_Y:= _Y_
	WinMove(MainhWnd,_X_,_Y_,MagSz,MagSz) ;SWP_NOZORDER|SWP_NOACTIVATE;
	, mdc:= DCStuff(Img_UnC), fade_decr:= 0x0
	, hSS_Frame:= DllCall("GetDC","UInt",sswnd)
	, BitBlt(vp_Frame,0,0,aView_W,aView_H,DesktopDC,aView_X,aView_Y,srccopy)
	gui,pic:hide
}

settimer,guiClose,-144000
Init_complete:= 1, StartTime:= A_TickCount
,CaretXold:= A_CaretX, CaretYold:= A_CaretY
,SetStretchBltMode(HDC_Frame,iStretchMode:=3)
,SetStretchBltMode(MDC,iStretchMode:=3)
	WinMove(VPhWNd,"","","","")
,BitBlt(HDC_Frame,0,0,aView_W,aView_H,DesktopDC,aView_X,aView_Y,srccopy)
,DllCall("UpdateLayeredWindow","UInt",NinjMagID,"UInt",0,"UInt",0,"Int64P"
,aView_W|aView_H<<32,"UInt",DesktopDC,"Int64P",aView_X,"UInt",y,"IntP",1<<16|1<<24,"UInt",2)
transpset(hpic,1)
gui,pic:	show,na x%aView_X% y%aView_Y% h%MagSz% w%MagSz%
BitBlt(vp_Frame,0,0,aView_W,aView_H,DesktopDC,aView_X,aView_Y,srccopy)
,DllCall("gdi32.dll\StretchBlt","UInt",Hss_Frame,"Int",0,"Int",0,"Int"
,MagSz,"Int",MagSz,"UInt",VP_Frame,"UInt"
,0,"UInt",0,"Int",aView_W,"Int",aView_H,"UInt",srccopy)
WinSet,transcolor,000000,ahk_id %MainhWnd%
gui,ss:		show,na x0 y0 w%MagSz% h%MagSz%
gui,pic:	show,na x0 y0 w%MagSz% h%MagSz%,pic
sleep,20
SetWinDelay,-1
(!Resize_complete? gsub("Region_set"))
;gui,BackMain:show,na hide x0 y0 w%MagSz% h%MagSz%
exstyle(mainhwnd, "+0x08000008")
, style(mainhwnd, "-0x10000000")
, result:= DllCall("SetWindowBand","ptr",MainhWnd,"ptr",0,"uint",18,"uint")
sleep,20
tooltip,% result

;gui,ninjmag:show,na hide x0 y0 w%MagSz% h%MagSz%
loop,{
	((a_index=2)? gsub("fadein"))
	((Frame_i=200)&&FPStest? ((FPS_:=(((a_tickcount-TimeS)*.002)**-1)*1000), FPStest:= False
	,(FPS_?(tt(FPS_,aView_W,aView_H,4),FPS_:=0)), ((toggling||Paused)? return())): Frame_i++)
	mouseGetPos,x,y 
	if(cunt:= check_corner() ) {
		tt("asdsad" hidden " dfdfdffdf")
		win_animate(mainhwnd,((hidden:=!hidden)? "hide":"activate") " center",100)
	} if(50<A_timeidlemouse&&!(CaretXold=A_CaretX||CaretYold=A_CaretY)) 
	&&(!(A_CaretX=0||A_CaretX="")&&!(A_CaretY=0||A_CaretY="")) 
	&&(A_CaretXold2!=A_CaretX &&! A_CaretYold2!=A_CaretY) { 
		xold:= x, yold:= y, icobz:= True, mpos:= wingetpos(winexist("a"))
		,c_x:= mpos.x-80, c_y:= mpos.y-172 ;,tt(A_CaretX)
	}
	((_X_:= x-magoffset+Area_offset)<MagSz*.5?  _X_:= MagSz*.5:())
	,(((_Y_:= y-magoffset+Area_offset)<MagSz*.5)? _Y_:= MagSz*.5:())
	aView_W:= aView_H:= 2*(Zx:= Zy:= MagSz*(Zoom**-1))

	for,ordinal in _X_,_Y_,aView_W,aView_H,aView_X,aView_Y
		(ordinal<1?ordinal:=0)
	(!(x=xold||y=yold)? icobz:= False)
	if(icobz&&optfollowcaret) {
		CaretXold2:= (CaretXold:= A_CaretX), Caretyold2:= (CaretYold:= A_CaretY)
		, 
	,	aView_X:= A_CaretX-(10 *Zoom), aView_Y:= A_CaretY-(10 *Zoom)
	} else,aView_X:= x -zx, aView_Y:= y -zy 
	DllCall("gdi32.dll\StretchBlt","UInt",Hss_Frame,"Int",0,"Int",0,"Int",MagSz,"Int",MagSz,"UInt"
	,DesktopDC,"UInt",aView_X ,"UInt",aView_Y,"Int",aView_W,"Int",aView_H,"UInt",srccopy)
	Win_Move(MainhWnd,_X_,_Y_,magsz,magsz,"") ; SWP_NOZORDER&SWP_NOACTIVATE ;
}

fadein:
(the_end? (msgb0x(),return())) ;shouldnt proc;
fadein0:
mouseGetPos,x,y
Zx:= Zy:= 300/Zoom, aView_W:= 2*Zx, aView_H:= 2*Zy
, (aView_H<0? aView_H:= 0), (aView_W<0? aView_W:= 0)
WinMove(MainhWnd,-300,-300,MagSz,MagSz) ; SWP_NOZORDER + SWP_NOACTIVATE
mouseGetPos,x,y 
_X_:= Area_offset +x-magoffset, _Y_:= Area_offset +y-magoffset
winshow,ahk_id %MainhWnd%
WinSet,transparent,1,ahk_id %MainhWnd%
DllCall("gdi32.dll\StretchBlt","UInt",Hss_Frame,"Int",0,"Int",0,"Int"
,	MagSz,"Int",MagSz,"UInt",DesktopDC,"UInt",aView_X ,"UInt",aView_Y
,	"Int",aView_W,"Int",aView_H,"UInt",srccopy)
, WinMove(MainhWnd,_X_,_Y_,MagSz,MagSz) ; SWP_NOZORDER + SWP_NOACTIVATE	
global toggler,cuntface
loop,85 {
	mouseGetPos,x,y
	 _X_:= Area_offset +x -magoffset, _Y_:= Area_offset +y -magoffset
	if(toggler:=!toggler) {
		if(cuntface:=!cuntface) {
			Zx:=Zy:=MagSz*(Zoom**-1), aView_W:=aView_H:=2*Zy, aView_X:=x-zx, aView_Y:=y-zy 
			,DllCall("gdi32.dll\StretchBlt","UInt",Hss_Frame,"Int",0,"Int",0,"Int"
			,MagSz,"Int",MagSz,"UInt",DesktopDC,"UInt",aView_X ,"UInt",aView_Y,"Int"
			,aView_W,"Int",aView_H,"UInt",srccopy)
		} ;else,ssleep(1)
	} ;else,ssleep(1)
	Win_Move(MainhWnd,_X_,_Y_,"","","") ; SWP_NOZORDER + SWP_NOACTIVATE
	WinSet,transparent,% a_index*3,ahk_id %MainhWnd%
}
; winset exstyle, +0x8 , ahk_id %mainhwnd%
; winset exstyle, +0x8 , ahk_id %vphwnd%
; DllCall(" SetParent","UInt",hpic,"UInt",MainhWnd) ;gui,ss:hide ;Win_Animate(M
; winset exstyle, +0x8 , ahk_id %hpic%
; winset exstyle, +0x8 , ahk_id %sswnd%
; winset exstyle, +0x8 , ahk_id %ninjmagid%
The_End:= 1
return,


check_corner() { ; 150,129-492,430
	return,((x=<492&&x>=150) && (y=<492&&y>=150))?1:()
}

sSleep(stime=4) {
	DllCall("Winmm\timeBeginPeriod","UInt",3)
	DllCall("Sleep","UInt",stime)
	DllCall("Winmm\timeEndPeriod","UInt",3)
}

WinMove(hWnd="",X="",Y="",W="",H="") {
;msgbox % t:= Format("{:#x}",16388)
	return,DllCall("SetWindowPos","uint",hWnd,"uint",-1,"int",x,"int",y,"int",w,"int",h,"uint",16384)
}
DCStuff(Img) {
	global ;hpic,MagSz
	pBitmap:= File_2_pBMP(Img), CURRENT_W:= Gdip_GetImage_W(pBitmap)
	, CURRENT_H:= Gdip_GetImage_H(pBitmap), pImage:= Gdip_CreateBMP(CURRENT_W*wscale:= 1
	, CURRENT_H *hscale:= 1), G2:= Gdip_GfxFromImage(pImage)
	Gdip_DrawImgfast(G2,pBitmap,0,0), Gdip_Set_InterpolationMode(G2,1), Gdip_Set_SmoothingMode(G2,1)
	, mDC:= Gdi_CreateDC(0), mBM:= Gdi_Create_DIB((mDC), CURRENT_W,CURRENT_H,32)
	, oBM:= Gdi_Select_Obj(mDC,mBM), pGFX:= Gdip_Pgfx_From_HDC(mDC)
	try,Gdip_DrawImgRect(pGFX,pImage,0,0,CURRENT_W,CURRENT_H)
		DllCall("UpdateLayeredWindow","UInt",hpic,"UInt",0,"UInt",0,"Int64P",MagSz|MagSz<<32
,	"UInt",mDC,"Int64P",0,"UInt",0,"IntP",0xFF<<16|1<<24,"UInt",2)
	return,mDC
}
; DCStuff(Img,hpic2="") {
	; global ; MagSz,mBM2,hpic
	; pBitmap:= File_2_pBMP(Img), CURRENT_W:= Gdip_GetImageWidth(pBitmap)
	; , CURRENT_H:= Gdip_GetImageHeight(pBitmap), pImage:= Gdip_CreateBitmap(CURRENT_W*wscale:= 1
	; , CURRENT_H *hscale:= 1), G2:= Gdip_GraphicsFromImage(pImage)
	; Gdip_DrawImageFast(G2,pBitmap,0,0), Gdip_SetInterpolationMode(G2,1), Gdip_SetSmoothingMode(G2,1)
	; , mDC:= CreateCompatibleDC(0), mBM2:= CreateDIBSection((mDC), CURRENT_W,CURRENT_H,32)
	; , oBM:= SelectObject(mDC,mBM2), pGFX:= Gdip_CreateFromHDC(mDC)
	; try,Gdip_DrawImageRectI(pGFX,pImage,0,0,CURRENT_W,CURRENT_H)
		; DllCall("UpdateLayeredWindow","UInt",hpic,"UInt",0,"UInt",0,"Int64P",MagSz|MagSz<<32
; ,	"UInt",mDC,"Int64P",0,"UInt",0,"IntP",0xFF<<16|1<<24,"UInt",2)
;win_move(hpic,10,100,"","","")
	; return,mDC
; }
File_2_pBMP(Image) {	; This is faster than GdipCreateBitmapFromFile and does not lock the file. ;
	File:= FileOpen(Image, "r")
	hData:= DllCall("GlobalAlloc","uint",0x2,"uptr",File.Length,"ptr")
	pData:= DllCall("GlobalLock","ptr",hData,"ptr")
	File.RawRead(pData+0,File.Length)
	DllCall("GlobalUnlock","ptr",hData)
	File.Close()
	DllCall("ole32\CreateStreamOnHGlobal","ptr",hData,"int",True,"ptr*",pStream:=0,"uint")
	DllCall("gdiplus\GdipCreateBitmapFromStream","ptr",pStream,"ptr*",pBitmap:=0)
	ObjRelease(pStream)
	return,pBitmap
}
gui(byref guiname="",byref command1="",byref command2="") {
	global
	( !command1? command1:= guiname : guiname:= "_")
	(	!guiname?  guiname:= "_" : ("") )
	gui,% guiname ": " command1 (!(command2="")?(,command2:="_") : (""))
	return,
}

t_t(TxT="",x:="",y="",dur="") {
	listlines,off
	(TxT=""? TxT:= A_now)
	if(x && !isInt(x)) { ;allow2declare a_LocStr
		isInt(y)? (y? dur:= y) ;transpose potential arg
		somethingElseThatMightBeDeclarableLater:= dur? dur : () 
		switch (tt_loc:= X)	{
			case "center" : x:=	(A_screenwidth *.5) -80,y:= (A_screenheight*.5) -35
			case "tray"	  : x:= A_screenwidth-10,		y:=	45
			case "!tray"  : x:=	A_screenwidth-10,		y:= A_screenheight -10
		}
	} else (!y&&!dur? dur:= (x? x:-880)) ;def T/0 880 ms
	((dur&&!dur=0)? (dur<100&&-100<dur)? (dur *=1000)) ;(t_o as param.2 (Int||str))
	ToolTip,% TxT,% (x&&y? x:""),% (x&&y? y:""),1 ;(y="center"? y:= (A_screenheight*.5)-35)
	SetTimer,t_o,% ((instr(dur,"-")||(dur<0))? dur : ("-" . dur))
	return,~errOrlevel
} ; (x="center"?Dur:=y, x:=(A_screenwidth*0.5)-80, y:=(A_screenheight*.5)-35,)


#s::
win_animate(mainhwnd,((hidden:=!hidden)? "hide":"activate") " center",100)
return,

style(hwnd,style) {
	winset,style,%style%,ahk_id %hwnd%
	return,
}

exstyle(hwnd,exstyle) {
	winset,exstyle,%exstyle%,ahk_id %hwnd%
	return,
}

Region_set:
sleep,30
WinSet,Region,0-0 W%MagSz% H%MagSz% R%MagSz%-%MagSz%,ahk_id %NinjMagID%
Resize_complete:= 1
return,

T_det:
if(ElapsedTime:= A_TickCount -StartTime)>1000
	if KeyIsDown:= GetKeyState("LWin","P")
		if(KeyIsDown:= GetKeyState("m","P"))
			Paused:= 1, Resize_complete:= False
			,gui("lens","Hide"), toggling:= True ;gui,2:Hide
return,

TrayKillIcon:
menu,tray,NoIcon
visible:= !(toggling:= Paused:= True)
return, ;//gui,ss:hide;gui,BackMain:hide IniWrite,%Zoom%,zoom.ini,LastScaleFactor,LastScaleFactor

guiClose:
gosub,Cleanup
exitapp,

Cleanup:
menu,tray,noicon ; visible:= False;toggling:= (Paused:= True); gui,"lens":"hide"
return,

Clear_up_gdi:
DllCall("gdi32.dll\DeleteDC",UInt,HDC_Frame)
DllCall("gdi32.dll\DeleteObject",UInt,HDC_Frame)
DllCall("gdi32.dll\DeleteDC",UInt,DesktopDC)
DllCall("gdi32.dll\DeleteObject",UInt,DesktopDC)
Gdip_shutdown(pToken)
return,

guifade_tst() { ;DllCall("SetParent","UInt",hpic,"UInt",MainhWnd) ;gui,ss:hide ;Win_Animate(MainhWnd,"hide blend",999)
	global
	menu,tray,noicon
	setbatchlines,-1 ;ptoken:= Gdip_Startup()
	DllCall("UpdateLayeredWindow","UInt",NinjMagID,"UInt",0,"UInt",0,"Int64P"
	, aView_W|aView_H<<32,"UInt",DesktopDC,"Int64P",aView_X,"UInt",y,"IntP",1<<16|1<<24,"UInt",2)
	,DllCall("gdi32.dll\StretchBlt","UInt",Hss_Frame,"Int",0,"Int",0,"Int"
	, MagSz,"Int",MagSz,"UInt",DesktopDC,"UInt"
	, aView_X,"UInt",aView_Y,"Int",aView_W,"Int",aView_H,"UInt",srccopy)
	Desktop:= DllCall("GetDC","UInt","d")
	loop,85 {
		if(toggler:=!toggler) {
			if(cuntface:=!cuntface) {
				Zx:= Zy:= MagSz*(Zoom**-1), aView_W:= aView_H:= 2*Zy
				,aView_X:= x -zx, aView_Y:= y -zy 
			,	DllCall("gdi32.dll\StretchBlt","UInt",Hss_Frame,"Int",0,"Int",0,"Int"
			,	MagSz,"Int",MagSz,"UInt",DesktopDC,"UInt"
			,	aView_X ,"UInt",aView_Y,"Int",aView_W,"Int",aView_H,"UInt",srccopy)
			}
		} WinSet,transparent,% 255-3*a_index,ahk_id %MainhWnd%
	} gosub,Clear_up_gdi
	exitapp,
}

;==========BINDZ================================BINDZ======================================BINDZ====
#q:: Gsub("fad3out")
~#B:: ; Inverted Mag-Colour Toggle
Invert:
SRCCOPY:= (Invert:= !Invert)? NOTSRCCOPY : "0x00CC0020"
return,

#z::
t_t(aa)
(aa<img_maxi)?():aa:=1
mdc:= DCStuff(Img_[aa++])
return,

#,::
mode1:=blitmodes[Numm--]
tooltip,% mode1 " " Numm
settimer,tooloff,-500
return,

#.::
Numm++
mode1:=blitmodes[Numm++]
tooltip,% mode1 " " Numm
settimer,tooloff,-500
return,

^+Left::(MagSz:= (MagSz +4), MagOffset:= (MagOffset +4),Resize_complete:= "")

^+Right:: (MagSz:= (MagSz -4), MagOffset:= (MagOffset -4), Resize_complete:= "")

~WheelUp::
(Zoom:= round(Zoom*1.189))
Area_offset:= round(1.189 *zoom) 
tt("up " Zoom)
Resize_complete:=false
return,

 ~WheelDown::
 Zoom:= round(Zoom /= 1.189)
Area_offset:= round(1.189 *zoom)
tt("down " Zoom )
Resize_complete:=false
 return,

Receive_WM_COPYDATA(wParam,lParam) {
	CopyOfData:= StrGet(NumGet(lParam +(2* A_PtrSize)))
	gosub,% CopyOfData
	TT(CopyOfData)
	return,1	;return,True
}

fad3out:
;guifade_tst()
; Win_Animate(MainhWnd,"hide blend",999)
exitapp,

gsub(label){
	if(strlen(label)&&(islabel(label)))
		gosub,%label%
	else,if(isfunc(label))
		(%label%)()
	else,return,msgb0x("bad label: " label)
	return,true
}

transpset(hWNd,val) {
	return,winset,transparent,%val%,ahk_id %hWNd%
}

~esc::
exitapp,
return,

;==END OF BINDS====END OF BINDS====END OF BINDS====END OF BINDS=;

;	;	G-Dip-f0nx	;	;	G-Dip-f0nx	;	;	G-Dip-f0nx	;	;
Gdip_CBitmapFromFile(sFile,IconNumber:=1,IcoSz:="",useICM:=0) {
	pBitmap:= pBitmapOld:= hIcon:= 0
	SplitPath,sFile,,,Extension
	if(RegExMatch(Extension,"^(?i:exe|dll)$")) {
		Sizes:= IcoSz? IcoSz : 256 "|" 128 "|" 64 "|" 48 "|" 32 "|" 16
		,SzBuf:= 16 +(2*A_PtrSize)
		,VarSetCapacity(buf,SzBuf,0)
		For,eachSize,Size in StrSplit( Sizes,"|" )
		{
			DllCall("PrivateExtractIcons","str",sFile,"Int",IconNumber-1,"Int"
			,		Size,"Int",Size,"UPtr*",hIcon,"UPtr*",0,"UInt",1,"UInt",0)
			if(!hIcon)
				continue,
			if(!DllCall("GetIconInfo","UPtr",hIcon,"UPtr",&buf)) {
				DestroyIcon(hIcon)
				continue,
			}
			hbmMask:= NumGet(buf,12 +(A_PtrSize -4))
			, hbmColor:= NumGet(buf,12 +(A_PtrSize -4) +A_PtrSize)
			if(hbmColor && DllCall("GetObject","UPtr",hBmColor,"Int",SzBuf,"UPtr",&buf)) {
				DestroyIcon(hIcon)
				continue,
			}
			break,
		}
		if(!hIcon)
			return,-1
		Width:= NumGet(buf,4,"Int"), Height:= NumGet(buf,8,"Int")
		hBm:= CreateDIBSection(Width,-Height), hdc:= CreateCompatibleDC()
		, obm:= SelectObject(hdc,hBm)
		if(!DllCall("DrawIconEx","UPtr",hdc,"Int",0,"Int",0,"UPtr"
		,hIcon,"UInt",Width,"UInt",Height,"UInt",0,"UPtr",0,"UInt",3)) {
			SelectObject(hdc,obm)
			DeleteObject(hBm), DeleteDC(hdc)
			DestroyIcon(hIcon), buf:= ""
			return,-2
		}
		VarSetCapacity(dib,104)
		DllCall("GetObject","UPtr",hBm,"Int",A_PtrSize=8? 104:84,"UPtr",&dib)
		Stride:= NumGet(dib,12,"Int") ;sizeof(DIBSECTION)=76+2*(A_PtrSize=8?4:0)+2*A_PtrSize
		Bits:= NumGet(dib,20 +(A_PtrSize=8? 4:0)) ;padding
		pBitmapOld:= Gdip_CreateBMP(Width,Height,0,Stride,Bits)
		pBitmap:= Gdip_CreateBMP(Width,Height)
		_G:= Gdip_GfxFromImage(pBitmap)
		Gdip_DrawImage(_G,pBitmapOld,0,0,Width,Height,0,0,Width,Height)
		SelectObject(hdc,obm)
		DeleteObject(hBm)
		DeleteDC(hdc)
		Gdip_DeleteGraphics(_G)
		Gdip_DisposeImage(pBitmapOld)
		DestroyIcon(hIcon)
		dib:= "", buf:= ""
	} else {
		function2call:= (useICM=1)? "ICM":""
		gdipLastError:= DllCall("gdiplus\GdipCreateBitmapFromFile" function2call,"WStr",sFile,"UPtr*",pBitmap)
	}
	Return,pBitmap
}

Gdip_CreateBMP(Width,Height,PixelFormat:=0,Stride:=0,Scan0:=0) { ; By default, this function creates a new 32-ARGB bitmap.
	pBitmap:= 0 ; modified by Marius Șucadik
	((!PixelFormat)? PixelFormat:= 0x26200A)	; 32-ARGB
	DllCall("gdiplus\GdipCreateBitmapFromScan0"
		,"Int",		Width
		,"Int",		Height
		,"Int",		Stride
		,"Int",		PixelFormat
		,"UPtr",	Scan0
		,"UPtr*",	pBitmap)
	Return,pBitmap
}

Gdip_GetImage_W(pBitmap) {
	Width:= 0
	gdipLastError:= DllCall("gdiplus\GdipGetImageWidth","UPtr",pBitmap,"UInt*",Width)
	Return,Width
}

Gdip_GetImage_H(pBitmap) {
	Height:= 0
	gdipLastError:= DllCall("gdiplus\GdipGetImageHeight","UPtr",pBitmap,"UInt*",Height)
	Return,Height
}

Gdip_GfxFromImage(pBitmap,InterpolationMode:="",SmoothingMode:="",PageUnit:="",CompositingQuality:="") {
	pGraphics:= 0, gdipLastError:= DllCall("gdiplus\GdipGetImageGraphicsContext","UPtr",pBitmap,"UPtr*",pGraphics)
	((gdipLastError=1&&A_LastError=8)? gdipLastError:= 3) ;out of memory
	if(pGraphics && !gdipLastError) {
		((InterpolationMode!="")? Gdip_Set_InterpolationMode(pGraphics,InterpolationMode))
		((SmoothingMode!="")? Gdip_Set_SmoothingMode(pGraphics,SmoothingMode))
		((PageUnit!="")? Gdip_SetPageUnit(pGraphics,PageUnit))
		((CompositingQuality!="")? Gdip_SetCompositingQuality(pGraphics,CompositingQuality))
	}
	Return,pGraphics
}

gdip_DrawImg(pGraphics,pBitmap,dx:="",dy:="",dw:="",dh:="",sx:="",sy:="",sw:="",sh:="",Matrix:=1,Unit:=2,ImageAttr:=0) {
	Static Ptr:= "UPtr"
	if(!ImageAttr) {
		if(!IsNumber(Matrix))
			ImageAttr:= Gdip_SetImageAttributesColorMatrix(Matrix)
		else,if(Matrix!=1)
			ImageAttr:= Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")
	} else,usrImageAttr:= 1

	if(dx!="" && dy!="" && dw="" && dh="" && sx="" && sy="" && sw="" && sh="") {
		sx:= sy:= 0
	,	sw:= dw:= Gdip_GetImageWidth(pBitmap)
	,	sh:= dh:= Gdip_GetImageHeight(pBitmap)
	} else,if(sx="" && sy="" && sw="" && sh="")	{
		if(dx="" && dy="" && dw="" && dh="") {
		sx:= dx:= 0,sy:= dy:= 0
	,	sw:= dw:= Gdip_GetImageWidth(pBitmap)
	,	sh:= dh:= Gdip_GetImageHeight(pBitmap)
		} else {
			sx:= sy:= 0
		,	Gdip_GetImageDimensions(pBitmap,sw,sh)
	}	}
	_E:= DllCall("gdiplus\GdipDrawImageRectRect"
		,Ptr,pGraphics
		,Ptr,pBitmap
		,"float",dX,"float",dY
		,"float",dW,"float",dH
		,"float",sX,"float",sY
		,"float",sW,"float",sH
		,"Int",Unit
		,Ptr,ImageAttr? ImageAttr:0
		,Ptr,0,Ptr,0)
	((ImageAttr& usrImageAttr!=1)? Gdip_DisposeImageAttributes(ImageAttr))
	Return,_E
}

Gdip_DrawImgFast(pGraphics,pBitmap,X:=0,Y:=0) {
	Return,DllCall("gdiplus\GdipDrawImage"
			,"UPtr",pGraphics
			,"UPtr",pBitmap
			,"float",X
			,"float",Y)
}

Gdip_Set_InterpolationMode(pGraphics,InterpolationMode) {
	if(!pGraphics)
		Return,2
	Return,DllCall("gdiplus\GdipSetInterpolationMode","UPtr",pGraphics,"Int",InterpolationMode)
}

Gdip_Set_SmoothingMode(pGraphics,SmoothingMode) { ; SmoothingMode options : 
;Default=0 HighSpd=1 HighQual=2 None=3 AntiAlias=4 AntiAliasx4=5 AntiAliasx8=6
	if(!pGraphics)
		Return,2
	Return,DllCall("gdiplus\GdipSetSmoothingMode","UPtr",pGraphics,"Int",SmoothingMode)
}

Gdip_DrawImgRect(pGraphics,pImage,nL,nT,nW,nH) {
	Return,DllCall("gdiplus\GdipDrawImageRectI","UInt",pGraphics,"UInt",pImage,"Int",nL,"Int",nT,"Int",nW,"Int",nH)
}

Gdip_Pgfx_From_HDC(hDC) {
	DllCall("gdiplus\GdipCreateFromHDC","UInt",hDC,"UIntP",pGraphics)
	Return,pGraphics
}

Gdi_Create_DIB(hDC,nW,nH,bpp =32,ByRef pBits="") {
	NumPut(VarSetCapacity(bi,40,0),bi)
,	NumPut(nW,bi,4), NumPut(nH,bi,8)
,	NumPut(bpp,NumPut(1,bi,12,"UShort"),0,"Ushort")
	Return,DllCall("gdi32\CreateDIBSection","UInt",hDC,"UInt",&bi,"UInt",DIB_RGB_COLORS:=0,"UIntP",pBits,"UInt",0,"UInt",0)
}

Gdi_Select_Obj(hDC,hGdiObj) {
	Return,DllCall("gdi32\SelectObject","UInt",hDC,"UInt",hGdiObj)
}

Gdi_Del_Obj(hGdiObj) {
	Return,DllCall("gdi32\DeleteObject","UInt",hGdiObj)
}

Gdi_Del_DC(hDC) {
	Return,DllCall("gdi32\DeleteDC","UInt",hDC)
}

Gdi_CreateDC(hDC=0) {
	Return,DllCall("gdi32\CreateCompatibleDC","UInt",hDC)
}

isInt(var) {			; In(x,a,b)	{
	if var is Integer	; IfLess x,%a%,return,a
		 return,1		; IfLess b,%x%,return,b
	else,return,0		; return,x		; }
}

t_o:
tooltip,
return,

return() {
	exit,
}

;====----
;=======----
varz:	;=-----
;=======----
Img_:= []
loop,files,	C:\Script\AHK\GDI\images\*.png,
,img_maxi:= a_index,img_.push(A_LoopFileLongPath)
global the_end, zCaretXold, CaretYold, xold, yold, icobz, Resize_complete
,Area_offset:= (1.2 *(Zoom:= LastScaleFactor? LastScaleFactor : 8))
,RefreshInterval:=(1000/(FPS:=60)),MagOffset:=(48+(MagSz:=w:=h:=300))
,Numm:= 1,R_DPI:= A_ScreenDPI/96,aa:=1,icondll:= "C:\Script\AHK\Z_MIDI_IN_OUT\icons.DLL"
,fade_decr:= 255,img_maxi,anit
,_:="Antialias_on,Zoom,FPS,Zoom,MagSz,RefreshInterval,R_DPI,MagOffset,x,y,Area_offset
,magoffset,NinjMagID,MagSz,rim_,Init_complete,OFFSet_,w,h,mode1,Numm,visible
,Paused,toggling,i,aa,c_x,c_y,optfollowcaret,fade_decr,pToken"
loop,parse,% _,`, 
	global (%A_loopfield%)
global SS_BITMAP:= 0xE,SS_ICON:= 0x3,STM_SETIMAGE:= 0x172,IMAGE_BITMAP:= 0x0
,	BLACKNESS:= 0x00000042,NOTSRCERASE:= 0x001100A6,NOTSRCCOPY:= 0x00330008
,	DSTINVERT:= 0x00550009,PATINVERT:= 0x005A0049,SRCINVERT:= 0x00660046,SRCAND:= 0x008800C6
,	MERGEPAInt:= 0x00BB0226,MERGECOPY:= 0x00C000CA,SRCCOPY:= 0x00CC0020,SRCPAInt:= 0x00EE0086
,	PATCOPY:= 0x00F00021,PATPAInt:= 0x00FB0A09,WHITENESS:= 0x00FF0062,CAPTUREBLT:= 0x40000000
,	NOMIRRORBITMAP:= 0x80000000,SRCCOPY:= 0x00CC0020,SRCERASE:= 0x00440328

global Rastas:=[]
rastas[IMAGE_BITMAP]:= 0x0,rastas[SRCCOPY]:=	0x00CC0020,rastas[BLACKNESS]:= 0x00000042,
rastas[NOTSRCERASE]:= 0x001100A6,rastas[PATINVERT]:= 0x005A0049,rastas[MERGECOPY]:= 0x00C000CA
rastas[NOTSRCCOPY]:= 0x00330008,rastas[SRCERASE]:= 0x00440328,rastas[DSTINVERT]:= 0x00550009,
rastas[SRCINVERT]:= 0x00660046,rastas[SRCAND]:= 0x008800C6,rastas[MERGEPAInt]:= 0x00BB0226,
rastas[SRCCOPY]:= 0x00CC0020,rastas[SRCPAInt]:= 0x00EE0086,rastas[PATCOPY]:= 0x00F00021,
rastas[PATPAInt]:= 0x00FB0A09,rastas[WHITENESS]:= 0x00FF0062,rastas[CAPTUREBLT]:= 0x40000000,
rastas[NOMIRRORBITMAP]:= 0x80000000,

blitmodes:= [], blitmodes:= [BLACKNESS, NOTSRCERASE, NOTSRCCOPY, SRCERASE, DSTINVERT
, PATINVERT, SRCINVERT, SRCAND, MERGEPAInt, MERGECOPY, SRCCOPY, SRCPAInt, PATCOPY
, PATPAInt, WHITENESS, CAPTUREBLT, NOMIRRORBITMAP]
return,

Open_ScriptDir()
; Win_Animate(Hwnd,Type="",Time=100) {
	; static AW_ACTIVATE = 0x20000,AW_BLEND=0x80000,AW_CENTER=0x10,AW_HIDE=0x10000
		; , AW_HNEG=0x2,AW_HPOS=0x1,AW_SLIDE=0x40000,AW_VNEG=0x8,AW_VPOS=0x4
	       ; hFlags := 0
	; loop,parse,Type,%A_Tab%%A_Space%,%A_Tab%%A_Space%
		; ifEqual,A_LoopField,,continue
		; else hFlags |= AW_%A_LoopField%

	; ifEqual,hFlags,,return "Err: Some of the types are invalid"
	; dllcall("AnimateWindow","uint",Hwnd,"uint",Time,"uint",hFlags)
; }
; _X_:=round(Area_offset +(x-(magoffset *0.5))) -200, ;_Y_:=round(Area_offset +(y-(magoffset *0.5))) -200
	; (_X_<0? _X_:=0),		(_Y_<0? _Y_:= 0); (_Y_<0.5*MagSz? _X_-= 30); (_X_<0? ((_X_>(x-(0.5*MagSz +(0.5*MagSz/4))))
	; ? (_X_:= abs(_X_ -30),	_Y_:= abs(_Y_))))

;	SS_BITMAP:= 0xE,SS_ICON:= 0x3,STM_SETIMAGE:= 0x172,IMAGE_BITMAP:= 0x0,SRCCOPY:= 0x00CC0020,BLACKNESS:= 0x00000042,NOTSRCERASE:= 0x001100A6,NOTSRCCOPY:= 0x00330008,SRCERASE:= 0x00440328,DSTINVERT:= 0x00550009,PATINVERT:= 0x005A0049,SRCINVERT:= 0x00660046,SRCAND:= 0x008800C6,MERGEPAInt:= 0x00BB0226,MERGECOPY:= 0x00C000CA,SRCCOPY:= 0x00CC0020,SRCPAInt:= 0x00EE0086,PATCOPY:= 0x00F00021,PATPAInt:= 0x00FB0A09,WHITENESS:= 0x00FF0062,CAPTUREBLT:= 0x40000000,NOMIRRORBITMAP:= 0x80000000,

;	DllCall("UpdateLayeredWindow","UInt",VPhWNd,"UInt",0,"UInt",0,"Int64P"
;,aView_W|aView_H<<32,"UInt",DesktopDC,"Int64P",aView_X,"UInt",y,"IntP",0xFF<<16|1<<24,"UInt",2)
;	DllCall("UpdateLayeredWindow","UInt",VPhWNd,"UInt",0,"UInt",0,"Int64P"
;,aView_W|aView_H<<32,"UInt",vp_Frame,"Int64P",aView_X,"UInt",y,"IntP",0xFF<<16|1<<24,"UInt",2)

;	DllCall("gdi32.dll\StretchBlt",UInt,vp_Frame,Int,aView_X,Int,aView_Y,Int
;,	aView_W,Int,aView_H,UInt,DesktopDC,UInt)
;	WinSet,EXStyle,	+0x00200000,ahk_id %VPhWNd%
	;DllCall("UpdateLayeredWindow","UInt",VPhWNd,"UInt",0,"UInt",0,"Int64P",aView_W|aView_H<<32
;,	"UInt",vp_Frame,"Int64P",0,"UInt",0,"IntP",0x8<<16|1<<24,"UInt",2) ;msgbox % _nx " " _nY	;

;	DllCall("UpdateLayeredWindow","UInt",MainhWnd,"UInt",0,"UInt",0,"Int64P"
; ,	MagSz|MagSz<<32,"UInt",DesktopDC,"Int64P",500,"UInt",500,"IntP",1<<16|1<<24,"UInt",2)
; 	sleep,60

;	;BitBlt(vp_Frame,0,0,aView_W,aView_H,DesktopDC,aView_X,aView_Y,srccopy)
;	DllCall("UpdateLayeredWindow","UInt",MainhWnd,"UInt",0,"UInt",0,"Int64P",aView_W|aView_H<<32
;	,	"UInt",vp_Frame,"Int64P",0,"UInt",0,"IntP",0x2<<16|1<<24,"UInt",2) ;msgbox % _nx " " _nY	;
;	WinSet,EXStyle,	-0x00200000,ahk_id %VPhWNd%
;	DllCall("UpdateLayeredWindow","UInt",VPhWNd,"UInt",0,"UInt",0,"Int64P",aView_W|aView_H<<32
;	,	"UInt",vp_Frame,"Int64P",0,"UInt",0,"IntP",0xff<<16|1<<24,"UInt",2) ;msgbox % _nx " " _nY	;
;	;BitBlt(Hss_Frame,0,0,MagSz*2,MagSz*2,vp_Frame,0,0,srccopy )
;	DllCall("UpdateLayeredWindow","UInt",MainhWnd,"UInt",0,"UInt",0,"Int64P",aView_W|aView_H<<32
;	,	"UInt",vp_Frame,"Int64P",0,"UInt",0,"IntP",0xff<<16|1<<24,"UInt",2) ;msgbox % _nx " " _nY	;
;	BitBlt(Hss_Frame,0,0,MagSz,MagSz,mdc,0,0,srcand^notsrccopy) ;srcand^mergecopy
;	;BitBlt(HDC_Frame,0,0,MagSz,MagSz,vp_Frame,0,0,srccopy ) srcand^mergepaInt
;	; WinMove(sswnd,_X_,_Y_,"","","" ) ; SWP_NOZORDER + SWP_NOACTIVATE
;	;WinMove(VPhWNd,aView_X,aView_Y,aView_W,aView_H,"" ) ; SWP_NOZORDER + SWP_NOACTIVATE

;	_X_:=round(Area_offset+(x-magoffset)) ; _Y_:=round(Area_offset+(y-magoffset))
;	(_X_<0? _X_:=0),			(_Y_<0? _Y_:=0)	; (_Y_<0.5*MagSz? _X_-=30)
;	(_X_<0? ((_X_>(x-(MagSz+(0.5 *MagSz*0.25)))) ; ? (_X_:= abs(_X_ -30), _Y_:= abs(_Y_))))
;	aView_X:= x-zx,			aView_Y:= y-zy
;	(aView_X<0? aView_X=0),	(aView_Y<0? aView_Y=0)
 
;UIBAND Z PLACEMNT WITH AHK UiA 1.33
;+ +wa_topmost	NinjMagID:= DllCall("CreateWindowInBand","UInt",0,"str","Autohotkey","str","title","UInt",0,"Int",0,"Int",0,"Int",200,"Int",200,"ptr",0,"ptr",0,"ptr",0,"ptr",0,"Int",ZBID_UIACCESS:= 2,"ptr")

TT_0ff() {
	tooltip,
	return,
}