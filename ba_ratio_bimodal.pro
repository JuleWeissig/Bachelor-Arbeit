pro ba_ratio_bimodal
;
;   NAME: ba_ratio_bimodal.pro
;
;   ZWECK: - Plotten der Verhältnisse der 1. und 2. Mode aus dem bimodalen Fits 
;          - für den 02.08.2021 und den 31.05.2022
;
;   ZULETZT BEARBEITET: 17.02.2024, Juliane Christin Weißig
;---------------------------------------------------------------------------------------------------------------------------------------------
  ; Höhe der DPOPS Messungen 
  hight = 210
  
  ; Höhenabschnitte zum Plotten 
  abschnitte_hoehe = findgen(hight)*100.
  
  ; Tropopausenhöhe 2022
  tropo2022 = 7.5 ; Werte wurden aus den SAGE Einzelmessungen über den USA an den selben Tagen übernommen
  ; Einzelmessungen wurden gemittelt 
  
  ; Tropopausenhöhe 2021
  tropo2021 =  14.

  ; Plotten einer Geradeen als Tropopausenhöhe
  tropo21 = plot(fltarr(5) + tropo2021, COLOR="black", THICK=3, LINESTYLE = 1,$
     NAME = "Tropopausenhöhe vom 02.08.2021") ; Tropopause plotten
    
  tropo22 = plot(fltarr(5) + tropo2022, COLOR="red", THICK=3, LINESTYLE = 1,$
    /OVERPLOT, NAME = "Tropopausenhöhe vom 31.05.2022") ; Tropopause plotten

  restore, 'bifunc_parameter_20210802.sav'
  
 ; Verhältnis Plotten der Verteilungsbreite 2021 
 ratio_verteilungsbreite1 = plot(parameter[*,4]/parameter[*,5],abschnitte_hoehe/1000., $
    XTITLE = "Verteilungsbreite Verhältnis 1. zu 2. Mode", NAME = "Verhältnis vom 02.08.2021",position = [0.1, 0.125, 0.95, 0.95],$
    YTITLE = "Höhe [km]",THICK = 2,YRANGE = [5,25], /OVERPLOT)

  restore, 'bifunc_parameter_20220531.sav'
  ; Verhältnis Plotten der Verteilungsbreite 2022
  ratio_verteilungsbreite2 = plot(parameter[*,4]/parameter[*,5],abschnitte_hoehe/1000., $
    XTITLE = "Verteilungsbreite Verhältnis 1. zu 2. Mode",NAME = "Verhältnis vom 31.05.2022",$
    YTITLE = "Höhe [km]",THICK = 2, /OVERPLOT, COLOR = "red")
   
  ; Legende 
  legende = legend(TARGET=[ratio_verteilungsbreite1,ratio_verteilungsbreite2,tropo21,tropo22],$
    POSITION=[0.99,0.99])

  tropo21 = plot(fltarr(3) + tropo2021, COLOR="black", THICK=3, LINESTYLE = 1,$
   NAME = "Tropopausenhöhe vom 02.08.2021", XRANGE = [0,0.5]) ; Tropopause plotten
  
  tropo22 = plot(fltarr(3) + tropo2022, COLOR="red", THICK=3, LINESTYLE = 1,$
  /OVERPLOT, NAME = "Tropopausenhöhe vom 31.05.2022") ; Tropopause plotten

    restore, 'bifunc_parameter_20210802.sav'
    ; Verhältnis Medianradien 2021 plotten
    ratio_median1 = plot(parameter[*,2]/parameter[*,3],abschnitte_hoehe/1000., $
      XTITLE = "Medianradius Verhältnis 1. zu 2. Mode", NAME = "Verhältnis vom 02.08.2021", position = [0.1, 0.125, 0.95, 0.95],$
      YTITLE = "Höhe [km]",THICK = 2,YRANGE = [5,25], /OVERPLOT)
      
    restore, 'bifunc_parameter_20220531.sav'
    ; Verhältnis Medianradien 2022 plotten
    ratio_median2 = plot(parameter[*,2]/parameter[*,3],abschnitte_hoehe/1000., $
      XTITLE = "Medianradius Verhältnis 1. zu 2. Mode", NAME = "Verhältnis vom 31.05.2022",$
      YTITLE = "Höhe [km]",THICK = 2, /OVERPLOT, COLOR = "red")
      
    ; Legende
    legende = legend(TARGET=[ratio_median1, ratio_median2,tropo21,tropo22],$
      POSITION=[0.99,0.99])
 
    tropo21 = plot(fltarr(100000) + tropo2021, COLOR="black", THICK=2, LINESTYLE = 1,$
       NAME = "Tropopausenhöhe vom 02.08.2021") ; Tropopause plotten
      
    tropo22 = plot(fltarr(100000) + tropo2022, COLOR="red", THICK=2, LINESTYLE = 1,$
      /OVERPLOT, NAME = "Tropopausenhöhe vom 31.05.2022") ; Tropopause plotten
 
    restore, 'bifunc_parameter_20210802.sav'
    ; Verhältnis Anzahldichte  2021 plotten
    ratio_anzahldichte1 = plot(parameter[*,0]/parameter[*,1],abschnitte_hoehe/1000.,position = [0.1, 0.125, 0.95, 0.95],$
       XRANGE = [10,100000], XTITLE = "Anzahldichte Verhältnis 1. zu 2. Mode",NAME = "Verhältnis vom 02.08.2021",YRANGE = [5,25],$
      YTITLE = "Höhe [km]",THICK = 2,COLOR = "black", /XLOG, /OVERPLOT)
      
    restore, 'bifunc_parameter_20220531.sav'
    ; Verhältnis Anzahldichte  2022 plotten
    ratio_anzahldichte2 = plot(parameter[*,0]/parameter[*,1],abschnitte_hoehe/1000., $
      XTITLE = "Anzahldichte Verhältnis 1. zu 2. Mode",NAME = "Verhältnis vom 31.05.2022",$
      YTITLE = "Höhe [km]",THICK = 2, /OVERPLOT, COLOR = "red")
      
      ; Legende

      legende = legend(TARGET=[ratio_anzahldichte1, ratio_anzahldichte2,tropo21,tropo22],$
      POSITION=[0.99,0.99])
      
  end