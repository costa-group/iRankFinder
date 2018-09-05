(declare-sort Loc 0)
(declare-const l0 Loc)
(declare-const l1 Loc)
(declare-const l2 Loc)
(declare-const l3 Loc)
(declare-const l4 Loc)
(declare-const l5 Loc)
(declare-const l6 Loc)
(declare-const l7 Loc)
(declare-const l8 Loc)
(declare-const l9 Loc)
(declare-const l10 Loc)
(declare-const l11 Loc)
(declare-const l12 Loc)
(assert (distinct l0 l1 l2 l3 l4 l5 l6 l7 l8 l9 l10 l11 l12))

(define-fun cfg_init ( (pc Loc) (src Loc) (rel Bool) ) Bool
  (and (= pc src) rel))

(define-fun cfg_trans2 ( (pc Loc) (src Loc)
                         (pc1 Loc) (dst Loc)
                         (rel Bool) ) Bool
  (and (= pc src) (= pc1 dst) rel))

(define-fun cfg_trans3 ( (pc Loc) (exit Loc)
                         (pc1 Loc) (call Loc)
                         (pc2 Loc) (return Loc)
                         (rel Bool) ) Bool
  (and (= pc exit) (= pc1 call) (= pc2 return) rel))

(define-fun init_main ( (pc^0 Loc) (Result_4^0 Int) (___cil_tmp2_7^0 Int) (___retres1_6^0 Int) (b_128^0 Int) (b_51^0 Int) (b_76^0 Int) (count_5^0 Int) (lt_12^0 Int) (lt_13^0 Int) (tmp_11^0 Int) (x_8^0 Int) (y_9^0 Int) (z_10^0 Int) ) Bool
  (cfg_init pc^0 l12 true))

