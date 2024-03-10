pro verteilungsbreite_durchschnitt_plot_mitg
;
;   NAME: verteilungsbreite_durchschnitt_plot_mitg.pro
;   
;   ZWECK: - Berechnung der Durchschnitte der Größenverteilungsparameter (zuvor mittels gaussfit ermittelt)
;          - Vergleich von SAGE und DPOPS Verteilungsbreite im vertikalen Höhenprofil
;          - Plotten der wichtigsten Daten unter Berücksichtigung des Genauigkeitsparameter
;   
;   ZULETZT BEARBEITET: 01.02.2024 von Juliane Christin Weißig
;   
; ---------------------------------------------------------------------------------------------------------------------
;       Berechnung Durchschnitte der DPOPS Medianradius für alle 100 Höhenmeter
; ---------------------------------------------------------------------------------------------------------------------
  
  ; Array mit allen Dateiname
  filename = ["DCOTSS-MERGE-10S_MERGE_20210617_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20210716_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20210720_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20210723_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20210726_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20210729_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20210802_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20210806_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20210810_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20210814_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220513_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220529_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220531_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220602_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220605_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220608_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220621_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220624_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220629_R2.sav"]
    
    
  array_medianradius = ["arr_anzahldichte_medianradius_verteilungsbreite_20210617.sav",$ ; 0
    "arr_anzahldichte_medianradius_verteilungsbreite_20210716.sav",$ 
    "arr_anzahldichte_medianradius_verteilungsbreite_20210720.sav",$ ; 2
    "arr_anzahldichte_medianradius_verteilungsbreite_20210723.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20210726.sav",$ ; 4
    "arr_anzahldichte_medianradius_verteilungsbreite_20210729.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20210802.sav",$ ; 6
    "arr_anzahldichte_medianradius_verteilungsbreite_20210806.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20210810.sav",$ ; 8
    "arr_anzahldichte_medianradius_verteilungsbreite_20210814.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20220513.sav",$ ; 10
    "arr_anzahldichte_medianradius_verteilungsbreite_20220529.sav",$ 
    "arr_anzahldichte_medianradius_verteilungsbreite_20220531.sav",$ ; 12
    "arr_anzahldichte_medianradius_verteilungsbreite_20220602.sav",$ 
    "arr_anzahldichte_medianradius_verteilungsbreite_20220605.sav",$ ; 14
    "arr_anzahldichte_medianradius_verteilungsbreite_20220608.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20220621.sav",$ ; 16
    "arr_anzahldichte_medianradius_verteilungsbreite_20220624.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20220629.sav"] ; 18
    
    
  ; Anzahl der Datein für 2021 und 2022 zusammen
  number_filename = n_elements(array_medianradius)
  ;Größe des Höhenmeter Arary --> maximale Höhe von 21 km für Flugzeig angenommen
  hight = 210
  ; Pfad der Datei
  path = "I:\DPOPS_NC_2022\"
  
  ; Erstellen der Arrays für die späteren Durchschnitte der Anzahldichte
  VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM = make_array(number_filename, hight)
  ; Erstellen der Arrays für die Abweichunge der Durchschnitte der Anzahldichte
  VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM = make_array(number_filename, hight)
  
  ; Berechnung der Durchschnitte + Abspeichern im Array für alle 19 Datein
  for i = 0, number_filename -1 do begin
  
    ; Wiederherstellen der Datei
    restore, path + array_medianradius[i]
    restore, path + filename[i]
    
    ; Definieren
    ; Höhenabschnitte für alle 100 Höhenmeter
    abschnitte_hoehe = findgen(hight)*100.
    ; Höhe und Anzahldichte als Array(2, Einzelmessungen) zusammenführen
    hoehe_verteilungsbreite = [[ALT_ER2],[ANZAHLDICHTE_MEDIANRADIUS_VERTEILUNGSBREITE[*,2]]]
    ; Alle NAN Werte aus den Anzahldichten herraussuchen
    nan = where(finite(hoehe_verteilungsbreite[*,1], /NAN))
    ; NAN Werte 0. setzen
    hoehe_verteilungsbreite[nan,1] = 0.
    
    ; temporäres Array für Anzahldichten-Durchschnitte
    temp_durchschnitte_verteilungsbreite = make_array(hight)
    ; temporäres Array für Abweichungen der Anzahldichten-Durchschnitte
    temp_abweichung_verteilungsbreite= make_Array(hight)
    ; Größe des Messung --> Anzahl der Einzelmessungen
    ending = n_elements(ALT_ER2)
    
    ; alle 100m Durchschnitte des verteilungsbreite
    for k = 0, hight-2 do begin
      y = make_array(ending)
      for j = 0, ending-1 do begin
        if (hoehe_verteilungsbreite[j,0] gt abschnitte_hoehe[k]) and (hoehe_verteilungsbreite[j,0] lt abschnitte_hoehe[k+1]) then begin
          y[j] = hoehe_verteilungsbreite[j,1]
        endif
      endfor
      temp_durchschnitte_verteilungsbreite[k] = mean(y(where(y ne 0.)))
      temp_abweichung_verteilungsbreite[k] = stddev(y)
    endfor
    
    VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[i,*] = temp_abweichung_verteilungsbreite
    VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[i,*] = temp_durchschnitte_verteilungsbreite
    
  endfor

