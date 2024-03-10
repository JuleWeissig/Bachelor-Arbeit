pro ba_plot_bimodal
;
;   NAME: ba_plot_bimodal.pro
;
;   ZWECK: - Plotten der Größenverteilungsparameter aus bi- und monomodaler Berechnung
;
;   ZULETZT BEARBEITET: 06.02.2024 von Juliane Christin Weißig
;
  ; Daten 
  restore, 'bifunc_parameter_20210802.sav'
  restore, "arr_anzahldichte_medianradius_verteilungsbreite_20210802.sav"
  restore, "DCOTSS-MERGE-10S_MERGE_20210802_R2.sav"
 
;  restore, 'bifunc_parameter_20220531.sav'
;  restore, "arr_anzahldichte_medianradius_verteilungsbreite_20220531.sav"
;  restore, "DCOTSS-MERGE-10S_MERGE_20220531_R2.sav"
;  
  ; Höhendurchschnitt berechnen aus Gaussfitparametern berechnen
  
  hight = 210
  ; Array für Höhendurchschnitte
  temp_durchschnitte_anzahldichte = make_array(hight)
  temp_durchschnitte_medianradius = make_array(hight)
  temp_durchschnitte_verteilungsbreite = make_array(hight)
  temp_abw_durchschnitte_anzahldichte = make_array(hight)
  temp_abw_durchschnitte_medianradius = make_array(hight)
  temp_abw_durchschnitte_verteilungsbreite = make_array(hight)
  abschnitte_hoehe = findgen(hight)*100.
  
  ; Anzahl der DPOPS-Einzelmessungen
  ending = n_elements(ALT_ER2)
  
  ; Schleife über Höhenmeter
  for k = 0, hight-2 do begin
    x = make_array(ending)
    y = make_array(ending)
    z = make_array(ending)
    ; Schleife über alle Einzelmessungen
    for j = 0, ending-1 do begin
      if (ALT_ER2[j] gt abschnitte_hoehe[k]) and (ALT_ER2[j] lt abschnitte_hoehe[k+1]) then begin
        x[j] = anzahldichte_medianradius_verteilungsbreite[j,0]
        y[j] = anzahldichte_medianradius_verteilungsbreite[j,1]
        z[j] = anzahldichte_medianradius_verteilungsbreite[j,2]
      endif
    endfor
    temp_durchschnitte_anzahldichte[k] = mean(x(where(x ne 0.)))
    temp_durchschnitte_medianradius[k] = mean(y(where(y ne 0.)))
    temp_durchschnitte_verteilungsbreite[k] = mean(z(where(z ne 0.)))
    temp_abw_durchschnitte_anzahldichte[k] = stddev(x)
    temp_abw_durchschnitte_medianradius[k] = stddev(y)
    temp_abw_durchschnitte_verteilungsbreite[k] = stddev(z)
  endfor
  
  
  abschnitte_hoehe = findgen(hight)*100.
  
  ; Abbildungen 
  abschnitte_hoehe = findgen(210)*100.
  ; alle 0.000 Werte fürs Plotten heraussuchen
  anzahldichte_ne_zero1 = where(parameter[*,0] gt 0.0)
  anzahldichte_ne_zero2 = where(parameter[*,1] gt 0.0)
  medianradius_ne_zero1 = where(parameter[*,2] gt 0.0)
  medianradius_ne_zero2 = where(parameter[*,3] gt 0.0)
  sigma_ne_zero1 = where(parameter[*,4] gt 0.0)
  sigma_ne_zero2 = where(parameter[*,5] gt 0.0)

  ; SAGE Daten
  restore, "medianradius_sage3iss_wlkombi_45.sav"
  restore, "verteilungsbreite_sage3iss_wlkombi_45.sav"
  restore, "anzahldichte_sage3iss_wlkombi45_755nm.sav"
  restore, "julian_dates_sage3iss.sav"
  restore, "sage3iss_latitude.sav"
  restore, "sage3iss_longitude.sav"
  restore, "sage3iss_tropopause_height.sav"
  restore, "genauigkeitsparameter_sage3iss_wlkombi45.sav"
  
  ; Anzahl der SAGE-Messungen
  ending = n_elements(sage3iss_latitude)
  ; Definieren des Arrays: Anzahldichte mit Genauigkeitsparameter

