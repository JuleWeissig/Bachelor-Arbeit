pro dos_n_durchschnitt_ohneg
;
;   NAME: dos_n_durchschnitt_ohneg.pro
;
;   ZWECK: - Berechnung der Durchschnitte der Anzahldichte
;          - Vergleich von SAGE und DPOPS Anzahldichte im vertikalen Höhenprofil
;          - Plotten der wichtigsten Daten ohne Berücksichtigung des Genauigkeitsparameter
;          --> Gesamtheit aller SAGE Messwerte werden dargestellt
;
;   ZULETZT BEARBEITET: 03.02.2024 von Juliane Christin Weißig
;
;
; ---------------------------------------------------------------------------------------------------------------------
;       Berechnung Durchschnitte der DPOPS Anzahldichten für alle 100 Höhenmeter
; ---------------------------------------------------------------------------------------------------------------------
  
  ; Array mit allen Dateiname
  filename = ["DCOTSS-MERGE-10S_MERGE_20210617_R2.sav",$ ; 0
    "DCOTSS-MERGE-10S_MERGE_20210716_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20210720_R2.sav",$ ; 2
    "DCOTSS-MERGE-10S_MERGE_20210723_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20210726_R2.sav",$ ; 4
    "DCOTSS-MERGE-10S_MERGE_20210729_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20210802_R2.sav",$ ; 6
    "DCOTSS-MERGE-10S_MERGE_20210806_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20210810_R2.sav",$ ; 8
    "DCOTSS-MERGE-10S_MERGE_20210814_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220513_R2.sav",$ ; 10
    "DCOTSS-MERGE-10S_MERGE_20220529_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220531_R2.sav",$ ; 12
    "DCOTSS-MERGE-10S_MERGE_20220602_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220605_R2.sav",$ ; 14
    "DCOTSS-MERGE-10S_MERGE_20220608_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220621_R2.sav",$ ; 16
    "DCOTSS-MERGE-10S_MERGE_20220624_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220629_R2.sav"] ; 18
    
  ; Anzahl der Datein für 2021 und 2022 zusammen
  number_filename = n_elements(filename)
  ;Größe des Höhenmeter Arary --> maximale Höhe von 21 km für Flugzeig angenommen
  hight = 210
  ; Pfad der Datei
  path = "I:\DPOPS_NC_2022\"
  
  ; Erstellen der Arrays für die späteren Durchschnitte der Anzahldichte
  DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM = make_array(number_filename, hight)
  ; Erstellen der Arrays für die Abweichunge der Durchschnitte der Anzahldichte
  DOS_N_DPOPS_HOEHENDURSCHNITTE_ABWEICHUNG_BIS_21KM = make_array(number_filename, hight)
  
  ; Berechnung der Durchschnitte + Abspeichern im Array für alle 19 Datein
  for i = 0, number_filename -1 do begin
  
    ; Wiederherstellen der Datei
    restore, path + filename[i]
    
    ; Definieren
    ; Höhenabschnitte für alle 100 Höhenmeter
    abschnitte_hoehe = findgen(hight)*100.
    ; Höhe und Anzahldichte als Array(2, Einzelmessungen) zusammenführen
    hoehe_dos_n = [[ALT_ER2],[dos_n]]
    ; Alle NAN Werte aus den Anzahldichten herraussuchen
    nan = where(finite(hoehe_dos_n[*,1], /NAN))
    ; NAN Werte 0. setzen
    hoehe_dos_n[nan,1] = 0.
    
    ; temporäres Array für Anzahldichten-Durchschnitte
    temp_durchschnitte_dos_n = make_array(hight)
    ; temporäres Array für Abweichungen der Anzahldichten-Durchschnitte
    temp_abweichung_dos_n= make_Array(hight)
    ; Größe des Messung --> Anzahl der Einzelmessungen
    ending = n_elements(ALT_ER2)
    
    ; alle 100m Durchschnitte des Medianradius
    for k = 0, hight-2 do begin
      y = make_array(ending)
      for j = 0, ending-1 do begin
        if (hoehe_dos_n[j,0] gt abschnitte_hoehe[k]) and (hoehe_dos_n[j,0] lt abschnitte_hoehe[k+1]) then begin
          y[j] = hoehe_dos_n[j,1]
        endif
      endfor
      temp_durchschnitte_dos_n[k] = mean(y(where(y ne 0.)))
      temp_abweichung_dos_n[k] = stddev(y)
    endfor
    
    DOS_N_DPOPS_HOEHENDURSCHNITTE_ABWEICHUNG_BIS_21KM[i,*] = temp_abweichung_dos_n
    DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[i,*] = temp_durchschnitte_dos_n
    
  endfor
  
  ; ---------------------------------------------------------------------------------------------------------------------
  ;       PLOTS BACHELORARBEIT: Vergleich Anzahldichte DPOPS und SAGE im vertikalen Höhenprofil
  ; ---------------------------------------------------------------------------------------------------------------------
  
  ; SAGE Daten
  restore, "anzahldichte_sage3iss_wlkombi45_755nm.sav"
  restore, "julian_dates_sage3iss.sav"
  restore, "sage3iss_latitude.sav"
  restore, "sage3iss_longitude.sav"
  restore, "sage3iss_tropopause_height.sav"
  restore, "genauigkeitsparameter_sage3iss_wlkombi45.sav"
  
  ; Anzahl der SAGE-Messungen
  ending = n_elements(sage3iss_latitude)
  
  ; Array der Höhenmeter zum Plotten der SAGE Daten
  altitude = findgen(n_elements(anzahldichte_sage3iss_wlkombi45_755nm[1,*]))*0.5+0.5
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
  xr = [0,80] ; XRANGE
  yr = [5,30] ; YRANGE
  yt = "Höhe [km]" ; TITLE Y ACHSE
  xt = "$Anzahldichte [1/cm^{3}]$" ; TITLE X ACHSE
  
