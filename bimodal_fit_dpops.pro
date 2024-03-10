; ---------------------------------------------------------------------------------------------------------------------
;       bimodale Größenverteilungsfunktion der stratosphärischen Aerosole
;       file bimodalfunction.pro
; ---------------------------------------------------------------------------------------------------------------------
;   
;  ls_0=alog(A[4])     ;log(sigma_0)
;  ls_1=alog(A[5])     ;log(sigma_1)
;  
;  lx_0=alog(radius)-alog(A[2])  ; log(r/r_median_0)
;  lx_1=alog(radius)-alog(A[3])  ; log(r/r_median_1)
;  
;  ex_0=exp(-(lx_0^2)/(2*ls_0^2))   ; erster exponent
;  ex_1=exp(-(lx_1^2)/(2*ls_1^2))   ; zweiter exponent
;  
;  V_0=A[0]/(sqrt(2*!PI)*ls_0)
;  V_1=A[1]/(sqrt(2*!PI)*ls_1)
;  
;  F=V_0*ex_0+V_1*ex_1               ; Bimodale vert.
;  ; wird im spätern in der CURVEFIT Funktion aufgerufen

  

pro bimodal_fit_dpops
; ---------------------------------------------------------------------------------------------------------------------
;       Berechnung durchschnittliche Verteilung für alle 100 Höhenmeter
; ---------------------------------------------------------------------------------------------------------------------

  filename = ["DCOTSS-MERGE-10S_MERGE_20210617_R2.sav",$
  "DCOTSS-MERGE-10S_MERGE_20210716_R2.sav",$
  "DCOTSS-MERGE-10S_MERGE_20210720_R2.sav",$;2
  "DCOTSS-MERGE-10S_MERGE_20210723_R2.sav",$
  "DCOTSS-MERGE-10S_MERGE_20210726_R2.sav",$;4
  "DCOTSS-MERGE-10S_MERGE_20210729_R2.sav",$
  "DCOTSS-MERGE-10S_MERGE_20210802_R2.sav",$;6
  "DCOTSS-MERGE-10S_MERGE_20210806_R2.sav",$
  "DCOTSS-MERGE-10S_MERGE_20210810_R2.sav",$;8
  "DCOTSS-MERGE-10S_MERGE_20210814_R2.sav",$
  "DCOTSS-MERGE-10S_MERGE_20220513_R2.sav",$;10
  "DCOTSS-MERGE-10S_MERGE_20220529_R2.sav",$
  "DCOTSS-MERGE-10S_MERGE_20220531_R2.sav",$; 12
  "DCOTSS-MERGE-10S_MERGE_20220602_R2.sav",$
  "DCOTSS-MERGE-10S_MERGE_20220605_R2.sav",$;14
  "DCOTSS-MERGE-10S_MERGE_20210621_R2.sav",$
  "DCOTSS-MERGE-10S_MERGE_20220624_R2.sav",$
  "DCOTSS-MERGE-10S_MERGE_20220629_R2.sav"] ;16
  
  ; Anzahl der Datein für 2021 und 2022 zusammen 
  number_filename = n_elements(filename)
  ;Größe des Höhenmeter Arary --> maximale Höhe von 21 km für Flugzeig angenommen
  hight = 210
  ; Pfad der Datei   
  path = "I:\DPOPS_NC_2022\"
  
  bins = 36
  
  ; Erstellen der Arrays für die späteren Durchschnitte der Anzahldichte  
  PSD_DURCHSCHNITTE_ALL_BINS_20220531 = make_array(hight, bins)
  
  file_idx = 12

  radius_bins=[140., 147., 154.,161.,169.,176.,185.,194.,203.,212.,222.,233.,244.$
    ,255.,267.,280.,293.,328.,387.,452.,523.,583.,634.,692.,769.,883.,1021.,1166.,1316.,$
    1483.,1681.,1917.,2206.,2568.,3031.,3451.]/2.
  
    ; Wiederherstellen der Datei
    restore, path + filename[file_idx]

    ; Definieren
    ; Höhenabschnitte für alle 100 Höhenmeter
    abschnitte_hoehe = findgen(hight)*100.
    ; Alle NAN Werte aus den Anzahldichten herraussuchen

    allbins=[[BIN01],[BIN02],[BIN03],[BIN04],[BIN05],[BIN06],[BIN07],[BIN08],[BIN09],[BIN10],[BIN11],[BIN12],[BIN13],[BIN14],[BIN15],[BIN16],$
    [BIN17],[BIN18],[BIN19],[BIN20],[BIN21],[BIN22],[BIN23],[BIN24],[BIN25],[BIN26],[BIN27],[BIN28],[BIN29],[BIN30],[BIN31],[BIN32],[BIN33],$
    [BIN34],[BIN35],[BIN36]]

    ; temporäres Array für Anzahldichten-Durchschnitte
    temp_durchschnitte_psd = make_array(hight)
    ; Größe des Messung --> Anzahl der Einzelmessungen
    ending = n_elements(ALT_ER2)

    ; alle 100m Durchschnitte des Medianradius
    for binidx = 0, bins-1 do begin
      psd_index = allbins[*,binidx]

      nan = where(finite(psd_index, /NAN))
      psd_index[nan] = 0.
  
    for k = 0, hight-2 do begin
      y = make_array(ending)
      for j = 0, ending-1 do begin
        if (ALT_ER2[j] gt abschnitte_hoehe[k]) and (ALT_ER2[j] lt abschnitte_hoehe[k+1]) then begin
          y[j] = psd_index[j]
        endif
      endfor
      temp_durchschnitte_psd[k] = mean(y(where(y ne 0.)))
    endfor
    PSD_DURCHSCHNITTE_ALL_BINS_20220531[*,binidx] = temp_durchschnitte_psd
    endfor
    save, PSD_DURCHSCHNITTE_ALL_BINS_20220531,  FILENAME = 'PSD_DURCHSCHNITTE_ALL_BINS_20220531.sav'

