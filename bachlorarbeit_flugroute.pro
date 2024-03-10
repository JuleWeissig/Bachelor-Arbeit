pro bachlorarbeit_flugroute 

; 2021 DPOPS
  restore, "DCOTSS-MERGE-10S_MERGE_20210617_R2.sav"
  longitude1 = LONG_ER2
  latitude1 = LAT_ER2    
  restore, "DCOTSS-MERGE-10S_MERGE_20210716_R2.sav"
  longitude2 = LONG_ER2
  latitude2 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20210720_R2.sav"
  longitude3 = LONG_ER2
  latitude3 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20210723_R2.sav"
  longitude4 = LONG_ER2
  latitude4 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20210726_R2.sav"
  longitude5 = LONG_ER2
  latitude5 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20210729_R2.sav"
  longitude6 = LONG_ER2
  latitude6 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20210802_R2.sav"
  longitude7 = LONG_ER2
  latitude7 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20210806_R2.sav"
  longitude8 = LONG_ER2
  latitude8 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20210810_R2.sav"
  longitude9 = LONG_ER2
  latitude9 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20210814_R2.sav"
  longitude10 = LONG_ER2
  latitude10 = LAT_ER2

  ; Karte estellen
  map1 = map('Equirectangular', LIMIT = [10, -135, 60, -75], $
    BACKGROUND_COLOR = "light blue",FONT_SIZE = 17, FILL_COLOR = "light blue")
  
  ; Rastereigenschaften  
  grid1 = map1.MAPGRID
  grid1.LINESTYLE = "dotted"
  grid1.LABEL_POSITION = 0
  
  ; Farbeigenschaften der Karte
  m1 = MapContinents(FILL_COLOR="OLD LACE" )  
  m2 = mapcontinents(/USA, COMBINE = 0, FILL_COLOR = "WHEAT")
  m3 = mapcontinents(/LAKES, FILL_COLOR= "light blue")

  ; Koordinaten der einzelnen Flüge plotten
  p1 = plot(longitude1, latitude1, SYMBOL=".", COLOR="green",  THICK=3, NAME = " 2021", /OVERPLOT )
  p2 = plot(longitude2, latitude2, SYMBOL=".", COLOR="green",  THICK=3, /OVERPLOT)
  p3 = plot(longitude3, latitude3, SYMBOL=".", COLOR="green",  THICK=3,  /OVERPLOT)
  p4 = plot(longitude4, latitude4, SYMBOL=".", COLOR="green",  THICK=3,  /OVERPLOT)
  p5 = plot(longitude5, latitude5, SYMBOL=".", COLOR="green",  THICK=3,  /OVERPLOT)
  p6 = plot(longitude6, latitude6, SYMBOL=".", COLOR="green",  THICK=3, /OVERPLOT)
  p8 = plot(longitude8, latitude8, SYMBOL=".", COLOR="green",  THICK=3,  /OVERPLOT)
  p9 = plot(longitude9, latitude9, SYMBOL=".", COLOR="green",  THICK=3,  /OVERPLOT)
  p10 = plot(longitude10, latitude10, SYMBOL=".", COLOR="green",  THICK=3,  /OVERPLOT)
  
  ; Standorte 
  palmdale = SYMBOL(longitude1[1], latitude1[1], 'Star', /DATA, $
    /SYM_FILLED, SYM_COLOR='magenta', SYM_SIZE = 3, NAME = "Palmdale, CA")
  salina = SYMBOL(longitude5[1], latitude5[1], 'Star', /DATA, $
    /SYM_FILLED, SYM_COLOR='cyan', SYM_SIZE = 3, NAME = "Salina, KS")    
  ; Legende 
  legende = legend(TARGET=[p1,palmdale,salina],POSITION=[128,17], /DATA, /AUTO_TEXT_COLOR,FONT_SIZE = 17)


