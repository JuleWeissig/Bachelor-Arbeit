pro extinction_dpops_psd

  wavelengths = [448.511, 755.979, 1543.92]*1.e-9 ;;in m
  refr_real_ = [1.45762, 1.45186, 1.42510]
  refr_imaginary = [0.00000, 7.69735e-08, 0.000141861]
  
  nd=1.e6  ;;1 Mio. Teilchen pro m^3 entspricht 1 /cm^3. Diese Angabe hier bestimmt, dass die Anzahldichte später auch in 1/cm^3 in die Matrizen eingetragen wird.
  wn_449nm = 1. / wavelengths[0]
  wn_756nm = 1. / wavelengths[1]
  wn_1544nm = 1. / wavelengths[2]
  m_449nm=complex(refr_real_[0], - refr_imaginary[0]);; Brechungsindex mit realem und imaginärem Anteil (Streuung, Absorption)
  m_756nm=complex(refr_real_[1], - refr_imaginary[1])
  m_1544nm=complex(refr_real_[2], - refr_imaginary[2])
  
  hight = 210
  abschnitte_hoehe = findgen(hight)*100.
  extinction_first_mode = make_array(hight)
  extinction_second_mode = make_array(hight)
  extinction_monomodal = make_array(hight)
  
  radius=[140., 147., 154.,161.,169.,176.,185.,194.,203.,212.,222.,233.,244.$
    ,255.,267.,280.,293.,328.,387.,452.,523.,583.,634.,692.,769.,883.,1021.,1166.,1316.,$
    1483.,1681.,1917.,2206.,2568.,3031.,3451.]/2.
  restore, "DCOTSS-MERGE-10S_MERGE_20210802_R2.sav"
  dpops_size = n_elements(LAT_ER2)

  
  allbins=[[BIN01],[BIN02],[BIN03],[BIN04],[BIN05],[BIN06],[BIN07],[BIN08],[BIN09],[BIN10],[BIN11],[BIN12],[BIN13],[BIN14],[BIN15],[BIN16],$
    [BIN17],[BIN18],[BIN19],[BIN20],[BIN21],[BIN22],[BIN23],[BIN24],[BIN25],[BIN26],[BIN27],[BIN28],[BIN29],[BIN30],[BIN31],[BIN32],[BIN33],$
    [BIN34],[BIN35],[BIN36]]

    
;  bin_boundary = [135., 143.5 ,150.5, 157.5, 165., 172.5, 180.5, 189.5, 198.5, 207.5, 217, 227.5, 138.5, $
;    249.5, 261., 274.5, 287.5, 310.5, 357.5, 419.5,  ] 

  bin_boundary = make_array(38) 
  bin_boundary[0] = 135./2.
  bin_boundary[36] = 3241./2.
  bin_boundary[37] = 3661./2.
  
  
  for i =0, 34 do begin
    y = (radius[i+1] + radius[i])/2 
      bin_boundary[i+1] = y
  endfor
  
  dn = make_array(dpops_size, 36)
  for k = 0, dpops_size-1 do begin
  for i = 0, 35 do begin
    dn[k,i] = allbins[k,i]* (ALOG10(bin_boundary[i+1]) - ALOG10(bin_boundary[i]))
  endfor 
  endfor

  k_ext = make_array(dpops_size, 36)
 
  for i = 0, dpops_size-1  do begin
    for bin = 0, 35 do begin
    if dn[i,bin] gt 0. then begin
      mie_size_dist, 'log_normal', dn[i,bin]*1.e6,$
        [radius[bin]*1e-9, ALOG10(bin_boundary[bin+1]-bin_boundary[bin])]$
        , wn_756nm, m_756nm ,k_ext_mono
        k_ext[i, bin] = k_ext_mono*1000.
    endif
  endfor
  endfor

  print, TOTAL(k_ext[500,*]) 
  k_ext_total = make_array(dpops_size, 36)

    for i = 0, dpops_size-1 do begin
      k_ext_total[i] = TOTAL(k_ext[i,*]) 
    endfor
    
   save, k_ext_total, FILENAME = "k_ext_total_20210802.sav"
  p = plot(k_ext_total, ALT_ER2/1000., /XLOG, LINESTYLE = "none", SYMBOL = "*" )

  

end