; ---------------------------------------------------------------------------------------------------------------------
;       PLOTS: Anwendung der CURVEFIT Methode 
;       - bimodaler Fit an die zuvor berechneten Größenverteilungen für alle 100 Höhenmeter 
; ---------------------------------------------------------------------------------------------------------------------

;wird nur beim ersten durchlauf verwenet um Array mit NULL zu erstellen --> zahlenwerte werden im folgenden geändert
;  parameter = make_array(210, 6)
;  chi_square = make_array(210, /FLOAT)

;  restore, 'PSD_DURCHSCHNITTE_ALL_BINS_20220531.sav'

 
  hight_idx = 184
  path_1 = "C:\Users\Jule\Desktop"
   
 radius_bins=[140., 147., 154.,161.,169.,176.,185.,194.,203.,212.,222.,233.,244.$
      ,255.,267.,280.,293.,328.,387.,452.,523.,583.,634.,692.,769.,883.,1021.,1166.,1316.,$
      1483.,1681.,1917.,2206.,2568.,3031.,3451.]/2.
    
  ;A-priori-Parameter:
  N1 = 25.
  N2 = 0.5
  rm1 = 50.
  rm2 = 300.
  sigma1 = 1.6
  sigma2 = 1.1
   
;    ;A-priori-Parameter:
;    N1 = 0.
;    N2 = 0.
;    rm1 = 0.
;    rm2 = 0.
;    sigma1 = 0.
;    sigma2 = 0.
  
  ; erst ab dem 2 Durchlauf verwenden, damit Parameter aus erstem Durchlauf erhalten bleiben 
  

  Y_DPOPS = PSD_DURCHSCHNITTE_ALL_BINS_20220531[hight_idx,*]

  A = [N1, N2, rm1, rm2, sigma1, sigma2] ; Vorgabe der Anfangswerte für bifunc
  
  print, 'A priori Parameter:', A
  
 ; weights = MAKE_ARRAY(n_elements(radius_bins), /float, VALUE=1.) ;;gleiche Gewichtung aller Bins
  weights = findgen(n_elements(radius_bins)) ;;stärkere Gewichtung der größeren Radien im Fit
  
  y_fitted_bimodal = CURVEFIT(radius_bins, Y_DPOPS, weights, A, /NODERIVATIVE,$
     FUNCTION_NAME='bimodalfunction', CHISQ=chi, ITER=n_iter)
  
  ; Ausgabe der optimalen Parameter
  print, 'Optimierte Parameter:', A
  print, 'Anzahl Iterationen:', n_iter
  print, 'Chi-Quadrat-Wert:', chi
  
;  dpops_log = PLOT(radius_bins, Y_DPOPS, XRANGE=[60,2000], YRANGE=[0.01,50],SYMBOL = "o", /XLOG, /YLOG)
;  fit_log = PLOT(radius_bins, y_fitted_bimodal, color = "red", SYMBOL = "o",/OVERPLOT)

  dpops = PLOT(radius_bins, Y_DPOPS,XRANGE=[0,1000], YTITLE = "$dN/dlog(r) [1/cm^3]$", XTITLE = "Radius [nm]",$
   position = [0.115, 0.125, 0.95, 0.95], NAME = "DPOPS Größenverteilung", THICK = 2)
  fit = PLOT(radius_bins, y_fitted_bimodal, color = "blue", /OVERPLOT, NAME = "bimodaler Fit", THICK = 2)
  ;;Modenradius der zweiten Mode berechnen und markieren
  rmod = exp(alog(A[3])-(alog(A[5]))^2.)
  P = PLOT([rmod,rmod], [0, max(y_fitted_bimodal)], color = "green", /OVERPLOT, NAME = "Modenradius der 2. Mode", THICK = 2)   
  
 legende = legend(TARGET=[dpops, fit, P],$
    POSITION=[0.99,0.99])  
      
  print, rmod
  
;  restore, "bifunc_parameter_20220531.sav"
;  print, parameter

;  restore, 'chi_square_bifunc_20220531.sav'
;  parameter[hight_idx,*] = A
;  save, parameter,  FILENAME = 'bifunc_parameter_20220531.sav'
stop  
  ; log. plot speichern
  string = "log_hoehe_" + STRTRIM(hight_idx)+".png"
  varname = STRCOMPRESS( string, /REMOVE_ALL )
  p.save, path_1+".\durchschnitt_dos_n_20220531\"+varname, RESOLUTION=300
  
  ; linear plot speichern
  string = "hoehe_" + STRTRIM(hight_idx)+".png"
  varname = STRCOMPRESS(string, /REMOVE_ALL )
  fit.save, path_1+".\durchschnitt_dos_n_20220531\"+varname, RESOLUTION=300

end 