; ------------------- USA Betrachtung: 02.06.2022 ---------------------------------------------------------------------
 
  ; Index file DPOPS
  idx_dpops_file = 13
  ; Index SAGE-Messungen
  idx_sage_beg = 26
  idx_sage_end = 28
  
  ; alle 0.000 Werte fürs Plotten heraussuchen
  dos_n_ne_zero = where(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,*] gt 0.0)

  ; DPOPS Messwerte plotten
  dpops_abweichung_20220602_1 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,dos_n_ne_zero] + $
    DOS_N_DPOPS_HOEHENDURSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file,dos_n_ne_zero],$
    hoehe_km[dos_n_ne_zero], COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20220602_2 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,dos_n_ne_zero] - $
    DOS_N_DPOPS_HOEHENDURSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file,dos_n_ne_zero],$
    hoehe_km[dos_n_ne_zero], /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20220602 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,dos_n_ne_zero], hoehe_km[dos_n_ne_zero], THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
  
  ; SAGE Einzelmessungen plotten
  for i = idx_sage_beg, idx_sage_end do begin
    sage_einzel = plot(anzahldichte_sage3iss_wlkombi45_755nm[sage_usa_index_2022[i:i],*],altitude, NAME = "SAGE III on ISS Einzelmessung",$
      COLOR = "violet", /OVERPLOT, THICK=2)
  endfor
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20220602 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20220602[i] = mean(anzahldichte_sage3iss_wlkombi45_755nm[sage_usa_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor

  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20220602, altitude, /OVERPLOT, THICK = 2, COLOR = "purple", NAME = "SAGE III on ISS Durchschnitt")
  
  ; Durchschnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2022[26:28]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20220602, dpops_abweichung_20220602_1, sage_einzel, sage_durchschnitt, tropo],$
    POSITION=[0.99,0.99])

  ; ------------------- USA Betrachtung: 06.08.2021 ---------------------------------------------------------------------
  
  ; Index file DPOPS
  idx_dpops_file = 7
  ; Index SAGE-Messungen
  idx_sage_beg = 89
  idx_sage_end = 90
  
  
  ; alle 0.000 Werte fürs Plotten heraussuchen
  dos_n_ne_zero = where(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,*] gt 0.)
 
  ; DPOPS Messwerte plotten
  dpops_abweichung_20210806_1 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,dos_n_ne_zero] + $
    DOS_N_DPOPS_HOEHENDURSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file,dos_n_ne_zero],$
    hoehe_km[dos_n_ne_zero], COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20210806_2 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,dos_n_ne_zero] - $
    DOS_N_DPOPS_HOEHENDURSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file,dos_n_ne_zero],$
    hoehe_km[dos_n_ne_zero], /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20210806 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,dos_n_ne_zero], hoehe_km[dos_n_ne_zero], THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
  
  ; SAGE Einzelmessungen plotten
  for i = idx_sage_beg, idx_sage_end do begin
    sage_einzel = plot(anzahldichte_sage3iss_wlkombi45_755nm[sage_usa_index_2021[i:i],*],altitude, NAME = "SAGE III on ISS Einzelmessung",$
      COLOR = "violet", /OVERPLOT, THICK=2)
  endfor
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210806 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210806[i] = mean(anzahldichte_sage3iss_wlkombi45_755nm[sage_usa_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210806, altitude, /OVERPLOT, THICK = 2, COLOR = "purple", NAME = "SAGE III on ISS Durchschnitt")
  
  ; Durchschnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2021[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20210806, dpops_abweichung_20210806_1, sage_einzel, sage_durchschnitt, tropo],$
    POSITION=[0.99,0.99])
    

