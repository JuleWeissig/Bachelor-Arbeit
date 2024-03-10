pro medianradius_durchschnitt_plot_mitg
;
;   NAME: medianradius_durchschnitt_plot_mitg.pro
;
;   ZWECK: - Berechnung der Durchschnitte der Medianradien (zuvor mittels gaussfit ermittelt)
;          - Vergleich von SAGE und DPOPS Medianradien im vertikalen Höhenprofil
;          - Plotten der wichtigsten Daten unter Berücksichtigung des Genauigkeitsparameter von SAGE 
;
;   ZULETZT BEARBEITET: 02.02.2024 von Juliane Christin Weißig
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
    "DCOTSS-MERGE-10S_MERGE_20220608_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220621_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220624_R2.sav",$
    "DCOTSS-MERGE-10S_MERGE_20220629_R2.sav"]


  array_medianradius = ["arr_anzahldichte_medianradius_verteilungsbreite_20210617.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20210716.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20210720.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20210723.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20210726.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20210729.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20210802.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20210806.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20210810.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20210814.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20220513.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20220529.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20220531.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20220602.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20220608.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20220621.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20220624.sav",$
    "arr_anzahldichte_medianradius_verteilungsbreite_20220629.sav"]
    
 
  ; Anzahl der Datein für 2021 und 2022 zusammen
  number_filename = n_elements(array_medianradius)
  ;Größe des Höhenmeter Arary --> maximale Höhe von 21 km für Flugzeig angenommen
  hight = 210
  ; Pfad der Datei
  path = "I:\DPOPS_NC_2022\"
  
  ; Erstellen der Arrays für die späteren Durchschnitte der Anzahldichte
  MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM = make_array(number_filename, hight)
  ; Erstellen der Arrays für die Abweichunge der Durchschnitte der Anzahldichte
  MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM = make_array(number_filename, hight)
  
  ; Berechnung der Durchschnitte + Abspeichern im Array für alle 19 Datein
  for i = 0, number_filename -1 do begin
  
    ; Wiederherstellen der Datei
    restore, path + array_medianradius[i]
    restore, path + filename[i]

    ; Definieren
    ; Höhenabschnitte für alle 100 Höhenmeter
    abschnitte_hoehe = findgen(hight)*100.
    ; Höhe und Anzahldichte als Array(2, Einzelmessungen) zusammenführen
    hoehe_medianradius = [[ALT_ER2],[ANZAHLDICHTE_MEDIANRADIUS_VERTEILUNGSBREITE[*,1]]]
    ; Alle NAN Werte aus den Anzahldichten herraussuchen
    nan = where(finite(hoehe_medianradius[*,1], /NAN))
    ; NAN Werte 0. setzen
    hoehe_medianradius[nan,1] = 0.
    
    ; temporäres Array für Anzahldichten-Durchschnitte
    temp_durchschnitte_medianradius = make_array(hight)
    ; temporäres Array für Abweichungen der Anzahldichten-Durchschnitte
    temp_abweichung_medianradius= make_Array(hight)
    ; Größe des Messung --> Anzahl der Einzelmessungen
    ending = n_elements(ALT_ER2)
    
    ; alle 100m Durchschnitte des Medianradius
    for k = 0, hight-2 do begin
      y = make_array(ending)
      for j = 0, ending-1 do begin
        if (hoehe_medianradius[j,0] gt abschnitte_hoehe[k]) and (hoehe_medianradius[j,0] lt abschnitte_hoehe[k+1]) then begin
          y[j] = hoehe_medianradius[j,1]
        endif
      endfor
      temp_durchschnitte_medianradius[k] = mean(y(where(y ne 0.)))
      temp_abweichung_medianradius[k] = stddev(y)
    endfor
    
    MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[i,*] = temp_abweichung_medianradius
    MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[i,*] = temp_durchschnitte_medianradius
    
  endfor
  ; ---------------------------------------------------------------------------------------------------------------------
  ;       PLOTS BACHELORARBEIT: Vergleich Medianradius DPOPS und SAGE im vertikalen Höhenprofil
  ; ---------------------------------------------------------------------------------------------------------------------
  
  ; SAGE Daten
  restore, "medianradius_sage3iss_wlkombi_45.sav"
  restore, "julian_dates_sage3iss.sav"
  restore, "sage3iss_latitude.sav"
  restore, "sage3iss_longitude.sav"
  restore, "sage3iss_tropopause_height.sav"
  restore, "genauigkeitsparameter_sage3iss_wlkombi45.sav"
  
  ; Anzahl der SAGE-Messungen
  ending = n_elements(sage3iss_latitude)
  ; Definieren des Arrays: Anzahldichte mit Genauigkeitsparameter
  medianradius_mit_genauigkeitsparameter = medianradius_sage3iss_wlkombi_45
  
  ; medianradius mit Genauigkeitsparameter --> alle ungenauen Werte werden NAN gesetzt
  ; ungenau, wenn g kleiner als 16. ist
  for i = 0, ending-1 do begin
    ungenau = where(genauigkeitsparameter_sage3iss_wlkombi45[i,*] lt 16.)
    medianradius_mit_genauigkeitsparameter[i, ungenau] = !Values.F_NAN
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
  xr = [0,250] ; XRANGE
  yr = [5,30] ; YRANGE
  yt = "Höhe [km]" ; TITLE Y ACHSE
  xt = "$Medianradius [nm]$" ; TITLE X ACHSE
  
