pro calculating_effective_radii_2021
;
;   NAME: calculating_effective_radii_2021.pro
;
;   ZWECK: - Berechnung der effektiven Radien aus den DPOPS-Messungen 
;          - Berechnung aus den gemessenen Größenverteilungen jeder einzelnen Messung
;          - Bildung des gemittelten effektiven Radius für alle 100 Höhenmeter 
;
;   ZULETZT BEARBEITET: 06.03.2024, Juliane Christin Weißig
;---------------------------------------------------------------------------------------------------------------------------------------------

  ; Definition allgemeiner Variablen
  hight = 213 ; 21,3 km

restore, "DCOTSS-MERGE-10S_MERGE_20210617_R2.sav"
  
   ; Array über alle Radien
    bincenter=[140., 147., 154.,161.,169.,176.,185.,194.,203.,212.,222.,233.,244.$
      ,255.,267.,280.,293.,328.,387.,452.,523.,583.,634.,692.,769.,883.,1021.,1166.,1316.,$
      1483.,1681.,1917.,2206.,2568.,3031.,3451.]/2.
      
   ; Array mit allen Bins erstellen
    allbins=[[BIN01],[BIN02],[BIN03],[BIN04],[BIN05],[BIN06],[BIN07],[BIN08],[BIN09],[BIN10],[BIN11],[BIN12],[BIN13],[BIN14],[BIN15],[BIN16],$
      [BIN17],[BIN18],[BIN19],[BIN20],[BIN21],[BIN22],[BIN23],[BIN24],[BIN25],[BIN26],[BIN27],[BIN28],[BIN29],[BIN30],[BIN31],[BIN32],[BIN33],$
      [BIN34],[BIN35],[BIN36]]
    
    ; Definieren 
    ; Anzahl der Einzelmessungen
    ending = n_elements(ALT_ER2)
    ; Array für Nenner und Zähler der Array Berechnung 
    effektiver_radius_x = make_array(ending) 
    effektiver_radius_y = make_array(ending)
    ; effektiver Radius
    radius_eff = make_array(ending)
    ; Durchschnitte für alle 100 Höhenmeter 
    durchschnitte_effektiver_radius = make_array(hight)
    abweichung_durchschnitte_effektiver_radius = make_array(hight)
    
    ; Schleife über alle Einzelmessungen
    for i = 0, ending-1 do begin
    ; Zähler
    x = 10^(3*ALOG10(radius))*allbins[i,*]
    effektiver_radius_x[i] = int_tabulated(Alog10(radius), x)
    
    ;Nenner
    y = 10^(2*ALOG10(radius))*allbins[i,*]
    effektiver_radius_y[i] = int_tabulated(Alog10(radius), y)
    
    ; Verhältnis bilden
    radius_eff[i] = effektiver_radius_x[i]/effektiver_radius_y[i]
  endfor
    
    ; alle effektive Radien (jeder Einzelmessung) in einem Array abspeichern  
    effektiver_radius = radius_eff
    SAVE, effektiver_radius, FILENAME = 'arr_effektiver_radius_20210617.sav'
    
  ; Durchschnitt berechnen --> mitteln über alle 100 Höhenmeter 
    ; Höhenabschnitte definieren
    abschnitte_hoehe = findgen(hight)*100.
    ; Höhe und effektiver Radius in ein Array speichern
    hoehe_effektiver_radius = [[ALT_ER2],[radius_eff]]
    ; alle NAN Werte identifizieren
    nan = where(finite(hoehe_effektiver_radius[*,1], /NAN))
    ; NAN-Werte werden NULL gesetzt
    hoehe_effektiver_radius[nan,1] = 0.
        
    ; alle 100m Durchschnitte des Medianradius bilden
    ; Schleife über alle Höhenabschnitte
    for i = 0, hight-2 do begin
      ; temporäres Array um alle effektiven Radien in einem Höhenabschnitt zu speichern
      y = make_array(ending)
      ; Schleife über alle Einzelmessungen
      for j = 0, ending-1 do begin
        if (hoehe_effektiver_radius[j,0] gt abschnitte_hoehe[i]) and (hoehe_effektiver_radius[j,0] lt abschnitte_hoehe[i+1]) then begin
          y[j] = hoehe_effektiver_radius[j,1]
        endif
      endfor
      ; Durchschnitt bilden und Ergebniss in Array übertragen 
      durchschnitte_effektiver_radius[i] = mean(y(where(y ne 0.)))
      ; Standardabweichung berechnen
      abweichung_durchschnitte_effektiver_radius[i] = STDDEV(y,/NAN)
    endfor
    
    ; Abspeichern
    durchschnitt_effektiver_radius = durchschnitte_effektiver_radius
    SAVE, durchschnitt_effektiver_radius, FILENAME = 'arr_durchschnitt_effektiver_radius_20210617.sav'
    abweichung_durchschnitt_effektiver_radius = abweichung_durchschnitte_effektiver_radius
    SAVE, abweichung_durchschnitt_effektiver_radius, FILENAME = 'arr_abweichung_durchschnitt_effektiver_radius_20210617.sav'

