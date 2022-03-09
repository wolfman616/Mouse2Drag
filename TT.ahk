TT(TxT = "",Ti = "") {
	if dbgtt {
		tooltip, % TxT,
		if !ti 
			settimer, TT_Off, % ("-" . tt),
		else 
			settimer, TT_Off, % ("-" . ti),
}	}	

TT_Off:
tooltip,
return