; ------------------- USA Betrachtung: 02.08.2021 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 6
  ; Index SAGE-Messungen
  idx_sage_beg = 76
  idx_sage_end = 78
  
  ; alle 0.000 Werte fürs Plotten heraussuchen
  medianradius_ne_zero = where(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file,*] gt 0.02)

  ; DPOPS Messwerte plotten
  dpops_abweichung_20210802_1 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero] +$
     MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, medianradius_ne_zero],$
   hoehe_km(medianradius_ne_zero), COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
   YTITLE = yt, THICK=2)
  dpops_abweichung_20210802_2 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero] -$
     MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, medianradius_ne_zero],$
    hoehe_km(medianradius_ne_zero), /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20210802 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero], hoehe_km(medianradius_ne_zero), THICK=2,$
     NAME = "DPOPS Durchschnitt", /OVERPLOT)
  
  ; SAGE Einzelmessungen plotten
  for i = idx_sage_beg, idx_sage_end do begin
    sage_einzel = plot(medianradius_mit_genauigkeitsparameter[sage_usa_index_2021[i],*],altitude, NAME = "SAGE III on ISS Einzelmessung",$
      COLOR = "light blue", /OVERPLOT, THICK=2)
  endfor
 
  ; Mittelwert der "genauen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210802 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210802[i] = mean(medianradius_mit_genauigkeitsparameter[sage_usa_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  

  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210802, altitude, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2021[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20210802, dpops_abweichung_20210802_1, sage_einzel, sage_durchschnitt, tropo],$
    POSITION=[0.99,0.99])

  ; ------------------- USA Betrachtung: 02.08.2021 SAGE: 01.08. - 03.08.2021---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 6
  ; Index SAGE-Messungen
  idx_sage_beg = 73
  idx_sage_end = 81
  
  ; alle 0.000 Werte fürs Plotten heraussuchen
  medianradius_ne_zero = where(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file,*] gt 0.) 
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20210802_1 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero] +$
     MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, medianradius_ne_zero],$
    hoehe_km(medianradius_ne_zero), COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20210802_2 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero] -$
     MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, medianradius_ne_zero],$
    hoehe_km(medianradius_ne_zero), /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20210802 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero], hoehe_km(medianradius_ne_zero), THICK=2,$
     NAME = "DPOPS Durchschnitt", /OVERPLOT)

  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210802_3tage = make_array(90)
  mitg_stddev_sage_20210802_3tage = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210802_3tage[i] = mean(medianradius_mit_genauigkeitsparameter[sage_usa_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
    mitg_stddev_sage_20210802_3tage[i] = stddev(medianradius_mit_genauigkeitsparameter[sage_usa_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210802_3tage, altitude, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20210802_3tage + mitg_stddev_sage_20210802_3tage, altitude, /OVERPLOT, THICK = 2,$
     COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20210802_3tage - mitg_stddev_sage_20210802_3tage, altitude, /OVERPLOT, THICK = 2,$
     COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
  
    
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2021[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20210802, dpops_abweichung_20210802_1, sage_abweichung_2, sage_durchschnitt, tropo],$
    POSITION=[0.99,0.99])

  ; ------------------- USA Betrachtung: 06.08.2021 ---------------------------------------------------------------------
  
  ; Index file DPOPS
  idx_dpops_file = 7
  ; Index SAGE-Messungen
  idx_sage_beg = 89
  idx_sage_end = 90
  
  ; alle 0.000 Werte fürs Plotten heraussuchen
  medianradius_ne_zero = where(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file,*] gt 0.02)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20210806_1 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero] +$
     MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, medianradius_ne_zero],$
    hoehe_km(medianradius_ne_zero), COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20210806_2 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero] -$
     MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, medianradius_ne_zero],$
    hoehe_km(medianradius_ne_zero), /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20210806 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero], hoehe_km(medianradius_ne_zero), THICK=2,$
     NAME = "DPOPS Durchschnitt", /OVERPLOT)
  
  ; SAGE Einzelmessungen plotten
  for i = idx_sage_beg,idx_sage_end do begin
    sage_einzel = plot(medianradius_mit_genauigkeitsparameter[sage_usa_index_2021[i:i],*],altitude, NAME = "SAGE III on ISS Einzelmessung",$
      COLOR = "light blue", /OVERPLOT, THICK=2)
  endfor
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210806 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210806[i] = mean(medianradius_mit_genauigkeitsparameter[sage_usa_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210806, altitude, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2021[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20210806, dpops_abweichung_20210806_1, sage_einzel, sage_durchschnitt, tropo],$
    POSITION=[0.99,0.99])
    
  ; ------------------- USA Betrachtung: 02.06.2022 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 5
  ; Index SAGE-Messungen
  idx_sage_beg = 26
  idx_sage_end = 28
  

  ; alle 0.000 Werte fürs Plotten heraussuchen
  medianradius_ne_zero = where(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file,*] gt 0.02)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20220602_1 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero] +$
     MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, medianradius_ne_zero],$
    hoehe_km(medianradius_ne_zero), COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20220602_2 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero] -$
     MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, medianradius_ne_zero],$
    hoehe_km(medianradius_ne_zero), /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20220602 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero], hoehe_km(medianradius_ne_zero), THICK=2,$
     NAME = "DPOPS Durchschnitt", /OVERPLOT)
  
  ; SAGE Einzelmessungen plotten
  for i = idx_sage_beg,idx_sage_end do begin
    sage_einzel = plot(medianradius_mit_genauigkeitsparameter[sage_usa_index_2022[i:i],*],altitude, NAME = "SAGE III on ISS Einzelmessung",$
      COLOR = "light blue", /OVERPLOT, THICK=2)
  endfor
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20220602 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20220602[i] = mean(medianradius_mit_genauigkeitsparameter[sage_usa_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20220602, altitude, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2022[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20220602, dpops_abweichung_20220602_1, sage_einzel, sage_durchschnitt, tropo],$
    POSITION=[0.99,0.99])

  ; ------------------- zonale Betrachtung: 02.08.2021 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 6
  ; Index SAGE-Messungen
  idx_sage_beg = 388
  idx_sage_end = 402
  

  ; alle 0.000 Werte fürs Plotten heraussuchen
  medianradius_ne_zero = where(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file,*] gt 0.02)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20210802_1 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero] +$
     MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, medianradius_ne_zero],$
    hoehe_km(medianradius_ne_zero), COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20210802_2 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero] -$
     MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, medianradius_ne_zero],$
    hoehe_km(medianradius_ne_zero), /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20210802 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero], hoehe_km(medianradius_ne_zero), THICK=2,$
     NAME = "DPOPS Durchschnitt", /OVERPLOT)
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210802 = make_array(90)
  mitg_abweichung_sage_20210802 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210802[i] = mean(medianradius_mit_genauigkeitsparameter[sage_zonal_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
    mitg_abweichung_sage_20210802[i] = stddev(medianradius_mit_genauigkeitsparameter[sage_zonal_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210802, altitude, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20210802 - mitg_abweichung_sage_20210802, altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20210802 + mitg_abweichung_sage_20210802 , altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
    
    
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_zonal_index_2021[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20210802, dpops_abweichung_20210802_1, sage_durchschnitt,sage_abweichung_1, tropo],$
    POSITION=[0.99,0.99])

  ; ------------------- zonale Betrachtung: 21.06.2022 ---------------------------------------------------------------------
  ; Index file DPOPS
  idx_dpops_file = 15
  ; Index SAGE-Messungen
  idx_sage_beg = 291
  idx_sage_end = 298

  
  ; alle 0.000 Werte fürs Plotten heraussuchen
  medianradius_ne_zero = where(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file,*] gt 0.02)
  
  ; DPOPS Messwerte plotten
  dpops_abweichung_20220621_1 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero] + $
    MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, medianradius_ne_zero],$
    hoehe_km(medianradius_ne_zero), COLOR="grey", NAME = "DPOPS Standardabweichung", POSITION = position, XRANGE = xr, YRANGE = yr, XTITLE = xt, $
    YTITLE = yt, THICK=2)
  dpops_abweichung_20220621_2 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero] - $
    MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_ABWEICHUNG_BIS_21KM[idx_dpops_file, medianradius_ne_zero],$
    hoehe_km(medianradius_ne_zero), /OVERPLOT, COLOR="grey", NAME = "DPOPS Standardabweichung", THICK=2)
  dpops_20220621 = plot(MEDIANRADIUS_DPOPS_HOEHENDURCHSCHNITTE_BIS_21KM[idx_dpops_file, medianradius_ne_zero], hoehe_km(medianradius_ne_zero), THICK=2,$
     NAME = "DPOPS Durchschnitt", /OVERPLOT)
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20220621 = make_array(90)
  mitg_abweichung_sage_20220621 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20220621[i] = mean(medianradius_mit_genauigkeitsparameter[sage_zonal_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
    mitg_abweichung_sage_20220621[i] = stddev(medianradius_mit_genauigkeitsparameter[sage_zonal_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20220621, altitude, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20220621 - mitg_abweichung_sage_20220621, altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20220621 + mitg_abweichung_sage_20220621 , altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
    
    
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_zonal_index_2022[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  ; Legende
  legende = legend(TARGET=[dpops_20220621, dpops_abweichung_20220621_1, sage_durchschnitt,sage_abweichung_1, tropo],$
    POSITION=[0.99,0.99])
end