(set-logic QF_NRA)
(declare-fun __minima__ () Real)
(declare-fun sc_0 () Real)
(assert (> sc_0 1e-08))
(declare-fun of_0 () Real)
(declare-fun sc_1 () Real)
(assert (> sc_1 1e-08))
(declare-fun of_1 () Real)
(declare-fun sc_2 () Real)
(assert (> sc_2 1e-08))
(declare-fun of_2 () Real)
(declare-fun sc_3 () Real)
(assert (> sc_3 1e-08))
(declare-fun of_3 () Real)
(declare-fun sc_4 () Real)
(assert (> sc_4 1e-08))
(declare-fun of_4 () Real)
; no offset
(assert (= of_0 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_1 0.))
; no offset
(assert (= of_2 0.))
; 
; =  {(sc.switch[7].SUB/sc.switch[7].Kmod)} {1.}
(assert (= (/ sc_1 sc_2) 1.))
; no scale
(assert (= (/ sc_1 sc_2) 1.))
; no scale
(assert (= (/ sc_0 1.) 1.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_3 0.))
; no offset
(assert (= 0. 0.))
; 
; =  {sc.switch[7].PROD} {(sc.switch[7].Vmax/1.)}
(assert (= sc_4 (/ sc_3 1.)))
; 
; =  {of.switch[7].PROD} {0.}
(assert (= of_4 0.))
; 
; >=  {((sc.switch[7].n*1000.75)+of.switch[7].n)} {3300.}
(assert (<= (+ (* sc_0 1000.75) of_0) 3300.))
; 
; <=  {((sc.switch[7].n*1000.75)+of.switch[7].n)} {0.5}
(assert (>= (+ (* sc_0 1000.75) of_0) 0.5))
; 
; >=  {((sc.switch[7].SUB*337.632520764)+of.switch[7].SUB)} {10.}
(assert (<= (+ (* sc_1 337.632520764) of_1) 10.))
; 
; <=  {((sc.switch[7].SUB*337.632520764)+of.switch[7].SUB)} {0.0001}
(assert (>= (+ (* sc_1 337.632520764) of_1) 0.0001))
(declare-fun slbot_2 () Real)
(declare-fun sltop_2 () Real)
; 
; =  {(((sc.switch[7].Kmod*0.)+of.switch[7].Kmod)+sl.min.switch[7].Kmod)} {0.0001}
(assert (= (+ (+ (* sc_2 0.) of_2) slbot_2) 0.0001))
; 
; =  {(((sc.switch[7].Kmod*1.66666666667)+of.switch[7].Kmod)+sl.max.switch[7].Kmod)} {10.}
(assert (= (+ (+ (* sc_2 1.66666666667) of_2) sltop_2) 10.))
(declare-fun slbot_4 () Real)
(declare-fun sltop_4 () Real)
; 
; =  {(((sc.switch[7].PROD*0.)+of.switch[7].PROD)+sl.min.switch[7].PROD)} {9.99934002508e-38}
(assert (= (+ (+ (* sc_4 0.) of_4) slbot_4) 9.99934002508e-38))
; 
; =  {(((sc.switch[7].PROD*15.6)+of.switch[7].PROD)+sl.max.switch[7].PROD)} {9.9999999}
(assert (= (+ (+ (* sc_4 15.6) of_4) sltop_4) 9.9999999))
(declare-fun slbot_3 () Real)
(declare-fun sltop_3 () Real)
; 
; =  {(((sc.switch[7].Vmax*0.)+of.switch[7].Vmax)+sl.min.switch[7].Vmax)} {0.0001}
(assert (= (+ (+ (* sc_3 0.) of_3) slbot_3) 0.0001))
; 
; =  {(((sc.switch[7].Vmax*15.6)+of.switch[7].Vmax)+sl.max.switch[7].Vmax)} {10.}
(assert (= (+ (+ (* sc_3 15.6) of_3) sltop_3) 10.))
(declare-fun slbot_4 () Real)
(declare-fun sltop_4 () Real)
; 
; =  {(((sc.switch[7].PROD*0.)+of.switch[7].PROD)+sl.min.switch[7].PROD)} {9.99934002508e-38}
(assert (= (+ (+ (* sc_4 0.) of_4) slbot_4) 9.99934002508e-38))
; 
; =  {(((sc.switch[7].PROD*15.6)+of.switch[7].PROD)+sl.max.switch[7].PROD)} {9.9999999}
(assert (= (+ (+ (* sc_4 15.6) of_4) sltop_4) 9.9999999))
(declare-fun sc_5 () Real)
(assert (> sc_5 1e-08))
(declare-fun of_5 () Real)
(declare-fun sc_6 () Real)
(assert (> sc_6 1e-08))
(declare-fun of_6 () Real)
; 
; =  {sc.input.I[2].O} {sc.input.I[2].X}
(assert (= sc_6 sc_5))
; 
; =  {of.input.I[2].O} {of.input.I[2].X}
(assert (= of_6 of_5))
; 
; >=  {((sc.input.I[2].X*0.)+of.input.I[2].X)} {10.}
(assert (<= (+ (* sc_5 0.) of_5) 10.))
; 
; <=  {((sc.input.I[2].X*0.)+of.input.I[2].X)} {0.}
(assert (>= (+ (* sc_5 0.) of_5) 0.))
; 
; >=  {((sc.input.I[2].O*0.)+of.input.I[2].O)} {10.}
(assert (<= (+ (* sc_6 0.) of_6) 10.))
; 
; <=  {((sc.input.I[2].O*0.)+of.input.I[2].O)} {0.}
(assert (>= (+ (* sc_6 0.) of_6) 0.))
(declare-fun sc_7 () Real)
(assert (> sc_7 1e-08))
(declare-fun of_7 () Real)
(declare-fun sc_8 () Real)
(assert (> sc_8 1e-08))
(declare-fun of_8 () Real)
; 
; =  {sc.input.I[8].O} {sc.input.I[8].X}
(assert (= sc_8 sc_7))
; 
; =  {of.input.I[8].O} {of.input.I[8].X}
(assert (= of_8 of_7))
; 
; >=  {((sc.input.I[8].X*0.)+of.input.I[8].X)} {10.}
(assert (<= (+ (* sc_7 0.) of_7) 10.))
; 
; <=  {((sc.input.I[8].X*0.)+of.input.I[8].X)} {0.}
(assert (>= (+ (* sc_7 0.) of_7) 0.))
; 
; >=  {((sc.input.I[8].O*0.)+of.input.I[8].O)} {10.}
(assert (<= (+ (* sc_8 0.) of_8) 10.))
; 
; <=  {((sc.input.I[8].O*0.)+of.input.I[8].O)} {0.}
(assert (>= (+ (* sc_8 0.) of_8) 0.))
(declare-fun sc_9 () Real)
(assert (> sc_9 1e-08))
(declare-fun of_9 () Real)
(declare-fun sc_10 () Real)
(assert (> sc_10 1e-08))
(declare-fun of_10 () Real)
; 
; =  {sc.input.I[7].O} {sc.input.I[7].X}
(assert (= sc_10 sc_9))
; 
; =  {of.input.I[7].O} {of.input.I[7].X}
(assert (= of_10 of_9))
; 
; >=  {((sc.input.I[7].X*0.)+of.input.I[7].X)} {10.}
(assert (<= (+ (* sc_9 0.) of_9) 10.))
; 
; <=  {((sc.input.I[7].X*0.)+of.input.I[7].X)} {0.}
(assert (>= (+ (* sc_9 0.) of_9) 0.))
; 
; >=  {((sc.input.I[7].O*0.)+of.input.I[7].O)} {10.}
(assert (<= (+ (* sc_10 0.) of_10) 10.))
; 
; <=  {((sc.input.I[7].O*0.)+of.input.I[7].O)} {0.}
(assert (>= (+ (* sc_10 0.) of_10) 0.))
(declare-fun sc_11 () Real)
(assert (> sc_11 1e-08))
(declare-fun of_11 () Real)
(declare-fun sc_12 () Real)
(assert (> sc_12 1e-08))
(declare-fun of_12 () Real)
; 
; =  {sc.input.I[13].O} {sc.input.I[13].X}
(assert (= sc_12 sc_11))
; 
; =  {of.input.I[13].O} {of.input.I[13].X}
(assert (= of_12 of_11))
; 
; >=  {((sc.input.I[13].X*337.632520764)+of.input.I[13].X)} {10.}
(assert (<= (+ (* sc_11 337.632520764) of_11) 10.))
; 
; <=  {((sc.input.I[13].X*337.632520764)+of.input.I[13].X)} {0.}
(assert (>= (+ (* sc_11 337.632520764) of_11) 0.))
; 
; >=  {((sc.input.I[13].O*337.632520764)+of.input.I[13].O)} {10.}
(assert (<= (+ (* sc_12 337.632520764) of_12) 10.))
; 
; <=  {((sc.input.I[13].O*337.632520764)+of.input.I[13].O)} {0.}
(assert (>= (+ (* sc_12 337.632520764) of_12) 0.))
(declare-fun sc_13 () Real)
(assert (> sc_13 1e-08))
(declare-fun of_13 () Real)
(declare-fun sc_14 () Real)
(assert (> sc_14 1e-08))
(declare-fun of_14 () Real)
; 
; =  {sc.input.I[12].O} {sc.input.I[12].X}
(assert (= sc_14 sc_13))
; 
; =  {of.input.I[12].O} {of.input.I[12].X}
(assert (= of_14 of_13))
; 
; >=  {((sc.input.I[12].X*0.)+of.input.I[12].X)} {10.}
(assert (<= (+ (* sc_13 0.) of_13) 10.))
; 
; <=  {((sc.input.I[12].X*0.)+of.input.I[12].X)} {0.}
(assert (>= (+ (* sc_13 0.) of_13) 0.))
; 
; >=  {((sc.input.I[12].O*0.)+of.input.I[12].O)} {10.}
(assert (<= (+ (* sc_14 0.) of_14) 10.))
; 
; <=  {((sc.input.I[12].O*0.)+of.input.I[12].O)} {0.}
(assert (>= (+ (* sc_14 0.) of_14) 0.))
(declare-fun sc_15 () Real)
(assert (> sc_15 1e-08))
(declare-fun of_15 () Real)
(declare-fun sc_16 () Real)
(assert (> sc_16 1e-08))
(declare-fun of_16 () Real)
; 
; =  {sc.input.I[9].O} {sc.input.I[9].X}
(assert (= sc_16 sc_15))
; 
; =  {of.input.I[9].O} {of.input.I[9].X}
(assert (= of_16 of_15))
; 
; >=  {((sc.input.I[9].X*0.)+of.input.I[9].X)} {10.}
(assert (<= (+ (* sc_15 0.) of_15) 10.))
; 
; <=  {((sc.input.I[9].X*0.)+of.input.I[9].X)} {0.}
(assert (>= (+ (* sc_15 0.) of_15) 0.))
; 
; >=  {((sc.input.I[9].O*0.)+of.input.I[9].O)} {10.}
(assert (<= (+ (* sc_16 0.) of_16) 10.))
; 
; <=  {((sc.input.I[9].O*0.)+of.input.I[9].O)} {0.}
(assert (>= (+ (* sc_16 0.) of_16) 0.))
(declare-fun sc_17 () Real)
(assert (> sc_17 1e-08))
(declare-fun of_17 () Real)
(declare-fun sc_18 () Real)
(assert (> sc_18 1e-08))
(declare-fun of_18 () Real)
; 
; =  {sc.input.I[0].O} {sc.input.I[0].X}
(assert (= sc_18 sc_17))
; 
; =  {of.input.I[0].O} {of.input.I[0].X}
(assert (= of_18 of_17))
(declare-fun slbot_17 () Real)
(declare-fun sltop_17 () Real)
; 
; =  {(((sc.input.I[0].X*0.)+of.input.I[0].X)+sl.min.input.I[0].X)} {0.}
(assert (= (+ (+ (* sc_17 0.) of_17) slbot_17) 0.))
; 
; =  {(((sc.input.I[0].X*0.6)+of.input.I[0].X)+sl.max.input.I[0].X)} {10.}
(assert (= (+ (+ (* sc_17 0.6) of_17) sltop_17) 10.))
(declare-fun slbot_18 () Real)
(declare-fun sltop_18 () Real)
; 
; =  {(((sc.input.I[0].O*0.)+of.input.I[0].O)+sl.min.input.I[0].O)} {0.}
(assert (= (+ (+ (* sc_18 0.) of_18) slbot_18) 0.))
; 
; =  {(((sc.input.I[0].O*0.6)+of.input.I[0].O)+sl.max.input.I[0].O)} {10.}
(assert (= (+ (+ (* sc_18 0.6) of_18) sltop_18) 10.))
(declare-fun sc_19 () Real)
(assert (> sc_19 1e-08))
(declare-fun of_19 () Real)
(declare-fun sc_20 () Real)
(assert (> sc_20 1e-08))
(declare-fun of_20 () Real)
; 
; =  {sc.input.I[11].O} {sc.input.I[11].X}
(assert (= sc_20 sc_19))
; 
; =  {of.input.I[11].O} {of.input.I[11].X}
(assert (= of_20 of_19))
; 
; >=  {((sc.input.I[11].X*0.)+of.input.I[11].X)} {10.}
(assert (<= (+ (* sc_19 0.) of_19) 10.))
; 
; <=  {((sc.input.I[11].X*0.)+of.input.I[11].X)} {0.}
(assert (>= (+ (* sc_19 0.) of_19) 0.))
; 
; >=  {((sc.input.I[11].O*0.)+of.input.I[11].O)} {10.}
(assert (<= (+ (* sc_20 0.) of_20) 10.))
; 
; <=  {((sc.input.I[11].O*0.)+of.input.I[11].O)} {0.}
(assert (>= (+ (* sc_20 0.) of_20) 0.))
(declare-fun sc_21 () Real)
(assert (> sc_21 1e-08))
(declare-fun of_21 () Real)
(declare-fun sc_22 () Real)
(assert (> sc_22 1e-08))
(declare-fun of_22 () Real)
; 
; =  {sc.input.I[10].O} {sc.input.I[10].X}
(assert (= sc_22 sc_21))
; 
; =  {of.input.I[10].O} {of.input.I[10].X}
(assert (= of_22 of_21))
; 
; >=  {((sc.input.I[10].X*0.)+of.input.I[10].X)} {10.}
(assert (<= (+ (* sc_21 0.) of_21) 10.))
; 
; <=  {((sc.input.I[10].X*0.)+of.input.I[10].X)} {0.}
(assert (>= (+ (* sc_21 0.) of_21) 0.))
; 
; >=  {((sc.input.I[10].O*0.)+of.input.I[10].O)} {10.}
(assert (<= (+ (* sc_22 0.) of_22) 10.))
; 
; <=  {((sc.input.I[10].O*0.)+of.input.I[10].O)} {0.}
(assert (>= (+ (* sc_22 0.) of_22) 0.))
(declare-fun sc_23 () Real)
(assert (> sc_23 1e-08))
(declare-fun of_23 () Real)
(declare-fun sc_24 () Real)
(assert (> sc_24 1e-08))
(declare-fun of_24 () Real)
; 
; =  {sc.input.I[15].O} {sc.input.I[15].X}
(assert (= sc_24 sc_23))
; 
; =  {of.input.I[15].O} {of.input.I[15].X}
(assert (= of_24 of_23))
; 
; >=  {((sc.input.I[15].X*4.)+of.input.I[15].X)} {10.}
(assert (<= (+ (* sc_23 4.) of_23) 10.))
; 
; <=  {((sc.input.I[15].X*4.)+of.input.I[15].X)} {0.}
(assert (>= (+ (* sc_23 4.) of_23) 0.))
; 
; >=  {((sc.input.I[15].O*4.)+of.input.I[15].O)} {10.}
(assert (<= (+ (* sc_24 4.) of_24) 10.))
; 
; <=  {((sc.input.I[15].O*4.)+of.input.I[15].O)} {0.}
(assert (>= (+ (* sc_24 4.) of_24) 0.))
(declare-fun sc_25 () Real)
(assert (> sc_25 1e-08))
(declare-fun of_25 () Real)
(declare-fun sc_26 () Real)
(assert (> sc_26 1e-08))
(declare-fun of_26 () Real)
; 
; =  {sc.input.I[6].O} {sc.input.I[6].X}
(assert (= sc_26 sc_25))
; 
; =  {of.input.I[6].O} {of.input.I[6].X}
(assert (= of_26 of_25))
; 
; >=  {((sc.input.I[6].X*0.)+of.input.I[6].X)} {10.}
(assert (<= (+ (* sc_25 0.) of_25) 10.))
; 
; <=  {((sc.input.I[6].X*0.)+of.input.I[6].X)} {0.}
(assert (>= (+ (* sc_25 0.) of_25) 0.))
; 
; >=  {((sc.input.I[6].O*0.)+of.input.I[6].O)} {10.}
(assert (<= (+ (* sc_26 0.) of_26) 10.))
; 
; <=  {((sc.input.I[6].O*0.)+of.input.I[6].O)} {0.}
(assert (>= (+ (* sc_26 0.) of_26) 0.))
(declare-fun sc_27 () Real)
(assert (> sc_27 1e-08))
(declare-fun of_27 () Real)
(declare-fun sc_28 () Real)
(assert (> sc_28 1e-08))
(declare-fun of_28 () Real)
; 
; =  {sc.input.I[14].O} {sc.input.I[14].X}
(assert (= sc_28 sc_27))
; 
; =  {of.input.I[14].O} {of.input.I[14].X}
(assert (= of_28 of_27))
; 
; >=  {((sc.input.I[14].X*15.6)+of.input.I[14].X)} {10.}
(assert (<= (+ (* sc_27 15.6) of_27) 10.))
; 
; <=  {((sc.input.I[14].X*15.6)+of.input.I[14].X)} {0.}
(assert (>= (+ (* sc_27 15.6) of_27) 0.))
; 
; >=  {((sc.input.I[14].O*15.6)+of.input.I[14].O)} {10.}
(assert (<= (+ (* sc_28 15.6) of_28) 10.))
; 
; <=  {((sc.input.I[14].O*15.6)+of.input.I[14].O)} {0.}
(assert (>= (+ (* sc_28 15.6) of_28) 0.))
(declare-fun sc_29 () Real)
(assert (> sc_29 1e-08))
(declare-fun of_29 () Real)
(declare-fun sc_30 () Real)
(assert (> sc_30 1e-08))
(declare-fun of_30 () Real)
; 
; =  {sc.input.I[24].O} {sc.input.I[24].X}
(assert (= sc_30 sc_29))
; 
; =  {of.input.I[24].O} {of.input.I[24].X}
(assert (= of_30 of_29))
; 
; >=  {((sc.input.I[24].X*0.)+of.input.I[24].X)} {10.}
(assert (<= (+ (* sc_29 0.) of_29) 10.))
; 
; <=  {((sc.input.I[24].X*0.)+of.input.I[24].X)} {0.}
(assert (>= (+ (* sc_29 0.) of_29) 0.))
; 
; >=  {((sc.input.I[24].O*0.)+of.input.I[24].O)} {10.}
(assert (<= (+ (* sc_30 0.) of_30) 10.))
; 
; <=  {((sc.input.I[24].O*0.)+of.input.I[24].O)} {0.}
(assert (>= (+ (* sc_30 0.) of_30) 0.))
(declare-fun sc_31 () Real)
(assert (> sc_31 1e-08))
(declare-fun of_31 () Real)
(declare-fun sc_32 () Real)
(assert (> sc_32 1e-08))
(declare-fun of_32 () Real)
; 
; =  {sc.input.I[16].O} {sc.input.I[16].X}
(assert (= sc_32 sc_31))
; 
; =  {of.input.I[16].O} {of.input.I[16].X}
(assert (= of_32 of_31))
; 
; >=  {((sc.input.I[16].X*1.)+of.input.I[16].X)} {10.}
(assert (<= (+ (* sc_31 1.) of_31) 10.))
; 
; <=  {((sc.input.I[16].X*1.)+of.input.I[16].X)} {0.}
(assert (>= (+ (* sc_31 1.) of_31) 0.))
; 
; >=  {((sc.input.I[16].O*1.)+of.input.I[16].O)} {10.}
(assert (<= (+ (* sc_32 1.) of_32) 10.))
; 
; <=  {((sc.input.I[16].O*1.)+of.input.I[16].O)} {0.}
(assert (>= (+ (* sc_32 1.) of_32) 0.))
(declare-fun sc_33 () Real)
(assert (> sc_33 1e-08))
(declare-fun of_33 () Real)
(declare-fun sc_34 () Real)
(assert (> sc_34 1e-08))
(declare-fun of_34 () Real)
; 
; =  {sc.input.I[3].O} {sc.input.I[3].X}
(assert (= sc_34 sc_33))
; 
; =  {of.input.I[3].O} {of.input.I[3].X}
(assert (= of_34 of_33))
; 
; >=  {((sc.input.I[3].X*0.)+of.input.I[3].X)} {10.}
(assert (<= (+ (* sc_33 0.) of_33) 10.))
; 
; <=  {((sc.input.I[3].X*0.)+of.input.I[3].X)} {0.}
(assert (>= (+ (* sc_33 0.) of_33) 0.))
; 
; >=  {((sc.input.I[3].O*0.)+of.input.I[3].O)} {10.}
(assert (<= (+ (* sc_34 0.) of_34) 10.))
; 
; <=  {((sc.input.I[3].O*0.)+of.input.I[3].O)} {0.}
(assert (>= (+ (* sc_34 0.) of_34) 0.))
(declare-fun sc_35 () Real)
(assert (> sc_35 1e-08))
(declare-fun of_35 () Real)
(declare-fun sc_36 () Real)
(assert (> sc_36 1e-08))
(declare-fun of_36 () Real)
; 
; =  {sc.input.I[4].O} {sc.input.I[4].X}
(assert (= sc_36 sc_35))
; 
; =  {of.input.I[4].O} {of.input.I[4].X}
(assert (= of_36 of_35))
; 
; >=  {((sc.input.I[4].X*0.)+of.input.I[4].X)} {10.}
(assert (<= (+ (* sc_35 0.) of_35) 10.))
; 
; <=  {((sc.input.I[4].X*0.)+of.input.I[4].X)} {0.}
(assert (>= (+ (* sc_35 0.) of_35) 0.))
; 
; >=  {((sc.input.I[4].O*0.)+of.input.I[4].O)} {10.}
(assert (<= (+ (* sc_36 0.) of_36) 10.))
; 
; <=  {((sc.input.I[4].O*0.)+of.input.I[4].O)} {0.}
(assert (>= (+ (* sc_36 0.) of_36) 0.))
(declare-fun sc_37 () Real)
(assert (> sc_37 1e-08))
(declare-fun of_37 () Real)
(declare-fun sc_38 () Real)
(assert (> sc_38 1e-08))
(declare-fun of_38 () Real)
; 
; =  {sc.input.I[5].O} {sc.input.I[5].X}
(assert (= sc_38 sc_37))
; 
; =  {of.input.I[5].O} {of.input.I[5].X}
(assert (= of_38 of_37))
; 
; >=  {((sc.input.I[5].X*0.)+of.input.I[5].X)} {10.}
(assert (<= (+ (* sc_37 0.) of_37) 10.))
; 
; <=  {((sc.input.I[5].X*0.)+of.input.I[5].X)} {0.}
(assert (>= (+ (* sc_37 0.) of_37) 0.))
; 
; >=  {((sc.input.I[5].O*0.)+of.input.I[5].O)} {10.}
(assert (<= (+ (* sc_38 0.) of_38) 10.))
; 
; <=  {((sc.input.I[5].O*0.)+of.input.I[5].O)} {0.}
(assert (>= (+ (* sc_38 0.) of_38) 0.))
(declare-fun sc_39 () Real)
(assert (> sc_39 1e-08))
(declare-fun of_39 () Real)
(declare-fun sc_40 () Real)
(assert (> sc_40 1e-08))
(declare-fun of_40 () Real)
; 
; =  {sc.input.I[23].O} {sc.input.I[23].X}
(assert (= sc_40 sc_39))
; 
; =  {of.input.I[23].O} {of.input.I[23].X}
(assert (= of_40 of_39))
; 
; >=  {((sc.input.I[23].X*0.)+of.input.I[23].X)} {10.}
(assert (<= (+ (* sc_39 0.) of_39) 10.))
; 
; <=  {((sc.input.I[23].X*0.)+of.input.I[23].X)} {0.}
(assert (>= (+ (* sc_39 0.) of_39) 0.))
; 
; >=  {((sc.input.I[23].O*0.)+of.input.I[23].O)} {10.}
(assert (<= (+ (* sc_40 0.) of_40) 10.))
; 
; <=  {((sc.input.I[23].O*0.)+of.input.I[23].O)} {0.}
(assert (>= (+ (* sc_40 0.) of_40) 0.))
(declare-fun sc_41 () Real)
(assert (> sc_41 1e-08))
(declare-fun of_41 () Real)
(declare-fun sc_42 () Real)
(assert (> sc_42 1e-08))
(declare-fun of_42 () Real)
; 
; =  {sc.input.I[25].O} {sc.input.I[25].X}
(assert (= sc_42 sc_41))
; 
; =  {of.input.I[25].O} {of.input.I[25].X}
(assert (= of_42 of_41))
; 
; >=  {((sc.input.I[25].X*0.)+of.input.I[25].X)} {10.}
(assert (<= (+ (* sc_41 0.) of_41) 10.))
; 
; <=  {((sc.input.I[25].X*0.)+of.input.I[25].X)} {0.}
(assert (>= (+ (* sc_41 0.) of_41) 0.))
; 
; >=  {((sc.input.I[25].O*0.)+of.input.I[25].O)} {10.}
(assert (<= (+ (* sc_42 0.) of_42) 10.))
; 
; <=  {((sc.input.I[25].O*0.)+of.input.I[25].O)} {0.}
(assert (>= (+ (* sc_42 0.) of_42) 0.))
(declare-fun sc_43 () Real)
(assert (> sc_43 1e-08))
(declare-fun of_43 () Real)
(declare-fun sc_44 () Real)
(assert (> sc_44 1e-08))
(declare-fun of_44 () Real)
; 
; =  {sc.input.I[1].O} {sc.input.I[1].X}
(assert (= sc_44 sc_43))
; 
; =  {of.input.I[1].O} {of.input.I[1].X}
(assert (= of_44 of_43))
; 
; >=  {((sc.input.I[1].X*156.25)+of.input.I[1].X)} {10.}
(assert (<= (+ (* sc_43 156.25) of_43) 10.))
; 
; <=  {((sc.input.I[1].X*156.25)+of.input.I[1].X)} {0.}
(assert (>= (+ (* sc_43 156.25) of_43) 0.))
; 
; >=  {((sc.input.I[1].O*156.25)+of.input.I[1].O)} {10.}
(assert (<= (+ (* sc_44 156.25) of_44) 10.))
; 
; <=  {((sc.input.I[1].O*156.25)+of.input.I[1].O)} {0.}
(assert (>= (+ (* sc_44 156.25) of_44) 0.))
(declare-fun sc_45 () Real)
(assert (> sc_45 1e-08))
(declare-fun of_45 () Real)
(declare-fun sc_46 () Real)
(assert (> sc_46 1e-08))
(declare-fun of_46 () Real)
; 
; =  {sc.input.I[17].O} {sc.input.I[17].X}
(assert (= sc_46 sc_45))
; 
; =  {of.input.I[17].O} {of.input.I[17].X}
(assert (= of_46 of_45))
; 
; >=  {((sc.input.I[17].X*1.)+of.input.I[17].X)} {10.}
(assert (<= (+ (* sc_45 1.) of_45) 10.))
; 
; <=  {((sc.input.I[17].X*1.)+of.input.I[17].X)} {0.}
(assert (>= (+ (* sc_45 1.) of_45) 0.))
; 
; >=  {((sc.input.I[17].O*1.)+of.input.I[17].O)} {10.}
(assert (<= (+ (* sc_46 1.) of_46) 10.))
; 
; <=  {((sc.input.I[17].O*1.)+of.input.I[17].O)} {0.}
(assert (>= (+ (* sc_46 1.) of_46) 0.))
(declare-fun sc_47 () Real)
(assert (> sc_47 1e-08))
(declare-fun of_47 () Real)
(declare-fun sc_48 () Real)
(assert (> sc_48 1e-08))
(declare-fun of_48 () Real)
; 
; =  {sc.input.I[18].O} {sc.input.I[18].X}
(assert (= sc_48 sc_47))
; 
; =  {of.input.I[18].O} {of.input.I[18].X}
(assert (= of_48 of_47))
; 
; >=  {((sc.input.I[18].X*1.)+of.input.I[18].X)} {10.}
(assert (<= (+ (* sc_47 1.) of_47) 10.))
; 
; <=  {((sc.input.I[18].X*1.)+of.input.I[18].X)} {0.}
(assert (>= (+ (* sc_47 1.) of_47) 0.))
; 
; >=  {((sc.input.I[18].O*1.)+of.input.I[18].O)} {10.}
(assert (<= (+ (* sc_48 1.) of_48) 10.))
; 
; <=  {((sc.input.I[18].O*1.)+of.input.I[18].O)} {0.}
(assert (>= (+ (* sc_48 1.) of_48) 0.))
(declare-fun sc_49 () Real)
(assert (> sc_49 1e-08))
(declare-fun of_49 () Real)
(declare-fun sc_50 () Real)
(assert (> sc_50 1e-08))
(declare-fun of_50 () Real)
; 
; =  {sc.input.I[19].O} {sc.input.I[19].X}
(assert (= sc_50 sc_49))
; 
; =  {of.input.I[19].O} {of.input.I[19].X}
(assert (= of_50 of_49))
; 
; >=  {((sc.input.I[19].X*1.)+of.input.I[19].X)} {10.}
(assert (<= (+ (* sc_49 1.) of_49) 10.))
; 
; <=  {((sc.input.I[19].X*1.)+of.input.I[19].X)} {0.}
(assert (>= (+ (* sc_49 1.) of_49) 0.))
; 
; >=  {((sc.input.I[19].O*1.)+of.input.I[19].O)} {10.}
(assert (<= (+ (* sc_50 1.) of_50) 10.))
; 
; <=  {((sc.input.I[19].O*1.)+of.input.I[19].O)} {0.}
(assert (>= (+ (* sc_50 1.) of_50) 0.))
(declare-fun sc_51 () Real)
(assert (> sc_51 1e-08))
(declare-fun of_51 () Real)
(declare-fun sc_52 () Real)
(assert (> sc_52 1e-08))
(declare-fun of_52 () Real)
; 
; =  {sc.output.V[0].O} {sc.output.V[0].X}
(assert (= sc_52 sc_51))
; 
; =  {of.output.V[0].O} {of.output.V[0].X}
(assert (= of_52 of_51))
(declare-fun slbot_51 () Real)
(declare-fun sltop_51 () Real)
; 
; =  {(((sc.output.V[0].X*0.)+of.output.V[0].X)+sl.min.output.V[0].X)} {0.0001}
(assert (= (+ (+ (* sc_51 0.) of_51) slbot_51) 0.0001))
; 
; =  {(((sc.output.V[0].X*156.25)+of.output.V[0].X)+sl.max.output.V[0].X)} {3300.}
(assert (= (+ (+ (* sc_51 156.25) of_51) sltop_51) 3300.))
(declare-fun slbot_52 () Real)
(declare-fun sltop_52 () Real)
; 
; =  {(((sc.output.V[0].O*0.)+of.output.V[0].O)+sl.min.output.V[0].O)} {0.0001}
(assert (= (+ (+ (* sc_52 0.) of_52) slbot_52) 0.0001))
; 
; =  {(((sc.output.V[0].O*156.25)+of.output.V[0].O)+sl.max.output.V[0].O)} {3300.}
(assert (= (+ (+ (* sc_52 156.25) of_52) sltop_52) 3300.))
(declare-fun sc_53 () Real)
(assert (> sc_53 1e-08))
(declare-fun of_53 () Real)
(declare-fun sc_54 () Real)
(assert (> sc_54 1e-08))
(declare-fun of_54 () Real)
; 
; =  {sc.output.V[1].O} {sc.output.V[1].X}
(assert (= sc_54 sc_53))
; 
; =  {of.output.V[1].O} {of.output.V[1].X}
(assert (= of_54 of_53))
(declare-fun slbot_53 () Real)
(declare-fun sltop_53 () Real)
; 
; =  {(((sc.output.V[1].X*0.)+of.output.V[1].X)+sl.min.output.V[1].X)} {0.0001}
(assert (= (+ (+ (* sc_53 0.) of_53) slbot_53) 0.0001))
; 
; =  {(((sc.output.V[1].X*15.6)+of.output.V[1].X)+sl.max.output.V[1].X)} {3300.}
(assert (= (+ (+ (* sc_53 15.6) of_53) sltop_53) 3300.))
(declare-fun slbot_54 () Real)
(declare-fun sltop_54 () Real)
; 
; =  {(((sc.output.V[1].O*0.)+of.output.V[1].O)+sl.min.output.V[1].O)} {0.0001}
(assert (= (+ (+ (* sc_54 0.) of_54) slbot_54) 0.0001))
; 
; =  {(((sc.output.V[1].O*15.6)+of.output.V[1].O)+sl.max.output.V[1].O)} {3300.}
(assert (= (+ (+ (* sc_54 15.6) of_54) sltop_54) 3300.))
(declare-fun sc_55 () Real)
(assert (> sc_55 1e-08))
(declare-fun of_55 () Real)
(declare-fun sc_56 () Real)
(assert (> sc_56 1e-08))
(declare-fun of_56 () Real)
(declare-fun sc_57 () Real)
(assert (> sc_57 1e-08))
(declare-fun of_57 () Real)
(declare-fun sc_58 () Real)
(assert (> sc_58 1e-08))
(declare-fun of_58 () Real)
(declare-fun sc_59 () Real)
(assert (> sc_59 1e-08))
(declare-fun of_59 () Real)
(declare-fun sc_60 () Real)
(assert (> sc_60 1e-08))
(declare-fun of_60 () Real)
(declare-fun sc_61 () Real)
(assert (> sc_61 1e-08))
(declare-fun of_61 () Real)
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_56 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_57 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_59 0.))
; 
; =  {sc.vadd[2].A} {(1.*sc.vadd[2].B)}
(assert (= sc_58 (* 1. sc_59)))
; 
; =  {sc.vadd[2].A} {(1.*sc.vadd[2].C)} {(1.*sc.vadd[2].D)}
(assert (and (= sc_58 (* 1. sc_57)) (= sc_58 (* 1. sc_56))))
; no offset
(assert (= (- (+ of_58 0.) (+ 0. 0.)) 0.))
; no offset
(assert (= 0. 0.))
; 
; =  {sc.vadd[2].OUT} {(sc.vadd[2].A*1.)}
(assert (= sc_60 (* sc_58 1.)))
; 
; =  {of.vadd[2].OUT} {0.}
(assert (= of_60 0.))
; no scale
(assert (= sc_56 1.))
; no scale
(assert (= 1. 1.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_56 0.))
; no offset
(assert (= of_61 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_57 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_59 0.))
; 
; =  {sc.vadd[2].A} {(1.*sc.vadd[2].B)}
(assert (= sc_58 (* 1. sc_59)))
; 
; =  {sc.vadd[2].A} {(1.*sc.vadd[2].C)} {(1.*sc.vadd[2].D*sc.vadd[2].OUT2)}
(assert (and (= sc_58 (* 1. sc_57)) (= sc_58 (* (* 1. sc_56) sc_61))))
; no offset
(assert (= (- (+ of_58 0.) (+ 0. 0.)) 0.))
; no offset
(assert (= 0. 0.))
; 
; =  {sc.vadd[2].OUT2} {(sc.vadd[2].A*1.)}
(assert (= sc_61 (* sc_58 1.)))
; no offset
(assert (= of_61 0.))
; no offset
(assert (= 0. 0.))
; 
; =  {sc.vadd[2].OUT2_0} {(sc.vadd[2].A*1.)}
(assert (= sc_55 (* sc_58 1.)))
; 
; =  {of.vadd[2].OUT2_0} {0.}
(assert (= of_55 0.))
; 
; >=  {((sc.vadd[2].OUT2_0*0.)+of.vadd[2].OUT2_0)} {3300.}
(assert (<= (+ (* sc_55 0.) of_55) 3300.))
; 
; <=  {((sc.vadd[2].OUT2_0*0.)+of.vadd[2].OUT2_0)} {0.}
(assert (>= (+ (* sc_55 0.) of_55) 0.))
; 
; >=  {((sc.vadd[2].D*4.)+of.vadd[2].D)} {3300.}
(assert (<= (+ (* sc_56 4.) of_56) 3300.))
; 
; <=  {((sc.vadd[2].D*4.)+of.vadd[2].D)} {0.}
(assert (>= (+ (* sc_56 4.) of_56) 0.))
; 
; >=  {((sc.vadd[2].C*0.)+of.vadd[2].C)} {3300.}
(assert (<= (+ (* sc_57 0.) of_57) 3300.))
; 
; <=  {((sc.vadd[2].C*0.)+of.vadd[2].C)} {0.}
(assert (>= (+ (* sc_57 0.) of_57) 0.))
; 
; >=  {((sc.vadd[2].A*0.)+of.vadd[2].A)} {3300.}
(assert (<= (+ (* sc_58 0.) of_58) 3300.))
; 
; <=  {((sc.vadd[2].A*0.)+of.vadd[2].A)} {0.}
(assert (>= (+ (* sc_58 0.) of_58) 0.))
(declare-fun slbot_61 () Real)
(declare-fun sltop_61 () Real)
; 
; =  {(((sc.vadd[2].OUT2*0.)+of.vadd[2].OUT2)+sl.min.vadd[2].OUT2)} {0.}
(assert (= (+ (+ (* sc_61 0.) of_61) slbot_61) 0.))
; 
; =  {(((sc.vadd[2].OUT2*156.25)+of.vadd[2].OUT2)+sl.max.vadd[2].OUT2)} {3300.}
(assert (= (+ (+ (* sc_61 156.25) of_61) sltop_61) 3300.))
(declare-fun slbot_59 () Real)
(declare-fun sltop_59 () Real)
; 
; =  {(((sc.vadd[2].B*3.75903614458)+of.vadd[2].B)+sl.min.vadd[2].B)} {0.}
(assert (= (+ (+ (* sc_59 3.75903614458) of_59) slbot_59) 0.))
; 
; =  {(((sc.vadd[2].B*62.4)+of.vadd[2].B)+sl.max.vadd[2].B)} {3300.}
(assert (= (+ (+ (* sc_59 62.4) of_59) sltop_59) 3300.))
(declare-fun slbot_60 () Real)
(declare-fun sltop_60 () Real)
; 
; =  {(((sc.vadd[2].OUT*3.75903614458)+of.vadd[2].OUT)+sl.min.vadd[2].OUT)} {-1650.}
(assert (= (+ (+ (* sc_60 3.75903614458) of_60) slbot_60) -1650.))
; 
; =  {(((sc.vadd[2].OUT*62.4)+of.vadd[2].OUT)+sl.max.vadd[2].OUT)} {1650.}
(assert (= (+ (+ (* sc_60 62.4) of_60) sltop_60) 1650.))
(declare-fun slbot_61 () Real)
(declare-fun sltop_61 () Real)
; 
; =  {(((sc.vadd[2].OUT2*0.)+of.vadd[2].OUT2)+sl.min.vadd[2].OUT2)} {0.}
(assert (= (+ (+ (* sc_61 0.) of_61) slbot_61) 0.))
; 
; =  {(((sc.vadd[2].OUT2*156.25)+of.vadd[2].OUT2)+sl.max.vadd[2].OUT2)} {3300.}
(assert (= (+ (+ (* sc_61 156.25) of_61) sltop_61) 3300.))
(declare-fun sc_62 () Real)
(assert (> sc_62 1e-08))
(declare-fun of_62 () Real)
(declare-fun sc_63 () Real)
(assert (> sc_63 1e-08))
(declare-fun of_63 () Real)
(declare-fun sc_64 () Real)
(assert (> sc_64 1e-08))
(declare-fun of_64 () Real)
(declare-fun sc_65 () Real)
(assert (> sc_65 1e-08))
(declare-fun of_65 () Real)
(declare-fun sc_66 () Real)
(assert (> sc_66 1e-08))
(declare-fun of_66 () Real)
(declare-fun sc_67 () Real)
(assert (> sc_67 1e-08))
(declare-fun of_67 () Real)
(declare-fun sc_68 () Real)
(assert (> sc_68 1e-08))
(declare-fun of_68 () Real)
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_63 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_64 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_66 0.))
; 
; =  {sc.vadd[5].A} {(1.*sc.vadd[5].B)}
(assert (= sc_65 (* 1. sc_66)))
; 
; =  {sc.vadd[5].A} {(1.*sc.vadd[5].C)} {(1.*sc.vadd[5].D)}
(assert (and (= sc_65 (* 1. sc_64)) (= sc_65 (* 1. sc_63))))
; no offset
(assert (= (- (+ of_65 0.) (+ 0. 0.)) 0.))
; no offset
(assert (= 0. 0.))
; 
; =  {sc.vadd[5].OUT} {(sc.vadd[5].A*1.)}
(assert (= sc_67 (* sc_65 1.)))
; 
; =  {of.vadd[5].OUT} {0.}
(assert (= of_67 0.))
; no scale
(assert (= sc_63 1.))
; no scale
(assert (= 1. 1.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_63 0.))
; no offset
(assert (= of_68 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_64 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_66 0.))
; 
; =  {sc.vadd[5].A} {(1.*sc.vadd[5].B)}
(assert (= sc_65 (* 1. sc_66)))
; 
; =  {sc.vadd[5].A} {(1.*sc.vadd[5].C)} {(1.*sc.vadd[5].D*sc.vadd[5].OUT2)}
(assert (and (= sc_65 (* 1. sc_64)) (= sc_65 (* (* 1. sc_63) sc_68))))
; no offset
(assert (= (- (+ of_65 0.) (+ 0. 0.)) 0.))
; no offset
(assert (= 0. 0.))
; 
; =  {sc.vadd[5].OUT2} {(sc.vadd[5].A*1.)}
(assert (= sc_68 (* sc_65 1.)))
; no offset
(assert (= of_68 0.))
; no offset
(assert (= 0. 0.))
; 
; =  {sc.vadd[5].OUT2_0} {(sc.vadd[5].A*1.)}
(assert (= sc_62 (* sc_65 1.)))
; 
; =  {of.vadd[5].OUT2_0} {0.}
(assert (= of_62 0.))
; 
; >=  {((sc.vadd[5].OUT2_0*0.)+of.vadd[5].OUT2_0)} {3300.}
(assert (<= (+ (* sc_62 0.) of_62) 3300.))
; 
; <=  {((sc.vadd[5].OUT2_0*0.)+of.vadd[5].OUT2_0)} {0.}
(assert (>= (+ (* sc_62 0.) of_62) 0.))
; 
; >=  {((sc.vadd[5].D*4.)+of.vadd[5].D)} {3300.}
(assert (<= (+ (* sc_63 4.) of_63) 3300.))
; 
; <=  {((sc.vadd[5].D*4.)+of.vadd[5].D)} {0.}
(assert (>= (+ (* sc_63 4.) of_63) 0.))
; 
; >=  {((sc.vadd[5].C*0.)+of.vadd[5].C)} {3300.}
(assert (<= (+ (* sc_64 0.) of_64) 3300.))
; 
; <=  {((sc.vadd[5].C*0.)+of.vadd[5].C)} {0.}
(assert (>= (+ (* sc_64 0.) of_64) 0.))
; 
; >=  {((sc.vadd[5].A*0.)+of.vadd[5].A)} {3300.}
(assert (<= (+ (* sc_65 0.) of_65) 3300.))
; 
; <=  {((sc.vadd[5].A*0.)+of.vadd[5].A)} {0.}
(assert (>= (+ (* sc_65 0.) of_65) 0.))
(declare-fun slbot_68 () Real)
(declare-fun sltop_68 () Real)
; 
; =  {(((sc.vadd[5].OUT2*0.)+of.vadd[5].OUT2)+sl.min.vadd[5].OUT2)} {0.}
(assert (= (+ (+ (* sc_68 0.) of_68) slbot_68) 0.))
; 
; =  {(((sc.vadd[5].OUT2*15.6)+of.vadd[5].OUT2)+sl.max.vadd[5].OUT2)} {3300.}
(assert (= (+ (+ (* sc_68 15.6) of_68) sltop_68) 3300.))
(declare-fun slbot_66 () Real)
(declare-fun sltop_66 () Real)
; 
; =  {(((sc.vadd[5].B*0.00204799328914)+of.vadd[5].B)+sl.min.vadd[5].B)} {0.}
(assert (= (+ (+ (* sc_66 0.00204799328914) of_66) slbot_66) 0.))
; 
; =  {(((sc.vadd[5].B*625.)+of.vadd[5].B)+sl.max.vadd[5].B)} {3300.}
(assert (= (+ (+ (* sc_66 625.) of_66) sltop_66) 3300.))
(declare-fun slbot_67 () Real)
(declare-fun sltop_67 () Real)
; 
; =  {(((sc.vadd[5].OUT*0.00204799328914)+of.vadd[5].OUT)+sl.min.vadd[5].OUT)} {-1650.}
(assert (= (+ (+ (* sc_67 0.00204799328914) of_67) slbot_67) -1650.))
; 
; =  {(((sc.vadd[5].OUT*625.)+of.vadd[5].OUT)+sl.max.vadd[5].OUT)} {1650.}
(assert (= (+ (+ (* sc_67 625.) of_67) sltop_67) 1650.))
(declare-fun slbot_68 () Real)
(declare-fun sltop_68 () Real)
; 
; =  {(((sc.vadd[5].OUT2*0.)+of.vadd[5].OUT2)+sl.min.vadd[5].OUT2)} {0.}
(assert (= (+ (+ (* sc_68 0.) of_68) slbot_68) 0.))
; 
; =  {(((sc.vadd[5].OUT2*15.6)+of.vadd[5].OUT2)+sl.max.vadd[5].OUT2)} {3300.}
(assert (= (+ (+ (* sc_68 15.6) of_68) sltop_68) 3300.))
(declare-fun sc_69 () Real)
(assert (> sc_69 1e-08))
(declare-fun of_69 () Real)
(declare-fun sc_70 () Real)
(assert (> sc_70 1e-08))
(declare-fun of_70 () Real)
(declare-fun sc_71 () Real)
(assert (> sc_71 1e-08))
(declare-fun of_71 () Real)
(declare-fun sc_72 () Real)
(assert (> sc_72 1e-08))
(declare-fun of_72 () Real)
(declare-fun sc_73 () Real)
(assert (> sc_73 1e-08))
(declare-fun of_73 () Real)
(declare-fun sc_74 () Real)
(assert (> sc_74 1e-08))
(declare-fun of_74 () Real)
; no offset
(assert (= of_70 0.))
; no offset
(assert (= of_71 0.))
; no scale
(assert (= (/ sc_70 sc_71) 1.))
; no scale
(assert (= sc_69 1.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_69 0.))
; no offset
(assert (= of_70 0.))
; no offset
(assert (= of_71 0.))
; no scale
(assert (= (/ sc_70 sc_71) 1.))
; no scale
(assert (= sc_69 1.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_69 0.))
; 
; =  {1.} {1.}
(assert (= 1. 1.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_72 0.))
; no offset
(assert (= 0. 0.))
; 
; =  {sc.ihill[0].STIM} {(sc.ihill[0].Vmax*(1./1.))}
(assert (= sc_73 (* sc_72 (/ 1. 1.))))
; 
; =  {of.ihill[0].STIM} {0.}
(assert (= of_73 0.))
; no scale
(assert (= sc_71 1.))
; no scale
(assert (= (* sc_69 1.) 1.))
; no offset
(assert (= of_71 0.))
; no offset
(assert (= 0. 0.))
; no scale
(assert (= sc_71 1.))
; no scale
(assert (= (* sc_69 1.) 1.))
; no offset
(assert (= of_71 0.))
; no offset
(assert (= 0. 0.))
; no scale
(assert (= sc_70 1.))
; no scale
(assert (= sc_69 1.))
; no offset
(assert (= of_70 0.))
; no offset
(assert (= of_69 0.))
; 
; =  {1.} {1.}
(assert (= 1. 1.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_72 0.))
; no offset
(assert (= 0. 0.))
; 
; =  {sc.ihill[0].REP} {(sc.ihill[0].Vmax*(1./1.))}
(assert (= sc_74 (* sc_72 (/ 1. 1.))))
; 
; =  {of.ihill[0].REP} {0.}
(assert (= of_74 0.))
; 
; >=  {((sc.ihill[0].n*2.5)+of.ihill[0].n)} {5.}
(assert (<= (+ (* sc_69 2.5) of_69) 5.))
; 
; <=  {((sc.ihill[0].n*2.5)+of.ihill[0].n)} {1.}
(assert (>= (+ (* sc_69 2.5) of_69) 1.))
(declare-fun slbot_70 () Real)
(declare-fun sltop_70 () Real)
; 
; =  {(((sc.ihill[0].S*0.)+of.ihill[0].S)+sl.min.ihill[0].S)} {1.}
(assert (= (+ (+ (* sc_70 0.) of_70) slbot_70) 1.))
; 
; =  {(((sc.ihill[0].S*156.25)+of.ihill[0].S)+sl.max.ihill[0].S)} {10.}
(assert (= (+ (+ (* sc_70 156.25) of_70) sltop_70) 10.))
(declare-fun slbot_74 () Real)
(declare-fun sltop_74 () Real)
; 
; =  {(((sc.ihill[0].REP*0.000511998322284)+of.ihill[0].REP)+sl.min.ihill[0].REP)} {9.999900001e-10}
(assert (= (+ (+ (* sc_74 0.000511998322284) of_74) slbot_74) 9.999900001e-10))
; 
; =  {(((sc.ihill[0].REP*156.25)+of.ihill[0].REP)+sl.max.ihill[0].REP)} {5.}
(assert (= (+ (+ (* sc_74 156.25) of_74) sltop_74) 5.))
; 
; >=  {((sc.ihill[0].Vmax*156.25)+of.ihill[0].Vmax)} {10.}
(assert (<= (+ (* sc_72 156.25) of_72) 10.))
; 
; <=  {((sc.ihill[0].Vmax*156.25)+of.ihill[0].Vmax)} {0.0001}
(assert (>= (+ (* sc_72 156.25) of_72) 0.0001))
(declare-fun sc_75 () Real)
(assert (> sc_75 1e-08))
(declare-fun of_75 () Real)
(declare-fun sc_76 () Real)
(assert (> sc_76 1e-08))
(declare-fun of_76 () Real)
(declare-fun sc_77 () Real)
(assert (> sc_77 1e-08))
(declare-fun of_77 () Real)
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_76 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_75 0.))
; 
; =  {sc.vtoi[0].Y} {((1./sc.vtoi[0].K)*sc.vtoi[0].X)}
(assert (= sc_77 (* (/ 1. sc_76) sc_75)))
; 
; =  {of.vtoi[0].Y} {0.}
(assert (= of_77 0.))
(declare-fun slbot_75 () Real)
(declare-fun sltop_75 () Real)
; 
; =  {(((sc.vtoi[0].X*0.)+of.vtoi[0].X)+sl.min.vtoi[0].X)} {1.}
(assert (= (+ (+ (* sc_75 0.) of_75) slbot_75) 1.))
; 
; =  {(((sc.vtoi[0].X*156.25)+of.vtoi[0].X)+sl.max.vtoi[0].X)} {3300.}
(assert (= (+ (+ (* sc_75 156.25) of_75) sltop_75) 3300.))
; 
; >=  {((sc.vtoi[0].K*1.)+of.vtoi[0].K)} {3300.}
(assert (<= (+ (* sc_76 1.) of_76) 3300.))
; 
; <=  {((sc.vtoi[0].K*1.)+of.vtoi[0].K)} {1.}
(assert (>= (+ (* sc_76 1.) of_76) 1.))
(declare-fun slbot_77 () Real)
(declare-fun sltop_77 () Real)
; 
; =  {(((sc.vtoi[0].Y*0.)+of.vtoi[0].Y)+sl.min.vtoi[0].Y)} {0.00030303030303}
(assert (= (+ (+ (* sc_77 0.) of_77) slbot_77) 0.00030303030303))
; 
; =  {(((sc.vtoi[0].Y*156.25)+of.vtoi[0].Y)+sl.max.vtoi[0].Y)} {3300.}
(assert (= (+ (+ (* sc_77 156.25) of_77) sltop_77) 3300.))
(declare-fun sc_78 () Real)
(assert (> sc_78 1e-08))
(declare-fun of_78 () Real)
(declare-fun sc_79 () Real)
(assert (> sc_79 1e-08))
(declare-fun of_79 () Real)
(declare-fun sc_80 () Real)
(assert (> sc_80 1e-08))
(declare-fun of_80 () Real)
(declare-fun sc_81 () Real)
(assert (> sc_81 1e-08))
(declare-fun of_81 () Real)
; no offset
(assert (= of_79 0.))
; no offset
(assert (= of_78 0.))
; 
; =  {1.} {(sc.igenebind[10].K*sc.igenebind[10].TF)}
(assert (= 1. (* sc_79 sc_78)))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_80 0.))
; no offset
(assert (= 0. 0.))
; 
; =  {sc.igenebind[10].GE} {(sc.igenebind[10].Vmax*(1./1.))}
(assert (= sc_81 (* sc_80 (/ 1. 1.))))
; 
; =  {of.igenebind[10].GE} {0.}
(assert (= of_81 0.))
(declare-fun slbot_78 () Real)
(declare-fun sltop_78 () Real)
; 
; =  {(((sc.igenebind[10].TF*-1.)+of.igenebind[10].TF)+sl.min.igenebind[10].TF)} {0.0001}
(assert (= (+ (+ (* sc_78 -1.) of_78) slbot_78) 0.0001))
; 
; =  {(((sc.igenebind[10].TF*-0.4)+of.igenebind[10].TF)+sl.max.igenebind[10].TF)} {10.}
(assert (= (+ (+ (* sc_78 -0.4) of_78) sltop_78) 10.))
; 
; >=  {((sc.igenebind[10].K*1.)+of.igenebind[10].K)} {10.}
(assert (<= (+ (* sc_79 1.) of_79) 10.))
; 
; <=  {((sc.igenebind[10].K*1.)+of.igenebind[10].K)} {0.0001}
(assert (>= (+ (* sc_79 1.) of_79) 0.0001))
(declare-fun slbot_81 () Real)
(declare-fun sltop_81 () Real)
; 
; =  {(((sc.igenebind[10].GE*0.)+of.igenebind[10].GE)+sl.min.igenebind[10].GE)} {9.90099009901e-07}
(assert (= (+ (+ (* sc_81 0.) of_81) slbot_81) 9.90099009901e-07))
; 
; =  {(((sc.igenebind[10].GE*1.66666666667)+of.igenebind[10].GE)+sl.max.igenebind[10].GE)} {9.9999999}
(assert (= (+ (+ (* sc_81 1.66666666667) of_81) sltop_81) 9.9999999))
; 
; >=  {((sc.igenebind[10].Vmax*1.)+of.igenebind[10].Vmax)} {10.}
(assert (<= (+ (* sc_80 1.) of_80) 10.))
; 
; <=  {((sc.igenebind[10].Vmax*1.)+of.igenebind[10].Vmax)} {0.0001}
(assert (>= (+ (* sc_80 1.) of_80) 0.0001))
(declare-fun slbot_81 () Real)
(declare-fun sltop_81 () Real)
; 
; =  {(((sc.igenebind[10].GE*0.)+of.igenebind[10].GE)+sl.min.igenebind[10].GE)} {9.90099009901e-07}
(assert (= (+ (+ (* sc_81 0.) of_81) slbot_81) 9.90099009901e-07))
; 
; =  {(((sc.igenebind[10].GE*1.66666666667)+of.igenebind[10].GE)+sl.max.igenebind[10].GE)} {9.9999999}
(assert (= (+ (+ (* sc_81 1.66666666667) of_81) sltop_81) 9.9999999))
(declare-fun sc_82 () Real)
(assert (> sc_82 1e-08))
(declare-fun of_82 () Real)
(declare-fun sc_83 () Real)
(assert (> sc_83 1e-08))
(declare-fun of_83 () Real)
(declare-fun sc_84 () Real)
(assert (> sc_84 1e-08))
(declare-fun of_84 () Real)
(declare-fun sc_85 () Real)
(assert (> sc_85 1e-08))
(declare-fun of_85 () Real)
; no offset
(assert (= of_83 0.))
; no offset
(assert (= of_82 0.))
; 
; =  {1.} {(sc.igenebind[3].K*sc.igenebind[3].TF)}
(assert (= 1. (* sc_83 sc_82)))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= 0. 0.))
; no offset
(assert (= of_84 0.))
; no offset
(assert (= 0. 0.))
; 
; =  {sc.igenebind[3].GE} {(sc.igenebind[3].Vmax*(1./1.))}
(assert (= sc_85 (* sc_84 (/ 1. 1.))))
; 
; =  {of.igenebind[3].GE} {0.}
(assert (= of_85 0.))
; 
; >=  {((sc.igenebind[3].TF*1.)+of.igenebind[3].TF)} {10.}
(assert (<= (+ (* sc_82 1.) of_82) 10.))
; 
; <=  {((sc.igenebind[3].TF*1.)+of.igenebind[3].TF)} {0.0001}
(assert (>= (+ (* sc_82 1.) of_82) 0.0001))
(declare-fun slbot_83 () Real)
(declare-fun sltop_83 () Real)
; 
; =  {(((sc.igenebind[3].K*0.)+of.igenebind[3].K)+sl.min.igenebind[3].K)} {0.0001}
(assert (= (+ (+ (* sc_83 0.) of_83) slbot_83) 0.0001))
; 
; =  {(((sc.igenebind[3].K*15.6)+of.igenebind[3].K)+sl.max.igenebind[3].K)} {10.}
(assert (= (+ (+ (* sc_83 15.6) of_83) sltop_83) 10.))
(declare-fun slbot_85 () Real)
(declare-fun sltop_85 () Real)
; 
; =  {(((sc.igenebind[3].GE*0.939759036145)+of.igenebind[3].GE)+sl.min.igenebind[3].GE)} {9.90099009901e-07}
(assert (= (+ (+ (* sc_85 0.939759036145) of_85) slbot_85) 9.90099009901e-07))
; 
; =  {(((sc.igenebind[3].GE*15.6)+of.igenebind[3].GE)+sl.max.igenebind[3].GE)} {9.9999999}
(assert (= (+ (+ (* sc_85 15.6) of_85) sltop_85) 9.9999999))
; 
; >=  {((sc.igenebind[3].Vmax*15.6)+of.igenebind[3].Vmax)} {10.}
(assert (<= (+ (* sc_84 15.6) of_84) 10.))
; 
; <=  {((sc.igenebind[3].Vmax*15.6)+of.igenebind[3].Vmax)} {0.0001}
(assert (>= (+ (* sc_84 15.6) of_84) 0.0001))
(declare-fun sc_86 () Real)
(assert (> sc_86 1e-08))
(declare-fun of_86 () Real)
(declare-fun sc_87 () Real)
(assert (> sc_87 1e-08))
(declare-fun of_87 () Real)
; 
; =  {sc.input.V[2].O} {sc.input.V[2].X}
(assert (= sc_87 sc_86))
; 
; =  {of.input.V[2].O} {of.input.V[2].X}
(assert (= of_87 of_86))
; 
; >=  {((sc.input.V[2].X*0.)+of.input.V[2].X)} {3300.}
(assert (<= (+ (* sc_86 0.) of_86) 3300.))
; 
; <=  {((sc.input.V[2].X*0.)+of.input.V[2].X)} {0.}
(assert (>= (+ (* sc_86 0.) of_86) 0.))
; 
; >=  {((sc.input.V[2].O*0.)+of.input.V[2].O)} {3300.}
(assert (<= (+ (* sc_87 0.) of_87) 3300.))
; 
; <=  {((sc.input.V[2].O*0.)+of.input.V[2].O)} {0.}
(assert (>= (+ (* sc_87 0.) of_87) 0.))
(declare-fun sc_88 () Real)
(assert (> sc_88 1e-08))
(declare-fun of_88 () Real)
(declare-fun sc_89 () Real)
(assert (> sc_89 1e-08))
(declare-fun of_89 () Real)
; 
; =  {sc.input.V[8].O} {sc.input.V[8].X}
(assert (= sc_89 sc_88))
; 
; =  {of.input.V[8].O} {of.input.V[8].X}
(assert (= of_89 of_88))
; 
; >=  {((sc.input.V[8].X*4.)+of.input.V[8].X)} {3300.}
(assert (<= (+ (* sc_88 4.) of_88) 3300.))
; 
; <=  {((sc.input.V[8].X*4.)+of.input.V[8].X)} {0.}
(assert (>= (+ (* sc_88 4.) of_88) 0.))
; 
; >=  {((sc.input.V[8].O*4.)+of.input.V[8].O)} {3300.}
(assert (<= (+ (* sc_89 4.) of_89) 3300.))
; 
; <=  {((sc.input.V[8].O*4.)+of.input.V[8].O)} {0.}
(assert (>= (+ (* sc_89 4.) of_89) 0.))
(declare-fun sc_90 () Real)
(assert (> sc_90 1e-08))
(declare-fun of_90 () Real)
(declare-fun sc_91 () Real)
(assert (> sc_91 1e-08))
(declare-fun of_91 () Real)
; 
; =  {sc.input.V[7].O} {sc.input.V[7].X}
(assert (= sc_91 sc_90))
; 
; =  {of.input.V[7].O} {of.input.V[7].X}
(assert (= of_91 of_90))
; 
; >=  {((sc.input.V[7].X*4.)+of.input.V[7].X)} {3300.}
(assert (<= (+ (* sc_90 4.) of_90) 3300.))
; 
; <=  {((sc.input.V[7].X*4.)+of.input.V[7].X)} {0.}
(assert (>= (+ (* sc_90 4.) of_90) 0.))
; 
; >=  {((sc.input.V[7].O*4.)+of.input.V[7].O)} {3300.}
(assert (<= (+ (* sc_91 4.) of_91) 3300.))
; 
; <=  {((sc.input.V[7].O*4.)+of.input.V[7].O)} {0.}
(assert (>= (+ (* sc_91 4.) of_91) 0.))
(declare-fun sc_92 () Real)
(assert (> sc_92 1e-08))
(declare-fun of_92 () Real)
(declare-fun sc_93 () Real)
(assert (> sc_93 1e-08))
(declare-fun of_93 () Real)
; 
; =  {sc.input.V[12].O} {sc.input.V[12].X}
(assert (= sc_93 sc_92))
; 
; =  {of.input.V[12].O} {of.input.V[12].X}
(assert (= of_93 of_92))
; 
; >=  {((sc.input.V[12].X*1.)+of.input.V[12].X)} {3300.}
(assert (<= (+ (* sc_92 1.) of_92) 3300.))
; 
; <=  {((sc.input.V[12].X*1.)+of.input.V[12].X)} {0.}
(assert (>= (+ (* sc_92 1.) of_92) 0.))
; 
; >=  {((sc.input.V[12].O*1.)+of.input.V[12].O)} {3300.}
(assert (<= (+ (* sc_93 1.) of_93) 3300.))
; 
; <=  {((sc.input.V[12].O*1.)+of.input.V[12].O)} {0.}
(assert (>= (+ (* sc_93 1.) of_93) 0.))
(declare-fun sc_94 () Real)
(assert (> sc_94 1e-08))
(declare-fun of_94 () Real)
(declare-fun sc_95 () Real)
(assert (> sc_95 1e-08))
(declare-fun of_95 () Real)
; 
; =  {sc.input.V[9].O} {sc.input.V[9].X}
(assert (= sc_95 sc_94))
; 
; =  {of.input.V[9].O} {of.input.V[9].X}
(assert (= of_95 of_94))
; 
; >=  {((sc.input.V[9].X*4.)+of.input.V[9].X)} {3300.}
(assert (<= (+ (* sc_94 4.) of_94) 3300.))
; 
; <=  {((sc.input.V[9].X*4.)+of.input.V[9].X)} {0.}
(assert (>= (+ (* sc_94 4.) of_94) 0.))
; 
; >=  {((sc.input.V[9].O*4.)+of.input.V[9].O)} {3300.}
(assert (<= (+ (* sc_95 4.) of_95) 3300.))
; 
; <=  {((sc.input.V[9].O*4.)+of.input.V[9].O)} {0.}
(assert (>= (+ (* sc_95 4.) of_95) 0.))
(declare-fun sc_96 () Real)
(assert (> sc_96 1e-08))
(declare-fun of_96 () Real)
(declare-fun sc_97 () Real)
(assert (> sc_97 1e-08))
(declare-fun of_97 () Real)
; 
; =  {sc.input.V[0].O} {sc.input.V[0].X}
(assert (= sc_97 sc_96))
; 
; =  {of.input.V[0].O} {of.input.V[0].X}
(assert (= of_97 of_96))
; 
; >=  {((sc.input.V[0].X*2.5)+of.input.V[0].X)} {3300.}
(assert (<= (+ (* sc_96 2.5) of_96) 3300.))
; 
; <=  {((sc.input.V[0].X*2.5)+of.input.V[0].X)} {0.}
(assert (>= (+ (* sc_96 2.5) of_96) 0.))
; 
; >=  {((sc.input.V[0].O*2.5)+of.input.V[0].O)} {3300.}
(assert (<= (+ (* sc_97 2.5) of_97) 3300.))
; 
; <=  {((sc.input.V[0].O*2.5)+of.input.V[0].O)} {0.}
(assert (>= (+ (* sc_97 2.5) of_97) 0.))
(declare-fun sc_98 () Real)
(assert (> sc_98 1e-08))
(declare-fun of_98 () Real)
(declare-fun sc_99 () Real)
(assert (> sc_99 1e-08))
(declare-fun of_99 () Real)
; 
; =  {sc.input.V[10].O} {sc.input.V[10].X}
(assert (= sc_99 sc_98))
; 
; =  {of.input.V[10].O} {of.input.V[10].X}
(assert (= of_99 of_98))
; 
; >=  {((sc.input.V[10].X*1000.75)+of.input.V[10].X)} {3300.}
(assert (<= (+ (* sc_98 1000.75) of_98) 3300.))
; 
; <=  {((sc.input.V[10].X*1000.75)+of.input.V[10].X)} {0.}
(assert (>= (+ (* sc_98 1000.75) of_98) 0.))
; 
; >=  {((sc.input.V[10].O*1000.75)+of.input.V[10].O)} {3300.}
(assert (<= (+ (* sc_99 1000.75) of_99) 3300.))
; 
; <=  {((sc.input.V[10].O*1000.75)+of.input.V[10].O)} {0.}
(assert (>= (+ (* sc_99 1000.75) of_99) 0.))
(declare-fun sc_100 () Real)
(assert (> sc_100 1e-08))
(declare-fun of_100 () Real)
(declare-fun sc_101 () Real)
(assert (> sc_101 1e-08))
(declare-fun of_101 () Real)
; 
; =  {sc.input.V[6].O} {sc.input.V[6].X}
(assert (= sc_101 sc_100))
; 
; =  {of.input.V[6].O} {of.input.V[6].X}
(assert (= of_101 of_100))
; 
; >=  {((sc.input.V[6].X*0.)+of.input.V[6].X)} {3300.}
(assert (<= (+ (* sc_100 0.) of_100) 3300.))
; 
; <=  {((sc.input.V[6].X*0.)+of.input.V[6].X)} {0.}
(assert (>= (+ (* sc_100 0.) of_100) 0.))
; 
; >=  {((sc.input.V[6].O*0.)+of.input.V[6].O)} {3300.}
(assert (<= (+ (* sc_101 0.) of_101) 3300.))
; 
; <=  {((sc.input.V[6].O*0.)+of.input.V[6].O)} {0.}
(assert (>= (+ (* sc_101 0.) of_101) 0.))
(declare-fun sc_102 () Real)
(assert (> sc_102 1e-08))
(declare-fun of_102 () Real)
(declare-fun sc_103 () Real)
(assert (> sc_103 1e-08))
(declare-fun of_103 () Real)
; 
; =  {sc.input.V[3].O} {sc.input.V[3].X}
(assert (= sc_103 sc_102))
; 
; =  {of.input.V[3].O} {of.input.V[3].X}
(assert (= of_103 of_102))
; 
; >=  {((sc.input.V[3].X*0.)+of.input.V[3].X)} {3300.}
(assert (<= (+ (* sc_102 0.) of_102) 3300.))
; 
; <=  {((sc.input.V[3].X*0.)+of.input.V[3].X)} {0.}
(assert (>= (+ (* sc_102 0.) of_102) 0.))
; 
; >=  {((sc.input.V[3].O*0.)+of.input.V[3].O)} {3300.}
(assert (<= (+ (* sc_103 0.) of_103) 3300.))
; 
; <=  {((sc.input.V[3].O*0.)+of.input.V[3].O)} {0.}
(assert (>= (+ (* sc_103 0.) of_103) 0.))
(declare-fun sc_104 () Real)
(assert (> sc_104 1e-08))
(declare-fun of_104 () Real)
(declare-fun sc_105 () Real)
(assert (> sc_105 1e-08))
(declare-fun of_105 () Real)
; 
; =  {sc.input.V[4].O} {sc.input.V[4].X}
(assert (= sc_105 sc_104))
; 
; =  {of.input.V[4].O} {of.input.V[4].X}
(assert (= of_105 of_104))
; 
; >=  {((sc.input.V[4].X*0.)+of.input.V[4].X)} {3300.}
(assert (<= (+ (* sc_104 0.) of_104) 3300.))
; 
; <=  {((sc.input.V[4].X*0.)+of.input.V[4].X)} {0.}
(assert (>= (+ (* sc_104 0.) of_104) 0.))
; 
; >=  {((sc.input.V[4].O*0.)+of.input.V[4].O)} {3300.}
(assert (<= (+ (* sc_105 0.) of_105) 3300.))
; 
; <=  {((sc.input.V[4].O*0.)+of.input.V[4].O)} {0.}
(assert (>= (+ (* sc_105 0.) of_105) 0.))
(declare-fun sc_106 () Real)
(assert (> sc_106 1e-08))
(declare-fun of_106 () Real)
(declare-fun sc_107 () Real)
(assert (> sc_107 1e-08))
(declare-fun of_107 () Real)
; 
; =  {sc.input.V[5].O} {sc.input.V[5].X}
(assert (= sc_107 sc_106))
; 
; =  {of.input.V[5].O} {of.input.V[5].X}
(assert (= of_107 of_106))
; 
; >=  {((sc.input.V[5].X*0.)+of.input.V[5].X)} {3300.}
(assert (<= (+ (* sc_106 0.) of_106) 3300.))
; 
; <=  {((sc.input.V[5].X*0.)+of.input.V[5].X)} {0.}
(assert (>= (+ (* sc_106 0.) of_106) 0.))
; 
; >=  {((sc.input.V[5].O*0.)+of.input.V[5].O)} {3300.}
(assert (<= (+ (* sc_107 0.) of_107) 3300.))
; 
; <=  {((sc.input.V[5].O*0.)+of.input.V[5].O)} {0.}
(assert (>= (+ (* sc_107 0.) of_107) 0.))
(declare-fun sc_108 () Real)
(assert (> sc_108 1e-08))
(declare-fun of_108 () Real)
(declare-fun sc_109 () Real)
(assert (> sc_109 1e-08))
(declare-fun of_109 () Real)
; 
; =  {sc.input.V[1].O} {sc.input.V[1].X}
(assert (= sc_109 sc_108))
; 
; =  {of.input.V[1].O} {of.input.V[1].X}
(assert (= of_109 of_108))
; 
; >=  {((sc.input.V[1].X*0.)+of.input.V[1].X)} {3300.}
(assert (<= (+ (* sc_108 0.) of_108) 3300.))
; 
; <=  {((sc.input.V[1].X*0.)+of.input.V[1].X)} {0.}
(assert (>= (+ (* sc_108 0.) of_108) 0.))
; 
; >=  {((sc.input.V[1].O*0.)+of.input.V[1].O)} {3300.}
(assert (<= (+ (* sc_109 0.) of_109) 3300.))
; 
; <=  {((sc.input.V[1].O*0.)+of.input.V[1].O)} {0.}
(assert (>= (+ (* sc_109 0.) of_109) 0.))
(declare-fun sc_110 () Real)
(assert (> sc_110 1e-08))
(declare-fun of_110 () Real)
(declare-fun sc_111 () Real)
(assert (> sc_111 1e-08))
(declare-fun of_111 () Real)
(declare-fun sc_112 () Real)
(assert (> sc_112 1e-08))
(declare-fun of_112 () Real)
; no offset
(assert (= of_111 0.))
; no offset
(assert (= of_110 0.))
; 
; =  {sc.itov[4].Y} {(sc.itov[4].K*sc.itov[4].X)}
(assert (= sc_112 (* sc_111 sc_110)))
; 
; =  {of.itov[4].Y} {0.}
(assert (= of_112 0.))
(declare-fun slbot_110 () Real)
(declare-fun sltop_110 () Real)
; 
; =  {(((sc.itov[4].X*0.000511998322284)+of.itov[4].X)+sl.min.itov[4].X)} {0.0001}
(assert (= (+ (+ (* sc_110 0.000511998322284) of_110) slbot_110) 0.0001))
; 
; =  {(((sc.itov[4].X*156.25)+of.itov[4].X)+sl.max.itov[4].X)} {10.}
(assert (= (+ (+ (* sc_110 156.25) of_110) sltop_110) 10.))
(declare-fun slbot_112 () Real)
(declare-fun sltop_112 () Real)
; 
; =  {(((sc.itov[4].Y*0.00204799328914)+of.itov[4].Y)+sl.min.itov[4].Y)} {0.0001}
(assert (= (+ (+ (* sc_112 0.00204799328914) of_112) slbot_112) 0.0001))
; 
; =  {(((sc.itov[4].Y*625.)+of.itov[4].Y)+sl.max.itov[4].Y)} {3300.}
(assert (= (+ (+ (* sc_112 625.) of_112) sltop_112) 3300.))
; 
; >=  {((sc.itov[4].K*4.)+of.itov[4].K)} {330.}
(assert (<= (+ (* sc_111 4.) of_111) 330.))
; 
; <=  {((sc.itov[4].K*4.)+of.itov[4].K)} {1.}
(assert (>= (+ (* sc_111 4.) of_111) 1.))
(declare-fun slbot_112 () Real)
(declare-fun sltop_112 () Real)
; 
; =  {(((sc.itov[4].Y*0.00204799328914)+of.itov[4].Y)+sl.min.itov[4].Y)} {0.0001}
(assert (= (+ (+ (* sc_112 0.00204799328914) of_112) slbot_112) 0.0001))
; 
; =  {(((sc.itov[4].Y*625.)+of.itov[4].Y)+sl.max.itov[4].Y)} {3300.}
(assert (= (+ (+ (* sc_112 625.) of_112) sltop_112) 3300.))
(declare-fun sc_113 () Real)
(assert (> sc_113 1e-08))
(declare-fun of_113 () Real)
(declare-fun sc_114 () Real)
(assert (> sc_114 1e-08))
(declare-fun of_114 () Real)
(declare-fun sc_115 () Real)
(assert (> sc_115 1e-08))
(declare-fun of_115 () Real)
; no offset
(assert (= of_114 0.))
; no offset
(assert (= of_113 0.))
; 
; =  {sc.itov[1].Y} {(sc.itov[1].K*sc.itov[1].X)}
(assert (= sc_115 (* sc_114 sc_113)))
; 
; =  {of.itov[1].Y} {0.}
(assert (= of_115 0.))
; 
; >=  {((sc.itov[1].X*4.)+of.itov[1].X)} {10.}
(assert (<= (+ (* sc_113 4.) of_113) 10.))
; 
; <=  {((sc.itov[1].X*4.)+of.itov[1].X)} {0.0001}
(assert (>= (+ (* sc_113 4.) of_113) 0.0001))
(declare-fun slbot_115 () Real)
(declare-fun sltop_115 () Real)
; 
; =  {(((sc.itov[1].Y*3.75903614458)+of.itov[1].Y)+sl.min.itov[1].Y)} {0.0001}
(assert (= (+ (+ (* sc_115 3.75903614458) of_115) slbot_115) 0.0001))
; 
; =  {(((sc.itov[1].Y*62.4)+of.itov[1].Y)+sl.max.itov[1].Y)} {3300.}
(assert (= (+ (+ (* sc_115 62.4) of_115) sltop_115) 3300.))
(declare-fun slbot_114 () Real)
(declare-fun sltop_114 () Real)
; 
; =  {(((sc.itov[1].K*0.939759036145)+of.itov[1].K)+sl.min.itov[1].K)} {1.}
(assert (= (+ (+ (* sc_114 0.939759036145) of_114) slbot_114) 1.))
; 
; =  {(((sc.itov[1].K*15.6)+of.itov[1].K)+sl.max.itov[1].K)} {330.}
(assert (= (+ (+ (* sc_114 15.6) of_114) sltop_114) 330.))
(declare-fun slbot_115 () Real)
(declare-fun sltop_115 () Real)
; 
; =  {(((sc.itov[1].Y*3.75903614458)+of.itov[1].Y)+sl.min.itov[1].Y)} {0.0001}
(assert (= (+ (+ (* sc_115 3.75903614458) of_115) slbot_115) 0.0001))
; 
; =  {(((sc.itov[1].Y*62.4)+of.itov[1].Y)+sl.max.itov[1].Y)} {3300.}
(assert (= (+ (+ (* sc_115 62.4) of_115) sltop_115) 3300.))
(declare-fun sc_116 () Real)
(assert (> sc_116 1e-08))
(declare-fun of_116 () Real)
(declare-fun sc_117 () Real)
(assert (> sc_117 1e-08))
(declare-fun of_117 () Real)
(declare-fun sc_118 () Real)
(assert (> sc_118 1e-08))
(declare-fun of_118 () Real)
(declare-fun sc_119 () Real)
(assert (> sc_119 1e-08))
(declare-fun of_119 () Real)
(declare-fun sc_120 () Real)
(assert (> sc_120 1e-08))
(declare-fun of_120 () Real)
; 
; =  {sc.iadd[8].A} {sc.iadd[8].B}
(assert (= sc_118 sc_119))
; 
; =  {sc.iadd[8].A} {sc.iadd[8].C} {sc.iadd[8].D}
(assert (and (= sc_118 sc_117) (= sc_118 sc_116)))
; 
; =  {sc.iadd[8].OUT} {sc.iadd[8].A}
(assert (= sc_120 sc_118))
; 
; =  {of.iadd[8].OUT} {((of.iadd[8].A+of.iadd[8].B)-of.iadd[8].C-of.iadd[8].D)}
(assert (= of_120 (- (+ of_118 of_119) (+ of_117 of_116))))
; 
; >=  {((sc.iadd[8].D*0.)+of.iadd[8].D)} {5.}
(assert (<= (+ (* sc_116 0.) of_116) 5.))
; 
; <=  {((sc.iadd[8].D*0.)+of.iadd[8].D)} {0.}
(assert (>= (+ (* sc_116 0.) of_116) 0.))
; 
; >=  {((sc.iadd[8].C*0.)+of.iadd[8].C)} {5.}
(assert (<= (+ (* sc_117 0.) of_117) 5.))
; 
; <=  {((sc.iadd[8].C*0.)+of.iadd[8].C)} {0.}
(assert (>= (+ (* sc_117 0.) of_117) 0.))
(declare-fun slbot_120 () Real)
(declare-fun sltop_120 () Real)
; 
; =  {(((sc.iadd[8].OUT*0.)+of.iadd[8].OUT)+sl.min.iadd[8].OUT)} {-10.}
(assert (= (+ (+ (* sc_120 0.) of_120) slbot_120) -10.))
; 
; =  {(((sc.iadd[8].OUT*1.66666666667)+of.iadd[8].OUT)+sl.max.iadd[8].OUT)} {10.}
(assert (= (+ (+ (* sc_120 1.66666666667) of_120) sltop_120) 10.))
; 
; >=  {((sc.iadd[8].A*0.)+of.iadd[8].A)} {5.}
(assert (<= (+ (* sc_118 0.) of_118) 5.))
; 
; <=  {((sc.iadd[8].A*0.)+of.iadd[8].A)} {0.}
(assert (>= (+ (* sc_118 0.) of_118) 0.))
(declare-fun slbot_119 () Real)
(declare-fun sltop_119 () Real)
; 
; =  {(((sc.iadd[8].B*0.)+of.iadd[8].B)+sl.min.iadd[8].B)} {0.}
(assert (= (+ (+ (* sc_119 0.) of_119) slbot_119) 0.))
; 
; =  {(((sc.iadd[8].B*1.66666666667)+of.iadd[8].B)+sl.max.iadd[8].B)} {5.}
(assert (= (+ (+ (* sc_119 1.66666666667) of_119) sltop_119) 5.))
(declare-fun slbot_120 () Real)
(declare-fun sltop_120 () Real)
; 
; =  {(((sc.iadd[8].OUT*0.)+of.iadd[8].OUT)+sl.min.iadd[8].OUT)} {-10.}
(assert (= (+ (+ (* sc_120 0.) of_120) slbot_120) -10.))
; 
; =  {(((sc.iadd[8].OUT*1.66666666667)+of.iadd[8].OUT)+sl.max.iadd[8].OUT)} {10.}
(assert (= (+ (+ (* sc_120 1.66666666667) of_120) sltop_120) 10.))
(declare-fun sc_121 () Real)
(assert (> sc_121 1e-08))
(declare-fun of_121 () Real)
(declare-fun sc_122 () Real)
(assert (> sc_122 1e-08))
(declare-fun of_122 () Real)
(declare-fun sc_123 () Real)
(assert (> sc_123 1e-08))
(declare-fun of_123 () Real)
(declare-fun sc_124 () Real)
(assert (> sc_124 1e-08))
(declare-fun of_124 () Real)
(declare-fun sc_125 () Real)
(assert (> sc_125 1e-08))
(declare-fun of_125 () Real)
; 
; =  {sc.iadd[12].A} {sc.iadd[12].B}
(assert (= sc_123 sc_124))
; 
; =  {sc.iadd[12].A} {sc.iadd[12].C} {sc.iadd[12].D}
(assert (and (= sc_123 sc_122) (= sc_123 sc_121)))
; 
; =  {sc.iadd[12].OUT} {sc.iadd[12].A}
(assert (= sc_125 sc_123))
; 
; =  {of.iadd[12].OUT} {((of.iadd[12].A+of.iadd[12].B)-of.iadd[12].C-of.iadd[12].D)}
(assert (= of_125 (- (+ of_123 of_124) (+ of_122 of_121))))
; 
; >=  {((sc.iadd[12].D*0.)+of.iadd[12].D)} {5.}
(assert (<= (+ (* sc_121 0.) of_121) 5.))
; 
; <=  {((sc.iadd[12].D*0.)+of.iadd[12].D)} {0.}
(assert (>= (+ (* sc_121 0.) of_121) 0.))
; 
; >=  {((sc.iadd[12].C*0.)+of.iadd[12].C)} {5.}
(assert (<= (+ (* sc_122 0.) of_122) 5.))
; 
; <=  {((sc.iadd[12].C*0.)+of.iadd[12].C)} {0.}
(assert (>= (+ (* sc_122 0.) of_122) 0.))
; 
; >=  {((sc.iadd[12].A*0.)+of.iadd[12].A)} {5.}
(assert (<= (+ (* sc_123 0.) of_123) 5.))
; 
; <=  {((sc.iadd[12].A*0.)+of.iadd[12].A)} {0.}
(assert (>= (+ (* sc_123 0.) of_123) 0.))
(declare-fun slbot_124 () Real)
(declare-fun sltop_124 () Real)
; 
; =  {(((sc.iadd[12].B*0.)+of.iadd[12].B)+sl.min.iadd[12].B)} {0.}
(assert (= (+ (+ (* sc_124 0.) of_124) slbot_124) 0.))
; 
; =  {(((sc.iadd[12].B*15.6)+of.iadd[12].B)+sl.max.iadd[12].B)} {5.}
(assert (= (+ (+ (* sc_124 15.6) of_124) sltop_124) 5.))
(declare-fun slbot_125 () Real)
(declare-fun sltop_125 () Real)
; 
; =  {(((sc.iadd[12].OUT*0.)+of.iadd[12].OUT)+sl.min.iadd[12].OUT)} {-10.}
(assert (= (+ (+ (* sc_125 0.) of_125) slbot_125) -10.))
; 
; =  {(((sc.iadd[12].OUT*15.6)+of.iadd[12].OUT)+sl.max.iadd[12].OUT)} {10.}
(assert (= (+ (+ (* sc_125 15.6) of_125) sltop_125) 10.))
(declare-fun sc_126 () Real)
(assert (> sc_126 1e-08))
(declare-fun of_126 () Real)
(declare-fun sc_127 () Real)
(assert (> sc_127 1e-08))
(declare-fun of_127 () Real)
(declare-fun sc_128 () Real)
(assert (> sc_128 1e-08))
(declare-fun of_128 () Real)
(declare-fun sc_129 () Real)
(assert (> sc_129 1e-08))
(declare-fun of_129 () Real)
(declare-fun sc_130 () Real)
(assert (> sc_130 1e-08))
(declare-fun of_130 () Real)
; 
; =  {sc.iadd[9].A} {sc.iadd[9].B}
(assert (= sc_128 sc_129))
; 
; =  {sc.iadd[9].A} {sc.iadd[9].C} {sc.iadd[9].D}
(assert (and (= sc_128 sc_127) (= sc_128 sc_126)))
; 
; =  {sc.iadd[9].OUT} {sc.iadd[9].A}
(assert (= sc_130 sc_128))
; 
; =  {of.iadd[9].OUT} {((of.iadd[9].A+of.iadd[9].B)-of.iadd[9].C-of.iadd[9].D)}
(assert (= of_130 (- (+ of_128 of_129) (+ of_127 of_126))))
; 
; >=  {((sc.iadd[9].D*0.)+of.iadd[9].D)} {5.}
(assert (<= (+ (* sc_126 0.) of_126) 5.))
; 
; <=  {((sc.iadd[9].D*0.)+of.iadd[9].D)} {0.}
(assert (>= (+ (* sc_126 0.) of_126) 0.))
; 
; >=  {((sc.iadd[9].C*0.)+of.iadd[9].C)} {5.}
(assert (<= (+ (* sc_127 0.) of_127) 5.))
; 
; <=  {((sc.iadd[9].C*0.)+of.iadd[9].C)} {0.}
(assert (>= (+ (* sc_127 0.) of_127) 0.))
(declare-fun slbot_130 () Real)
(declare-fun sltop_130 () Real)
; 
; =  {(((sc.iadd[9].OUT*0.)+of.iadd[9].OUT)+sl.min.iadd[9].OUT)} {-10.}
(assert (= (+ (+ (* sc_130 0.) of_130) slbot_130) -10.))
; 
; =  {(((sc.iadd[9].OUT*1.66666666667)+of.iadd[9].OUT)+sl.max.iadd[9].OUT)} {10.}
(assert (= (+ (+ (* sc_130 1.66666666667) of_130) sltop_130) 10.))
; 
; >=  {((sc.iadd[9].A*0.)+of.iadd[9].A)} {5.}
(assert (<= (+ (* sc_128 0.) of_128) 5.))
; 
; <=  {((sc.iadd[9].A*0.)+of.iadd[9].A)} {0.}
(assert (>= (+ (* sc_128 0.) of_128) 0.))
(declare-fun slbot_129 () Real)
(declare-fun sltop_129 () Real)
; 
; =  {(((sc.iadd[9].B*0.)+of.iadd[9].B)+sl.min.iadd[9].B)} {0.}
(assert (= (+ (+ (* sc_129 0.) of_129) slbot_129) 0.))
; 
; =  {(((sc.iadd[9].B*1.66666666667)+of.iadd[9].B)+sl.max.iadd[9].B)} {5.}
(assert (= (+ (+ (* sc_129 1.66666666667) of_129) sltop_129) 5.))
(declare-fun slbot_130 () Real)
(declare-fun sltop_130 () Real)
; 
; =  {(((sc.iadd[9].OUT*0.)+of.iadd[9].OUT)+sl.min.iadd[9].OUT)} {-10.}
(assert (= (+ (+ (* sc_130 0.) of_130) slbot_130) -10.))
; 
; =  {(((sc.iadd[9].OUT*1.66666666667)+of.iadd[9].OUT)+sl.max.iadd[9].OUT)} {10.}
(assert (= (+ (+ (* sc_130 1.66666666667) of_130) sltop_130) 10.))
(declare-fun sc_131 () Real)
(assert (> sc_131 1e-08))
(declare-fun of_131 () Real)
(declare-fun sc_132 () Real)
(assert (> sc_132 1e-08))
(declare-fun of_132 () Real)
(declare-fun sc_133 () Real)
(assert (> sc_133 1e-08))
(declare-fun of_133 () Real)
(declare-fun sc_134 () Real)
(assert (> sc_134 1e-08))
(declare-fun of_134 () Real)
(declare-fun sc_135 () Real)
(assert (> sc_135 1e-08))
(declare-fun of_135 () Real)
; 
; =  {sc.iadd[11].A} {sc.iadd[11].B}
(assert (= sc_133 sc_134))
; 
; =  {sc.iadd[11].A} {sc.iadd[11].C} {sc.iadd[11].D}
(assert (and (= sc_133 sc_132) (= sc_133 sc_131)))
; 
; =  {sc.iadd[11].OUT} {sc.iadd[11].A}
(assert (= sc_135 sc_133))
; 
; =  {of.iadd[11].OUT} {((of.iadd[11].A+of.iadd[11].B)-of.iadd[11].C-of.iadd[11].D)}
(assert (= of_135 (- (+ of_133 of_134) (+ of_132 of_131))))
(declare-fun slbot_131 () Real)
(declare-fun sltop_131 () Real)
; 
; =  {(((sc.iadd[11].D*-0.6)+of.iadd[11].D)+sl.min.iadd[11].D)} {0.}
(assert (= (+ (+ (* sc_131 -0.6) of_131) slbot_131) 0.))
; 
; =  {(((sc.iadd[11].D*0.)+of.iadd[11].D)+sl.max.iadd[11].D)} {5.}
(assert (= (+ (+ (* sc_131 0.) of_131) sltop_131) 5.))
; 
; >=  {((sc.iadd[11].C*1.)+of.iadd[11].C)} {5.}
(assert (<= (+ (* sc_132 1.) of_132) 5.))
; 
; <=  {((sc.iadd[11].C*1.)+of.iadd[11].C)} {0.}
(assert (>= (+ (* sc_132 1.) of_132) 0.))
(declare-fun slbot_135 () Real)
(declare-fun sltop_135 () Real)
; 
; =  {(((sc.iadd[11].OUT*-1.)+of.iadd[11].OUT)+sl.min.iadd[11].OUT)} {-10.}
(assert (= (+ (+ (* sc_135 -1.) of_135) slbot_135) -10.))
; 
; =  {(((sc.iadd[11].OUT*-0.4)+of.iadd[11].OUT)+sl.max.iadd[11].OUT)} {10.}
(assert (= (+ (+ (* sc_135 -0.4) of_135) sltop_135) 10.))
; 
; >=  {((sc.iadd[11].A*0.)+of.iadd[11].A)} {5.}
(assert (<= (+ (* sc_133 0.) of_133) 5.))
; 
; <=  {((sc.iadd[11].A*0.)+of.iadd[11].A)} {0.}
(assert (>= (+ (* sc_133 0.) of_133) 0.))
; 
; >=  {((sc.iadd[11].B*0.)+of.iadd[11].B)} {5.}
(assert (<= (+ (* sc_134 0.) of_134) 5.))
; 
; <=  {((sc.iadd[11].B*0.)+of.iadd[11].B)} {0.}
(assert (>= (+ (* sc_134 0.) of_134) 0.))
(declare-fun slbot_135 () Real)
(declare-fun sltop_135 () Real)
; 
; =  {(((sc.iadd[11].OUT*-1.)+of.iadd[11].OUT)+sl.min.iadd[11].OUT)} {-10.}
(assert (= (+ (+ (* sc_135 -1.) of_135) slbot_135) -10.))
; 
; =  {(((sc.iadd[11].OUT*-0.4)+of.iadd[11].OUT)+sl.max.iadd[11].OUT)} {10.}
(assert (= (+ (+ (* sc_135 -0.4) of_135) sltop_135) 10.))
(declare-fun sc_136 () Real)
(assert (> sc_136 1e-08))
(declare-fun of_136 () Real)
(declare-fun sc_137 () Real)
(assert (> sc_137 1e-08))
(declare-fun of_137 () Real)
(declare-fun sc_138 () Real)
(assert (> sc_138 1e-08))
(declare-fun of_138 () Real)
(declare-fun sc_139 () Real)
(assert (> sc_139 1e-08))
(declare-fun of_139 () Real)
(declare-fun sc_140 () Real)
(assert (> sc_140 1e-08))
(declare-fun of_140 () Real)
; 
; =  {sc.iadd[6].A} {sc.iadd[6].B}
(assert (= sc_138 sc_139))
; 
; =  {sc.iadd[6].A} {sc.iadd[6].C} {sc.iadd[6].D}
(assert (and (= sc_138 sc_137) (= sc_138 sc_136)))
; 
; =  {sc.iadd[6].OUT} {sc.iadd[6].A}
(assert (= sc_140 sc_138))
; 
; =  {of.iadd[6].OUT} {((of.iadd[6].A+of.iadd[6].B)-of.iadd[6].C-of.iadd[6].D)}
(assert (= of_140 (- (+ of_138 of_139) (+ of_137 of_136))))
; 
; >=  {((sc.iadd[6].D*0.)+of.iadd[6].D)} {5.}
(assert (<= (+ (* sc_136 0.) of_136) 5.))
; 
; <=  {((sc.iadd[6].D*0.)+of.iadd[6].D)} {0.}
(assert (>= (+ (* sc_136 0.) of_136) 0.))
(declare-fun slbot_137 () Real)
(declare-fun sltop_137 () Real)
; 
; =  {(((sc.iadd[6].C*0.)+of.iadd[6].C)+sl.min.iadd[6].C)} {0.}
(assert (= (+ (+ (* sc_137 0.) of_137) slbot_137) 0.))
; 
; =  {(((sc.iadd[6].C*0.6)+of.iadd[6].C)+sl.max.iadd[6].C)} {5.}
(assert (= (+ (+ (* sc_137 0.6) of_137) sltop_137) 5.))
(declare-fun slbot_140 () Real)
(declare-fun sltop_140 () Real)
; 
; =  {(((sc.iadd[6].OUT*-0.6)+of.iadd[6].OUT)+sl.min.iadd[6].OUT)} {-10.}
(assert (= (+ (+ (* sc_140 -0.6) of_140) slbot_140) -10.))
; 
; =  {(((sc.iadd[6].OUT*0.)+of.iadd[6].OUT)+sl.max.iadd[6].OUT)} {10.}
(assert (= (+ (+ (* sc_140 0.) of_140) sltop_140) 10.))
; 
; >=  {((sc.iadd[6].A*0.)+of.iadd[6].A)} {5.}
(assert (<= (+ (* sc_138 0.) of_138) 5.))
; 
; <=  {((sc.iadd[6].A*0.)+of.iadd[6].A)} {0.}
(assert (>= (+ (* sc_138 0.) of_138) 0.))
; 
; >=  {((sc.iadd[6].B*0.)+of.iadd[6].B)} {5.}
(assert (<= (+ (* sc_139 0.) of_139) 5.))
; 
; <=  {((sc.iadd[6].B*0.)+of.iadd[6].B)} {0.}
(assert (>= (+ (* sc_139 0.) of_139) 0.))
; 
; =  {sc.input.I[6].O} {sc.iadd[8].A}
(assert (= sc_26 sc_118))
; 
; =  {of.input.I[6].O} {of.iadd[8].A}
(assert (= of_26 of_118))
; 
; =  {sc.iadd[6].OUT} {sc.iadd[11].D}
(assert (= sc_140 sc_131))
; 
; =  {of.iadd[6].OUT} {of.iadd[11].D}
(assert (= of_140 of_131))
; 
; =  {sc.vadd[2].OUT2} {sc.output.V[0].X}
(assert (= sc_61 sc_51))
; 
; =  {of.vadd[2].OUT2} {of.output.V[0].X}
(assert (= of_61 of_51))
; 
; =  {sc.vadd[2].OUT2} {sc.vtoi[0].X}
(assert (= sc_61 sc_75))
; 
; =  {of.vadd[2].OUT2} {of.vtoi[0].X}
(assert (= of_61 of_75))
; 
; =  {sc.input.I[0].O} {sc.iadd[6].C}
(assert (= sc_18 sc_137))
; 
; =  {of.input.I[0].O} {of.iadd[6].C}
(assert (= of_18 of_137))
; 
; =  {sc.switch[7].PROD} {sc.iadd[12].B}
(assert (= sc_4 sc_124))
; 
; =  {of.switch[7].PROD} {of.iadd[12].B}
(assert (= of_4 of_124))
; 
; =  {sc.ihill[0].REP} {sc.itov[4].X}
(assert (= sc_74 sc_110))
; 
; =  {of.ihill[0].REP} {of.itov[4].X}
(assert (= of_74 of_110))
; 
; =  {sc.input.V[9].O} {sc.itov[4].K}
(assert (= sc_95 sc_111))
; 
; =  {of.input.V[9].O} {of.itov[4].K}
(assert (= of_95 of_111))
; 
; =  {sc.itov[1].Y} {sc.vadd[2].B}
(assert (= sc_115 sc_59))
; 
; =  {of.itov[1].Y} {of.vadd[2].B}
(assert (= of_115 of_59))
; 
; =  {sc.input.I[25].O} {sc.iadd[12].A}
(assert (= sc_42 sc_123))
; 
; =  {of.input.I[25].O} {of.iadd[12].A}
(assert (= of_42 of_123))
; 
; =  {sc.input.I[18].O} {sc.iadd[11].C}
(assert (= sc_48 sc_132))
; 
; =  {of.input.I[18].O} {of.iadd[11].C}
(assert (= of_48 of_132))
; 
; =  {sc.input.I[9].O} {sc.iadd[9].A}
(assert (= sc_16 sc_128))
; 
; =  {of.input.I[9].O} {of.iadd[9].A}
(assert (= of_16 of_128))
; 
; =  {sc.input.I[3].O} {sc.iadd[6].D}
(assert (= sc_34 sc_136))
; 
; =  {of.input.I[3].O} {of.iadd[6].D}
(assert (= of_34 of_136))
; 
; =  {sc.input.I[4].O} {sc.iadd[6].B}
(assert (= sc_36 sc_139))
; 
; =  {of.input.I[4].O} {of.iadd[6].B}
(assert (= of_36 of_139))
; 
; =  {sc.input.I[16].O} {sc.igenebind[3].TF}
(assert (= sc_32 sc_82))
; 
; =  {of.input.I[16].O} {of.igenebind[3].TF}
(assert (= of_32 of_82))
; 
; =  {sc.igenebind[10].GE} {sc.iadd[9].B}
(assert (= sc_81 sc_129))
; 
; =  {of.igenebind[10].GE} {of.iadd[9].B}
(assert (= of_81 of_129))
; 
; =  {sc.input.I[5].O} {sc.iadd[8].D}
(assert (= sc_38 sc_116))
; 
; =  {of.input.I[5].O} {of.iadd[8].D}
(assert (= of_38 of_116))
; 
; =  {sc.vtoi[0].Y} {sc.ihill[0].S}
(assert (= sc_77 sc_70))
; 
; =  {of.vtoi[0].Y} {of.ihill[0].S}
(assert (= of_77 of_70))
; 
; =  {sc.iadd[12].OUT} {sc.igenebind[3].K}
(assert (= sc_125 sc_83))
; 
; =  {of.iadd[12].OUT} {of.igenebind[3].K}
(assert (= of_125 of_83))
; 
; =  {sc.input.I[14].O} {sc.igenebind[3].Vmax}
(assert (= sc_28 sc_84))
; 
; =  {of.input.I[14].O} {of.igenebind[3].Vmax}
(assert (= of_28 of_84))
; 
; =  {sc.input.V[12].O} {sc.vtoi[0].K}
(assert (= sc_93 sc_76))
; 
; =  {of.input.V[12].O} {of.vtoi[0].K}
(assert (= of_93 of_76))
; 
; =  {sc.input.V[8].O} {sc.vadd[5].D}
(assert (= sc_89 sc_63))
; 
; =  {of.input.V[8].O} {of.vadd[5].D}
(assert (= of_89 of_63))
; 
; =  {sc.input.I[2].O} {sc.iadd[6].A}
(assert (= sc_6 sc_138))
; 
; =  {of.input.I[2].O} {of.iadd[6].A}
(assert (= of_6 of_138))
; 
; =  {sc.input.V[3].O} {sc.vadd[5].A}
(assert (= sc_103 sc_65))
; 
; =  {of.input.V[3].O} {of.vadd[5].A}
(assert (= of_103 of_65))
; 
; =  {sc.input.V[2].O} {sc.vadd[2].C}
(assert (= sc_87 sc_57))
; 
; =  {of.input.V[2].O} {of.vadd[2].C}
(assert (= of_87 of_57))
; 
; =  {sc.vadd[5].OUT2} {sc.output.V[1].X}
(assert (= sc_68 sc_53))
; 
; =  {of.vadd[5].OUT2} {of.output.V[1].X}
(assert (= of_68 of_53))
; 
; =  {sc.vadd[5].OUT2} {sc.switch[7].Vmax}
(assert (= sc_68 sc_3))
; 
; =  {of.vadd[5].OUT2} {of.switch[7].Vmax}
(assert (= of_68 of_3))
; 
; =  {sc.input.I[24].O} {sc.iadd[12].D}
(assert (= sc_30 sc_121))
; 
; =  {of.input.I[24].O} {of.iadd[12].D}
(assert (= of_30 of_121))
; 
; =  {sc.input.I[15].O} {sc.itov[1].X}
(assert (= sc_24 sc_113))
; 
; =  {of.input.I[15].O} {of.itov[1].X}
(assert (= of_24 of_113))
; 
; =  {sc.input.I[12].O} {sc.iadd[11].A}
(assert (= sc_14 sc_133))
; 
; =  {of.input.I[12].O} {of.iadd[11].A}
(assert (= of_14 of_133))
; 
; =  {sc.input.I[1].O} {sc.ihill[0].Vmax}
(assert (= sc_44 sc_72))
; 
; =  {of.input.I[1].O} {of.ihill[0].Vmax}
(assert (= of_44 of_72))
; 
; =  {sc.input.I[10].O} {sc.iadd[9].C}
(assert (= sc_22 sc_127))
; 
; =  {of.input.I[10].O} {of.iadd[9].C}
(assert (= of_22 of_127))
; 
; =  {sc.iadd[11].OUT} {sc.igenebind[10].TF}
(assert (= sc_135 sc_78))
; 
; =  {of.iadd[11].OUT} {of.igenebind[10].TF}
(assert (= of_135 of_78))
; 
; =  {sc.input.I[7].O} {sc.iadd[8].C}
(assert (= sc_10 sc_117))
; 
; =  {of.input.I[7].O} {of.iadd[8].C}
(assert (= of_10 of_117))
; 
; =  {sc.input.I[13].O} {sc.switch[7].SUB}
(assert (= sc_12 sc_1))
; 
; =  {of.input.I[13].O} {of.switch[7].SUB}
(assert (= of_12 of_1))
; 
; =  {sc.input.V[1].O} {sc.vadd[2].A}
(assert (= sc_109 sc_58))
; 
; =  {of.input.V[1].O} {of.vadd[2].A}
(assert (= of_109 of_58))
; 
; =  {sc.input.I[17].O} {sc.igenebind[10].Vmax}
(assert (= sc_46 sc_80))
; 
; =  {of.input.I[17].O} {of.igenebind[10].Vmax}
(assert (= of_46 of_80))
; 
; =  {sc.input.V[7].O} {sc.vadd[2].D}
(assert (= sc_91 sc_56))
; 
; =  {of.input.V[7].O} {of.vadd[2].D}
(assert (= of_91 of_56))
; 
; =  {sc.input.I[8].O} {sc.iadd[9].D}
(assert (= sc_8 sc_126))
; 
; =  {of.input.I[8].O} {of.iadd[9].D}
(assert (= of_8 of_126))
; 
; =  {sc.iadd[9].OUT} {sc.iadd[8].B}
(assert (= sc_130 sc_119))
; 
; =  {of.iadd[9].OUT} {of.iadd[8].B}
(assert (= of_130 of_119))
; 
; =  {sc.input.I[23].O} {sc.iadd[12].C}
(assert (= sc_40 sc_122))
; 
; =  {of.input.I[23].O} {of.iadd[12].C}
(assert (= of_40 of_122))
; 
; =  {sc.igenebind[3].GE} {sc.itov[1].K}
(assert (= sc_85 sc_114))
; 
; =  {of.igenebind[3].GE} {of.itov[1].K}
(assert (= of_85 of_114))
; 
; =  {sc.input.V[0].O} {sc.ihill[0].n}
(assert (= sc_97 sc_69))
; 
; =  {of.input.V[0].O} {of.ihill[0].n}
(assert (= of_97 of_69))
; 
; =  {sc.input.V[10].O} {sc.switch[7].n}
(assert (= sc_99 sc_0))
; 
; =  {of.input.V[10].O} {of.switch[7].n}
(assert (= of_99 of_0))
; 
; =  {sc.itov[4].Y} {sc.vadd[5].B}
(assert (= sc_112 sc_66))
; 
; =  {of.itov[4].Y} {of.vadd[5].B}
(assert (= of_112 of_66))
; 
; =  {sc.iadd[8].OUT} {sc.switch[7].Kmod}
(assert (= sc_120 sc_2))
; 
; =  {of.iadd[8].OUT} {of.switch[7].Kmod}
(assert (= of_120 of_2))
; 
; =  {sc.input.V[5].O} {sc.vadd[5].OUT2_0}
(assert (= sc_107 sc_62))
; 
; =  {of.input.V[5].O} {of.vadd[5].OUT2_0}
(assert (= of_107 of_62))
; 
; =  {sc.input.V[4].O} {sc.vadd[5].C}
(assert (= sc_105 sc_64))
; 
; =  {of.input.V[4].O} {of.vadd[5].C}
(assert (= of_105 of_64))
; 
; =  {sc.input.I[19].O} {sc.igenebind[10].K}
(assert (= sc_50 sc_79))
; 
; =  {of.input.I[19].O} {of.igenebind[10].K}
(assert (= of_50 of_79))
; 
; =  {sc.input.V[6].O} {sc.vadd[2].OUT2_0}
(assert (= sc_101 sc_55))
; 
; =  {of.input.V[6].O} {of.vadd[2].OUT2_0}
(assert (= of_101 of_55))
; 
; =  {sc.input.I[11].O} {sc.iadd[11].B}
(assert (= sc_20 sc_134))
; 
; =  {of.input.I[11].O} {of.iadd[11].B}
(assert (= of_20 of_134))
(assert (<= (* (/ 1. sc_52) 0.001) 0.001))
(assert (<= (* (/ 1. sc_54) 0.001) 0.001))
; 
; =  {sc.vadd[2].OUT2} {sc.output.V[0].O} {sc.vadd[5].OUT2} {sc.output.V[1].O}
(assert (and (and (= sc_61 sc_52) (= sc_61 sc_68)) (= sc_61 sc_54)))
(assert (= __minima__ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (ite (>= sltop_77 0.) sltop_77 (- sltop_77)) (ite (>= sltop_130 0.) sltop_130 (- sltop_130))) (ite (>= sltop_18 0.) sltop_18 (- sltop_18))) (ite (>= sltop_125 0.) sltop_125 (- sltop_125))) (ite (>= sltop_4 0.) sltop_4 (- sltop_4))) (ite (>= sltop_66 0.) sltop_66 (- sltop_66))) (ite (>= sltop_120 0.) sltop_120 (- sltop_120))) (ite (>= slbot_3 0.) slbot_3 (- slbot_3))) (ite (>= slbot_53 0.) slbot_53 (- slbot_53))) (ite (>= slbot_59 0.) slbot_59 (- slbot_59))) (ite (>= slbot_2 0.) slbot_2 (- slbot_2))) (ite (>= slbot_120 0.) slbot_120 (- slbot_120))) (ite (>= slbot_119 0.) slbot_119 (- slbot_119))) (ite (>= sltop_112 0.) sltop_112 (- sltop_112))) (ite (>= slbot_130 0.) slbot_130 (- slbot_130))) (ite (>= slbot_85 0.) slbot_85 (- slbot_85))) (ite (>= slbot_18 0.) slbot_18 (- slbot_18))) (ite (>= slbot_125 0.) slbot_125 (- slbot_125))) (ite (>= sltop_2 0.) sltop_2 (- sltop_2))) (ite (>= slbot_124 0.) slbot_124 (- slbot_124))) (ite (>= sltop_137 0.) sltop_137 (- sltop_137))) (ite (>= sltop_85 0.) sltop_85 (- sltop_85))) (ite (>= slbot_115 0.) slbot_115 (- slbot_115))) (ite (>= slbot_131 0.) slbot_131 (- slbot_131))) (ite (>= slbot_54 0.) slbot_54 (- slbot_54))) (ite (>= sltop_74 0.) sltop_74 (- sltop_74))) (ite (>= sltop_51 0.) sltop_51 (- sltop_51))) (ite (>= slbot_81 0.) slbot_81 (- slbot_81))) (ite (>= sltop_131 0.) sltop_131 (- sltop_131))) (ite (>= slbot_68 0.) slbot_68 (- slbot_68))) (ite (>= sltop_110 0.) sltop_110 (- sltop_110))) (ite (>= sltop_115 0.) sltop_115 (- sltop_115))) (ite (>= sltop_135 0.) sltop_135 (- sltop_135))) (ite (>= sltop_68 0.) sltop_68 (- sltop_68))) (ite (>= sltop_75 0.) sltop_75 (- sltop_75))) (ite (>= slbot_77 0.) slbot_77 (- slbot_77))) (ite (>= slbot_114 0.) slbot_114 (- slbot_114))) (ite (>= sltop_17 0.) sltop_17 (- sltop_17))) (ite (>= slbot_75 0.) slbot_75 (- slbot_75))) (ite (>= slbot_110 0.) slbot_110 (- slbot_110))) (ite (>= sltop_3 0.) sltop_3 (- sltop_3))) (ite (>= slbot_135 0.) slbot_135 (- slbot_135))) (ite (>= sltop_119 0.) sltop_119 (- sltop_119))) (ite (>= slbot_66 0.) slbot_66 (- slbot_66))) (ite (>= sltop_52 0.) sltop_52 (- sltop_52))) (ite (>= slbot_78 0.) slbot_78 (- slbot_78))) (ite (>= slbot_60 0.) slbot_60 (- slbot_60))) (ite (>= sltop_70 0.) sltop_70 (- sltop_70))) (ite (>= sltop_81 0.) sltop_81 (- sltop_81))) (ite (>= slbot_83 0.) slbot_83 (- slbot_83))) (ite (>= slbot_112 0.) slbot_112 (- slbot_112))) (ite (>= sltop_114 0.) sltop_114 (- sltop_114))) (ite (>= slbot_140 0.) slbot_140 (- slbot_140))) (ite (>= sltop_54 0.) sltop_54 (- sltop_54))) (ite (>= slbot_61 0.) slbot_61 (- slbot_61))) (ite (>= sltop_124 0.) sltop_124 (- sltop_124))) (ite (>= sltop_129 0.) sltop_129 (- sltop_129))) (ite (>= sltop_67 0.) sltop_67 (- sltop_67))) (ite (>= slbot_17 0.) slbot_17 (- slbot_17))) (ite (>= slbot_129 0.) slbot_129 (- slbot_129))) (ite (>= slbot_67 0.) slbot_67 (- slbot_67))) (ite (>= slbot_4 0.) slbot_4 (- slbot_4))) (ite (>= slbot_52 0.) slbot_52 (- slbot_52))) (ite (>= sltop_140 0.) sltop_140 (- sltop_140))) (ite (>= slbot_51 0.) slbot_51 (- slbot_51))) (ite (>= sltop_60 0.) sltop_60 (- sltop_60))) (ite (>= slbot_70 0.) slbot_70 (- slbot_70))) (ite (>= sltop_78 0.) sltop_78 (- sltop_78))) (ite (>= sltop_53 0.) sltop_53 (- sltop_53))) (ite (>= slbot_137 0.) slbot_137 (- slbot_137))) (ite (>= sltop_83 0.) sltop_83 (- sltop_83))) (ite (>= sltop_61 0.) sltop_61 (- sltop_61))) (ite (>= slbot_74 0.) slbot_74 (- slbot_74))) (ite (>= sltop_59 0.) sltop_59 (- sltop_59)))))
(check-sat)