(define-fun next_main (
                 (pc^0 Loc) (Result_4^0 Int) (___cil_tmp2_7^0 Int) (___retres1_6^0 Int) (b_128^0 Int) (b_51^0 Int) (b_76^0 Int) (count_5^0 Int) (lt_12^0 Int) (lt_13^0 Int) (tmp_11^0 Int) (x_8^0 Int) (y_9^0 Int) (z_10^0 Int)
                 (pc^post Loc) (Result_4^post Int) (___cil_tmp2_7^post Int) (___retres1_6^post Int) (b_128^post Int) (b_51^post Int) (b_76^post Int) (count_5^post Int) (lt_12^post Int) (lt_13^post Int) (tmp_11^post Int) (x_8^post Int) (y_9^post Int) (z_10^post Int)
             ) Bool
  (or
    (cfg_trans2 pc^0 l0 pc^post l1 (exists ( (Result_4^1 Int) (lt_13^1 Int) ) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= lt_13^1 (+ 0 b_128^0)) (<= (+ 5 (* -1 lt_13^1)) 0)) (= lt_13^post lt_13^post)) (= ___retres1_6^post 1)) (= ___cil_tmp2_7^post (+ 0 ___retres1_6^post))) (= Result_4^1 (+ 0 ___cil_tmp2_7^post))) (= tmp_11^post (+ 0 Result_4^1))) (= Result_4^post Result_4^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= lt_12^0 lt_12^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post))))
    (cfg_trans2 pc^0 l0 pc^post l2 (exists ( (Result_4^1 Int) (lt_12^1 Int) (lt_13^1 Int) ) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= lt_13^1 (+ 0 b_128^0)) (<= 0 (+ 4 (* -1 lt_13^1)))) (= lt_13^post lt_13^post)) (= lt_12^1 (+ 0 b_128^0))) (= lt_12^post lt_12^post)) (= ___retres1_6^post 0)) (= ___cil_tmp2_7^post (+ 0 ___retres1_6^post))) (= Result_4^1 (+ 0 ___cil_tmp2_7^post))) (= tmp_11^post (+ 0 Result_4^1))) (= Result_4^post Result_4^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post))))
    (cfg_trans2 pc^0 l3 pc^post l4 (and (and (and (and (and (and (and (and (and (and (and (and (and (<= (+ (+ 0 (* -1 x_8^0)) y_9^0) 0) (= Result_4^post Result_4^post)) (= ___cil_tmp2_7^0 ___cil_tmp2_7^post)) (= ___retres1_6^0 ___retres1_6^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= lt_12^0 lt_12^post)) (= lt_13^0 lt_13^post)) (= tmp_11^0 tmp_11^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post)))
    (cfg_trans2 pc^0 l3 pc^post l5 (and (and (and (and (and (and (and (and (and (and (and (and (and (<= 0 (+ (+ -1 (* -1 x_8^0)) y_9^0)) (= Result_4^0 Result_4^post)) (= ___cil_tmp2_7^0 ___cil_tmp2_7^post)) (= ___retres1_6^0 ___retres1_6^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= lt_12^0 lt_12^post)) (= lt_13^0 lt_13^post)) (= tmp_11^0 tmp_11^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post)))
    (cfg_trans2 pc^0 l2 pc^post l0 (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (<= (+ 0 tmp_11^0) 0) (<= 0 (+ 0 tmp_11^0))) (<= 0 (+ (+ -1 (* -1 y_9^0)) z_10^0))) (= Result_4^0 Result_4^post)) (= ___cil_tmp2_7^0 ___cil_tmp2_7^post)) (= ___retres1_6^0 ___retres1_6^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= lt_12^0 lt_12^post)) (= lt_13^0 lt_13^post)) (= tmp_11^0 tmp_11^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post)))
    (cfg_trans2 pc^0 l6 pc^post l2 (exists ( (Result_4^1 Int) (lt_12^1 Int) (lt_13^1 Int) ) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (<= 0 (+ (+ -1 (* -1 y_9^0)) z_10^0)) (= lt_13^1 0)) (<= 0 (+ 4 (* -1 lt_13^1)))) (= lt_13^post lt_13^post)) (= lt_12^1 0)) (= lt_12^post lt_12^post)) (= ___retres1_6^post 0)) (= ___cil_tmp2_7^post (+ 0 ___retres1_6^post))) (= Result_4^1 (+ 0 ___cil_tmp2_7^post))) (= tmp_11^post (+ 0 Result_4^1))) (= Result_4^post Result_4^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post))))
    (cfg_trans2 pc^0 l6 pc^post l3 (and (and (and (and (and (and (and (and (and (and (and (and (and (<= (+ (+ 0 (* -1 y_9^0)) z_10^0) 0) (= x_8^post (+ 1 x_8^0))) (= Result_4^0 Result_4^post)) (= ___cil_tmp2_7^0 ___cil_tmp2_7^post)) (= ___retres1_6^0 ___retres1_6^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= lt_12^0 lt_12^post)) (= lt_13^0 lt_13^post)) (= tmp_11^0 tmp_11^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post)))
    (cfg_trans2 pc^0 l1 pc^post l7 (and (and (and (and (and (and (and (and (and (and (and (and (and (<= (+ 1 tmp_11^0) 0) (= Result_4^0 Result_4^post)) (= ___cil_tmp2_7^0 ___cil_tmp2_7^post)) (= ___retres1_6^0 ___retres1_6^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= lt_12^0 lt_12^post)) (= lt_13^0 lt_13^post)) (= tmp_11^0 tmp_11^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post)))
    (cfg_trans2 pc^0 l1 pc^post l7 (and (and (and (and (and (and (and (and (and (and (and (and (and (<= 1 (+ 0 tmp_11^0)) (= Result_4^0 Result_4^post)) (= ___cil_tmp2_7^0 ___cil_tmp2_7^post)) (= ___retres1_6^0 ___retres1_6^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= lt_12^0 lt_12^post)) (= lt_13^0 lt_13^post)) (= tmp_11^0 tmp_11^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post)))
    (cfg_trans2 pc^0 l7 pc^post l6 (and (and (and (and (and (and (and (and (and (and (and (and (= y_9^post (+ 1 y_9^0)) (= Result_4^0 Result_4^post)) (= ___cil_tmp2_7^0 ___cil_tmp2_7^post)) (= ___retres1_6^0 ___retres1_6^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= lt_12^0 lt_12^post)) (= lt_13^0 lt_13^post)) (= tmp_11^0 tmp_11^post)) (= x_8^0 x_8^post)) (= z_10^0 z_10^post)))
    (cfg_trans2 pc^0 l5 pc^post l2 (exists ( (Result_4^1 Int) (lt_12^1 Int) (lt_13^1 Int) ) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (<= 0 (+ (+ -1 (* -1 y_9^0)) z_10^0)) (= lt_13^1 0)) (<= 0 (+ 4 (* -1 lt_13^1)))) (= lt_13^post lt_13^post)) (= lt_12^1 0)) (= lt_12^post lt_12^post)) (= ___retres1_6^post 0)) (= ___cil_tmp2_7^post (+ 0 ___retres1_6^post))) (= Result_4^1 (+ 0 ___cil_tmp2_7^post))) (= tmp_11^post (+ 0 Result_4^1))) (= Result_4^post Result_4^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post))))
    (cfg_trans2 pc^0 l5 pc^post l3 (and (and (and (and (and (and (and (and (and (and (and (and (and (<= (+ (+ 0 (* -1 y_9^0)) z_10^0) 0) (= x_8^post (+ 1 x_8^0))) (= Result_4^0 Result_4^post)) (= ___cil_tmp2_7^0 ___cil_tmp2_7^post)) (= ___retres1_6^0 ___retres1_6^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= lt_12^0 lt_12^post)) (= lt_13^0 lt_13^post)) (= tmp_11^0 tmp_11^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post)))
    (cfg_trans2 pc^0 l8 pc^post l3 (and (and (and (and (and (and (and (and (and (and (and (and (= count_5^post count_5^post) (= Result_4^0 Result_4^post)) (= ___cil_tmp2_7^0 ___cil_tmp2_7^post)) (= ___retres1_6^0 ___retres1_6^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= lt_12^0 lt_12^post)) (= lt_13^0 lt_13^post)) (= tmp_11^0 tmp_11^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post)))
    (cfg_trans2 pc^0 l9 pc^post l2 (exists ( (Result_4^1 Int) (lt_12^1 Int) (lt_13^1 Int) ) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= b_51^post -2) (= lt_13^1 -1)) (<= 0 (+ 4 (* -1 lt_13^1)))) (= lt_13^post lt_13^post)) (= lt_12^1 -1)) (= lt_12^post lt_12^post)) (= ___retres1_6^post 0)) (= ___cil_tmp2_7^post (+ 0 ___retres1_6^post))) (= Result_4^1 (+ 0 ___cil_tmp2_7^post))) (= tmp_11^post (+ 0 Result_4^1))) (= Result_4^post Result_4^post)) (= b_128^0 b_128^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post))))
    (cfg_trans2 pc^0 l10 pc^post l2 (exists ( (Result_4^1 Int) (lt_12^1 Int) (lt_13^1 Int) ) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= b_76^post (+ -1 b_51^0)) (= lt_13^1 (+ 0 b_51^0))) (<= 0 (+ 4 (* -1 lt_13^1)))) (= lt_13^post lt_13^post)) (= lt_12^1 (+ 0 b_51^0))) (= lt_12^post lt_12^post)) (= ___retres1_6^post 0)) (= ___cil_tmp2_7^post (+ 0 ___retres1_6^post))) (= Result_4^1 (+ 0 ___cil_tmp2_7^post))) (= tmp_11^post (+ 0 Result_4^1))) (= Result_4^post Result_4^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= count_5^0 count_5^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post))))
    (cfg_trans2 pc^0 l10 pc^post l1 (exists ( (Result_4^1 Int) (lt_13^1 Int) ) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= lt_13^1 (+ 0 b_51^0)) (<= (+ 5 (* -1 lt_13^1)) 0)) (= lt_13^post lt_13^post)) (= ___retres1_6^post 1)) (= ___cil_tmp2_7^post (+ 0 ___retres1_6^post))) (= Result_4^1 (+ 0 ___cil_tmp2_7^post))) (= tmp_11^post (+ 0 Result_4^1))) (= Result_4^post Result_4^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= lt_12^0 lt_12^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post))))
    (cfg_trans2 pc^0 l11 pc^post l2 (exists ( (Result_4^1 Int) (lt_12^1 Int) (lt_13^1 Int) ) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= b_128^post -2) (= lt_13^1 -1)) (<= 0 (+ 4 (* -1 lt_13^1)))) (= lt_13^post lt_13^post)) (= lt_12^1 -1)) (= lt_12^post lt_12^post)) (= ___retres1_6^post 0)) (= ___cil_tmp2_7^post (+ 0 ___retres1_6^post))) (= Result_4^1 (+ 0 ___cil_tmp2_7^post))) (= tmp_11^post (+ 0 Result_4^1))) (= Result_4^post Result_4^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post))))
    (cfg_trans2 pc^0 l12 pc^post l8 (and (and (and (and (and (and (and (and (and (and (and (and (= Result_4^0 Result_4^post) (= ___cil_tmp2_7^0 ___cil_tmp2_7^post)) (= ___retres1_6^0 ___retres1_6^post)) (= b_128^0 b_128^post)) (= b_51^0 b_51^post)) (= b_76^0 b_76^post)) (= count_5^0 count_5^post)) (= lt_12^0 lt_12^post)) (= lt_13^0 lt_13^post)) (= tmp_11^0 tmp_11^post)) (= x_8^0 x_8^post)) (= y_9^0 y_9^post)) (= z_10^0 z_10^post)))
  )
)
