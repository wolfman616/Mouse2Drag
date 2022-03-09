	
class Circle	{
	__New(x,y,pGraphics,Brush){
		This.D := This._Random(3,15)
		This.Position := New HB_Vector(x - This.D / 2, y - This.D / 2)
		;~ This.Speed := This._Random(10.00,20.00)
		This.Speed := This._Random(20.00,40.00)
		;~ This.Speed := This._Random(5.00,20.00)
		This.Acc := New HB_Vector()
		This.Target := New HB_Vector()
		This.Graphics := pGraphics
		This.Brush := Brush
		This.Distance := 0
		This._SetTarget( x, y)
	}
	Draw(){
		Gdip_FillEllipse(This.Graphics, This.Brush, This.Position.X, This.Position.Y, This.D, This.D)
	}
	_SetTarget(tx,ty){
		local dist 
		This.Target := ""
		if(This.LastTX=tx&&This.LastTY=ty){
			This.Position.X := tx - (This.D/2) 
			This.Position.Y := ty - (This.D/2)
			This.Active := 0
			return
		}
		This.Active := 1
		This.LastTX := tx
		This.LastTY := ty
		This.Target := New HB_Vector(tx-(This.D / 2),ty-( This.D /2))
		dist := This.Position.dist(This.Target)
		This.Distance := dist / This.Speed
	}
	Move(tx,ty){
		if(--This.Distance>0){
			This.Acc.X := This.Target.X 
			This.Acc.Y := This.Target.Y
			This.Acc.Sub(This.Position)
			This.Acc.SetMag(This.Speed)
			This.Position.Add(This.Acc)
		}else{
			This._SetTarget(tx,ty)
		}
		return 1
	}
	_Random(Min,Max){
		local Out
		Random,Out,Min,Max
		return Out
	}
}
Class HB_Vector	{
	__New(x:=0,y:=0){
		This.X:=x
		This.Y:=y
	}
	Add(Other_HB_Vector){
		This.X+=Other_HB_Vector.X
		This.Y+=Other_HB_Vector.Y
	}
	Sub(Other_HB_Vector){
		This.X-=Other_HB_Vector.X
		This.Y-=Other_HB_Vector.Y
	}
	mag(){
		return Sqrt(This.X*This.X + This.Y*This.Y)
	}
	magsq(){
		return This.Mag()**2
	}	
	setMag(in1){
		m:=This.Mag()
		This.X := This.X * in1/m
		This.Y := This.Y * in1/m
		return This
	}
	mult(in1,in2:="",in3:="",in4:="",in5:=""){
		if(IsObject(in1)&&in2=""){
			This.X*=In1.X 
			This.Y*=In1.Y 
		}else if(!IsObject(In1)&&In2=""){
			This.X*=In1
			This.Y*=In1
		}else if(!IsObject(In1)&&IsObject(In2)){
			This.X*=In1*In2.X
			This.Y*=In1*In2.Y
		}else if(IsObject(In1)&&IsObject(In2)){
			This.X*=In1.X*In2.X
			This.Y*=In1.Y*In2.Y
		}	
	}
	div(in1,in2:="",in3:="",in4:="",in5:=""){
		if(IsObject(in1)&&in2=""){
			This.X/=In1.X 
			This.Y/=In1.Y 
		}else if(!IsObject(In1)&&In2=""){
			This.X/=In1
			This.Y/=In1
		}else if(!IsObject(In1)&&IsObject(In2)){
			This.X/=In1/In2.X
			This.Y/=In1/In2.Y
		}else if(IsObject(In1)&&IsObject(In2)){
			This.X/=In1.X/In2.X
			This.Y/=In1.Y/In2.Y
		}	
	}
	dist(in1){
		return Sqrt(((This.X-In1.X)**2) + ((This.Y-In1.Y)**2))
	}
	dot(in1){
		return (This.X*in1.X)+(This.Y*In1.Y)
	}
	cross(in1){
		return This.X*In1.Y-This.Y*In1.X
	}
	Norm(){
		m:=This.Mag()
		This.X/=m
		This.Y/=m
	}
}