restore, "DCOTSS-MERGE-10S_MERGE_20210716_R2.sav"
    
    ; Array über alle Radien
    bincenter=[140., 147., 154.,161.,169.,176.,185.,194.,203.,212.,222.,233.,244.$
      ,255.,267.,280.,293.,328.,387.,452.,523.,583.,634.,692.,769.,883.,1021.,1166.,1316.,$
      1483.,1681.,1917.,2206.,2568.,3031.,3451.]/2. ; geschlossene Intervall
      
    ; Array mit allen Bins erstellen
    allbins=[[BIN01],[BIN02],[BIN03],[BIN04],[BIN05],[BIN06],[BIN07],[BIN08],[BIN09],[BIN10],[BIN11],[BIN12],[BIN13],[BIN14],[BIN15],[BIN16],$
      [BIN17],[BIN18],[BIN19],[BIN20],[BIN21],[BIN22],[BIN23],[BIN24],[BIN25],[BIN26],[BIN27],[BIN28],[BIN29],[BIN30],[BIN31],[BIN32],[BIN33],$
      [BIN34],[BIN35],[BIN36]]
      
    ending = n_elements(ALT_ER2)
    effektiver_radius_x = make_array(ending)
    effektiver_radius_y = make_array(ending)
    radius_eff = make_array(ending)
    durchschnitte_effektiver_radius = make_array(hight)
    abweichung_durchschnitte_effektiver_radius = make_array(hight)
    
    for i = 0, ending-1 do begin
    ; Zähler
    x = 10^(3*ALOG10(radius))*allbins[i,*]
    effektiver_radius_x[i] = int_tabulated(Alog10(radius), x)
    
    ;Nenner
    y = 10^(2*ALOG10(radius))*allbins[i,*]
    effektiver_radius_y[i] = int_tabulated(Alog10(radius), y)
    
    ; Verhältnis bilden
    radius_eff[i] = effektiver_radius_x[i]/effektiver_radius_y[i]
  endfor
    
    effektiver_radius = radius_eff
    SAVE, effektiver_radius, FILENAME = 'arr_effektiver_radius_20210716.sav'
    
    abschnitte_hoehe = findgen(hight)*100.
    hoehe_effektiver_radius = [[ALT_ER2],[radius_eff]]
    nan = where(finite(hoehe_effektiver_radius[*,1], /NAN))
    hoehe_effektiver_radius[nan,1] = 0.
    
    ; alle 100m Durchschnitte des Medianradius
    for i = 0, hight-2 do begin
      y = make_array(ending)
      for j = 0, ending-1 do begin
        if (hoehe_effektiver_radius[j,0] gt abschnitte_hoehe[i]) and (hoehe_effektiver_radius[j,0] lt abschnitte_hoehe[i+1]) then begin
          y[j] = hoehe_effektiver_radius[j,1]
        endif
      endfor
      durchschnitte_effektiver_radius[i] = mean(y(where(y ne 0.)))
      abweichung_durchschnitte_effektiver_radius[i] = stddev(y, /NAN)
    endfor
    
    durchschnitt_effektiver_radius = durchschnitte_effektiver_radius
    SAVE, durchschnitt_effektiver_radius, FILENAME = 'arr_durchschnitt_effektiver_radius_20210716.sav'
    abweichung_durchschnitt_effektiver_radius = abweichung_durchschnitte_effektiver_radius
    SAVE, abweichung_durchschnitt_effektiver_radius, FILENAME = 'arr_abweichung_durchschnitt_effektiver_radius_20210716.sav'