; ------------------- USA Betrachtung: DPOPS: 26.07.2021, SAGE: 27.07.2021  ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 4
  ; Index SAGE-Messungen
  idx_sage_beg = 60
  idx_sage_end = 62

  ; alle 0.000 Werte fürs Plotten heraussuchen
  dos_n_ne_zero = where(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,*] gt 0.0)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20210802_1 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file, dos_n_ne_zero] + $
    DOS_N_DPOPS_HOEHENDURSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, dos_n_ne_zero],$
    hoehe_km[dos_n_ne_zero], COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20210802_2 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file, dos_n_ne_zero] - $
    DOS_N_DPOPS_HOEHENDURSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, dos_n_ne_zero],$
    hoehe_km[dos_n_ne_zero], /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20210802 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file, dos_n_ne_zero], hoehe_km[dos_n_ne_zero], THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
   
  ; SAGE Einzelmessungen plotten
  for i = idx_sage_beg, idx_sage_end do begin
    sage_einzel = plot(anzahldichte_sage3iss_wlkombi45_755nm[sage_usa_index_2021[i:i],*],altitude, NAME = "SAGE III on ISS Einzelmessung",$
      COLOR = "violet", /OVERPLOT, THICK=2)
  endfor
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210802 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210802[i] = mean(anzahldichte_sage3iss_wlkombi45_755nm[sage_usa_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor

  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210802, altitude, /OVERPLOT, THICK = 2, COLOR = "purple", NAME = "SAGE III on ISS Durchschnitt")
  
  ; Durchschnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2021[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20210802, dpops_abweichung_20210802_1, sage_einzel, sage_durchschnitt, tropo],$
    POSITION=[0.99,0.99])
    
  ; ------------------- zonale Betrachtung: 29.07.2021 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 5
  ; Index SAGE-Messungen
  idx_sage_beg = 334
  idx_sage_end = 344
  
  ; alle 0.000 Werte fürs Plotten heraussuchen
  dos_n_ne_zero = where(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,*] gt 0.0)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20210802_1 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file, dos_n_ne_zero] + $
    DOS_N_DPOPS_HOEHENDURSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, dos_n_ne_zero],$
    hoehe_km[dos_n_ne_zero], COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20210802_2 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file, dos_n_ne_zero] - $
    DOS_N_DPOPS_HOEHENDURSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, dos_n_ne_zero],$
    hoehe_km[dos_n_ne_zero], /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20210802 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file, dos_n_ne_zero], hoehe_km[dos_n_ne_zero], THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210802 = make_array(90)
  mitg_abweichung_sage_20210802 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210802[i] = mean(anzahldichte_sage3iss_wlkombi45_755nm[sage_zonal_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
    mitg_abweichung_sage_20210802[i] = stddev(anzahldichte_sage3iss_wlkombi45_755nm[sage_zonal_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210802, altitude, /OVERPLOT, THICK = 2, COLOR = "purple", NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20210802 - mitg_abweichung_sage_20210802, altitude, /OVERPLOT, THICK = 2,$
    COLOR = "violet", NAME = "SAGE III on ISS Standardabweichung")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20210802 + mitg_abweichung_sage_20210802 , altitude, /OVERPLOT, THICK = 2,$
    COLOR = "violet", NAME = "SAGE III on ISS Standardabweichung")
    
    
  ; Durchschnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_zonal_index_2021[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20210802, dpops_abweichung_20210802_1, sage_durchschnitt,sage_abweichung_1, tropo],$
    POSITION=[0.99,0.99])

; ------------------- zonale Betrachtung: 31.5.2022 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 10
  ; Index SAGE-Messungen
  idx_sage_beg = 136
  idx_sage_end = 150 
  
  ; alle 0.000 Werte fürs Plotten heraussuchen
  dos_n_ne_zero = where(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,*] gt 0.0)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20220531_1 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file, dos_n_ne_zero] + $
    DOS_N_DPOPS_HOEHENDURSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, dos_n_ne_zero],$
    hoehe_km[dos_n_ne_zero], COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20220531_2 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file, dos_n_ne_zero] - $
    DOS_N_DPOPS_HOEHENDURSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, dos_n_ne_zero],$
    hoehe_km[dos_n_ne_zero], /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20220531 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file, dos_n_ne_zero], hoehe_km[dos_n_ne_zero], THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20220531 = make_array(90)
  mitg_abweichung_sage_20220531 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20220531[i] = mean(anzahldichte_sage3iss_wlkombi45_755nm[sage_zonal_index_2022[136:150],i], /NAN)
    mitg_abweichung_sage_20220531[i] = stddev(anzahldichte_sage3iss_wlkombi45_755nm[sage_zonal_index_2022[136:150],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20220531, altitude, /OVERPLOT, THICK = 2, COLOR = "purple", NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20220531 - mitg_abweichung_sage_20220531, altitude, /OVERPLOT, THICK = 2,$
    COLOR = "violet", NAME = "SAGE III on ISS Standardabweichung")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20220531 + mitg_abweichung_sage_20220531 , altitude, /OVERPLOT, THICK = 2,$
    COLOR = "violet", NAME = "SAGE III on ISS Standardabweichung")
    
    
  ; Durchschnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_zonal_index_2022[136:150]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20220531, dpops_abweichung_20220531_1, sage_durchschnitt,sage_abweichung_1, tropo],$
    POSITION=[0.99,0.99])

