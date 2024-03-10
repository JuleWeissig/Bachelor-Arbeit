pro extinction_bimodal

  restore, 'bifunc_parameter_20210802.sav'
 
  restore, 'arr_hoehendurchschnitt_anzahldichte_standardabweichung_20210802.sav'
  restore,'arr_hoehendurchschnitt_verteilungsbreite_standardabweichung_20210802.sav'
  restore,'arr_hoehendurchschnitt_medianradius_standardabweichung_20210802.sav'
  
  
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
  hight_dpops = n_elements(hoehendurchschnitt_verteilungsbreite_standardabweichung_20210802[*,0])
  abschnitte_hoehe = findgen(hight)*100.
  extinction_first_mode = make_array(hight)
  extinction_second_mode = make_array(hight)
  extinction_monomodal = make_array(hight)
 

  for i = 0, hight-1 do begin
    if parameter[i,1] gt 0.0 then begin
    mie_size_dist, 'log_normal', parameter[i,0]*1.e6, [parameter[i,2]*1e-9,parameter[i,4]], wn_756nm, m_756nm ,k_ext1
    extinction_first_mode[i] = k_ext1*1000.
    mie_size_dist, 'log_normal', parameter[i,1]*1.e6, [parameter[i,3]*1e-9,parameter[i,5]], wn_756nm, m_756nm ,k_ext2
    extinction_second_mode[i] = k_ext2*1000.

    endif
  endfor

  ; monomodale Annahme
  for i = 0, hight_dpops-1 do begin
    if hoehendurchschnitt_anzahldichte_standardabweichung_20210802[i,0] gt 0. then begin
    mie_size_dist, 'log_normal', hoehendurchschnitt_anzahldichte_standardabweichung_20210802[i,0]*1.e6,$
    [hoehendurchschnitt_medianradius_standardabweichung_20210802[i,0]*1e-9,hoehendurchschnitt_verteilungsbreite_standardabweichung_20210802[i,0]]$
    , wn_756nm, m_756nm ,k_ext_mono
  extinction_monomodal[i] = k_ext_mono*1000.
  endif
  endfor
  
  save, extinction_monomodal, FILENAME = "extinction_monomodal_20210802.sav"
  save, extinction_first_mode, FILENAME = "extinction_first_mode_20210802.sav"
  save, extinction_second_mode, FILENAME = "extinction_secon_mode_20210802.sav"

       
   p = plot((extinction_first_mode + extinction_second_mode),abschnitte_hoehe/1000., /XLOG, LINESTYLE = "none", SYMBOL = "*" )
   p = plot(extinction_monomodal, abschnitte_hoehe/1000., /OVERPLOT, LINESTYLE = "none", SYMBOL = "*", COLOR = "red")  
   
   restore, 'bifunc_parameter_20220531.sav'
   
   restore, 'arr_hoehendurchschnitt_anzahldichte_standardabweichung_20220531.sav'
   restore,'arr_hoehendurchschnitt_verteilungsbreite_standardabweichung_20220531.sav'
   restore,'arr_hoehendurchschnitt_medianradius_standardabweichung_20220531.sav'

   extinction_first_mode = make_array(hight)
   extinction_second_mode = make_array(hight)
   extinction_monomodal = make_array(hight)
   
   for i = 0, hight-1 do begin
     if parameter[i,1] gt 0.0 then begin
       mie_size_dist, 'log_normal', parameter[i,0]*1.e6, [parameter[i,2]*1e-9,parameter[i,4]], wn_756nm, m_756nm ,k_ext1
       extinction_first_mode[i] = k_ext1*1000.
       mie_size_dist, 'log_normal', parameter[i,1]*1.e6, [parameter[i,3]*1e-9,parameter[i,5]], wn_756nm, m_756nm ,k_ext2
       extinction_second_mode[i] = k_ext2*1000.
       
     endif
   endfor
   
   ; monomodale Annahme
   for i = 0, hight_dpops-1 do begin
     if hoehendurchschnitt_anzahldichte_standardabweichung_20220531[i,0] gt 0. then begin
       mie_size_dist, 'log_normal', hoehendurchschnitt_anzahldichte_standardabweichung_20220531[i,0]*1.e6,$
         [hoehendurchschnitt_medianradius_standardabweichung_20220531[i,0]*1e-9,hoehendurchschnitt_verteilungsbreite_standardabweichung_20220531[i,0]]$
         , wn_756nm, m_756nm ,k_ext_mono
       extinction_monomodal[i] = k_ext_mono*1000.
     endif
   endfor
   
   save, extinction_monomodal, FILENAME = "extinction_monomodal_20220531.sav"
   save, extinction_first_mode, FILENAME = "extinction_first_mode_20220531.sav"
   save, extinction_second_mode, FILENAME = "extinction_secon_mode_20220531.sav"
   
   
   p = plot((extinction_first_mode + extinction_second_mode),abschnitte_hoehe/1000., /XLOG, LINESTYLE = "none", SYMBOL = "*" )
   p = plot(extinction_monomodal, abschnitte_hoehe/1000., /OVERPLOT, LINESTYLE = "none", SYMBOL = "*", COLOR = "red")


end