restore, "DCOTSS-MERGE-10S_MERGE_20210720_R2.sav"
    ; Array über alle Radien
    bincenter=[140., 147., 154.,161.,169.,176.,185.,194.,203.,212.,222.,233.,244.$
      ,255.,267.,280.,293.,328.,387.,452.,523.,583.,634.,692.,769.,883.,1021.,1166.,1316.,$
      1483.,1681.,1917.,2206.,2568.,3031.,3451.]/2. ; geschlossene Intervall
      
    ; Array mit allen Bins erstellen
    allbins=[[BIN01],[BIN02],[BIN03],[BIN04],[BIN05],[BIN06],[BIN07],[BIN08],[BIN09],[BIN10],[BIN11],[BIN12],[BIN13],[BIN14],[BIN15],[BIN16],$
      [BIN17],[BIN18],[BIN19],[BIN20],[BIN21],[BIN22],[BIN23],[BIN24],[BIN25],[BIN26],[BIN27],[BIN28],[BIN29],[BIN30],[BIN31],[BIN32],[BIN33],$
      [BIN34],[BIN35],[BIN36]]
      
    ending = n_elements(ALT_ER2)
    effektiver_radius_x = make_array(ending)
    effektiver_radius_y = make_array(ending)
    radius_eff = make_array(ending)
    durchschnitte_effektiver_radius = make_array(hight)
    abweichung_durchschnitte_effektiver_radius = make_array(hight)

    
   for i = 0, ending-1 do begin
    ; Zähler
    x = 10^(3*ALOG10(radius))*allbins[i,*]
    effektiver_radius_x[i] = int_tabulated(Alog10(radius), x)
    
    ;Nenner
    y = 10^(2*ALOG10(radius))*allbins[i,*]
    effektiver_radius_y[i] = int_tabulated(Alog10(radius), y)
    
    ; Verhältnis bilden
    radius_eff[i] = effektiver_radius_x[i]/effektiver_radius_y[i]
  endfor
    
    effektiver_radius = radius_eff
    SAVE, effektiver_radius, FILENAME = 'arr_effektiver_radius_20210720.sav'
    
    abschnitte_hoehe = findgen(hight)*100.
    hoehe_effektiver_radius = [[ALT_ER2],[radius_eff]]
    nan = where(finite(hoehe_effektiver_radius[*,1], /NAN))
    hoehe_effektiver_radius[nan,1] = 0.
    
    ; alle 100m Durchschnitte des Medianradius
    for i = 0, hight-2 do begin
      y = make_array(ending)
      for j = 0, ending-1 do begin
        if (hoehe_effektiver_radius[j,0] gt abschnitte_hoehe[i]) and (hoehe_effektiver_radius[j,0] lt abschnitte_hoehe[i+1]) then begin
          y[j] = hoehe_effektiver_radius[j,1]
        endif
      endfor
      durchschnitte_effektiver_radius[i] = mean(y(where(y ne 0.)))
      abweichung_durchschnitte_effektiver_radius[i] = stddev(y, /NAN)
    endfor
    
    durchschnitt_effektiver_radius = durchschnitte_effektiver_radius
    SAVE, durchschnitt_effektiver_radius, FILENAME = 'arr_durchschnitt_effektiver_radius_20210720.sav'
    abweichung_durchschnitt_effektiver_radius = abweichung_durchschnitte_effektiver_radius
    SAVE, abweichung_durchschnitt_effektiver_radius, FILENAME = 'arr_abweichung_durchschnitt_effektiver_radius_20210720.sav'

  
