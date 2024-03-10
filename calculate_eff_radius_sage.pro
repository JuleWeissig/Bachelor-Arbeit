pro calculate_eff_radius_sage
  ;
  ;   NAME: calculate_eff_radius_sage.pro
  ;
  ;   ZWECK: - Berechnung der effektiven Radien den SAGE Retrievals 
  ;          - mittels Medianradius und Verteilungsbreite
  ;
  ;   ZULETZT BEARBEITET: 01.02.2024, Juliane Christin Weißig
  ;---------------------------------------------------------------------------------------------------------------------------------------------

  ; SAGE Daten wiederherstellen
  restore, "medianradius_sage3iss_wlkombi_45.sav"
  restore, "verteilungsbreite_sage3iss_wlkombi_45.sav"
  restore, "julian_dates_sage3iss.sav"
  restore, "genauigkeitsparameter_sage3iss_wlkombi45.sav"

  ; Anzahl der Messungen 
  ending_data = n_elements(genauigkeitsparameter_sage3iss_wlkombi45[*,0])
  ; Anzahl der Einzelmessungen für jeder Messung
  measurements = n_elements(genauigkeitsparameter_sage3iss_wlkombi45[0,*])
  ; Array für effektiven Radius
  effektiverradius_sage3iss_wlkombi_45 = make_Array(ending_data, measurements)
  ; Höhenarray für jede Einzelmessung
  alt= findgen(measurements)*0.5+0.5

  ; Schleife über alle Messungen um ungenaue Einzelmessungen heraus zufiltern
  for i = 0, ending_data-1 do  begin
    ungenau = where(genauigkeitsparameter_sage3iss_wlkombi45[i,*] lt 16.)
    verteilungsbreite_sage3iss_wlkombi_45[i,ungenau] = !Values.F_NAN
    medianradius_sage3iss_wlkombi_45[i,ungenau] = !Values.F_NAN
  endfor
  
  ; Schleife über alle Einzelmessungen 
  for j = 0, measurements-1 do begin
    ; Schleife über alle Messungen 
    for i = 0, ending_data-1 do  begin
      ; Berechnung des effektiven Radius 
      effektiverradius_sage3iss_wlkombi_45[i,j] = medianradius_sage3iss_wlkombi_45[i,j]*exp((5/2)*ALOG(verteilungsbreite_sage3iss_wlkombi_45[i,j])^2)
    endfor
  endfor
  
  ; Abspeichern 
  effektiverradius_sage3iss_mit_genauigkeitsparameter = effektiverradius_sage3iss_wlkombi_45
  SAVE, effektiverradius_sage3iss_mit_genauigkeitsparameter, FILENAME='arr_effektiverradius_sage3iss_mit_genauigkeitsparameter.sav'

;  effektiverradius_sage3iss_ohne_genauigkeitsparameter = effektiverradius_sage3iss_wlkombi_45
;  SAVE, effektiverradius_sage3iss_ohne_genauigkeitsparameter, FILENAME='arr_effektiverradius_sage3iss_ohne_genauigkeitsparameter.sav'

end