; ---------------------------------------------------------------------------------------------------------------------
;       PLOTS BACHELORARBEIT: Vergleich Verteilungsbreite DPOPS und SAGE im vertikalen Höhenprofil
; ---------------------------------------------------------------------------------------------------------------------
  ; 
  ; SAGE Daten
  restore, "verteilungsbreite_sage3iss_wlkombi_45.sav"
  restore, "julian_dates_sage3iss.sav"
  restore, "sage3iss_latitude.sav"
  restore, "sage3iss_longitude.sav"
  restore, "sage3iss_tropopause_height.sav"
  restore, "genauigkeitsparameter_sage3iss_wlkombi45.sav"
  
  ; Anzahl der SAGE-Messungen
  ending = n_elements(sage3iss_latitude)
  ; Definieren des Arrays: Anzahldichte mit Genauigkeitsparameter
  verteilungsbreite_mit_genauigkeitsparameter = verteilungsbreite_sage3iss_wlkombi_45
  
  ; Verteilungsbreite mit Genauigkeitsparameter --> alle ungenauen Werte werden NAN gesetzt
  ; ungenau, wenn g kleiner als 16. ist
  for i = 0, ending-1 do begin
    ungenau = where(genauigkeitsparameter_sage3iss_wlkombi45[i,*] lt 16.)
    verteilungsbreite_mit_genauigkeitsparameter[i, ungenau] = !Values.F_NAN
  endfor
  
  ; Array der Höhenmeter zum Plotten der SAGE Daten
  altitude = findgen(n_elements(sage3iss_latitude))*0.5+0.5
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
  xr = [0.5,4] ; XRANGE
  yr = [5,30] ; YRANGE
  yt = "Höhe [km]" ; TITLE Y ACHSE
  xt = "Verteilungsbreite" ; TITLE X ACHSE
  