restore, "DCOTSS-MERGE-10S_MERGE_20210723_R2.sav"
    
    ; Array über alle Radien
    bincenter=[140., 147., 154.,161.,169.,176.,185.,194.,203.,212.,222.,233.,244.$
      ,255.,267.,280.,293.,328.,387.,452.,523.,583.,634.,692.,769.,883.,1021.,1166.,1316.,$
      1483.,1681.,1917.,2206.,2568.,3031.,3451.]/2. ; geschlossene Intervall
      
    ; Array mit allen Bins erstellen
    allbins=[[BIN01],[BIN02],[BIN03],[BIN04],[BIN05],[BIN06],[BIN07],[BIN08],[BIN09],[BIN10],[BIN11],[BIN12],[BIN13],[BIN14],[BIN15],[BIN16],$
      [BIN17],[BIN18],[BIN19],[BIN20],[BIN21],[BIN22],[BIN23],[BIN24],[BIN25],[BIN26],[BIN27],[BIN28],[BIN29],[BIN30],[BIN31],[BIN32],[BIN33],$
      [BIN34],[BIN35],[BIN36]]
      
    ending = n_elements(ALT_ER2)
    effektiver_radius_x = make_array(ending)
    effektiver_radius_y = make_array(ending)
    radius_eff = make_array(ending)
    durchschnitte_effektiver_radius = make_array(hight)
    abweichungdurchschnitte_effektiver_radius = make_array(hight)
    
    for i = 0, ending-1 do begin
    ; Zähler
    x = 10^(3*ALOG10(radius))*allbins[i,*]
    effektiver_radius_x[i] = int_tabulated(Alog10(radius), x)
    
    ;Nenner
    y = 10^(2*ALOG10(radius))*allbins[i,*]
    effektiver_radius_y[i] = int_tabulated(Alog10(radius), y)
    
    ; Verhältnis bilden
    radius_eff[i] = effektiver_radius_x[i]/effektiver_radius_y[i]
  endfor
    
    effektiver_radius = radius_eff
    SAVE, effektiver_radius, FILENAME = 'arr_effektiver_radius_20210723.sav'
    
    abschnitte_hoehe = findgen(hight)*100.
    hoehe_effektiver_radius = [[ALT_ER2],[radius_eff]]
    nan = where(finite(hoehe_effektiver_radius[*,1], /NAN))
    hoehe_effektiver_radius[nan,1] = 0.
    
    ; alle 100m Durchschnitte des Medianradius
    for i = 0, hight-2 do begin
      y = make_array(ending)
      for j = 0, ending-1 do begin
        if (hoehe_effektiver_radius[j,0] gt abschnitte_hoehe[i]) and (hoehe_effektiver_radius[j,0] lt abschnitte_hoehe[i+1]) then begin
          y[j] = hoehe_effektiver_radius[j,1]
        endif
      endfor
      durchschnitte_effektiver_radius[i] = mean(y(where(y ne 0.)))
      abweichung_durchschnitte_effektiver_radius[i] = stddev(y, /NAN)
    endfor
    
    durchschnitt_effektiver_radius = durchschnitte_effektiver_radius
    SAVE, durchschnitt_effektiver_radius, FILENAME = 'arr_durchschnitt_effektiver_radius_20210723.sav'
    abweichung_durchschnitt_effektiver_radius = abweichung_durchschnitte_effektiver_radius
    SAVE, abweichung_durchschnitt_effektiver_radius, FILENAME = 'arr_abweichung_durchschnitt_effektiver_radius_20210723.sav'

restore, "DCOTSS-MERGE-10S_MERGE_20210726_R2.sav"
    ; Array über alle Radien
    bincenter=[140., 147., 154.,161.,169.,176.,185.,194.,203.,212.,222.,233.,244.$
      ,255.,267.,280.,293.,328.,387.,452.,523.,583.,634.,692.,769.,883.,1021.,1166.,1316.,$
      1483.,1681.,1917.,2206.,2568.,3031.,3451.]/2. ; geschlossene Intervall
      
    ; Array mit allen Bins erstellen
    allbins=[[BIN01],[BIN02],[BIN03],[BIN04],[BIN05],[BIN06],[BIN07],[BIN08],[BIN09],[BIN10],[BIN11],[BIN12],[BIN13],[BIN14],[BIN15],[BIN16],$
      [BIN17],[BIN18],[BIN19],[BIN20],[BIN21],[BIN22],[BIN23],[BIN24],[BIN25],[BIN26],[BIN27],[BIN28],[BIN29],[BIN30],[BIN31],[BIN32],[BIN33],$
      [BIN34],[BIN35],[BIN36]]
      
    ending = n_elements(ALT_ER2)
    effektiver_radius_x = make_array(ending)
    effektiver_radius_y = make_array(ending)
    radius_eff = make_array(ending)
    durchschnitte_effektiver_radius = make_array(hight)
    abweichung_durchschnitte_effektiver_radius = make_array(hight)

    for i = 0, ending-1 do begin
    ; Zähler
    x = 10^(3*ALOG10(radius))*allbins[i,*]
    effektiver_radius_x[i] = int_tabulated(Alog10(radius), x)
    
    ;Nenner
    y = 10^(2*ALOG10(radius))*allbins[i,*]
    effektiver_radius_y[i] = int_tabulated(Alog10(radius), y)
    
    ; Verhältnis bilden
    radius_eff[i] = effektiver_radius_x[i]/effektiver_radius_y[i]
  endfor
    
    effektiver_radius = radius_eff
    SAVE, effektiver_radius, FILENAME = 'arr_effektiver_radius_20210726.sav'
    
    abschnitte_hoehe = findgen(hight)*100.
    hoehe_effektiver_radius = [[ALT_ER2],[radius_eff]]
    nan = where(finite(hoehe_effektiver_radius[*,1], /NAN))
    hoehe_effektiver_radius[nan,1] = 0.
    
    ; alle 100m Durchschnitte des Medianradius
    for i = 0, hight-2 do begin
      y = make_array(ending)
      for j = 0, ending-1 do begin
        if (hoehe_effektiver_radius[j,0] gt abschnitte_hoehe[i]) and (hoehe_effektiver_radius[j,0] lt abschnitte_hoehe[i+1]) then begin
          y[j] = hoehe_effektiver_radius[j,1]
        endif
      endfor
      durchschnitte_effektiver_radius[i] = mean(y(where(y ne 0.)))
      abweichung_durchschnitte_effektiver_radius[i] = stddev(y, /NAN)
    endfor
    
    durchschnitt_effektiver_radius = durchschnitte_effektiver_radius
    SAVE, durchschnitt_effektiver_radius, FILENAME = 'arr_durchschnitt_effektiver_radius_20210726.sav'
    abweichung_durchschnitt_effektiver_radius = abweichung_durchschnitte_effektiver_radius
    SAVE, abweichung_durchschnitt_effektiver_radius, FILENAME = 'arr_abweichung_durchschnitt_effektiver_radius_20210726.sav'