; Anzahldichte   
  anzahldichte_mit_genauigkeitsparameter = anzahldichte_sage3iss_wlkombi45_755nm
  
  ; anzahldichte mit Genauigkeitsparameter --> alle ungenauen Werte werden NAN gesetzt
  ; ungenau, wenn g kleiner als 16. ist
  for i = 0, ending-1 do begin
    ungenau = where(genauigkeitsparameter_sage3iss_wlkombi45[i,*] lt 16.)
    anzahldichte_mit_genauigkeitsparameter[i, ungenau] = !Values.F_NAN
  endfor
  
  
  medianradius_mit_genauigkeitsparameter = medianradius_sage3iss_wlkombi_45
  
  ; medianradius mit Genauigkeitsparameter --> alle ungenauen Werte werden NAN gesetzt
  ; ungenau, wenn g kleiner als 16. ist
  for i = 0, ending-1 do begin
    ungenau = where(genauigkeitsparameter_sage3iss_wlkombi45[i,*] lt 16.)
    medianradius_mit_genauigkeitsparameter[i, ungenau] = !Values.F_NAN
  endfor
  
  verteilunsgbreite_mit_genauigkeitsparameter = verteilungsbreite_sage3iss_wlkombi_45
  
  ; verteilunsgbreite mit Genauigkeitsparameter --> alle ungenauen Werte werden NAN gesetzt
  ; ungenau, wenn g kleiner als 16. ist
  for i = 0, ending-1 do begin
    ungenau = where(genauigkeitsparameter_sage3iss_wlkombi45[i,*] lt 16.)
    verteilunsgbreite_mit_genauigkeitsparameter[i, ungenau] = !Values.F_NAN
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


; ----- Anzahldichte ---------
  position = [0.1, 0.125, 0.95, 0.95] 
  ; Index SAGE-Messungen
