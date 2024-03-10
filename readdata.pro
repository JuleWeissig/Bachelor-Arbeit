pro readdata
;
;   NAME: readdata.pro
;
;   ZWECK: - Einlesen der ursprünglichen Datein
;          - .sav Datein wurden genauso benannt wie die ursprüngliche .nc Datei
;   
;   ZULETZT BEARBEITET: 06.03.2024, Juliane Christin Weißig
;---------------------------------------------------------------------------------------------------------------------------------------------


  ; searching for file
  file=DIALOG_PICKFILE(Filter="*.nc")
  ; opens .nc file
  input_nc= NCDF_OPEN(file) 

  NCDF_VARGET, input_nc,"DPOPS_DOS_N", dos_n
  NCDF_VARGET, input_nc,"DPOPS_DOS_S", dos_s
  NCDF_VARGET, input_nc,"DPOPS_DOS_V", dos_v
  NCDF_VARGET, input_nc, "DeltaT", time_dif
  
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin01", bin01
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin02", bin02
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin03", bin03
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin04", bin04
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin05", bin05
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin06", bin06
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin07", bin07
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin08", bin08
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin09", bin09
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin10", bin10
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin11", bin11
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin12", bin12
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin13", bin13
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin14", bin14
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin15", bin15
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin16", bin16
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin17", bin17
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin18", bin18
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin19", bin19
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin20", bin20
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin21", bin21
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin22", bin22
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin23", bin23
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin24", bin24
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin25", bin25
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin26", bin26
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin27", bin27
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin28", bin28
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin29", bin29
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin30", bin30
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin31", bin31
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin32", bin32
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin33", bin33
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin34", bin34
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin35", bin35
  NCDF_VARGET, input_nc, "DPOPS_DOS_bin36", bin36
  
  NCDF_VARGET, input_nc, "GPS_Altitude_ER2", alt_er2
  NCDF_VARGET, input_nc, "Latitude_ER2", lat_er2
  NCDF_VARGET, input_nc, "Longitude_ER2", long_er2
  
  NCDF_VARGET, input_nc, "G_LAT_MMS", lat_mms
  NCDF_VARGET, input_nc, "G_ALT_MMS", alt_mms
  NCDF_VARGET, input_nc, "G_LONG_MMS", long_mms
  NCDF_VARGET, input_nc, "Potential_Temp_ER2", temp
  NCDF_VARGET, input_nc, "Time_ISO", time_iso
  NCDF_VARGET, input_nc, "Time_Start", time_start
  NCDF_VARGET, input_nc, "Time_Stop", time_stop
  
  

  SAVE, $
    bin01,bin02,bin03,bin04,bin05,bin06,bin07,bin08,bin09,bin10,bin11,bin12,bin13,bin14,bin15,bin16,bin17,bin18,bin19,bin20,$
    bin21,bin22,bin23,bin24,bin25,bin26,bin27,bin28,bin29,bin30,bin31,bin32,bin33,bin34,bin35,bin36,alt_er2,lat_er2,long_er2,$
    alt_er2, lat_mms,alt_mms,long_mms, dos_v, dos_s, dos_n, temp, time_iso, time_start, time_stop,$
     filename="DCOTSS-MERGE-1S_MERGE_20210819_R4.sav"
  
  ncdf_close, input_nc
  return 
  
  

end