restore, "DCOTSS-MERGE-10S_MERGE_20210729_R2.sav"
    ; Array über alle Radien
    bincenter=[140., 147., 154.,161.,169.,176.,185.,194.,203.,212.,222.,233.,244.$
      ,255.,267.,280.,293.,328.,387.,452.,523.,583.,634.,692.,769.,883.,1021.,1166.,1316.,$
      1483.,1681.,1917.,2206.,2568.,3031.,3451.]/2. ; geschlossene Intervall
      
    ; Array mit allen Bins erstellen
    allbins=[[BIN01],[BIN02],[BIN03],[BIN04],[BIN05],[BIN06],[BIN07],[BIN08],[BIN09],[BIN10],[BIN11],[BIN12],[BIN13],[BIN14],[BIN15],[BIN16],$
      [BIN17],[BIN18],[BIN19],[BIN20],[BIN21],[BIN22],[BIN23],[BIN24],[BIN25],[BIN26],[BIN27],[BIN28],[BIN29],[BIN30],[BIN31],[BIN32],[BIN33],$
      [BIN34],[BIN35],[BIN36]]
      
    ending = n_elements(ALT_ER2)
    effektiver_radius_x = make_array(ending)
    effektiver_radius_y = make_array(ending)
    radius_eff = make_array(ending)
    durchschnitte_effektiver_radius = make_array(hight)
    abweichungdurchschnitte_effektiver_radius = make_array(hight)

    
   for i = 0, ending-1 do begin
    ; Zähler
    x = 10^(3*ALOG10(radius))*allbins[i,*]
    effektiver_radius_x[i] = int_tabulated(Alog10(radius), x)
    
    ;Nenner
    y = 10^(2*ALOG10(radius))*allbins[i,*]
    effektiver_radius_y[i] = int_tabulated(Alog10(radius), y)
    
    ; Verhältnis bilden
    radius_eff[i] = effektiver_radius_x[i]/effektiver_radius_y[i]
  endfor
    
    effektiver_radius = radius_eff
    SAVE, effektiver_radius, FILENAME = 'arr_effektiver_radius_20210729.sav'
    
    abschnitte_hoehe = findgen(hight)*100.
    hoehe_effektiver_radius = [[ALT_ER2],[radius_eff]]
    nan = where(finite(hoehe_effektiver_radius[*,1], /NAN))
    hoehe_effektiver_radius[nan,1] = 0.
    
    ; alle 100m Durchschnitte des Medianradius
    for i = 0, hight-2 do begin
      y = make_array(ending)
      for j = 0, ending-1 do begin
        if (hoehe_effektiver_radius[j,0] gt abschnitte_hoehe[i]) and (hoehe_effektiver_radius[j,0] lt abschnitte_hoehe[i+1]) then begin
          y[j] = hoehe_effektiver_radius[j,1]
        endif
      endfor
      durchschnitte_effektiver_radius[i] = mean(y(where(y ne 0.)))
     abweichung_durchschnitte_effektiver_radius[i] = stddev(y, /NAN)
    endfor
    
    durchschnitt_effektiver_radius = durchschnitte_effektiver_radius
    SAVE, durchschnitt_effektiver_radius, FILENAME = 'arr_durchschnitt_effektiver_radius_20210729.sav'
    abweichung_durchschnitt_effektiver_radius = abweichung_durchschnitte_effektiver_radius
    SAVE, abweichung_durchschnitt_effektiver_radius, FILENAME = 'arr_abweichung_durchschnitt_effektiver_radius_20210729.sav'

    
