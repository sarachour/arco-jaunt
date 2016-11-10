(set-logic QF_NRA)
(declare-fun __minima__ () Real)
(declare-fun sc_0 () Real)
(declare-fun of_0 () Real)
(declare-fun sc_1 () Real)
(declare-fun of_1 () Real)
(declare-fun sc_2 () Real)
(declare-fun of_2 () Real)
(declare-fun sc_3 () Real)
(declare-fun of_3 () Real)
(assert (= of_0 0))
(assert (= of_1 0))
(assert (= 0. 0))
(assert (= of_2 0))
(assert (= 0. 0))
; 
; =  {sc.vgain[4].P} {((sc.vgain[4].X/sc.vgain[4].Y)*sc.vgain[4].Z*1)}
(assert (= sc_3 (* (* (/ sc_0 sc_1) sc_2) 1)))
; 
; =  {of.vgain[4].P} {0}
(assert (= of_3 0.))
; 
; >=  {((sc.vgain[4].X*1.)+of.vgain[4].X)} {3300.}
(assert (<= (+ (* sc_0 1.) of_0) 3300.))
; 
; <=  {((sc.vgain[4].X*1.)+of.vgain[4].X)} {0.0001}
(assert (>= (+ (* sc_0 1.) of_0) 0.0001))
; 
; >=  {((sc.vgain[4].Y*0.125)+of.vgain[4].Y)} {3300.}
(assert (<= (+ (* sc_1 0.125) of_1) 3300.))
; 
; <=  {((sc.vgain[4].Y*0.125)+of.vgain[4].Y)} {1.}
(assert (>= (+ (* sc_1 0.125) of_1) 1.))
(declare-fun slbot_3 () Real)
(declare-fun sltop_3 () Real)
; 
; =  {(((sc.vgain[4].P*0.)+of.vgain[4].P)+sl.min.vgain[4].P)} {1.51515151515e-12}
(assert (= (+ (+ (* sc_3 0.) of_3) slbot_3) 1.51515151515e-12))
; 
; =  {(((sc.vgain[4].P*4.)+of.vgain[4].P)+sl.max.vgain[4].P)} {5445000.}
(assert (= (+ (+ (* sc_3 4.) of_3) sltop_3) 5445000.))
(declare-fun slbot_2 () Real)
(declare-fun sltop_2 () Real)
; 
; =  {(((sc.vgain[4].Z*0.)+of.vgain[4].Z)+sl.min.vgain[4].Z)} {0.0001}
(assert (= (+ (+ (* sc_2 0.) of_2) slbot_2) 0.0001))
; 
; =  {(((sc.vgain[4].Z*1.)+of.vgain[4].Z)+sl.max.vgain[4].Z)} {3300.}
(assert (= (+ (+ (* sc_2 1.) of_2) sltop_2) 3300.))
(declare-fun sc_4 () Real)
(declare-fun of_4 () Real)
(declare-fun sc_5 () Real)
(declare-fun of_5 () Real)
; 
; =  {sc.input.I[2].O} {sc.input.I[2].X}
(assert (= sc_5 sc_4))
; 
; =  {of.input.I[2].O} {of.input.I[2].X}
(assert (= of_5 of_4))
; 
; >=  {((sc.input.I[2].X*0.)+of.input.I[2].X)} {10.}
(assert (<= (+ (* sc_4 0.) of_4) 10.))
; 
; <=  {((sc.input.I[2].X*0.)+of.input.I[2].X)} {0.}
(assert (>= (+ (* sc_4 0.) of_4) 0.))
; 
; >=  {((sc.input.I[2].O*0.)+of.input.I[2].O)} {10.}
(assert (<= (+ (* sc_5 0.) of_5) 10.))
; 
; <=  {((sc.input.I[2].O*0.)+of.input.I[2].O)} {0.}
(assert (>= (+ (* sc_5 0.) of_5) 0.))
(declare-fun sc_6 () Real)
(declare-fun of_6 () Real)
(declare-fun sc_7 () Real)
(declare-fun of_7 () Real)
; 
; =  {sc.input.I[8].O} {sc.input.I[8].X}
(assert (= sc_7 sc_6))
; 
; =  {of.input.I[8].O} {of.input.I[8].X}
(assert (= of_7 of_6))
; 
; >=  {((sc.input.I[8].X*0.)+of.input.I[8].X)} {10.}
(assert (<= (+ (* sc_6 0.) of_6) 10.))
; 
; <=  {((sc.input.I[8].X*0.)+of.input.I[8].X)} {0.}
(assert (>= (+ (* sc_6 0.) of_6) 0.))
; 
; >=  {((sc.input.I[8].O*0.)+of.input.I[8].O)} {10.}
(assert (<= (+ (* sc_7 0.) of_7) 10.))
; 
; <=  {((sc.input.I[8].O*0.)+of.input.I[8].O)} {0.}
(assert (>= (+ (* sc_7 0.) of_7) 0.))
(declare-fun sc_8 () Real)
(declare-fun of_8 () Real)
(declare-fun sc_9 () Real)
(declare-fun of_9 () Real)
; 
; =  {sc.input.I[7].O} {sc.input.I[7].X}
(assert (= sc_9 sc_8))
; 
; =  {of.input.I[7].O} {of.input.I[7].X}
(assert (= of_9 of_8))
; 
; >=  {((sc.input.I[7].X*0.)+of.input.I[7].X)} {10.}
(assert (<= (+ (* sc_8 0.) of_8) 10.))
; 
; <=  {((sc.input.I[7].X*0.)+of.input.I[7].X)} {0.}
(assert (>= (+ (* sc_8 0.) of_8) 0.))
; 
; >=  {((sc.input.I[7].O*0.)+of.input.I[7].O)} {10.}
(assert (<= (+ (* sc_9 0.) of_9) 10.))
; 
; <=  {((sc.input.I[7].O*0.)+of.input.I[7].O)} {0.}
(assert (>= (+ (* sc_9 0.) of_9) 0.))
(declare-fun sc_10 () Real)
(declare-fun of_10 () Real)
(declare-fun sc_11 () Real)
(declare-fun of_11 () Real)
; 
; =  {sc.input.I[9].O} {sc.input.I[9].X}
(assert (= sc_11 sc_10))
; 
; =  {of.input.I[9].O} {of.input.I[9].X}
(assert (= of_11 of_10))
; 
; >=  {((sc.input.I[9].X*0.)+of.input.I[9].X)} {10.}
(assert (<= (+ (* sc_10 0.) of_10) 10.))
; 
; <=  {((sc.input.I[9].X*0.)+of.input.I[9].X)} {0.}
(assert (>= (+ (* sc_10 0.) of_10) 0.))
; 
; >=  {((sc.input.I[9].O*0.)+of.input.I[9].O)} {10.}
(assert (<= (+ (* sc_11 0.) of_11) 10.))
; 
; <=  {((sc.input.I[9].O*0.)+of.input.I[9].O)} {0.}
(assert (>= (+ (* sc_11 0.) of_11) 0.))
(declare-fun sc_12 () Real)
(declare-fun of_12 () Real)
(declare-fun sc_13 () Real)
(declare-fun of_13 () Real)
; 
; =  {sc.input.I[0].O} {sc.input.I[0].X}
(assert (= sc_13 sc_12))
; 
; =  {of.input.I[0].O} {of.input.I[0].X}
(assert (= of_13 of_12))
; 
; >=  {((sc.input.I[0].X*-0.11)+of.input.I[0].X)} {10.}
(assert (<= (+ (* sc_12 -0.11) of_12) 10.))
; 
; <=  {((sc.input.I[0].X*-0.11)+of.input.I[0].X)} {0.}
(assert (>= (+ (* sc_12 -0.11) of_12) 0.))
; 
; >=  {((sc.input.I[0].O*-0.11)+of.input.I[0].O)} {10.}
(assert (<= (+ (* sc_13 -0.11) of_13) 10.))
; 
; <=  {((sc.input.I[0].O*-0.11)+of.input.I[0].O)} {0.}
(assert (>= (+ (* sc_13 -0.11) of_13) 0.))
(declare-fun sc_14 () Real)
(declare-fun of_14 () Real)
(declare-fun sc_15 () Real)
(declare-fun of_15 () Real)
; 
; =  {sc.input.I[11].O} {sc.input.I[11].X}
(assert (= sc_15 sc_14))
; 
; =  {of.input.I[11].O} {of.input.I[11].X}
(assert (= of_15 of_14))
; 
; >=  {((sc.input.I[11].X*-0.15)+of.input.I[11].X)} {10.}
(assert (<= (+ (* sc_14 -0.15) of_14) 10.))
; 
; <=  {((sc.input.I[11].X*-0.15)+of.input.I[11].X)} {0.}
(assert (>= (+ (* sc_14 -0.15) of_14) 0.))
; 
; >=  {((sc.input.I[11].O*-0.15)+of.input.I[11].O)} {10.}
(assert (<= (+ (* sc_15 -0.15) of_15) 10.))
; 
; <=  {((sc.input.I[11].O*-0.15)+of.input.I[11].O)} {0.}
(assert (>= (+ (* sc_15 -0.15) of_15) 0.))
(declare-fun sc_16 () Real)
(declare-fun of_16 () Real)
(declare-fun sc_17 () Real)
(declare-fun of_17 () Real)
; 
; =  {sc.input.I[10].O} {sc.input.I[10].X}
(assert (= sc_17 sc_16))
; 
; =  {of.input.I[10].O} {of.input.I[10].X}
(assert (= of_17 of_16))
; 
; >=  {((sc.input.I[10].X*0.)+of.input.I[10].X)} {10.}
(assert (<= (+ (* sc_16 0.) of_16) 10.))
; 
; <=  {((sc.input.I[10].X*0.)+of.input.I[10].X)} {0.}
(assert (>= (+ (* sc_16 0.) of_16) 0.))
; 
; >=  {((sc.input.I[10].O*0.)+of.input.I[10].O)} {10.}
(assert (<= (+ (* sc_17 0.) of_17) 10.))
; 
; <=  {((sc.input.I[10].O*0.)+of.input.I[10].O)} {0.}
(assert (>= (+ (* sc_17 0.) of_17) 0.))
(declare-fun sc_18 () Real)
(declare-fun of_18 () Real)
(declare-fun sc_19 () Real)
(declare-fun of_19 () Real)
; 
; =  {sc.input.I[6].O} {sc.input.I[6].X}
(assert (= sc_19 sc_18))
; 
; =  {of.input.I[6].O} {of.input.I[6].X}
(assert (= of_19 of_18))
; 
; >=  {((sc.input.I[6].X*0.)+of.input.I[6].X)} {10.}
(assert (<= (+ (* sc_18 0.) of_18) 10.))
; 
; <=  {((sc.input.I[6].X*0.)+of.input.I[6].X)} {0.}
(assert (>= (+ (* sc_18 0.) of_18) 0.))
; 
; >=  {((sc.input.I[6].O*0.)+of.input.I[6].O)} {10.}
(assert (<= (+ (* sc_19 0.) of_19) 10.))
; 
; <=  {((sc.input.I[6].O*0.)+of.input.I[6].O)} {0.}
(assert (>= (+ (* sc_19 0.) of_19) 0.))
(declare-fun sc_20 () Real)
(declare-fun of_20 () Real)
(declare-fun sc_21 () Real)
(declare-fun of_21 () Real)
; 
; =  {sc.input.I[3].O} {sc.input.I[3].X}
(assert (= sc_21 sc_20))
; 
; =  {of.input.I[3].O} {of.input.I[3].X}
(assert (= of_21 of_20))
; 
; >=  {((sc.input.I[3].X*0.)+of.input.I[3].X)} {10.}
(assert (<= (+ (* sc_20 0.) of_20) 10.))
; 
; <=  {((sc.input.I[3].X*0.)+of.input.I[3].X)} {0.}
(assert (>= (+ (* sc_20 0.) of_20) 0.))
; 
; >=  {((sc.input.I[3].O*0.)+of.input.I[3].O)} {10.}
(assert (<= (+ (* sc_21 0.) of_21) 10.))
; 
; <=  {((sc.input.I[3].O*0.)+of.input.I[3].O)} {0.}
(assert (>= (+ (* sc_21 0.) of_21) 0.))
(declare-fun sc_22 () Real)
(declare-fun of_22 () Real)
(declare-fun sc_23 () Real)
(declare-fun of_23 () Real)
; 
; =  {sc.input.I[4].O} {sc.input.I[4].X}
(assert (= sc_23 sc_22))
; 
; =  {of.input.I[4].O} {of.input.I[4].X}
(assert (= of_23 of_22))
; 
; >=  {((sc.input.I[4].X*0.)+of.input.I[4].X)} {10.}
(assert (<= (+ (* sc_22 0.) of_22) 10.))
; 
; <=  {((sc.input.I[4].X*0.)+of.input.I[4].X)} {0.}
(assert (>= (+ (* sc_22 0.) of_22) 0.))
; 
; >=  {((sc.input.I[4].O*0.)+of.input.I[4].O)} {10.}
(assert (<= (+ (* sc_23 0.) of_23) 10.))
; 
; <=  {((sc.input.I[4].O*0.)+of.input.I[4].O)} {0.}
(assert (>= (+ (* sc_23 0.) of_23) 0.))
(declare-fun sc_24 () Real)
(declare-fun of_24 () Real)
(declare-fun sc_25 () Real)
(declare-fun of_25 () Real)
; 
; =  {sc.input.I[5].O} {sc.input.I[5].X}
(assert (= sc_25 sc_24))
; 
; =  {of.input.I[5].O} {of.input.I[5].X}
(assert (= of_25 of_24))
; 
; >=  {((sc.input.I[5].X*0.)+of.input.I[5].X)} {10.}
(assert (<= (+ (* sc_24 0.) of_24) 10.))
; 
; <=  {((sc.input.I[5].X*0.)+of.input.I[5].X)} {0.}
(assert (>= (+ (* sc_24 0.) of_24) 0.))
; 
; >=  {((sc.input.I[5].O*0.)+of.input.I[5].O)} {10.}
(assert (<= (+ (* sc_25 0.) of_25) 10.))
; 
; <=  {((sc.input.I[5].O*0.)+of.input.I[5].O)} {0.}
(assert (>= (+ (* sc_25 0.) of_25) 0.))
(declare-fun sc_26 () Real)
(declare-fun of_26 () Real)
(declare-fun sc_27 () Real)
(declare-fun of_27 () Real)
; 
; =  {sc.input.I[1].O} {sc.input.I[1].X}
(assert (= sc_27 sc_26))
; 
; =  {of.input.I[1].O} {of.input.I[1].X}
(assert (= of_27 of_26))
; 
; >=  {((sc.input.I[1].X*0.)+of.input.I[1].X)} {10.}
(assert (<= (+ (* sc_26 0.) of_26) 10.))
; 
; <=  {((sc.input.I[1].X*0.)+of.input.I[1].X)} {0.}
(assert (>= (+ (* sc_26 0.) of_26) 0.))
; 
; >=  {((sc.input.I[1].O*0.)+of.input.I[1].O)} {10.}
(assert (<= (+ (* sc_27 0.) of_27) 10.))
; 
; <=  {((sc.input.I[1].O*0.)+of.input.I[1].O)} {0.}
(assert (>= (+ (* sc_27 0.) of_27) 0.))
(declare-fun sc_28 () Real)
(declare-fun of_28 () Real)
(declare-fun sc_29 () Real)
(declare-fun of_29 () Real)
; 
; =  {sc.output.V[0].O} {sc.output.V[0].X}
(assert (= sc_29 sc_28))
; 
; =  {of.output.V[0].O} {of.output.V[0].X}
(assert (= of_29 of_28))
(declare-fun slbot_28 () Real)
(declare-fun sltop_28 () Real)
; 
; =  {(((sc.output.V[0].X*0.)+of.output.V[0].X)+sl.min.output.V[0].X)} {0.0001}
(assert (= (+ (+ (* sc_28 0.) of_28) slbot_28) 0.0001))
; 
; =  {(((sc.output.V[0].X*1.)+of.output.V[0].X)+sl.max.output.V[0].X)} {3300.}
(assert (= (+ (+ (* sc_28 1.) of_28) sltop_28) 3300.))
(declare-fun slbot_29 () Real)
(declare-fun sltop_29 () Real)
; 
; =  {(((sc.output.V[0].O*0.)+of.output.V[0].O)+sl.min.output.V[0].O)} {0.0001}
(assert (= (+ (+ (* sc_29 0.) of_29) slbot_29) 0.0001))
; 
; =  {(((sc.output.V[0].O*1.)+of.output.V[0].O)+sl.max.output.V[0].O)} {3300.}
(assert (= (+ (+ (* sc_29 1.) of_29) sltop_29) 3300.))
(declare-fun sc_30 () Real)
(declare-fun of_30 () Real)
(declare-fun sc_31 () Real)
(declare-fun of_31 () Real)
(declare-fun sc_32 () Real)
(declare-fun of_32 () Real)
(declare-fun sc_33 () Real)
(declare-fun of_33 () Real)
(declare-fun sc_34 () Real)
(declare-fun of_34 () Real)
(declare-fun sc_35 () Real)
(declare-fun of_35 () Real)
(declare-fun sc_36 () Real)
(declare-fun of_36 () Real)
(assert (= 0. 0))
(assert (= of_31 0))
(assert (= 0. 0))
(assert (= of_34 0))
; 
; =  {sc.vadd[5].A} {(1*sc.vadd[5].B)}
(assert (= sc_33 (* 1 sc_34)))
; 
; =  {sc.vadd[5].A} {(1*sc.vadd[5].C)} {(1*sc.vadd[5].D)}
(assert (and (= sc_33 (* 1 sc_32)) (= sc_33 (* 1 sc_31))))
(assert (= (- (+ of_33 0) (+ 0 0)) 0))
(assert (= 0. 0))
; 
; =  {sc.vadd[5].OUT} {(sc.vadd[5].A*1)}
(assert (= sc_35 (* sc_33 1)))
; 
; =  {of.vadd[5].OUT} {0}
(assert (= of_35 0.))
(assert (= 0. 0))
(assert (= of_31 0))
(assert (= 0. 0))
(assert (= 0. 0))
(assert (= of_34 0))
; 
; =  {sc.vadd[5].A} {(1*sc.vadd[5].B)}
(assert (= sc_33 (* 1 sc_34)))
; 
; =  {sc.vadd[5].A} {(1*sc.vadd[5].C)} {(1*sc.vadd[5].D*1)}
(assert (and (= sc_33 (* 1 sc_32)) (= sc_33 (* (* 1 sc_31) 1))))
(assert (= (- (+ of_33 0) (+ 0 0)) 0))
(assert (= 0. 0))
; 
; =  {sc.vadd[5].OUT2} {(sc.vadd[5].A*1)}
(assert (= sc_36 (* sc_33 1)))
(assert (= of_36 0))
(assert (= 0. 0))
; 
; =  {sc.vadd[5].OUT2_0} {(sc.vadd[5].A*1)}
(assert (= sc_30 (* sc_33 1)))
; 
; =  {of.vadd[5].OUT2_0} {0}
(assert (= of_30 0.))
; 
; >=  {((sc.vadd[5].OUT2_0*0.)+of.vadd[5].OUT2_0)} {3300.}
(assert (<= (+ (* sc_30 0.) of_30) 3300.))
; 
; <=  {((sc.vadd[5].OUT2_0*0.)+of.vadd[5].OUT2_0)} {0.}
(assert (>= (+ (* sc_30 0.) of_30) 0.))
; 
; >=  {((sc.vadd[5].D*4.)+of.vadd[5].D)} {3300.}
(assert (<= (+ (* sc_31 4.) of_31) 3300.))
; 
; <=  {((sc.vadd[5].D*4.)+of.vadd[5].D)} {0.0001}
(assert (>= (+ (* sc_31 4.) of_31) 0.0001))
; 
; >=  {((sc.vadd[5].A*0.)+of.vadd[5].A)} {3300.}
(assert (<= (+ (* sc_33 0.) of_33) 3300.))
; 
; <=  {((sc.vadd[5].A*0.)+of.vadd[5].A)} {0.0001}
(assert (>= (+ (* sc_33 0.) of_33) 0.0001))
(declare-fun slbot_36 () Real)
(declare-fun sltop_36 () Real)
; 
; =  {(((sc.vadd[5].OUT2*0.)+of.vadd[5].OUT2)+sl.min.vadd[5].OUT2)} {0.}
(assert (= (+ (+ (* sc_36 0.) of_36) slbot_36) 0.))
; 
; =  {(((sc.vadd[5].OUT2*1.)+of.vadd[5].OUT2)+sl.max.vadd[5].OUT2)} {5.}
(assert (= (+ (+ (* sc_36 1.) of_36) sltop_36) 5.))
(declare-fun slbot_34 () Real)
(declare-fun sltop_34 () Real)
; 
; =  {(((sc.vadd[5].B*0.)+of.vadd[5].B)+sl.min.vadd[5].B)} {0.0001}
(assert (= (+ (+ (* sc_34 0.) of_34) slbot_34) 0.0001))
; 
; =  {(((sc.vadd[5].B*4.)+of.vadd[5].B)+sl.max.vadd[5].B)} {3300.}
(assert (= (+ (+ (* sc_34 4.) of_34) sltop_34) 3300.))
(declare-fun slbot_35 () Real)
(declare-fun sltop_35 () Real)
; 
; =  {(((sc.vadd[5].OUT*0.)+of.vadd[5].OUT)+sl.min.vadd[5].OUT)} {-824.99995}
(assert (= (+ (+ (* sc_35 0.) of_35) slbot_35) -824.99995))
; 
; =  {(((sc.vadd[5].OUT*4.)+of.vadd[5].OUT)+sl.max.vadd[5].OUT)} {1649.999975}
(assert (= (+ (+ (* sc_35 4.) of_35) sltop_35) 1649.999975))
(declare-fun slbot_36 () Real)
(declare-fun sltop_36 () Real)
; 
; =  {(((sc.vadd[5].OUT2*0.)+of.vadd[5].OUT2)+sl.min.vadd[5].OUT2)} {0.}
(assert (= (+ (+ (* sc_36 0.) of_36) slbot_36) 0.))
; 
; =  {(((sc.vadd[5].OUT2*1.)+of.vadd[5].OUT2)+sl.max.vadd[5].OUT2)} {5.}
(assert (= (+ (+ (* sc_36 1.) of_36) sltop_36) 5.))
(declare-fun sc_37 () Real)
(declare-fun of_37 () Real)
(declare-fun sc_38 () Real)
(declare-fun of_38 () Real)
(declare-fun sc_39 () Real)
(declare-fun of_39 () Real)
(assert (= 0. 0))
(assert (= of_38 0))
(assert (= 0. 0))
(assert (= of_37 0))
; 
; =  {sc.vtoi[0].Y} {((1/sc.vtoi[0].K)*sc.vtoi[0].X)}
(assert (= sc_39 (* (/ 1 sc_38) sc_37)))
; 
; =  {of.vtoi[0].Y} {0}
(assert (= of_39 0.))
(declare-fun slbot_37 () Real)
(declare-fun sltop_37 () Real)
; 
; =  {(((sc.vtoi[0].X*0.)+of.vtoi[0].X)+sl.min.vtoi[0].X)} {1.}
(assert (= (+ (+ (* sc_37 0.) of_37) slbot_37) 1.))
; 
; =  {(((sc.vtoi[0].X*1.)+of.vtoi[0].X)+sl.max.vtoi[0].X)} {3300.}
(assert (= (+ (+ (* sc_37 1.) of_37) sltop_37) 3300.))
; 
; >=  {((sc.vtoi[0].K*1.)+of.vtoi[0].K)} {3300.}
(assert (<= (+ (* sc_38 1.) of_38) 3300.))
; 
; <=  {((sc.vtoi[0].K*1.)+of.vtoi[0].K)} {1.}
(assert (>= (+ (* sc_38 1.) of_38) 1.))
(declare-fun slbot_39 () Real)
(declare-fun sltop_39 () Real)
; 
; =  {(((sc.vtoi[0].Y*0.)+of.vtoi[0].Y)+sl.min.vtoi[0].Y)} {0.00030303030303}
(assert (= (+ (+ (* sc_39 0.) of_39) slbot_39) 0.00030303030303))
; 
; =  {(((sc.vtoi[0].Y*1.)+of.vtoi[0].Y)+sl.max.vtoi[0].Y)} {3300.}
(assert (= (+ (+ (* sc_39 1.) of_39) sltop_39) 3300.))
(declare-fun sc_40 () Real)
(declare-fun of_40 () Real)
(declare-fun sc_41 () Real)
(declare-fun of_41 () Real)
(declare-fun sc_42 () Real)
(declare-fun of_42 () Real)
(assert (= 0. 0))
(assert (= of_41 0))
(assert (= 0. 0))
(assert (= of_40 0))
; 
; =  {sc.vtoi[6].Y} {((1/sc.vtoi[6].K)*sc.vtoi[6].X)}
(assert (= sc_42 (* (/ 1 sc_41) sc_40)))
; 
; =  {of.vtoi[6].Y} {0}
(assert (= of_42 0.))
(declare-fun slbot_40 () Real)
(declare-fun sltop_40 () Real)
; 
; =  {(((sc.vtoi[6].X*0.)+of.vtoi[6].X)+sl.min.vtoi[6].X)} {1.}
(assert (= (+ (+ (* sc_40 0.) of_40) slbot_40) 1.))
; 
; =  {(((sc.vtoi[6].X*1.)+of.vtoi[6].X)+sl.max.vtoi[6].X)} {3300.}
(assert (= (+ (+ (* sc_40 1.) of_40) sltop_40) 3300.))
; 
; >=  {((sc.vtoi[6].K*1.)+of.vtoi[6].K)} {3300.}
(assert (<= (+ (* sc_41 1.) of_41) 3300.))
; 
; <=  {((sc.vtoi[6].K*1.)+of.vtoi[6].K)} {1.}
(assert (>= (+ (* sc_41 1.) of_41) 1.))
(declare-fun slbot_42 () Real)
(declare-fun sltop_42 () Real)
; 
; =  {(((sc.vtoi[6].Y*0.)+of.vtoi[6].Y)+sl.min.vtoi[6].Y)} {0.00030303030303}
(assert (= (+ (+ (* sc_42 0.) of_42) slbot_42) 0.00030303030303))
; 
; =  {(((sc.vtoi[6].Y*1.)+of.vtoi[6].Y)+sl.max.vtoi[6].Y)} {3300.}
(assert (= (+ (+ (* sc_42 1.) of_42) sltop_42) 3300.))
(declare-fun sc_43 () Real)
(declare-fun of_43 () Real)
(declare-fun sc_44 () Real)
(declare-fun of_44 () Real)
; 
; =  {sc.input.V[2].O} {sc.input.V[2].X}
(assert (= sc_44 sc_43))
; 
; =  {of.input.V[2].O} {of.input.V[2].X}
(assert (= of_44 of_43))
; 
; >=  {((sc.input.V[2].X*0.)+of.input.V[2].X)} {5.}
(assert (<= (+ (* sc_43 0.) of_43) 5.))
; 
; <=  {((sc.input.V[2].X*0.)+of.input.V[2].X)} {0.}
(assert (>= (+ (* sc_43 0.) of_43) 0.))
; 
; >=  {((sc.input.V[2].O*0.)+of.input.V[2].O)} {5.}
(assert (<= (+ (* sc_44 0.) of_44) 5.))
; 
; <=  {((sc.input.V[2].O*0.)+of.input.V[2].O)} {0.}
(assert (>= (+ (* sc_44 0.) of_44) 0.))
(declare-fun sc_45 () Real)
(declare-fun of_45 () Real)
(declare-fun sc_46 () Real)
(declare-fun of_46 () Real)
; 
; =  {sc.input.V[0].O} {sc.input.V[0].X}
(assert (= sc_46 sc_45))
; 
; =  {of.input.V[0].O} {of.input.V[0].X}
(assert (= of_46 of_45))
; 
; >=  {((sc.input.V[0].X*0.125)+of.input.V[0].X)} {5.}
(assert (<= (+ (* sc_45 0.125) of_45) 5.))
; 
; <=  {((sc.input.V[0].X*0.125)+of.input.V[0].X)} {0.}
(assert (>= (+ (* sc_45 0.125) of_45) 0.))
; 
; >=  {((sc.input.V[0].O*0.125)+of.input.V[0].O)} {5.}
(assert (<= (+ (* sc_46 0.125) of_46) 5.))
; 
; <=  {((sc.input.V[0].O*0.125)+of.input.V[0].O)} {0.}
(assert (>= (+ (* sc_46 0.125) of_46) 0.))
(declare-fun sc_47 () Real)
(declare-fun of_47 () Real)
(declare-fun sc_48 () Real)
(declare-fun of_48 () Real)
; 
; =  {sc.input.V[3].O} {sc.input.V[3].X}
(assert (= sc_48 sc_47))
; 
; =  {of.input.V[3].O} {of.input.V[3].X}
(assert (= of_48 of_47))
; 
; >=  {((sc.input.V[3].X*4.)+of.input.V[3].X)} {5.}
(assert (<= (+ (* sc_47 4.) of_47) 5.))
; 
; <=  {((sc.input.V[3].X*4.)+of.input.V[3].X)} {0.}
(assert (>= (+ (* sc_47 4.) of_47) 0.))
; 
; >=  {((sc.input.V[3].O*4.)+of.input.V[3].O)} {5.}
(assert (<= (+ (* sc_48 4.) of_48) 5.))
; 
; <=  {((sc.input.V[3].O*4.)+of.input.V[3].O)} {0.}
(assert (>= (+ (* sc_48 4.) of_48) 0.))
(declare-fun sc_49 () Real)
(declare-fun of_49 () Real)
(declare-fun sc_50 () Real)
(declare-fun of_50 () Real)
; 
; =  {sc.input.V[4].O} {sc.input.V[4].X}
(assert (= sc_50 sc_49))
; 
; =  {of.input.V[4].O} {of.input.V[4].X}
(assert (= of_50 of_49))
; 
; >=  {((sc.input.V[4].X*1.)+of.input.V[4].X)} {5.}
(assert (<= (+ (* sc_49 1.) of_49) 5.))
; 
; <=  {((sc.input.V[4].X*1.)+of.input.V[4].X)} {0.}
(assert (>= (+ (* sc_49 1.) of_49) 0.))
; 
; >=  {((sc.input.V[4].O*1.)+of.input.V[4].O)} {5.}
(assert (<= (+ (* sc_50 1.) of_50) 5.))
; 
; <=  {((sc.input.V[4].O*1.)+of.input.V[4].O)} {0.}
(assert (>= (+ (* sc_50 1.) of_50) 0.))
(declare-fun sc_51 () Real)
(declare-fun of_51 () Real)
(declare-fun sc_52 () Real)
(declare-fun of_52 () Real)
; 
; =  {sc.input.V[1].O} {sc.input.V[1].X}
(assert (= sc_52 sc_51))
; 
; =  {of.input.V[1].O} {of.input.V[1].X}
(assert (= of_52 of_51))
; 
; >=  {((sc.input.V[1].X*0.)+of.input.V[1].X)} {5.}
(assert (<= (+ (* sc_51 0.) of_51) 5.))
; 
; <=  {((sc.input.V[1].X*0.)+of.input.V[1].X)} {0.}
(assert (>= (+ (* sc_51 0.) of_51) 0.))
; 
; >=  {((sc.input.V[1].O*0.)+of.input.V[1].O)} {5.}
(assert (<= (+ (* sc_52 0.) of_52) 5.))
; 
; <=  {((sc.input.V[1].O*0.)+of.input.V[1].O)} {0.}
(assert (>= (+ (* sc_52 0.) of_52) 0.))
(declare-fun sc_53 () Real)
(declare-fun of_53 () Real)
(declare-fun sc_54 () Real)
(declare-fun of_54 () Real)
; 
; =  {sc.input.V[17].O} {sc.input.V[17].X}
(assert (= sc_54 sc_53))
; 
; =  {of.input.V[17].O} {of.input.V[17].X}
(assert (= of_54 of_53))
; 
; >=  {((sc.input.V[17].X*1.)+of.input.V[17].X)} {5.}
(assert (<= (+ (* sc_53 1.) of_53) 5.))
; 
; <=  {((sc.input.V[17].X*1.)+of.input.V[17].X)} {0.}
(assert (>= (+ (* sc_53 1.) of_53) 0.))
; 
; >=  {((sc.input.V[17].O*1.)+of.input.V[17].O)} {5.}
(assert (<= (+ (* sc_54 1.) of_54) 5.))
; 
; <=  {((sc.input.V[17].O*1.)+of.input.V[17].O)} {0.}
(assert (>= (+ (* sc_54 1.) of_54) 0.))
(declare-fun sc_55 () Real)
(declare-fun of_55 () Real)
(declare-fun sc_56 () Real)
(declare-fun of_56 () Real)
; 
; =  {sc.input.V[18].O} {sc.input.V[18].X}
(assert (= sc_56 sc_55))
; 
; =  {of.input.V[18].O} {of.input.V[18].X}
(assert (= of_56 of_55))
; 
; >=  {((sc.input.V[18].X*1.)+of.input.V[18].X)} {5.}
(assert (<= (+ (* sc_55 1.) of_55) 5.))
; 
; <=  {((sc.input.V[18].X*1.)+of.input.V[18].X)} {0.}
(assert (>= (+ (* sc_55 1.) of_55) 0.))
; 
; >=  {((sc.input.V[18].O*1.)+of.input.V[18].O)} {5.}
(assert (<= (+ (* sc_56 1.) of_56) 5.))
; 
; <=  {((sc.input.V[18].O*1.)+of.input.V[18].O)} {0.}
(assert (>= (+ (* sc_56 1.) of_56) 0.))
(declare-fun sc_57 () Real)
(declare-fun of_57 () Real)
(declare-fun sc_58 () Real)
(declare-fun of_58 () Real)
(declare-fun sc_59 () Real)
(declare-fun of_59 () Real)
(assert (= of_58 0))
(assert (= of_57 0))
; 
; =  {sc.itov[6].Y} {(sc.itov[6].K*sc.itov[6].X)}
(assert (= sc_59 (* sc_58 sc_57)))
; 
; =  {of.itov[6].Y} {0}
(assert (= of_59 0.))
(declare-fun slbot_57 () Real)
(declare-fun sltop_57 () Real)
; 
; =  {(((sc.itov[6].X*0.)+of.itov[6].X)+sl.min.itov[6].X)} {0.0001}
(assert (= (+ (+ (* sc_57 0.) of_57) slbot_57) 0.0001))
; 
; =  {(((sc.itov[6].X*1.)+of.itov[6].X)+sl.max.itov[6].X)} {10.}
(assert (= (+ (+ (* sc_57 1.) of_57) sltop_57) 10.))
(declare-fun slbot_59 () Real)
(declare-fun sltop_59 () Real)
; 
; =  {(((sc.itov[6].Y*0.)+of.itov[6].Y)+sl.min.itov[6].Y)} {0.0001}
(assert (= (+ (+ (* sc_59 0.) of_59) slbot_59) 0.0001))
; 
; =  {(((sc.itov[6].Y*4.)+of.itov[6].Y)+sl.max.itov[6].Y)} {3300.}
(assert (= (+ (+ (* sc_59 4.) of_59) sltop_59) 3300.))
(declare-fun slbot_58 () Real)
(declare-fun sltop_58 () Real)
; 
; =  {(((sc.itov[6].K*0.)+of.itov[6].K)+sl.min.itov[6].K)} {1.}
(assert (= (+ (+ (* sc_58 0.) of_58) slbot_58) 1.))
; 
; =  {(((sc.itov[6].K*4.)+of.itov[6].K)+sl.max.itov[6].K)} {330.}
(assert (= (+ (+ (* sc_58 4.) of_58) sltop_58) 330.))
(declare-fun slbot_59 () Real)
(declare-fun sltop_59 () Real)
; 
; =  {(((sc.itov[6].Y*0.)+of.itov[6].Y)+sl.min.itov[6].Y)} {0.0001}
(assert (= (+ (+ (* sc_59 0.) of_59) slbot_59) 0.0001))
; 
; =  {(((sc.itov[6].Y*4.)+of.itov[6].Y)+sl.max.itov[6].Y)} {3300.}
(assert (= (+ (+ (* sc_59 4.) of_59) sltop_59) 3300.))
(declare-fun sc_60 () Real)
(declare-fun of_60 () Real)
(declare-fun sc_61 () Real)
(declare-fun of_61 () Real)
(declare-fun sc_62 () Real)
(declare-fun of_62 () Real)
(declare-fun sc_63 () Real)
(declare-fun of_63 () Real)
(declare-fun sc_64 () Real)
(declare-fun of_64 () Real)
; 
; =  {sc.iadd[2].A} {sc.iadd[2].B}
(assert (= sc_62 sc_63))
; 
; =  {sc.iadd[2].A} {sc.iadd[2].C} {sc.iadd[2].D}
(assert (and (= sc_62 sc_61) (= sc_62 sc_60)))
; 
; =  {sc.iadd[2].OUT} {sc.iadd[2].A}
(assert (= sc_64 sc_62))
; 
; =  {of.iadd[2].OUT} {((of.iadd[2].A+of.iadd[2].B)-of.iadd[2].C-of.iadd[2].D)}
(assert (= of_64 (- (+ of_62 of_63) (+ of_61 of_60))))
(declare-fun slbot_60 () Real)
(declare-fun sltop_60 () Real)
; 
; =  {(((sc.iadd[2].D*0.)+of.iadd[2].D)+sl.min.iadd[2].D)} {0.}
(assert (= (+ (+ (* sc_60 0.) of_60) slbot_60) 0.))
; 
; =  {(((sc.iadd[2].D*1.)+of.iadd[2].D)+sl.max.iadd[2].D)} {5.}
(assert (= (+ (+ (* sc_60 1.) of_60) sltop_60) 5.))
; 
; >=  {((sc.iadd[2].C*0.)+of.iadd[2].C)} {5.}
(assert (<= (+ (* sc_61 0.) of_61) 5.))
; 
; <=  {((sc.iadd[2].C*0.)+of.iadd[2].C)} {0.}
(assert (>= (+ (* sc_61 0.) of_61) 0.))
(declare-fun slbot_64 () Real)
(declare-fun sltop_64 () Real)
; 
; =  {(((sc.iadd[2].OUT*-1.)+of.iadd[2].OUT)+sl.min.iadd[2].OUT)} {-10.}
(assert (= (+ (+ (* sc_64 -1.) of_64) slbot_64) -10.))
; 
; =  {(((sc.iadd[2].OUT*0.)+of.iadd[2].OUT)+sl.max.iadd[2].OUT)} {10.}
(assert (= (+ (+ (* sc_64 0.) of_64) sltop_64) 10.))
; 
; >=  {((sc.iadd[2].A*0.)+of.iadd[2].A)} {5.}
(assert (<= (+ (* sc_62 0.) of_62) 5.))
; 
; <=  {((sc.iadd[2].A*0.)+of.iadd[2].A)} {0.}
(assert (>= (+ (* sc_62 0.) of_62) 0.))
; 
; >=  {((sc.iadd[2].B*0.)+of.iadd[2].B)} {5.}
(assert (<= (+ (* sc_63 0.) of_63) 5.))
; 
; <=  {((sc.iadd[2].B*0.)+of.iadd[2].B)} {0.}
(assert (>= (+ (* sc_63 0.) of_63) 0.))
(declare-fun slbot_64 () Real)
(declare-fun sltop_64 () Real)
; 
; =  {(((sc.iadd[2].OUT*-1.)+of.iadd[2].OUT)+sl.min.iadd[2].OUT)} {-10.}
(assert (= (+ (+ (* sc_64 -1.) of_64) slbot_64) -10.))
; 
; =  {(((sc.iadd[2].OUT*0.)+of.iadd[2].OUT)+sl.max.iadd[2].OUT)} {10.}
(assert (= (+ (+ (* sc_64 0.) of_64) sltop_64) 10.))
(declare-fun sc_65 () Real)
(declare-fun of_65 () Real)
(declare-fun sc_66 () Real)
(declare-fun of_66 () Real)
(declare-fun sc_67 () Real)
(declare-fun of_67 () Real)
(declare-fun sc_68 () Real)
(declare-fun of_68 () Real)
(declare-fun sc_69 () Real)
(declare-fun of_69 () Real)
; 
; =  {sc.iadd[0].A} {sc.iadd[0].B}
(assert (= sc_67 sc_68))
; 
; =  {sc.iadd[0].A} {sc.iadd[0].C} {sc.iadd[0].D}
(assert (and (= sc_67 sc_66) (= sc_67 sc_65)))
; 
; =  {sc.iadd[0].OUT} {sc.iadd[0].A}
(assert (= sc_69 sc_67))
; 
; =  {of.iadd[0].OUT} {((of.iadd[0].A+of.iadd[0].B)-of.iadd[0].C-of.iadd[0].D)}
(assert (= of_69 (- (+ of_67 of_68) (+ of_66 of_65))))
(declare-fun slbot_65 () Real)
(declare-fun sltop_65 () Real)
; 
; =  {(((sc.iadd[0].D*0.)+of.iadd[0].D)+sl.min.iadd[0].D)} {0.}
(assert (= (+ (+ (* sc_65 0.) of_65) slbot_65) 0.))
; 
; =  {(((sc.iadd[0].D*1.)+of.iadd[0].D)+sl.max.iadd[0].D)} {5.}
(assert (= (+ (+ (* sc_65 1.) of_65) sltop_65) 5.))
; 
; >=  {((sc.iadd[0].C*0.)+of.iadd[0].C)} {5.}
(assert (<= (+ (* sc_66 0.) of_66) 5.))
; 
; <=  {((sc.iadd[0].C*0.)+of.iadd[0].C)} {0.}
(assert (>= (+ (* sc_66 0.) of_66) 0.))
(declare-fun slbot_69 () Real)
(declare-fun sltop_69 () Real)
; 
; =  {(((sc.iadd[0].OUT*-1.)+of.iadd[0].OUT)+sl.min.iadd[0].OUT)} {-10.}
(assert (= (+ (+ (* sc_69 -1.) of_69) slbot_69) -10.))
; 
; =  {(((sc.iadd[0].OUT*0.)+of.iadd[0].OUT)+sl.max.iadd[0].OUT)} {10.}
(assert (= (+ (+ (* sc_69 0.) of_69) sltop_69) 10.))
; 
; >=  {((sc.iadd[0].A*0.)+of.iadd[0].A)} {5.}
(assert (<= (+ (* sc_67 0.) of_67) 5.))
; 
; <=  {((sc.iadd[0].A*0.)+of.iadd[0].A)} {0.}
(assert (>= (+ (* sc_67 0.) of_67) 0.))
; 
; >=  {((sc.iadd[0].B*0.)+of.iadd[0].B)} {5.}
(assert (<= (+ (* sc_68 0.) of_68) 5.))
; 
; <=  {((sc.iadd[0].B*0.)+of.iadd[0].B)} {0.}
(assert (>= (+ (* sc_68 0.) of_68) 0.))
(declare-fun slbot_69 () Real)
(declare-fun sltop_69 () Real)
; 
; =  {(((sc.iadd[0].OUT*-1.)+of.iadd[0].OUT)+sl.min.iadd[0].OUT)} {-10.}
(assert (= (+ (+ (* sc_69 -1.) of_69) slbot_69) -10.))
; 
; =  {(((sc.iadd[0].OUT*0.)+of.iadd[0].OUT)+sl.max.iadd[0].OUT)} {10.}
(assert (= (+ (+ (* sc_69 0.) of_69) sltop_69) 10.))
(declare-fun sc_70 () Real)
(declare-fun of_70 () Real)
(declare-fun sc_71 () Real)
(declare-fun of_71 () Real)
(declare-fun sc_72 () Real)
(declare-fun of_72 () Real)
(declare-fun sc_73 () Real)
(declare-fun of_73 () Real)
(declare-fun sc_74 () Real)
(declare-fun of_74 () Real)
; 
; =  {sc.iadd[3].A} {sc.iadd[3].B}
(assert (= sc_72 sc_73))
; 
; =  {sc.iadd[3].A} {sc.iadd[3].C} {sc.iadd[3].D}
(assert (and (= sc_72 sc_71) (= sc_72 sc_70)))
; 
; =  {sc.iadd[3].OUT} {sc.iadd[3].A}
(assert (= sc_74 sc_72))
; 
; =  {of.iadd[3].OUT} {((of.iadd[3].A+of.iadd[3].B)-of.iadd[3].C-of.iadd[3].D)}
(assert (= of_74 (- (+ of_72 of_73) (+ of_71 of_70))))
; 
; >=  {((sc.iadd[3].D*-0.15)+of.iadd[3].D)} {5.}
(assert (<= (+ (* sc_70 -0.15) of_70) 5.))
; 
; <=  {((sc.iadd[3].D*-0.15)+of.iadd[3].D)} {0.}
(assert (>= (+ (* sc_70 -0.15) of_70) 0.))
; 
; >=  {((sc.iadd[3].C*0.)+of.iadd[3].C)} {5.}
(assert (<= (+ (* sc_71 0.) of_71) 5.))
; 
; <=  {((sc.iadd[3].C*0.)+of.iadd[3].C)} {0.}
(assert (>= (+ (* sc_71 0.) of_71) 0.))
(declare-fun slbot_74 () Real)
(declare-fun sltop_74 () Real)
; 
; =  {(((sc.iadd[3].OUT*0.)+of.iadd[3].OUT)+sl.min.iadd[3].OUT)} {-10.}
(assert (= (+ (+ (* sc_74 0.) of_74) slbot_74) -10.))
; 
; =  {(((sc.iadd[3].OUT*1.)+of.iadd[3].OUT)+sl.max.iadd[3].OUT)} {10.}
(assert (= (+ (+ (* sc_74 1.) of_74) sltop_74) 10.))
; 
; >=  {((sc.iadd[3].A*0.)+of.iadd[3].A)} {5.}
(assert (<= (+ (* sc_72 0.) of_72) 5.))
; 
; <=  {((sc.iadd[3].A*0.)+of.iadd[3].A)} {0.}
(assert (>= (+ (* sc_72 0.) of_72) 0.))
(declare-fun slbot_73 () Real)
(declare-fun sltop_73 () Real)
; 
; =  {(((sc.iadd[3].B*-1.)+of.iadd[3].B)+sl.min.iadd[3].B)} {0.}
(assert (= (+ (+ (* sc_73 -1.) of_73) slbot_73) 0.))
; 
; =  {(((sc.iadd[3].B*0.)+of.iadd[3].B)+sl.max.iadd[3].B)} {5.}
(assert (= (+ (+ (* sc_73 0.) of_73) sltop_73) 5.))
(declare-fun slbot_74 () Real)
(declare-fun sltop_74 () Real)
; 
; =  {(((sc.iadd[3].OUT*0.)+of.iadd[3].OUT)+sl.min.iadd[3].OUT)} {-10.}
(assert (= (+ (+ (* sc_74 0.) of_74) slbot_74) -10.))
; 
; =  {(((sc.iadd[3].OUT*1.)+of.iadd[3].OUT)+sl.max.iadd[3].OUT)} {10.}
(assert (= (+ (+ (* sc_74 1.) of_74) sltop_74) 10.))
(declare-fun sc_75 () Real)
(declare-fun of_75 () Real)
(declare-fun sc_76 () Real)
(declare-fun of_76 () Real)
(declare-fun sc_77 () Real)
(declare-fun of_77 () Real)
(declare-fun sc_78 () Real)
(declare-fun of_78 () Real)
(declare-fun sc_79 () Real)
(declare-fun of_79 () Real)
; 
; =  {sc.iadd[1].A} {sc.iadd[1].B}
(assert (= sc_77 sc_78))
; 
; =  {sc.iadd[1].A} {sc.iadd[1].C} {sc.iadd[1].D}
(assert (and (= sc_77 sc_76) (= sc_77 sc_75)))
; 
; =  {sc.iadd[1].OUT} {sc.iadd[1].A}
(assert (= sc_79 sc_77))
; 
; =  {of.iadd[1].OUT} {((of.iadd[1].A+of.iadd[1].B)-of.iadd[1].C-of.iadd[1].D)}
(assert (= of_79 (- (+ of_77 of_78) (+ of_76 of_75))))
; 
; >=  {((sc.iadd[1].D*-0.11)+of.iadd[1].D)} {5.}
(assert (<= (+ (* sc_75 -0.11) of_75) 5.))
; 
; <=  {((sc.iadd[1].D*-0.11)+of.iadd[1].D)} {0.}
(assert (>= (+ (* sc_75 -0.11) of_75) 0.))
; 
; >=  {((sc.iadd[1].C*0.)+of.iadd[1].C)} {5.}
(assert (<= (+ (* sc_76 0.) of_76) 5.))
; 
; <=  {((sc.iadd[1].C*0.)+of.iadd[1].C)} {0.}
(assert (>= (+ (* sc_76 0.) of_76) 0.))
(declare-fun slbot_79 () Real)
(declare-fun sltop_79 () Real)
; 
; =  {(((sc.iadd[1].OUT*0.)+of.iadd[1].OUT)+sl.min.iadd[1].OUT)} {-10.}
(assert (= (+ (+ (* sc_79 0.) of_79) slbot_79) -10.))
; 
; =  {(((sc.iadd[1].OUT*1.)+of.iadd[1].OUT)+sl.max.iadd[1].OUT)} {10.}
(assert (= (+ (+ (* sc_79 1.) of_79) sltop_79) 10.))
; 
; >=  {((sc.iadd[1].A*0.)+of.iadd[1].A)} {5.}
(assert (<= (+ (* sc_77 0.) of_77) 5.))
; 
; <=  {((sc.iadd[1].A*0.)+of.iadd[1].A)} {0.}
(assert (>= (+ (* sc_77 0.) of_77) 0.))
(declare-fun slbot_78 () Real)
(declare-fun sltop_78 () Real)
; 
; =  {(((sc.iadd[1].B*-1.)+of.iadd[1].B)+sl.min.iadd[1].B)} {0.}
(assert (= (+ (+ (* sc_78 -1.) of_78) slbot_78) 0.))
; 
; =  {(((sc.iadd[1].B*0.)+of.iadd[1].B)+sl.max.iadd[1].B)} {5.}
(assert (= (+ (+ (* sc_78 0.) of_78) sltop_78) 5.))
(declare-fun slbot_79 () Real)
(declare-fun sltop_79 () Real)
; 
; =  {(((sc.iadd[1].OUT*0.)+of.iadd[1].OUT)+sl.min.iadd[1].OUT)} {-10.}
(assert (= (+ (+ (* sc_79 0.) of_79) slbot_79) -10.))
; 
; =  {(((sc.iadd[1].OUT*1.)+of.iadd[1].OUT)+sl.max.iadd[1].OUT)} {10.}
(assert (= (+ (+ (* sc_79 1.) of_79) sltop_79) 10.))
(declare-fun sc_80 () Real)
(declare-fun of_80 () Real)
(declare-fun sc_81 () Real)
(declare-fun of_81 () Real)
; 
; =  {sc.output.I[0].O} {sc.output.I[0].X}
(assert (= sc_81 sc_80))
; 
; =  {of.output.I[0].O} {of.output.I[0].X}
(assert (= of_81 of_80))
(declare-fun slbot_80 () Real)
(declare-fun sltop_80 () Real)
; 
; =  {(((sc.output.I[0].X*0.)+of.output.I[0].X)+sl.min.output.I[0].X)} {0.}
(assert (= (+ (+ (* sc_80 0.) of_80) slbot_80) 0.))
; 
; =  {(((sc.output.I[0].X*1.)+of.output.I[0].X)+sl.max.output.I[0].X)} {10.}
(assert (= (+ (+ (* sc_80 1.) of_80) sltop_80) 10.))
(declare-fun slbot_81 () Real)
(declare-fun sltop_81 () Real)
; 
; =  {(((sc.output.I[0].O*0.)+of.output.I[0].O)+sl.min.output.I[0].O)} {0.}
(assert (= (+ (+ (* sc_81 0.) of_81) slbot_81) 0.))
; 
; =  {(((sc.output.I[0].O*1.)+of.output.I[0].O)+sl.max.output.I[0].O)} {10.}
(assert (= (+ (+ (* sc_81 1.) of_81) sltop_81) 10.))
(declare-fun sc_82 () Real)
(declare-fun of_82 () Real)
(declare-fun sc_83 () Real)
(declare-fun of_83 () Real)
; 
; =  {sc.output.I[1].O} {sc.output.I[1].X}
(assert (= sc_83 sc_82))
; 
; =  {of.output.I[1].O} {of.output.I[1].X}
(assert (= of_83 of_82))
(declare-fun slbot_82 () Real)
(declare-fun sltop_82 () Real)
; 
; =  {(((sc.output.I[1].X*0.)+of.output.I[1].X)+sl.min.output.I[1].X)} {0.}
(assert (= (+ (+ (* sc_82 0.) of_82) slbot_82) 0.))
; 
; =  {(((sc.output.I[1].X*1.)+of.output.I[1].X)+sl.max.output.I[1].X)} {10.}
(assert (= (+ (+ (* sc_82 1.) of_82) sltop_82) 10.))
(declare-fun slbot_83 () Real)
(declare-fun sltop_83 () Real)
; 
; =  {(((sc.output.I[1].O*0.)+of.output.I[1].O)+sl.min.output.I[1].O)} {0.}
(assert (= (+ (+ (* sc_83 0.) of_83) slbot_83) 0.))
; 
; =  {(((sc.output.I[1].O*1.)+of.output.I[1].O)+sl.max.output.I[1].O)} {10.}
(assert (= (+ (+ (* sc_83 1.) of_83) sltop_83) 10.))
; 
; =  {sc.input.V[17].O} {sc.vtoi[6].K}
(assert (= sc_54 sc_41))
; 
; =  {of.input.V[17].O} {of.vtoi[6].K}
(assert (= of_54 of_41))
; 
; =  {sc.input.I[6].O} {sc.iadd[2].A}
(assert (= sc_19 sc_62))
; 
; =  {of.input.I[6].O} {of.iadd[2].A}
(assert (= of_19 of_62))
; 
; =  {sc.input.I[0].O} {sc.iadd[1].D}
(assert (= sc_13 sc_75))
; 
; =  {of.input.I[0].O} {of.iadd[1].D}
(assert (= of_13 of_75))
; 
; =  {sc.input.I[9].O} {sc.iadd[3].A}
(assert (= sc_11 sc_72))
; 
; =  {of.input.I[9].O} {of.iadd[3].A}
(assert (= of_11 of_72))
; 
; =  {sc.input.I[4].O} {sc.iadd[1].A}
(assert (= sc_23 sc_77))
; 
; =  {of.input.I[4].O} {of.iadd[1].A}
(assert (= of_23 of_77))
; 
; =  {sc.input.I[3].O} {sc.iadd[0].C}
(assert (= sc_21 sc_66))
; 
; =  {of.input.I[3].O} {of.iadd[0].C}
(assert (= of_21 of_66))
; 
; =  {sc.vtoi[6].Y} {sc.iadd[0].D}
(assert (= sc_42 sc_65))
; 
; =  {of.vtoi[6].Y} {of.iadd[0].D}
(assert (= of_42 of_65))
; 
; =  {sc.input.I[5].O} {sc.iadd[1].C}
(assert (= sc_25 sc_76))
; 
; =  {of.input.I[5].O} {of.iadd[1].C}
(assert (= of_25 of_76))
; 
; =  {sc.vtoi[0].Y} {sc.iadd[2].D}
(assert (= sc_39 sc_60))
; 
; =  {of.vtoi[0].Y} {of.iadd[2].D}
(assert (= of_39 of_60))
; 
; =  {sc.input.I[2].O} {sc.iadd[0].B}
(assert (= sc_5 sc_68))
; 
; =  {of.input.I[2].O} {of.iadd[0].B}
(assert (= of_5 of_68))
; 
; =  {sc.input.V[2].O} {sc.vadd[5].OUT2_0}
(assert (= sc_44 sc_30))
; 
; =  {of.input.V[2].O} {of.vadd[5].OUT2_0}
(assert (= of_44 of_30))
; 
; =  {sc.input.V[3].O} {sc.vadd[5].D}
(assert (= sc_48 sc_31))
; 
; =  {of.input.V[3].O} {of.vadd[5].D}
(assert (= of_48 of_31))
; 
; =  {sc.vadd[5].OUT2} {sc.vtoi[6].X}
(assert (= sc_36 sc_40))
; 
; =  {of.vadd[5].OUT2} {of.vtoi[6].X}
(assert (= of_36 of_40))
; 
; =  {sc.vadd[5].OUT2} {sc.output.V[0].X}
(assert (= sc_36 sc_28))
; 
; =  {of.vadd[5].OUT2} {of.output.V[0].X}
(assert (= of_36 of_28))
; 
; =  {sc.vadd[5].OUT2} {sc.vtoi[0].X}
(assert (= sc_36 sc_37))
; 
; =  {of.vadd[5].OUT2} {of.vtoi[0].X}
(assert (= of_36 of_37))
; 
; =  {sc.iadd[0].OUT} {sc.iadd[1].B}
(assert (= sc_69 sc_78))
; 
; =  {of.iadd[0].OUT} {of.iadd[1].B}
(assert (= of_69 of_78))
; 
; =  {sc.input.I[10].O} {sc.iadd[3].C}
(assert (= sc_17 sc_71))
; 
; =  {of.input.I[10].O} {of.iadd[3].C}
(assert (= of_17 of_71))
; 
; =  {sc.input.I[1].O} {sc.iadd[0].A}
(assert (= sc_27 sc_67))
; 
; =  {of.input.I[1].O} {of.iadd[0].A}
(assert (= of_27 of_67))
; 
; =  {sc.iadd[1].OUT} {sc.output.I[0].X}
(assert (= sc_79 sc_80))
; 
; =  {of.iadd[1].OUT} {of.output.I[0].X}
(assert (= of_79 of_80))
; 
; =  {sc.iadd[1].OUT} {sc.itov[6].X}
(assert (= sc_79 sc_57))
; 
; =  {of.iadd[1].OUT} {of.itov[6].X}
(assert (= of_79 of_57))
; 
; =  {sc.input.V[1].O} {sc.vadd[5].A}
(assert (= sc_52 sc_33))
; 
; =  {of.input.V[1].O} {of.vadd[5].A}
(assert (= of_52 of_33))
; 
; =  {sc.input.I[7].O} {sc.iadd[2].B}
(assert (= sc_9 sc_63))
; 
; =  {of.input.I[7].O} {of.iadd[2].B}
(assert (= of_9 of_63))
; 
; =  {sc.iadd[3].OUT} {sc.vgain[4].Z}
(assert (= sc_74 sc_2))
; 
; =  {of.iadd[3].OUT} {of.vgain[4].Z}
(assert (= of_74 of_2))
; 
; =  {sc.iadd[3].OUT} {sc.output.I[1].X}
(assert (= sc_74 sc_82))
; 
; =  {of.iadd[3].OUT} {of.output.I[1].X}
(assert (= of_74 of_82))
; 
; =  {sc.iadd[2].OUT} {sc.iadd[3].B}
(assert (= sc_64 sc_73))
; 
; =  {of.iadd[2].OUT} {of.iadd[3].B}
(assert (= of_64 of_73))
; 
; =  {sc.input.I[8].O} {sc.iadd[2].C}
(assert (= sc_7 sc_61))
; 
; =  {of.input.I[8].O} {of.iadd[2].C}
(assert (= of_7 of_61))
; 
; =  {sc.itov[6].Y} {sc.vadd[5].B}
(assert (= sc_59 sc_34))
; 
; =  {of.itov[6].Y} {of.vadd[5].B}
(assert (= of_59 of_34))
; 
; =  {sc.vgain[4].P} {sc.itov[6].K}
(assert (= sc_3 sc_58))
; 
; =  {of.vgain[4].P} {of.itov[6].K}
(assert (= of_3 of_58))
; 
; =  {sc.input.V[0].O} {sc.vgain[4].Y}
(assert (= sc_46 sc_1))
; 
; =  {of.input.V[0].O} {of.vgain[4].Y}
(assert (= of_46 of_1))
; 
; =  {sc.input.V[18].O} {sc.vtoi[0].K}
(assert (= sc_56 sc_38))
; 
; =  {of.input.V[18].O} {of.vtoi[0].K}
(assert (= of_56 of_38))
; 
; =  {sc.input.V[4].O} {sc.vgain[4].X}
(assert (= sc_50 sc_0))
; 
; =  {of.input.V[4].O} {of.vgain[4].X}
(assert (= of_50 of_0))
; 
; =  {sc.input.I[11].O} {sc.iadd[3].D}
(assert (= sc_15 sc_70))
; 
; =  {of.input.I[11].O} {of.iadd[3].D}
(assert (= of_15 of_70))
(assert (<= (* sc_29 0.001) 0.001))
; 
; =  {sc.vadd[5].OUT2} {sc.output.V[0].O}
(assert (= sc_36 sc_29))
(assert (= __minima__ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (+ (* (ite (>= sltop_36 0) sltop_36 (- sltop_36)) 1.) (* (ite (>= slbot_29 0) slbot_29 (- slbot_29)) 1.)) (* (ite (>= slbot_78 0) slbot_78 (- slbot_78)) 1.)) (* (ite (>= slbot_80 0) slbot_80 (- slbot_80)) 1.)) (* (ite (>= slbot_35 0) slbot_35 (- slbot_35)) 1.)) (* (ite (>= slbot_60 0) slbot_60 (- slbot_60)) 1.)) (* (ite (>= sltop_65 0) sltop_65 (- sltop_65)) 1.)) (* (ite (>= sltop_80 0) sltop_80 (- sltop_80)) 1.)) (* (ite (>= sltop_81 0) sltop_81 (- sltop_81)) 1.)) (* (ite (>= slbot_83 0) slbot_83 (- slbot_83)) 1.)) (* (ite (>= slbot_3 0) slbot_3 (- slbot_3)) 1.)) (* (ite (>= sltop_42 0) sltop_42 (- sltop_42)) 1.)) (* (ite (>= sltop_79 0) sltop_79 (- sltop_79)) 1.)) (* (ite (>= sltop_28 0) sltop_28 (- sltop_28)) 1.)) (* (ite (>= slbot_59 0) slbot_59 (- slbot_59)) 1.)) (* (ite (>= slbot_64 0) slbot_64 (- slbot_64)) 1.)) (* (ite (>= slbot_2 0) slbot_2 (- slbot_2)) 1.)) (* (ite (>= slbot_37 0) slbot_37 (- slbot_37)) 1.)) (* (ite (>= sltop_29 0) sltop_29 (- sltop_29)) 1.)) (* (ite (>= sltop_39 0) sltop_39 (- sltop_39)) 1.)) (* (ite (>= sltop_58 0) sltop_58 (- sltop_58)) 1.)) (* (ite (>= slbot_36 0) slbot_36 (- slbot_36)) 1.)) (* (ite (>= sltop_82 0) sltop_82 (- sltop_82)) 1.)) (* (ite (>= slbot_82 0) slbot_82 (- slbot_82)) 1.)) (* (ite (>= sltop_2 0) sltop_2 (- sltop_2)) 1.)) (* (ite (>= slbot_28 0) slbot_28 (- slbot_28)) 1.)) (* (ite (>= sltop_57 0) sltop_57 (- sltop_57)) 1.)) (* (ite (>= slbot_57 0) slbot_57 (- slbot_57)) 1.)) (* (ite (>= slbot_65 0) slbot_65 (- slbot_65)) 1.)) (* (ite (>= sltop_74 0) sltop_74 (- sltop_74)) 1.)) (* (ite (>= slbot_81 0) slbot_81 (- slbot_81)) 1.)) (* (ite (>= sltop_34 0) sltop_34 (- sltop_34)) 1.)) (* (ite (>= sltop_60 0) sltop_60 (- sltop_60)) 1.)) (* (ite (>= slbot_73 0) slbot_73 (- slbot_73)) 1.)) (* (ite (>= sltop_78 0) sltop_78 (- sltop_78)) 1.)) (* (ite (>= sltop_64 0) sltop_64 (- sltop_64)) 1.)) (* (ite (>= sltop_83 0) sltop_83 (- sltop_83)) 1.)) (* (ite (>= sltop_37 0) sltop_37 (- sltop_37)) 1.)) (* (ite (>= slbot_42 0) slbot_42 (- slbot_42)) 1.)) (* (ite (>= slbot_74 0) slbot_74 (- slbot_74)) 1.)) (* (ite (>= sltop_69 0) sltop_69 (- sltop_69)) 1.)) (* (ite (>= slbot_34 0) slbot_34 (- slbot_34)) 1.)) (* (ite (>= sltop_73 0) sltop_73 (- sltop_73)) 1.)) (* (ite (>= slbot_79 0) slbot_79 (- slbot_79)) 1.)) (* (ite (>= sltop_3 0) sltop_3 (- sltop_3)) 1.)) (* (ite (>= sltop_35 0) sltop_35 (- sltop_35)) 1.)) (* (ite (>= slbot_39 0) slbot_39 (- slbot_39)) 1.)) (* (ite (>= sltop_40 0) sltop_40 (- sltop_40)) 1.)) (* (ite (>= slbot_58 0) slbot_58 (- slbot_58)) 1.)) (* (ite (>= slbot_69 0) slbot_69 (- slbot_69)) 1.)) (* (ite (>= slbot_40 0) slbot_40 (- slbot_40)) 1.)) (* (ite (>= sltop_59 0) sltop_59 (- sltop_59)) 1.))))
(check-sat)
