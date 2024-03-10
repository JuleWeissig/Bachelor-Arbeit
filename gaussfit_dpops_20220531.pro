pro gaussfit_dpops_20220531
  ;------------ DPOPS DATA ----------------
  restore, "DCOTSS-MERGE-10S_MERGE_20220531_R2.sav"
  
  ; Größe der DPOPS Datei
  ending=n_elements(ALT_ER2)
  ;leere Arrays für Medianradius, Verteilunsgbreite und Anzahldichte
  medianradius = FLTARR(ending)
  verteilungsbreite = DBLARR(ending)
  N_ges = FLTARR(ending)
  chi_quadrat = FLTARR(ending)
  
  ; Array mit allen Bins erstellen
  allbins=[[BIN01],[BIN02],[BIN03],[BIN04],[BIN05],[BIN06],[BIN07],[BIN08],[BIN09],[BIN10],[BIN11],[BIN12],[BIN13],[BIN14],[BIN15],[BIN16],$
    [BIN17],[BIN18],[BIN19],[BIN20],[BIN21],[BIN22],[BIN23],[BIN24],[BIN25],[BIN26],[BIN27],[BIN28],[BIN29],[BIN30],[BIN31],[BIN32],[BIN33],$
    [BIN34],[BIN35],[BIN36]]

  ; Array über alle Radien
  bincenter=[140., 147., 154.,161.,169.,176.,185.,194.,203.,212.,222.,233.,244.$
    ,255.,267.,280.,293.,328.,387.,452.,523.,583.,634.,692.,769.,883.,1021.,1166.,1316.,$
    1483.,1681.,1917.,2206.,2568.,3031.,3451.]/2.
  
  ; Schleife über alle BINS, erstellen des Fits
  for i=0, ending-1 do begin
    anzahldichte=allbins[i,*]
    if FINITE(allbins[i,0]) then begin
      fit=gaussfit(ALOG(bincenter), anzahldichte, coeff, NTERMS=3, CHISQ=chiq)
      N_ges[i]=(coeff(0))
      medianradius[i]=exp(coeff(1))
      verteilungsbreite[i]=exp(coeff(2))
    endif
  endfor
  
  
  ; mehrdimensionalles Array mit Medianradius, Verteilunsgbreite und Anzahldichte
  anzahldichte_medianradius_verteilungsbreite=[[N_ges], [medianradius], [verteilungsbreite]]
  SAVE, anzahldichte_medianradius_verteilungsbreite, FILENAME = 'arr_anzahldichte_medianradius_verteilungsbreite_20220531.sav'
  stop
 ; Durchschnitt für alle 100 Höhenmeter
  abschnitte_hoehe = findgen(201)*100.
  durchschnitte_anzahldichte = make_array(201)
  durchschnitte_medianradius = make_array(201)
  durchschnitte_verteilungsbreite = make_array(201)
  abweichung_durchschnitte_anzahldichte = make_array(201)
  abweichung_durchschnitte_medianradius = make_array(201)
  abweichung_durchschnitte_verteilungsbreite = make_array(201)
  hoehe_parameter = [[ALT_ER2],[N_ges], [medianradius], [verteilungsbreite] ]
  ;  nan = where(finite(hoehe_parameter[*,1], /NAN))
  ;  hoehe_parameter[nan,1] = 0.
  nan = where(finite(hoehe_parameter[*,1], /NAN))
  hoehe_parameter[nan,2] = 0.
  nan = where(finite(hoehe_parameter[*,1], /NAN))
  hoehe_parameter[nan,3] = 0.
  
  ; alle 100m Durchschnitte des Medianradius
  for i = 0, 199 do begin
    x = make_array(ending)
    y = make_array(ending)
    z = make_array(ending)
    for j = 0, ending-1 do begin
      if (hoehe_parameter[j,0] gt abschnitte_hoehe[i]) and (hoehe_parameter[j,0] lt abschnitte_hoehe[i+1]) then begin
        x[j] = hoehe_parameter[j,1]
        y[j] = hoehe_parameter[j,2]
        z[j] = hoehe_parameter[j,3]
      endif
    endfor
    durchschnitte_anzahldichte[i] = mean(x,(where(x ne 0.)))
    durchschnitte_medianradius[i] = mean(y(where(y ne 0.)))
    durchschnitte_verteilungsbreite[i] = mean(Z(where(y ne 0.)))
    abweichung_durchschnitte_anzahldichte[i] = stddev(x, /NAN)
    abweichung_durchschnitte_medianradius[i] = stddev(y, /NAN)
    abweichung_durchschnitte_verteilungsbreite[i] = stddev(z, /NAN)
  endfor
  
  p = plot(durchschnitte_medianradius,abschnitte_hoehe/1000. )
  p = plot((durchschnitte_medianradius + abweichung_durchschnitte_medianradius),abschnitte_hoehe/1000. , /OVERPLOT, COLOR="red")
  
  p = plot(durchschnitte_verteilungsbreite,abschnitte_hoehe/1000. )
  p = plot((durchschnitte_verteilungsbreite + abweichung_durchschnitte_verteilungsbreite),abschnitte_hoehe/1000. , /OVERPLOT, COLOR="red")
  
  p = plot(durchschnitte_anzahldichte,abschnitte_hoehe/1000. )
  p = plot((durchschnitte_anzahldichte + abweichung_durchschnitte_anzahldichte),abschnitte_hoehe/1000., /OVERPLOT, COLOR="red" )
  
  hoehendurchschnitt_anzahldichte_standardabweichung_20220531=[[durchschnitte_anzahldichte], [abweichung_durchschnitte_anzahldichte]]
  SAVE, hoehendurchschnitt_anzahldichte_standardabweichung_20220531, FILENAME = 'arr_hoehendurchschnitt_anzahldichte_standardabweichung_20220531.sav'
  
  hoehendurchschnitt_verteilungsbreite_standardabweichung_20220531=[[durchschnitte_verteilungsbreite], [abweichung_durchschnitte_verteilungsbreite]]
  SAVE, hoehendurchschnitt_verteilungsbreite_standardabweichung_20220531, FILENAME = 'arr_hoehendurchschnitt_verteilungsbreite_standardabweichung_20220531.sav'
  
  hoehendurchschnitt_medianradius_standardabweichung_20220531=[[durchschnitte_medianradius], [abweichung_durchschnitte_medianradius]]
  SAVE, hoehendurchschnitt_medianradius_standardabweichung_20220531, FILENAME = 'arr_hoehendurchschnitt_medianradius_standardabweichung_20220531.sav'
  
  stop
  
  
    ;Schleife zum plotten der fits
    for i=0, ending-1 do begin
      anzahldichte=allbins[i,*]
      if FINITE(allbins[i,0]) then begin
        plot_data=plot(bincenter,anzahldichte, XRANGE=[0,600], XTITLE="r [nm]",$
          YTITLE="dn/dlog(r) [$1/cm³$]", BUFFER=1, NAME="Messung")
          fit=gaussfit(ALOG(bincenter), anzahldichte, coeff, NTERMS=3)
        plot_fit=plot(bincenter, fit, COLOR='Red', NAME="Fit", /OVERPLOT)
        legend = legend(TARGET=[plot_data,plot_fit], /DATA)
        string="plot_20220531"+"_nr_"+STRTRIM(i)+"_hoehe:_"+STRTRIM(ROUND(ALT_ER2[i]))+".png"
        varname = STRCOMPRESS( String, /REMOVE_ALL )
        plot_data.save, "./gaussfit_20220531/"+varname, RESOLUTION=300
      endif
    endfor
  
  ;Schleife zum plotten der fits
  for i=0, ending-1 do begin
    anzahldichte=allbins[i,*]
    if FINITE(allbins[i,0]) then begin
      plot_data=plot(bincenter,anzahldichte, XRANGE=[50,1000], XTITLE="r [nm]",$
        YTITLE="dn/dlog(r) [$1/cm³$]", BUFFER=1, NAME="Messung", /XLOG, /YLOG, YRANGE =[0.1,100])
        fit=gaussfit(ALOG(bincenter), anzahldichte, coeff, NTERMS=3)
      plot_fit=plot(bincenter, fit, COLOR='Red', NAME="Fit", /OVERPLOT)
      legend = legend(TARGET=[plot_data,plot_fit], /DATA)
      string="plot_20220531"+"_nr_"+STRTRIM(i)+"_hoehe:_"+STRTRIM(ROUND(ALT_ER2[i]))+".png"
      varname = STRCOMPRESS( String, /REMOVE_ALL )
      plot_data.save, "./log_gaussfit_20220531/"+varname, RESOLUTION=300
    endif
  endfor
  
end