restore, "DCOTSS-MERGE-10S_MERGE_20210802_R2.sav"
    ; Array über alle Radien
    bincenter=[140., 147., 154.,161.,169.,176.,185.,194.,203.,212.,222.,233.,244.$
      ,255.,267.,280.,293.,328.,387.,452.,523.,583.,634.,692.,769.,883.,1021.,1166.,1316.,$
      1483.,1681.,1917.,2206.,2568.,3031.,3451.]/2. ; geschlossene Intervall
      
    ; Array mit allen Bins erstellen
    allbins=[[BIN01],[BIN02],[BIN03],[BIN04],[BIN05],[BIN06],[BIN07],[BIN08],[BIN09],[BIN10],[BIN11],[BIN12],[BIN13],[BIN14],[BIN15],[BIN16],$
      [BIN17],[BIN18],[BIN19],[BIN20],[BIN21],[BIN22],[BIN23],[BIN24],[BIN25],[BIN26],[BIN27],[BIN28],[BIN29],[BIN30],[BIN31],[BIN32],[BIN33],$
      [BIN34],[BIN35],[BIN36]]
      
    ending = n_elements(ALT_ER2)
    effektiver_radius_x = make_array(ending)
    effektiver_radius_y = make_array(ending)
    radius_eff = make_array(ending)
    durchschnitte_effektiver_radius = make_array(hight)
    abweichungdurchschnitte_effektiver_radius = make_array(hight)

   for i = 0, ending-1 do begin
    ; Zähler
    x = 10^(3*ALOG10(radius))*allbins[i,*]
    effektiver_radius_x[i] = int_tabulated(Alog10(radius), x)
    
    ;Nenner
    y = 10^(2*ALOG10(radius))*allbins[i,*]
    effektiver_radius_y[i] = int_tabulated(Alog10(radius), y)
    
    ; Verhältnis bilden
    radius_eff[i] = effektiver_radius_x[i]/effektiver_radius_y[i]
  endfor
    
    effektiver_radius = radius_eff
    SAVE, effektiver_radius, FILENAME = 'arr_effektiver_radius_20210802.sav'
    
    abschnitte_hoehe = findgen(hight)*100.
    hoehe_effektiver_radius = [[ALT_ER2],[radius_eff]]
    nan = where(finite(hoehe_effektiver_radius[*,1], /NAN))
    hoehe_effektiver_radius[nan,1] = 0.
    
    ; alle 100m Durchschnitte des Medianradius
    for i = 0, hight-2 do begin
      y = make_array(ending)
      for j = 0, ending-1 do begin
        if (hoehe_effektiver_radius[j,0] gt abschnitte_hoehe[i]) and (hoehe_effektiver_radius[j,0] lt abschnitte_hoehe[i+1]) then begin
          y[j] = hoehe_effektiver_radius[j,1]
        endif
      endfor
      durchschnitte_effektiver_radius[i] = mean(y(where(y ne 0.)))
      abweichung_durchschnitte_effektiver_radius[i] = stddev(y, /NAN)
    endfor
    
    durchschnitt_effektiver_radius = durchschnitte_effektiver_radius
    SAVE, durchschnitt_effektiver_radius, FILENAME = 'arr_durchschnitt_effektiver_radius_20210802.sav'
    abweichung_durchschnitt_effektiver_radius = abweichung_durchschnitte_effektiver_radius
    SAVE, abweichung_durchschnitt_effektiver_radius, FILENAME = 'arr_abweichung_durchschnitt_effektiver_radius_20210802.sav'

