pro bimodalfunction, radius, A, F
  ; ---------------------------------------------------------------------------------------------------------------------
  ;       bimodale Größenverteilungsfunktion der stratosphärischen Aerosole
  ; ---------------------------------------------------------------------------------------------------------------------
  
  ls_0=alog(A[4])     ;log(sigma_0)
  ls_1=alog(A[5])     ;log(sigma_1)
  
  lx_0=alog(radius)-alog(A[2])  ; log(r/r_median_0)
  lx_1=alog(radius)-alog(A[3])  ; log(r/r_median_1)
  
  ex_0=exp(-(lx_0^2)/(2*ls_0^2))   ; erster exponent
  ex_1=exp(-(lx_1^2)/(2*ls_1^2))   ; zweiter exponent
  
  V_0=A[0]/(sqrt(2*!PI)*ls_0)
  V_1=A[1]/(sqrt(2*!PI)*ls_1)
  
  F=V_0*ex_0+V_1*ex_1               ; Bimodale vert.
  ; wird im spätern in der CURVEFIT Funktion aufgerufen
  
  
end