; ------------------- USA Betrachtung: 02.08.2021  ---------------------------------------------------------------------
   
   ; Index file DPOPS
   idx_dpops_file = 6 
   ; Index SAGE-Messungen 
   idx_sage_beg = 76
   idx_sage_end = 78
   
   
   ; alle 0.000 Werte fürs Plotten heraussuchen
   verteilungsbreite_ne_zero = where(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, *] gt 0.2)

   ; DPOPS Messwerte plotten
  dpops_abweichung_20210802_1 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero] + $
    VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero],$
    hoehe_km[verteilungsbreite_ne_zero], COLOR="grey", NAME = "DPOPS Standardabweichung ", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20210802_2 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero] - $
    VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero],$
    hoehe_km[verteilungsbreite_ne_zero], /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung ", THICK=2)
  dpops_20210802 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero], hoehe_km[verteilungsbreite_ne_zero], $
    THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
  
  ; SAGE Einzelmessungen plotten
  for i = idx_sage_beg, idx_sage_end do begin
    sage_einzel = plot(verteilungsbreite_mit_genauigkeitsparameter[sage_usa_index_2021[i:i],*],altitude, NAME = "SAGE III on ISS Einzelmessung",$
      COLOR = "light blue", /OVERPLOT, THICK=2)
  endfor
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210802 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210802[i] = mean(verteilungsbreite_mit_genauigkeitsparameter[sage_usa_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
    
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210802, altitude, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2021[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20210802, dpops_abweichung_20210802_1, sage_einzel, sage_durchschnitt, tropo],$
    POSITION=[0.99,0.99])
    
; ------------------- USA Betrachtung: DPOPS: 26.07.2021, SAGE: 27.07.2021  ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 4
  ; Index SAGE-Messungen
  idx_sage_beg = 60
  idx_sage_end = 62
  
  ; alle 0.000 Werte fürs Plotten heraussuchen
  verteilungsbreite_ne_zero = where(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, *] gt 0.2)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20210726_1 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero] + $
    VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero],$
    hoehe_km[verteilungsbreite_ne_zero], COLOR="grey", NAME = "DPOPS Standardabweichung ", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20210726_2 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero] - $
    VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero],$
    hoehe_km[verteilungsbreite_ne_zero], /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung ", THICK=2)
  dpops_20210726 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero], hoehe_km[verteilungsbreite_ne_zero], $
    THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
    
  ; SAGE Einzelmessungen plotten
  for i = idx_sage_beg, idx_sage_end do begin
    sage_einzel = plot(verteilungsbreite_mit_genauigkeitsparameter[sage_usa_index_2021[i:i],*],altitude, NAME = "SAGE III on ISS Einzelmessung",$
      COLOR = "light blue", /OVERPLOT, THICK=2)
  endfor
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210727 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210727[i] = mean(verteilungsbreite_mit_genauigkeitsparameter[sage_usa_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor

  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210727, altitude, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2021[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20210726, dpops_abweichung_20210726_1, sage_einzel, sage_durchschnitt, tropo],$
    POSITION=[0.99,0.99])
    
; ------------------- USA Betrachtung: 31.05.2022 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 12
  ; Index SAGE-Messungen
  idx_sage_beg = 20
  idx_sage_end = 22
  
  ; alle 0.000 Werte fürs Plotten heraussuchen
  verteilungsbreite_ne_zero = where(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, *] gt 0.2)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20220531_1 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero] + $
    VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero],$
    hoehe_km[verteilungsbreite_ne_zero], COLOR="grey", NAME = "DPOPS Standardabweichung ", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20220531_2 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero] - $
    VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero],$
    hoehe_km[verteilungsbreite_ne_zero], /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung ", THICK=2)
  dpops_20220531 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero], hoehe_km[verteilungsbreite_ne_zero], $
    THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
    
  ; SAGE Einzelmessungen plotten
  for i = idx_sage_beg, idx_sage_end do begin
    sage_einzel = plot(verteilungsbreite_mit_genauigkeitsparameter[sage_usa_index_2022[i:i],*],altitude, NAME = "SAGE III on ISS Einzelmessung",$
      COLOR = "light blue", /OVERPLOT, THICK=2)
  endfor
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20220531 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20220531[i] = mean(verteilungsbreite_mit_genauigkeitsparameter[sage_usa_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20220531, altitude, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2022[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20220531, dpops_abweichung_20220531_1, sage_einzel, sage_durchschnitt, tropo],$
    POSITION=[0.99,0.99])

; ------------------- zonale Betrachtung: 06.08.2021 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 7
  ; Index SAGE-Messungen
  idx_sage_beg = 450
  idx_sage_end = 463

  
  ; alle 0.000 Werte fürs Plotten heraussuchen
  verteilungsbreite_ne_zero = where(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, *] gt 0.2)

  ; DPOPS Messwerte plotten
  dpops_abweichung_20210806_1 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero] + $
    VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero],$
    hoehe_km[verteilungsbreite_ne_zero], COLOR="grey", NAME = "DPOPS Standardabweichung ", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20210806_2 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero] - $
    VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero],$
    hoehe_km[verteilungsbreite_ne_zero], /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung ", THICK=2)
  dpops_20210806 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero], hoehe_km[verteilungsbreite_ne_zero], $
    THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
    
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210806 = make_array(90)
  mitg_abweichung_sage_20210806 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210806[i] = mean(verteilungsbreite_mit_genauigkeitsparameter[sage_zonal_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
    mitg_abweichung_sage_20210806[i] = stddev(verteilungsbreite_mit_genauigkeitsparameter[sage_zonal_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor

  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210806, altitude, /OVERPLOT, THICK = 2, COLOR = "blue",$
     NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20210806 - mitg_abweichung_sage_20210806, altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung ")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20210806 + mitg_abweichung_sage_20210806 , altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung ")
    
    
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_zonal_index_2021[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20210806, dpops_abweichung_20210806_1, sage_durchschnitt,sage_abweichung_1, tropo],$
    POSITION=[0.99,0.99])
    
; ------------------- zonale Betrachtung: 05.06.2022 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 14
  ; Index SAGE-Messungen
  idx_sage_beg = 181
  idx_sage_end = 196
  

  ; alle 0.000 Werte fürs Plotten heraussuchen
  verteilungsbreite_ne_zero = where(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, *] gt 0.2)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20220605_1 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero] + $
    VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero],$
    hoehe_km[verteilungsbreite_ne_zero], COLOR="grey", NAME = "DPOPS Standardabweichung ", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20220605_2 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero] - $
    VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero],$
    hoehe_km[verteilungsbreite_ne_zero], /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung ", THICK=2)
  dpops_20220605 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero], hoehe_km[verteilungsbreite_ne_zero], $
    THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
    
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20220605 = make_array(90)
  mitg_abweichung_sage_20220605 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20220605[i] = mean(verteilungsbreite_mit_genauigkeitsparameter[sage_zonal_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
    mitg_abweichung_sage_20220605[i] = stddev(verteilungsbreite_mit_genauigkeitsparameter[sage_zonal_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20220605, altitude, /OVERPLOT, THICK = 2, COLOR = "blue",$
    NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20220605 - mitg_abweichung_sage_20220605, altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung ")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20220605 + mitg_abweichung_sage_20220605 , altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung ")
    
    
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_zonal_index_2022[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20220605, dpops_abweichung_20220605_1, sage_durchschnitt,sage_abweichung_1, tropo],$
    POSITION=[0.99,0.99])  
    
; ------------------- zonale Betrachtung: 08.06.2022 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 15
  ; Index SAGE-Messungen
  idx_sage_beg = 227
  idx_sage_end = 241

  ; alle 0.000 Werte fürs Plotten heraussuchen
  verteilungsbreite_ne_zero = where(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, *] gt 0.2)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20220608_1 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero] + $
    VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero],$
    hoehe_km[verteilungsbreite_ne_zero], COLOR="grey", NAME = "DPOPS Standardabweichung ", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20220608_2 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero] - $
    VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero],$
    hoehe_km[verteilungsbreite_ne_zero], /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung ", THICK=2)
  dpops_20220608 = plot(VERTEILUNGSBREITE_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, verteilungsbreite_ne_zero], hoehe_km[verteilungsbreite_ne_zero], $
    THICK=2, NAME = "DPOPS Durchschnitt", /OVERPLOT)
    
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20220608 = make_array(90)
  mitg_abweichung_sage_20220608 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20220608[i] = mean(verteilungsbreite_mit_genauigkeitsparameter[sage_zonal_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
    mitg_abweichung_sage_20220608[i] = stddev(verteilungsbreite_mit_genauigkeitsparameter[sage_zonal_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20220608, altitude, /OVERPLOT, THICK = 2, COLOR = "blue",$
    NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20220608 - mitg_abweichung_sage_20220608, altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung ")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20220608 + mitg_abweichung_sage_20220608 , altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung ")
    
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_zonal_index_2022[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20220608, dpops_abweichung_20220608_1, sage_durchschnitt,sage_abweichung_1, tropo],$
    POSITION=[0.99,0.99])

end