restore, "DCOTSS-MERGE-10S_MERGE_20210806_R2.sav"
    ; Array über alle Radien
    bincenter=[140., 147., 154.,161.,169.,176.,185.,194.,203.,212.,222.,233.,244.$
      ,255.,267.,280.,293.,328.,387.,452.,523.,583.,634.,692.,769.,883.,1021.,1166.,1316.,$
      1483.,1681.,1917.,2206.,2568.,3031.,3451.]/2. ; geschlossene Intervall
      
    ; Array mit allen Bins erstellen
    allbins=[[BIN01],[BIN02],[BIN03],[BIN04],[BIN05],[BIN06],[BIN07],[BIN08],[BIN09],[BIN10],[BIN11],[BIN12],[BIN13],[BIN14],[BIN15],[BIN16],$
      [BIN17],[BIN18],[BIN19],[BIN20],[BIN21],[BIN22],[BIN23],[BIN24],[BIN25],[BIN26],[BIN27],[BIN28],[BIN29],[BIN30],[BIN31],[BIN32],[BIN33],$
      [BIN34],[BIN35],[BIN36]]
      
    
    ending = n_elements(ALT_ER2)
    effektiver_radius_x = make_array(ending)
    effektiver_radius_y = make_array(ending)
    radius_eff = make_array(ending)
    durchschnitte_effektiver_radius = make_array(hight)
    abweichung_durchschnitte_effektiver_radius = make_array(hight)

    for i = 0, ending-1 do begin
      ; Zähler
      x = 10^(3*ALOG10(radius))*allbins[i,*]
      effektiver_radius_x[i] = int_tabulated(Alog10(radius), x)
      
      ;Nenner
      y = 10^(2*ALOG10(radius))*allbins[i,*]
      effektiver_radius_y[i] = int_tabulated(Alog10(radius), y)
      
      ; Verhältnis bilden
      radius_eff[i] = effektiver_radius_x[i]/effektiver_radius_y[i]
    endfor
    
    effektiver_radius = radius_eff
    SAVE, effektiver_radius, FILENAME = 'arr_effektiver_radius_20210806.sav'
    
    abschnitte_hoehe = findgen(hight)*100.
    hoehe_effektiver_radius = [[ALT_ER2],[radius_eff]]
    nan = where(finite(hoehe_effektiver_radius[*,1], /NAN))
    hoehe_effektiver_radius[nan,1] = 0.
    
    ; alle 100m Durchschnitte des Medianradius
    for i = 0, hight-2 do begin
      y = make_array(ending)
      for j = 0, ending-1 do begin
        if (hoehe_effektiver_radius[j,0] gt abschnitte_hoehe[i]) and (hoehe_effektiver_radius[j,0] lt abschnitte_hoehe[i+1]) then begin
          y[j] = hoehe_effektiver_radius[j,1]
        endif
      endfor
      durchschnitte_effektiver_radius[i] = mean(y(where(y ne 0.)))
      abweichung_durchschnitte_effektiver_radius[i] = stddev(y, /NAN)
    endfor
    
    durchschnitt_effektiver_radius = durchschnitte_effektiver_radius
    SAVE, durchschnitt_effektiver_radius, FILENAME = 'arr_durchschnitt_effektiver_radius_20210806.sav'
    abweichung_durchschnitt_effektiver_radius = abweichung_durchschnitte_effektiver_radius
    SAVE, abweichung_durchschnitt_effektiver_radius, FILENAME = 'arr_abweichung_durchschnitt_effektiver_radius_20210806.sav'

restore, "DCOTSS-MERGE-10S_MERGE_20210810_R2.sav"
    ; Array über alle Radien
    bincenter=[140., 147., 154.,161.,169.,176.,185.,194.,203.,212.,222.,233.,244.$
      ,255.,267.,280.,293.,328.,387.,452.,523.,583.,634.,692.,769.,883.,1021.,1166.,1316.,$
      1483.,1681.,1917.,2206.,2568.,3031.,3451.]/2. ; geschlossene Intervall
      
    ; Array mit allen Bins erstellen
    allbins=[[BIN01],[BIN02],[BIN03],[BIN04],[BIN05],[BIN06],[BIN07],[BIN08],[BIN09],[BIN10],[BIN11],[BIN12],[BIN13],[BIN14],[BIN15],[BIN16],$
      [BIN17],[BIN18],[BIN19],[BIN20],[BIN21],[BIN22],[BIN23],[BIN24],[BIN25],[BIN26],[BIN27],[BIN28],[BIN29],[BIN30],[BIN31],[BIN32],[BIN33],$
      [BIN34],[BIN35],[BIN36]]
      
    ending = n_elements(ALT_ER2)
    effektiver_radius_x = make_array(ending)
    effektiver_radius_y = make_array(ending)
    radius_eff = make_array(ending)
    durchschnitte_effektiver_radius = make_array(hight)
    abweichungdurchschnitte_effektiver_radius = make_array(hight)

   for i = 0, ending-1 do begin
    ; Zähler
    x = 10^(3*ALOG10(radius))*allbins[i,*]
    effektiver_radius_x[i] = int_tabulated(Alog10(radius), x)
    
    ;Nenner
    y = 10^(2*ALOG10(radius))*allbins[i,*]
    effektiver_radius_y[i] = int_tabulated(Alog10(radius), y)
    
    ; Verhältnis bilden
    radius_eff[i] = effektiver_radius_x[i]/effektiver_radius_y[i]
  endfor
    
    effektiver_radius = radius_eff
    SAVE, effektiver_radius, FILENAME = 'arr_effektiver_radius_20210810.sav'
    
    abschnitte_hoehe = findgen(hight)*100.
    hoehe_effektiver_radius = [[ALT_ER2],[radius_eff]]
    nan = where(finite(hoehe_effektiver_radius[*,1], /NAN))
    hoehe_effektiver_radius[nan,1] = 0.
    
    ; alle 100m Durchschnitte des Medianradius
    for i = 0, hight-2 do begin
      y = make_array(ending)
      for j = 0, ending-1 do begin
        if (hoehe_effektiver_radius[j,0] gt abschnitte_hoehe[i]) and (hoehe_effektiver_radius[j,0] lt abschnitte_hoehe[i+1]) then begin
          y[j] = hoehe_effektiver_radius[j,1]
        endif
      endfor
      durchschnitte_effektiver_radius[i] = mean(y(where(y ne 0.)))
      abweichung_durchschnitte_effektiver_radius[i] = stddev(y, /NAN)
    endfor
    
    durchschnitt_effektiver_radius = durchschnitte_effektiver_radius
    SAVE, durchschnitt_effektiver_radius, FILENAME = 'arr_durchschnitt_effektiver_radius_20210810.sav'
    abweichung_durchschnitt_effektiver_radius = abweichung_durchschnitte_effektiver_radius
    SAVE, abweichung_durchschnitt_effektiver_radius, FILENAME = 'arr_abweichung_durchschnitt_effektiver_radius_20210810.sav'

