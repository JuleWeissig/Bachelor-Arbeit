pro effektiver_radius_durchschnitt_plot_mitg
;
;   NAME: effektiver_radius_durchschnitt_plot_mitg.pro
;
;   ZWECK: - Vergleich des effektiven Radius von SAGE und DPOPS im vertikalen Höhenprofil
;          - Plotten der wichtigsten Daten unter Berücksichtigung des Genauigkeitsparameter
;
;   ZULETZT BEARBEITET: 01.02.2024 von Juliane Christin Weißig


; ---------------------------------------------------------------------------------------------------------------------
;       Berechnung Durchschnitte der DPOPS Medianradius für alle 100 Höhenmeter
; ---------------------------------------------------------------------------------------------------------------------
   
  mean_files = [$
    "arr_durchschnitt_effektiver_radius_20210617.sav",$ ; 0
    "arr_durchschnitt_effektiver_radius_20210716.sav",$
    "arr_durchschnitt_effektiver_radius_20210720.sav",$ ; 2
    "arr_durchschnitt_effektiver_radius_20210723.sav",$
    "arr_durchschnitt_effektiver_radius_20210726.sav",$ ; 4
    "arr_durchschnitt_effektiver_radius_20210729.sav",$
    "arr_durchschnitt_effektiver_radius_20210802.sav",$ ; 6
    "arr_durchschnitt_effektiver_radius_20210806.sav",$
    "arr_durchschnitt_effektiver_radius_20210810.sav",$ ; 8
    "arr_durchschnitt_effektiver_radius_20210814.sav",$
    "arr_durchschnitt_effektiver_radius_20220513.sav",$ ; 10
    "arr_durchschnitt_effektiver_radius_20220529.sav",$
    "arr_durchschnitt_effektiver_radius_20220531.sav",$ ; 12
    "arr_durchschnitt_effektiver_radius_20220602.sav",$
    "arr_durchschnitt_effektiver_radius_20220605.sav",$ ; 14
    "arr_durchschnitt_effektiver_radius_20220608.sav",$
    "arr_durchschnitt_effektiver_radius_20220621.sav",$ ; 16
    "arr_durchschnitt_effektiver_radius_20220624.sav",$
    "arr_durchschnitt_effektiver_radius_20220629.sav"] ; 18
  
  ; Anzahl der files  
  number_files = n_elements(mean_files)
  
  ; Schleife um alle files wiederherzustellen  
  for i = 0, number_files -1 do begin
    restore, mean_files[i]
  endfor
  
  ; Arary über alle Variablen, welche in den files enthalten sind
  EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM = [$
    [durchschnitt_effektiver_radius_20210617],$ ; 0
    [durchschnitt_effektiver_radius_20210716],$
    [durchschnitt_effektiver_radius_20210720],$ ; 2
    [durchschnitt_effektiver_radius_20210723],$
    [durchschnitt_effektiver_radius_20210726],$ ; 4
    [durchschnitt_effektiver_radius_20210729],$
    [durchschnitt_effektiver_radius_20210802],$ ; 6
    [durchschnitt_effektiver_radius_20210806],$
    [durchschnitt_effektiver_radius_20210810],$ ; 8
    [durchschnitt_effektiver_radius_20210814],$
    [durchschnitt_effektiver_radius_20220513],$ ; 10
    [durchschnitt_effektiver_radius_20220529],$
    [durchschnitt_effektiver_radius_20220531],$ ; 12
    [durchschnitt_effektiver_radius_20220602],$
    [durchschnitt_effektiver_radius_20220605],$ ; 14
    [durchschnitt_effektiver_radius_20220608],$
    [durchschnitt_effektiver_radius_20220621],$ ; 16
    [durchschnitt_effektiver_radius_20220624],$
    [durchschnitt_effektiver_radius_20220629]] ; 18
  
  ; Standardabweichung der effektiven Radien
  stddev_files = [$
    "arr_abweichung_durchschnitt_effektiver_radius_20210617.sav",$ ; 0
    "arr_abweichung_durchschnitt_effektiver_radius_20210716.sav",$
    "arr_abweichung_durchschnitt_effektiver_radius_20210720.sav",$ ; 2
    "arr_abweichung_durchschnitt_effektiver_radius_20210723.sav",$
    "arr_abweichung_durchschnitt_effektiver_radius_20210726.sav",$ ; 4
    "arr_abweichung_durchschnitt_effektiver_radius_20210729.sav",$
    "arr_abweichung_durchschnitt_effektiver_radius_20210802.sav",$ ; 6
    "arr_abweichung_durchschnitt_effektiver_radius_20210806.sav",$
    "arr_abweichung_durchschnitt_effektiver_radius_20210810.sav",$ ; 8
    "arr_abweichung_durchschnitt_effektiver_radius_20210814.sav",$
    "arr_abweichung_durchschnitt_effektiver_radius_20220513.sav",$ ; 10
    "arr_abweichung_durchschnitt_effektiver_radius_20220529.sav",$
    "arr_abweichung_durchschnitt_effektiver_radius_20220531.sav",$ ; 12
    "arr_abweichung_durchschnitt_effektiver_radius_20220602.sav",$
    "arr_abweichung_durchschnitt_effektiver_radius_20220605.sav",$ ; 14
    "arr_abweichung_durchschnitt_effektiver_radius_20220608.sav",$
    "arr_abweichung_durchschnitt_effektiver_radius_20220621.sav",$ ; 16
    "arr_abweichung_durchschnitt_effektiver_radius_20220624.sav",$
    "arr_abweichung_durchschnitt_effektiver_radius_20220629.sav"] ; 18
    
  ; Schleife um alle files wiederherzustellen
  for i = 0, number_files -1 do begin
    restore, stddev_files[i]
  endfor
  
  ; Arary über alle Variablen, welche in den files enthalten sind
  EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM = [$
    [abweichung_durchschnitt_effektiver_radius_20210617],$ ; 0
    [abweichung_durchschnitt_effektiver_radius_20210716],$
    [abweichung_durchschnitt_effektiver_radius_20210720],$ ; 2
    [abweichung_durchschnitt_effektiver_radius_20210723],$
    [abweichung_durchschnitt_effektiver_radius_20210726],$ ; 4
    [abweichung_durchschnitt_effektiver_radius_20210729],$
    [abweichung_durchschnitt_effektiver_radius_20210802],$ ; 6
    [abweichung_durchschnitt_effektiver_radius_20210806],$
    [abweichung_durchschnitt_effektiver_radius_20210810],$ ; 8
    [abweichung_durchschnitt_effektiver_radius_20210814],$
    [abweichung_durchschnitt_effektiver_radius_20220513],$ ; 10
    [abweichung_durchschnitt_effektiver_radius_20220529],$
    [abweichung_durchschnitt_effektiver_radius_20220531],$ ; 12
    [abweichung_durchschnitt_effektiver_radius_20220602],$
    [abweichung_durchschnitt_effektiver_radius_20220605],$ ; 14
    [abweichung_durchschnitt_effektiver_radius_20220608],$
    [abweichung_durchschnitt_effektiver_radius_20220621],$ ; 16
    [abweichung_durchschnitt_effektiver_radius_20220624],$
    [abweichung_durchschnitt_effektiver_radius_20220629]] ; 18
    