;  idx_sage_beg = 20
;  idx_sage_end = 22
  
  idx_sage_beg = 76
  idx_sage_end = 78

   anzahldichte_mono_abw_1 = plot((temp_durchschnitte_anzahldichte[where(temp_durchschnitte_anzahldichte gt 0.)]- $
    temp_abw_durchschnitte_anzahldichte[where(temp_durchschnitte_anzahldichte gt 0.)]),$
    abschnitte_hoehe[where(temp_durchschnitte_anzahldichte gt 0.)]/1000., $
    NAME = "DPOPS monomodaler Fit Standardabweichung", COLOR = "wheat", THICK = 2$
    , XRANGE = [0,250], YRANGE = [5,30], POSITION = position)
    
  anzahldichte_mono_abw_2 = plot((temp_durchschnitte_anzahldichte[where(temp_durchschnitte_anzahldichte gt 0.)] + $
    temp_abw_durchschnitte_anzahldichte[where(temp_durchschnitte_anzahldichte gt 0.)]),$
    abschnitte_hoehe[where(temp_durchschnitte_anzahldichte gt 0.)]/1000., $
    NAME = "DPOPS monomodaler Fit Standardabweichung", COLOR = "wheat", THICK = 2, /OVERPLOT)
    
  anzahldichte_mono = plot(temp_durchschnitte_anzahldichte[where(temp_durchschnitte_anzahldichte gt 0.)], $
    abschnitte_hoehe[where(temp_durchschnitte_anzahldichte gt 0.)]/1000.,  $
    NAME = "DPOPS monomodaler Fit", COLOR = "peru", THICK = 2,/OVERPLOT)
    
  anzahldichte_bi1 = plot((parameter[where(parameter[*,0] gt 4.),0] + parameter[where(parameter[*,0] gt 4.),1]), abschnitte_hoehe[where(parameter[*,0] gt 4.)]/1000.,$
    XTITLE = "Anzahldichte [$1/cm^3$]", YTITLE = "Höhe [km]", NAME = "DPOPS bimodaler Fit: 1. + 2. Mode" , THICK = 2,/OVERPLOT)
    
    
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210802 = make_array(90)
  mitg_abweichung_sage_20210802 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210802[i] = mean(anzahldichte_mit_genauigkeitsparameter[sage_usa_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
    mitg_abweichung_sage_20210802[i] = stddev(anzahldichte_mit_genauigkeitsparameter[sage_usa_index_2021[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210802, altitude, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20210802 - mitg_abweichung_sage_20210802, altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20210802 + mitg_abweichung_sage_20210802 , altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
    
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2021[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  legende = legend(TARGET=[anzahldichte_mono,anzahldichte_mono_abw_1,anzahldichte_bi1, sage_durchschnitt, sage_abweichung_1, tropo],$
    POSITION=[0.99,0.99])
  
 ; Medianradius --------------------------------------------------------------------------------------------------------
  medianradius_mono_abw_1 = plot((temp_durchschnitte_medianradius[where(temp_durchschnitte_medianradius gt 0.)]- $
    temp_abw_durchschnitte_medianradius[where(temp_durchschnitte_medianradius gt 0.)]),$
     abschnitte_hoehe[where(temp_durchschnitte_medianradius gt 0.)]/1000., $
    NAME = "DPOPS monomodaler Fit Standardabweichung", COLOR = "wheat", THICK = 2$
    , XRANGE = [0,200], YRANGE = [5,32], POSITION = position)

  medianradius_mono_abw_2 = plot((temp_durchschnitte_medianradius[where(temp_durchschnitte_medianradius gt 0.)] + $
    temp_abw_durchschnitte_medianradius[where(temp_durchschnitte_medianradius gt 0.)]),$
     abschnitte_hoehe[where(temp_durchschnitte_medianradius gt 0.)]/1000., $
    NAME = "DPOPS monomodaler Fit Standardabweichung", COLOR = "wheat", THICK = 2, /OVERPLOT)
  
  medianradius_mono = plot(temp_durchschnitte_medianradius[where(temp_durchschnitte_medianradius gt 0.)], $
    abschnitte_hoehe[where(temp_durchschnitte_medianradius gt 0.)]/1000.,  $
    NAME = "DPOPS monomodaler Fit", COLOR = "peru", THICK = 2,/OVERPLOT)
  
  medinaradius_bi1 = plot(parameter[where(parameter[*,2] gt 0.),2], abschnitte_hoehe[where(parameter[*,2] gt 0.)]/1000.,$
     XTITLE = "Medianradius [nm]", YTITLE = "Höhe [km]", NAME = "DPOPS bimodaler Fit: 1. Mode" , THICK = 2,/OVERPLOT)
  
  
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210802 = make_array(90)
  mitg_abweichung_sage_20210802 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210802[i] = mean(medianradius_mit_genauigkeitsparameter[sage_usa_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
    mitg_abweichung_sage_20210802[i] = stddev(medianradius_mit_genauigkeitsparameter[sage_usa_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210802, altitude, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20210802 - mitg_abweichung_sage_20210802, altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20210802 + mitg_abweichung_sage_20210802 , altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
    
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2022[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten

  legende = legend(TARGET=[medianradius_mono,medianradius_mono_abw_1,medinaradius_bi1, sage_durchschnitt, sage_abweichung_1, tropo],$
    POSITION=[0.99,0.99])  

; Verteilungsbreite --------------------------------------------------------------------------------------------------------
  verteilungsbreite_mono_abw_1 = plot((temp_durchschnitte_verteilungsbreite[where(temp_durchschnitte_verteilungsbreite gt 0.)]- $
    temp_abw_durchschnitte_verteilungsbreite[where(temp_durchschnitte_verteilungsbreite gt 0.)]),$
    abschnitte_hoehe[where(temp_durchschnitte_verteilungsbreite gt 0.)]/1000., $
    NAME = "DPOPS monomodaler Fit Standardabweichung", COLOR = "wheat", THICK = 2$
    , XRANGE = [0.5,3], YRANGE = [5,32], POSITION = position)
    
  verteilungsbreite_mono_abw_2 = plot((temp_durchschnitte_verteilungsbreite[where(temp_durchschnitte_verteilungsbreite gt 0.)] + $
    temp_abw_durchschnitte_verteilungsbreite[where(temp_durchschnitte_verteilungsbreite gt 0.)]),$
    abschnitte_hoehe[where(temp_durchschnitte_verteilungsbreite gt 0.)]/1000., $
    NAME = "DPOPS monomodaler Fit Standardabweichung", COLOR = "wheat", THICK = 2, /OVERPLOT)
    
  verteilungsbreite_mono = plot(temp_durchschnitte_verteilungsbreite[where(temp_durchschnitte_verteilungsbreite gt 0.)], $
    abschnitte_hoehe[where(temp_durchschnitte_verteilungsbreite gt 0.)]/1000.,  $
    NAME = "DPOPS monomodaler Fit", COLOR = "peru", THICK = 2,/OVERPLOT)
 
  verteilungsbreite_bi1 = plot(parameter[where(parameter[*,4] gt 0.),4], abschnitte_hoehe[where(parameter[*,4] gt 0.)]/1000.,$
    XTITLE = "Verteilungsbreite", YTITLE = "Höhe [km]", NAME = "DPOPS bimodaler Fit: 1. Mode" , THICK = 2,/OVERPLOT)

    
  ; Mittelwert der "genaugen" SAGE Einzelmessungsweret über USA berechnen
  mitg_durchschnitt_sage_20210802 = make_array(90)
  mitg_abweichung_sage_20210802 = make_array(90)
  for i = 0, 89 do begin
    mitg_durchschnitt_sage_20210802[i] = mean(verteilunsgbreite_mit_genauigkeitsparameter[sage_usa_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
    mitg_abweichung_sage_20210802[i] = stddev(verteilunsgbreite_mit_genauigkeitsparameter[sage_usa_index_2022[idx_sage_beg:idx_sage_end],i], /NAN)
  endfor
  
  ; Plotten des SAGE Durchschnittes
  sage_durchschnitt = plot(mitg_durchschnitt_sage_20210802, altitude, /OVERPLOT, THICK = 2, COLOR = "blue", NAME = "SAGE III on ISS Durchschnitt")
  sage_abweichung_1 = plot(mitg_durchschnitt_sage_20210802 - mitg_abweichung_sage_20210802, altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
  sage_abweichung_2 = plot(mitg_durchschnitt_sage_20210802 + mitg_abweichung_sage_20210802 , altitude, /OVERPLOT, THICK = 2,$
    COLOR = "light blue", NAME = "SAGE III on ISS Standardabweichung")
    
  ; Durchshcnitt der Tropopausenhöhe der Einzelmessungen berechnen
  tropo_mean = mean(sage3iss_tropopause_height[sage_usa_index_2022[idx_sage_beg:idx_sage_end]])
  tropo = plot(fltarr(500) + tropo_mean, COLOR="red", THICK=2, /OVERPLOT, NAME = "Tropopausenhöhe") ; Tropopause plotten
  
  legende = legend(TARGET=[verteilungsbreite_mono,verteilungsbreite_mono_abw_1,verteilungsbreite_bi1,$
     sage_durchschnitt, sage_abweichung_1, tropo],$
    POSITION=[0.99,0.99])
  
end