; ------------------- zonale Betrachtung: 08.06.2022 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 13
  ; Index SAGE-Messungen
  idx_sage_beg = 227
  idx_sage_end = 241
  
  ; alle 0.000 Werte fürs Plotten heraussuchen
  dos_n_ne_zero = where(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,*] gt 0.0)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20220608_1 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,dos_n_ne_zero] + $
    DOS_N_DPOPS_HOEHENDURSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file,dos_n_ne_zero],$
    hoehe_km[dos_n_ne_zero], COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20220608_2 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,dos_n_ne_zero] - $
    DOS_N_DPOPS_HOEHENDURSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file,dos_n_ne_zero],$
    hoehe_km[dos_n_ne_zero], /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20220608 = plot(DOS_N_DPOPS_HOEHENDURSCHNITTE_BIS_21KM[idx_dpops_file,dos_n_ne_zero], hoehe_km[dos_n_ne_zero], THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20220608 = make_array(90)
  mitg_abweichung_sage_20220608 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20220608[i] = mean(anzahldichte_sage3iss_wlkombi45_755nm[sage_zonal_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
    mitg_abweichung_sage_20220608[i] = stddev(anzahldichte_sage3iss_wlkombi45_755nm[sage_zonal_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20220608, altitude, /OVERPLOT, THICK = 2, COLOR = "purple", NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20220608 - mitg_abweichung_sage_20220608, altitude, /OVERPLOT, THICK = 2,$
    COLOR = "violet", NAME = "SAGE III on ISS Standardabweichung")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20220608 + mitg_abweichung_sage_20220608 , altitude, /OVERPLOT, THICK = 2,$
    COLOR = "violet", NAME = "SAGE III on ISS Standardabweichung")
    
  ; Durchschnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_zonal_index_2022[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20220608, dpops_abweichung_20220608_1, sage_durchschnitt,sage_abweichung_1, tropo],$
    POSITION=[0.99,0.99])
end