; ---------------------------------------------------------------------------------------------------------------------
;       PLOTS BACHELORARBEIT: Vergleich effektiver Radien von DPOPS und SAGE im vertikalen Höhenprofil
; ---------------------------------------------------------------------------------------------------------------------

  ; SAGE Daten
  restore, "julian_dates_sage3iss.sav"
  restore, "sage3iss_latitude.sav"
  restore, "sage3iss_longitude.sav"
  restore, "sage3iss_tropopause_height.sav"
  restore, "genauigkeitsparameter_sage3iss_wlkombi45.sav"
  restore, "arr_effektiverradius_sage3iss_mit_genauigkeitsparameter.sav"
  
  ; Anzahl der SAGE-Messungen
  ending = n_elements(sage3iss_latitude)
  hight = 210
  ; Array der Höhenmeter zum Plotten der SAGE Daten
  altitude_sage = findgen(n_elements(sage3iss_latitude))*0.5+0.5
  ; Array für Höhenabschnitte der DPOPS Daten --> z.B. zwischen 100 und 200 m --> Daten werden im Plot bei 150m geplottet
  abschnitte_hoehe = findgen(hight)*100.+50
  hoehe_km = abschnitte_hoehe/1000.
  ; Array für zonale Indices und Betrachtung über den USA
  latitude_sage_usa= make_array(ending)
  latitude_sage_zonal= make_array(ending)
  
  
  ; zonale Messwerte raussuchen --> zwischen 10° und 60° N
  for i = 0, ending-1 do begin
    if (sage3iss_latitude[i] gt 10.) and (sage3iss_latitude[i] lt 60.) then begin
      latitude_sage_zonal[i] = sage3iss_latitude[i]
      if (sage3iss_longitude[i] gt -140.) and (sage3iss_longitude[i] lt -70.) then begin
        latitude_sage_usa[i] = sage3iss_latitude[i] ; zusätzliche Bregrenzung der Längengrade zwischen -140 und -70
        ;
      endif
    endif
  endfor
  
  ;Indices zurückführen auf ursprünglichen Datensatz
  index_values = where(latitude_sage_zonal[34900:37000] gt 0., count) ; Beginn: 04.06.2021 23 Uhr - Ende: 23.08.2021 1 Uhr
  sage_zonal_index_2021 = (index_values) + 34900 ; Indices einordnen in SAGE Daten
  
  index_values = where(latitude_sage_zonal[43250:45322] gt 0., count) ; Beginn: 30.04.2021 23 Uhr - Ende: 01.08.2021 1 Uhr
  sage_zonal_index_2022 = (index_values) + 43250 ; Indices einordnen in SAGE Daten
  
  index_values = where(latitude_sage_usa[34900:37000] gt 0., count) ; Beginn: 04.06.2021 23 Uhr - Ende: 23.08.2021 1 Uhr
  sage_usa_index_2021 = (index_values) + 34900 ; Indices einordnen in SAGE Daten
  
  index_values = where(latitude_sage_usa[43250:45322] gt 0., count) ; Beginn: 30.04.2021 23 Uhr - Ende: 01.08.2021 1 Uhr
  sage_usa_index_2022 = (index_values) + 43250 ; Indices einordnen in SAGE Daten
  
  
  ; Parameter für das einheitliche Plotten der Durchschnitte
  position = [0.1, 0.125, 0.95, 0.95] ; Position der Legende
  xr = [50,350] ; XRANGE
  yr = [5,30] ; YRANGE
  yt = "Höhe [km]" ; TITLE Y ACHSE
  xt = "effektiver Radius [nm]" ; TITLE X ACHSE
  
  ; ------------------- USA Betrachtung: 02.08.2021  ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 6
  ; Index SAGE-Messungen
  idx_sage_beg = 76
  idx_sage_end = 78

  ; alle 0.000 Werte fürs Plotten heraussuchen
  eff_radius_ne_zero = where(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[*, idx_dpops_file] ne 0.)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20210802_1 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file] + $
    EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[eff_radius_ne_zero, idx_dpops_file],$
    hoehe_km(eff_radius_ne_zero), COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2) 
    
  dpops_abweichung_20210802_2 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file] - $
    EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[eff_radius_ne_zero, idx_dpops_file],$
    hoehe_km(eff_radius_ne_zero), /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
    
  dpops_20210802 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file], hoehe_km(eff_radius_ne_zero), $
    THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
    
  ; SAGE Einzelmessungen plotten
  for i = idx_sage_beg, idx_sage_end do begin
    sage_einzel = plot(effektiverradius_sage3iss_mit_genauigkeitsparameter[sage_usa_index_2021[i:i],*],altitude_sage, NAME = "SAGE III on ISS Einzelmessung",$
      COLOR = "light blue", /OVERPLOT, THICK=2)
  endfor
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210802 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210802[i] = mean(effektiverradius_sage3iss_mit_genauigkeitsparameter[sage_usa_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor

  relative_abweichung_20210802 = make_array(210)
  
  for i = 0, 89 do begin
    for j = 2, 210-1 do begin
      if hoehe_km[j] gt  altitude_sage[i]-0.25 and hoehe_km[j] lt altitude_sage[i] + 0.25 then begin
        x = make_array(210)
        x = 100*((EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[j, idx_dpops_file] - mitg_durchschnitt_sage_20210802[i])/ mitg_durchschnitt_sage_20210802[i])
        relative_abweichung_20210802[j] = x
        print, x, hoehe_km[j]
      endif
    endfor
  endfor
  

  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210802, altitude_sage, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2021[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20210802, dpops_abweichung_20210802_1, sage_einzel, sage_durchschnitt, tropo],$
    POSITION=[0.99,0.99])

; ------------------- USA Betrachtung 31.05.2022  ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 12
  ; Index SAGE-Messungen
  idx_sage_beg = 20
  idx_sage_end = 22


  eff_radius_ne_zero = where(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[*, idx_dpops_file] ne 0.)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_202203105_1 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file] + $
    EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[*, idx_dpops_file],$
    hoehe_km(eff_radius_ne_zero), COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_202203105_2 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file] - $
    EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[*, idx_dpops_file],$
    hoehe_km(eff_radius_ne_zero), /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_202203105 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file], hoehe_km(eff_radius_ne_zero), $
    THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
    
  ; SAGE Einzelmessungen plotten
  for i = idx_sage_beg, idx_sage_end do begin
    sage_einzel = plot(effektiverradius_sage3iss_mit_genauigkeitsparameter[sage_usa_index_2022[i:i],*],altitude_sage, NAME = "SAGE III on ISS Einzelmessung",$
      COLOR = "light blue", /OVERPLOT, THICK=2)
  endfor
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_202203105 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_202203105[i] = mean(effektiverradius_sage3iss_mit_genauigkeitsparameter[sage_usa_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  relative_abweichung_202203105 = make_array(210)
  
  for i = 0, 89 do begin
    for j = 2, 210-1 do begin
      if hoehe_km[j] gt  altitude_sage[i]-0.25 and hoehe_km[j] lt altitude_sage[i] + 0.25 then begin
        x = make_array(210)
        x = 100*((EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[j, idx_dpops_file] - mitg_durchschnitt_sage_20210802[i])/ mitg_durchschnitt_sage_20210802[i])
        relative_abweichung_202203105[j] = x
        print, x, hoehe_km[j]
      endif
    endfor
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_202203105, altitude_sage, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2022[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_202203105, dpops_abweichung_202203105_1, sage_einzel, sage_durchschnitt, tropo],$
    POSITION=[0.99,0.99])
    
  ; ------------------- USA Betrachtung: 02.06.2022 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 13
  ; Index SAGE-Messungen
  idx_sage_beg = 26
  idx_sage_end = 28

  
  eff_radius_ne_zero = where(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[*, idx_dpops_file] ne 0.)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20220602_1 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file] + $
    EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[*, idx_dpops_file],$
    hoehe_km(eff_radius_ne_zero), COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20220602_2 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file] - $
    EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[*, idx_dpops_file],$
    hoehe_km(eff_radius_ne_zero), /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20220602 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file], hoehe_km(eff_radius_ne_zero), $
    THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
    
  ; SAGE Einzelmessungen plotten
  for i = idx_sage_beg, idx_sage_end do begin
    sage_einzel = plot(effektiverradius_sage3iss_mit_genauigkeitsparameter[sage_usa_index_2022[i:i],*],altitude_sage, NAME = "SAGE III on ISS Einzelmessung",$
      COLOR = "light blue", /OVERPLOT, THICK=2)
  endfor
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20220602 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20220602[i] = mean(effektiverradius_sage3iss_mit_genauigkeitsparameter[sage_usa_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20220602, altitude_sage, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2022[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20220602, dpops_abweichung_20220602_1, sage_einzel, sage_durchschnitt, tropo],$
    POSITION=[0.99,0.99])

; ------------------- zonale Betrachtung: 06.08.2021 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 7
  ; Index SAGE-Messungen
  idx_sage_beg = 450
  idx_sage_end = 463


  eff_radius_ne_zero = where(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[*, idx_dpops_file] ne 0.)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20210806_1 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file] + $
    EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[*, idx_dpops_file],$
    hoehe_km(eff_radius_ne_zero), COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20210806_2 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file] - $
    EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[*, idx_dpops_file],$
    hoehe_km(eff_radius_ne_zero), /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20210806 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file], hoehe_km(eff_radius_ne_zero), $
    THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
    
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210806 = make_array(90)
  mitg_abweichung_sage_20210806 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210806[i] = mean(effektiverradius_sage3iss_mit_genauigkeitsparameter[sage_zonal_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
    mitg_abweichung_sage_20210806[i] = stddev(effektiverradius_sage3iss_mit_genauigkeitsparameter[sage_zonal_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  

  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210806, altitude_sage, /OVERPLOT, THICK = 2, COLOR = "blue",$
    NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20210806 - mitg_abweichung_sage_20210806, altitude_sage, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20210806 + mitg_abweichung_sage_20210806 , altitude_sage, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
    
    
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_zonal_index_2021[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20210806, dpops_abweichung_20210806_1, sage_durchschnitt,sage_abweichung_1, tropo],$
    POSITION=[0.99,0.99])

; ------------------- zonale Betrachtung: 02.08.2021 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 6
  ; Index SAGE-Messungen
  idx_sage_beg = 388
  idx_sage_end = 402
 
  ; alle 0.000 Werte fürs Plotten heraussuchen
  eff_radius_ne_zero = where(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[*, idx_dpops_file] ne 0.)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20210802_1 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file] + $
    EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[eff_radius_ne_zero, idx_dpops_file],$
    hoehe_km(eff_radius_ne_zero), COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2) 
    
  dpops_abweichung_20210802_2 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file] - $
    EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[eff_radius_ne_zero, idx_dpops_file],$
    hoehe_km(eff_radius_ne_zero), /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
    
  dpops_20210802 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file], hoehe_km(eff_radius_ne_zero), $
    THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
    
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210802_zonal = make_array(90)
  mitg_abweichung_sage_20210802_zonal = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210802_zonal[i] = mean(effektiverradius_sage3iss_mit_genauigkeitsparameter[sage_zonal_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
    mitg_abweichung_sage_20210802_zonal[i] = stddev(effektiverradius_sage3iss_mit_genauigkeitsparameter[sage_zonal_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210802_zonal, altitude_sage, /OVERPLOT, THICK = 2, COLOR = "blue",$
    NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20210802_zonal - mitg_abweichung_sage_20210802_zonal, altitude_sage, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20210802_zonal + mitg_abweichung_sage_20210802_zonal , altitude_sage, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
    
    
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_zonal_index_2021[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20210802,dpops_abweichung_20210802_1, sage_durchschnitt,sage_abweichung_2, tropo],$
    POSITION=[0.99,0.99])

; ------------------- zonale Betrachtung: 24.06.2022 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 17
  ; Index SAGE-Messungen
  idx_sage_beg = 330
  idx_sage_end = 342
  
  eff_radius_ne_zero = where(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[*, idx_dpops_file] ne 0.)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20220624_1 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file] + $
    EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[*, idx_dpops_file],$
    hoehe_km(eff_radius_ne_zero), COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20220624_2 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file] - $
    EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[*, idx_dpops_file],$
    hoehe_km(eff_radius_ne_zero), /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20220624 = plot(EFF_RADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[eff_radius_ne_zero, idx_dpops_file], hoehe_km(eff_radius_ne_zero), $
    THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
    
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20220624 = make_array(90)
  mitg_abweichung_sage_20220624 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20220624[i] = mean(effektiverradius_sage3iss_mit_genauigkeitsparameter[sage_zonal_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
    mitg_abweichung_sage_20220624[i] = stddev(effektiverradius_sage3iss_mit_genauigkeitsparameter[sage_zonal_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20220624, altitude_sage, /OVERPLOT, THICK = 2, COLOR = "blue",$
    NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20220624 - mitg_abweichung_sage_20220624, altitude_sage, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20220624 + mitg_abweichung_sage_20220624 , altitude_sage, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")

    
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_zonal_index_2022[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20220624, dpops_abweichung_20220624_1, sage_durchschnitt,sage_abweichung_1, tropo],$
    POSITION=[0.99,0.99])
    
end