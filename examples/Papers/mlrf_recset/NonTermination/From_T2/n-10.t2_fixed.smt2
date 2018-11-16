(declare-sort Loc 0)
(declare-const l0 Loc)
(declare-const l1 Loc)
(declare-const l2 Loc)
(declare-const l4 Loc)
(declare-const l5 Loc)
(declare-const l3 Loc)
(declare-const l6 Loc)
(declare-const l7 Loc)
(assert (distinct l0 l1 l2 l4 l5 l3 l6 l7))

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

(define-fun init_main ( (pc^0 Loc) (Result_4^0 Int) (cnt_20^0 Int) (cnt_25^0 Int) (lt_10^0 Int) (lt_11^0 Int) (lt_12^0 Int) (p2_8^0 Int) (p_7^0 Int) (tmp_9^0 Int) (x_5^0 Int) (y_6^0 Int) ) Bool
  (cfg_init pc^0 l7 true))

(define-fun next_main (
                 (pc^0 Loc) (Result_4^0 Int) (cnt_20^0 Int) (cnt_25^0 Int) (lt_10^0 Int) (lt_11^0 Int) (lt_12^0 Int) (p2_8^0 Int) (p_7^0 Int) (tmp_9^0 Int) (x_5^0 Int) (y_6^0 Int)
                 (pc^post Loc) (Result_4^post Int) (cnt_20^post Int) (cnt_25^post Int) (lt_10^post Int) (lt_11^post Int) (lt_12^post Int) (p2_8^post Int) (p_7^post Int) (tmp_9^post Int) (x_5^post Int) (y_6^post Int)
             ) Bool
  (or
    (cfg_trans2 pc^0 l0 pc^post l1 (exists ( (lt_11^1 Int) (lt_12^1 Int) ) (and (and (and (and (and (and (and (and (and (and (and (and (and (= lt_11^1 (+ 0 cnt_20^0)) (= lt_12^1 (+ 0 cnt_25^0))) (<= (+ (+ 0 (* -1 lt_11^1)) lt_12^1) 0)) (= lt_11^post lt_11^post)) (= lt_12^post lt_12^post)) (= Result_4^post Result_4^post)) (= cnt_20^0 cnt_20^post)) (= cnt_25^0 cnt_25^post)) (= lt_10^0 lt_10^post)) (= p2_8^0 p2_8^post)) (= p_7^0 p_7^post)) (= tmp_9^0 tmp_9^post)) (= x_5^0 x_5^post)) (= y_6^0 y_6^post))))
    (cfg_trans2 pc^0 l0 pc^post l2 (exists ( (lt_11^1 Int) (lt_12^1 Int) ) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= lt_11^1 (+ 0 cnt_20^0)) (= lt_12^1 (+ 0 cnt_25^0))) (<= 0 (+ (+ -1 (* -1 lt_11^1)) lt_12^1))) (= lt_11^post lt_11^post)) (= lt_12^post lt_12^post)) (= tmp_9^post tmp_9^post)) (<= (+ 0 tmp_9^post) 0)) (<= 0 (+ 0 tmp_9^post))) (= Result_4^0 Result_4^post)) (= cnt_20^0 cnt_20^post)) (= cnt_25^0 cnt_25^post)) (= lt_10^0 lt_10^post)) (= p2_8^0 p2_8^post)) (= p_7^0 p_7^post)) (= x_5^0 x_5^post)) (= y_6^0 y_6^post))))
    (cfg_trans2 pc^0 l2 pc^post l0 (and (and (and (and (and (and (and (and (and (and (= Result_4^0 Result_4^post) (= cnt_20^0 cnt_20^post)) (= cnt_25^0 cnt_25^post)) (= lt_10^0 lt_10^post)) (= lt_11^0 lt_11^post)) (= lt_12^0 lt_12^post)) (= p2_8^0 p2_8^post)) (= p_7^0 p_7^post)) (= tmp_9^0 tmp_9^post)) (= x_5^0 x_5^post)) (= y_6^0 y_6^post)))
    (cfg_trans2 pc^0 l0 pc^post l4 (exists ( (lt_11^1 Int) (lt_12^1 Int) ) (and (and (and (and (and (and (and (and (and (and (and (and (and (= lt_11^1 (+ 0 cnt_20^0)) (= lt_12^1 (+ 0 cnt_25^0))) (<= 0 (+ (+ -1 (* -1 lt_11^1)) lt_12^1))) (= lt_11^post lt_11^post)) (= lt_12^post lt_12^post)) (= tmp_9^post tmp_9^post)) (= Result_4^0 Result_4^post)) (= cnt_20^0 cnt_20^post)) (= cnt_25^0 cnt_25^post)) (= lt_10^0 lt_10^post)) (= p2_8^0 p2_8^post)) (= p_7^0 p_7^post)) (= x_5^0 x_5^post)) (= y_6^0 y_6^post))))
    (cfg_trans2 pc^0 l4 pc^post l5 (and (and (and (and (and (and (and (and (and (and (and (<= (+ 1 tmp_9^0) 0) (= Result_4^0 Result_4^post)) (= cnt_20^0 cnt_20^post)) (= cnt_25^0 cnt_25^post)) (= lt_10^0 lt_10^post)) (= lt_11^0 lt_11^post)) (= lt_12^0 lt_12^post)) (= p2_8^0 p2_8^post)) (= p_7^0 p_7^post)) (= tmp_9^0 tmp_9^post)) (= x_5^0 x_5^post)) (= y_6^0 y_6^post)))
    (cfg_trans2 pc^0 l4 pc^post l5 (and (and (and (and (and (and (and (and (and (and (and (<= 1 (+ 0 tmp_9^0)) (= Result_4^0 Result_4^post)) (= cnt_20^0 cnt_20^post)) (= cnt_25^0 cnt_25^post)) (= lt_10^0 lt_10^post)) (= lt_11^0 lt_11^post)) (= lt_12^0 lt_12^post)) (= p2_8^0 p2_8^post)) (= p_7^0 p_7^post)) (= tmp_9^0 tmp_9^post)) (= x_5^0 x_5^post)) (= y_6^0 y_6^post)))
    (cfg_trans2 pc^0 l5 pc^post l3 (exists ( (lt_10^1 Int) ) (and (and (and (and (and (and (and (and (and (and (and (= lt_10^1 (+ 0 cnt_20^0)) (= lt_10^post lt_10^post)) (= Result_4^0 Result_4^post)) (= cnt_20^0 cnt_20^post)) (= cnt_25^0 cnt_25^post)) (= lt_11^0 lt_11^post)) (= lt_12^0 lt_12^post)) (= p2_8^0 p2_8^post)) (= p_7^0 p_7^post)) (= tmp_9^0 tmp_9^post)) (= x_5^0 x_5^post)) (= y_6^0 y_6^post))))
    (cfg_trans2 pc^0 l3 pc^post l0 (and (and (and (and (and (and (and (and (and (and (= Result_4^0 Result_4^post) (= cnt_20^0 cnt_20^post)) (= cnt_25^0 cnt_25^post)) (= lt_10^0 lt_10^post)) (= lt_11^0 lt_11^post)) (= lt_12^0 lt_12^post)) (= p2_8^0 p2_8^post)) (= p_7^0 p_7^post)) (= tmp_9^0 tmp_9^post)) (= x_5^0 x_5^post)) (= y_6^0 y_6^post)))
    (cfg_trans2 pc^0 l6 pc^post l0 (and (and (and (and (and (and (and (and (and (and (= y_6^post y_6^post) (= x_5^post x_5^post)) (= p_7^post (+ 0 x_5^post))) (= p2_8^post (+ 0 y_6^post))) (= Result_4^0 Result_4^post)) (= cnt_20^0 cnt_20^post)) (= cnt_25^0 cnt_25^post)) (= lt_10^0 lt_10^post)) (= lt_11^0 lt_11^post)) (= lt_12^0 lt_12^post)) (= tmp_9^0 tmp_9^post)))
    (cfg_trans2 pc^0 l7 pc^post l6 (and (and (and (and (and (and (and (and (and (and (= Result_4^0 Result_4^post) (= cnt_20^0 cnt_20^post)) (= cnt_25^0 cnt_25^post)) (= lt_10^0 lt_10^post)) (= lt_11^0 lt_11^post)) (= lt_12^0 lt_12^post)) (= p2_8^0 p2_8^post)) (= p_7^0 p_7^post)) (= tmp_9^0 tmp_9^post)) (= x_5^0 x_5^post)) (= y_6^0 y_6^post)))
  )
)