; 2022 DPOPS
  restore, "DCOTSS-MERGE-10S_MERGE_20220513_R2.sav"
  longitude1 = LONG_ER2
  latitude1 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20220529_R2.sav"
  longitude2 = LONG_ER2
  latitude2 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20220531_R2.sav"
  longitude3 = LONG_ER2
  latitude3 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20220602_R2.sav"
  longitude4 = LONG_ER2
  latitude4 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20220605_R2.sav"
  longitude5 = LONG_ER2
  latitude5 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20220608_R2.sav"
  longitude6 = LONG_ER2
  latitude6 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20220610_R2.sav"
  longitude7 = LONG_ER2
  latitude7 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20220621_R2.sav"
  longitude8 = LONG_ER2
  latitude8 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20220624_R2.sav"
  longitude9 = LONG_ER2
  latitude9 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20220629_R2.sav"
  longitude10 = LONG_ER2
  latitude10 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20220706_R2.sav"
  longitude11 = LONG_ER2
  latitude11 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20220708_R2.sav"
  longitude12 = LONG_ER2
  latitude12 = LAT_ER2
  restore, "DCOTSS-MERGE-10S_MERGE_20220711_R2.sav"
  longitude13 = LONG_ER2
  latitude13 = LAT_ER2


  map2 = map('Equirectangular', LIMIT = [10, -135, 60, -75], $
    FILL_COLOR = "light blue" , FONT_SIZE = 17, LAYOUT=[2,1,2], /CURRENT)
        
  grid2 = map2.MAPGRID
  grid2.LINESTYLE = "dotted"
  grid2.LABEL_POSITION = 0
  
  m1 = MapContinents(FILL_COLOR="OLD LACE" )  
  m2 = mapcontinents(/USA, COMBINE = 0, FILL_COLOR = "WHEAT")
  m3 = mapcontinents(/LAKES, FILL_COLOR= "light blue")
  
  
  p1 = plot(longitude1, latitude1, SYMBOL=".", COLOR="dark blue",  THICK=3, NAME = " 2022", /OVERPLOT )
  p2 = plot(longitude2, latitude2, SYMBOL=".", COLOR="dark blue",  THICK=3,  /OVERPLOT)
  p3 = plot(longitude3, latitude3, SYMBOL=".", COLOR="dark blue",  THICK=3,  /OVERPLOT)
  p4 = plot(longitude4, latitude4, SYMBOL=".", COLOR="dark blue",  THICK=3,  /OVERPLOT)
  p5 = plot(longitude5, latitude5, SYMBOL=".", COLOR="dark blue",  THICK=3,  /OVERPLOT)
  p6 = plot(longitude6, latitude6, SYMBOL=".", COLOR="dark blue",  THICK=3, /OVERPLOT)
  p7 = plot(longitude7, latitude7, SYMBOL=".", COLOR="dark blue",  THICK=3,  /OVERPLOT)
  p8 = plot(longitude8, latitude8, SYMBOL=".", COLOR="dark blue",  THICK=3,  /OVERPLOT)
  p9 = plot(longitude9, latitude9, SYMBOL=".", COLOR="dark blue",  THICK=3,  /OVERPLOT)
  p10 = plot(longitude10, latitude10, SYMBOL=".", COLOR="dark blue",  THICK=3,  /OVERPLOT)
  p11 = plot(longitude11, latitude11, SYMBOL=".", COLOR="dark blue",  THICK=3,  /OVERPLOT)
  p12 = plot(longitude12, latitude12, SYMBOL=".", COLOR="dark blue",  THICK=3,  /OVERPLOT)
  p13 = plot(longitude13, latitude13, SYMBOL=".", COLOR="dark blue",  THICK=3,  /OVERPLOT)
  palmdale = SYMBOL(longitude1[1], latitude1[1], 'Star', /DATA, $
    /SYM_FILLED, SYM_COLOR='magenta', SYM_SIZE = 3, NAME = "Palmdale, CA", /CURRENT)
  salina = SYMBOL(longitude5[1], latitude5[1], 'Star', /DATA, $
    /SYM_FILLED, SYM_COLOR='cyan', SYM_SIZE = 3, NAME = "Salina, KS", /CURRENT)
  legende = legend(TARGET=[p1], POSITION=[128,17], /DATA, /AUTO_TEXT_COLOR,FONT_SIZE = 17)




end