restore, "DCOTSS-MERGE-10S_MERGE_20210814_R2.sav"
  
    ; Array über alle Radien
    bincenter=[140., 147., 154.,161.,169.,176.,185.,194.,203.,212.,222.,233.,244.$
      ,255.,267.,280.,293.,328.,387.,452.,523.,583.,634.,692.,769.,883.,1021.,1166.,1316.,$
      1483.,1681.,1917.,2206.,2568.,3031.,3451.]/2. ; geschlossene Intervall
      
    ; Array mit allen Bins erstellen
    allbins=[[BIN01],[BIN02],[BIN03],[BIN04],[BIN05],[BIN06],[BIN07],[BIN08],[BIN09],[BIN10],[BIN11],[BIN12],[BIN13],[BIN14],[BIN15],[BIN16],$
      [BIN17],[BIN18],[BIN19],[BIN20],[BIN21],[BIN22],[BIN23],[BIN24],[BIN25],[BIN26],[BIN27],[BIN28],[BIN29],[BIN30],[BIN31],[BIN32],[BIN33],$
      [BIN34],[BIN35],[BIN36]]
      
    ending = n_elements(ALT_ER2)
    effektiver_radius_x = make_array(ending)
    effektiver_radius_y = make_array(ending)
    radius_eff = make_array(ending)
    durchschnitte_effektiver_radius = make_array(hight)
    abweichungdurchschnitte_effektiver_radius = make_array(hight)
  
  for i = 0, ending-1 do begin
    ; Zähler
    x = 10^(3*ALOG10(radius))*allbins[i,*]
    effektiver_radius_x[i] = int_tabulated(Alog10(radius), x)
    
    ;Nenner
    y = 10^(2*ALOG10(radius))*allbins[i,*]
    effektiver_radius_y[i] = int_tabulated(Alog10(radius), y)
    
    ; Verhältnis bilden
    radius_eff[i] = effektiver_radius_x[i]/effektiver_radius_y[i]
  endfor
    
    effektiver_radius = radius_eff
    SAVE, effektiver_radius, FILENAME = 'arr_effektiver_radius_20210814.sav'
    
    abschnitte_hoehe = findgen(hight)*100.
    hoehe_effektiver_radius = [[ALT_ER2],[radius_eff]]
    nan = where(finite(hoehe_effektiver_radius[*,1], /NAN))
    hoehe_effektiver_radius[nan,1] = 0.
    
    ; alle 100m Durchschnitte des Medianradius
    for i = 0, hight-2 do begin
      y = make_array(ending)
      for j = 0, ending-1 do begin
        if (hoehe_effektiver_radius[j,0] gt abschnitte_hoehe[i]) and (hoehe_effektiver_radius[j,0] lt abschnitte_hoehe[i+1]) then begin
          y[j] = hoehe_effektiver_radius[j,1]
        endif
      endfor
      durchschnitte_effektiver_radius[i] = mean(y(where(y ne 0.)))
      abweichung_durchschnitte_effektiver_radius[i] = stddev(y, /NAN)
    endfor
    
    durchschnitt_effektiver_radius = durchschnitte_effektiver_radius
    SAVE, durchschnitt_effektiver_radius, FILENAME = 'arr_durchschnitt_effektiver_radius_20210814.sav'
    abweichung_durchschnitt_effektiver_radius = abweichung_durchschnitte_effektiver_radius
    SAVE, abweichung_durchschnitt_effektiver_radius, FILENAME = 'arr_abweichung_durchschnitt_effektiver_radius_20210814.sav'



end 