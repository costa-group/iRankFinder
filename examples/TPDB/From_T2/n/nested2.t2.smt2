(declare-sort Loc 0)
(declare-const l0 Loc)
(declare-const l1 Loc)
(declare-const l2 Loc)
(declare-const l3 Loc)
(declare-const l4 Loc)
(declare-const l5 Loc)
(assert (distinct l0 l1 l2 l3 l4 l5))

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

(define-fun init_main ( (pc^0 Loc) (__const_5000^0 Int) (x_13^0 Int) (x_27^0 Int) (x_32^0 Int) (y_16^0 Int) (y_28^0 Int) (y_33^0 Int) ) Bool
  (cfg_init pc^0 l5 true))

(define-fun next_main (
                 (pc^0 Loc) (__const_5000^0 Int) (x_13^0 Int) (x_27^0 Int) (x_32^0 Int) (y_16^0 Int) (y_28^0 Int) (y_33^0 Int)
                 (pc^post Loc) (__const_5000^post Int) (x_13^post Int) (x_27^post Int) (x_32^post Int) (y_16^post Int) (y_28^post Int) (y_33^post Int)
             ) Bool
  (or
    (cfg_trans2 pc^0 l0 pc^post l1 (and (and (and (and (and (and (= x_13^post x_13^post) (= y_16^post y_16^post)) (= __const_5000^0 __const_5000^post)) (= x_27^0 x_27^post)) (= x_32^0 x_32^post)) (= y_28^0 y_28^post)) (= y_33^0 y_33^post)))
    (cfg_trans2 pc^0 l1 pc^post l2 (and (and (and (and (and (and (and (and (and (<= 1 (+ 0 x_13^0)) (= y_16^post (+ 0 __const_5000^0))) (<= 1 (+ 0 y_16^post))) (<= 1 (+ 0 x_13^0))) (= __const_5000^0 __const_5000^post)) (= x_13^0 x_13^post)) (= x_27^0 x_27^post)) (= x_32^0 x_32^post)) (= y_28^0 y_28^post)) (= y_33^0 y_33^post)))
    (cfg_trans2 pc^0 l3 pc^post l2 (and (and (and (and (and (and (and (and (and (and (and (and (and (= x_27^post x_27^post) (= y_28^post y_28^post)) (<= 1 (+ 0 y_16^0))) (= x_13^post (+ -1 x_13^0))) (= y_16^post (+ -1 y_16^0))) (<= (+ 0 x_13^post) (+ -1 x_27^post))) (<= (+ -1 x_27^post) (+ 0 x_13^post))) (<= (+ 0 y_16^post) (+ -1 y_28^post))) (<= (+ -1 y_28^post) (+ 0 y_16^post))) (<= 1 (+ 0 x_27^post))) (<= 1 (+ 0 y_28^post))) (= __const_5000^0 __const_5000^post)) (= x_32^0 x_32^post)) (= y_33^0 y_33^post)))
    (cfg_trans2 pc^0 l2 pc^post l1 (and (and (and (and (and (and (and (and (<= (+ 0 y_16^0) 0) (<= (+ 0 y_16^0) 0)) (= __const_5000^0 __const_5000^post)) (= x_13^0 x_13^post)) (= x_27^0 x_27^post)) (= x_32^0 x_32^post)) (= y_16^0 y_16^post)) (= y_28^0 y_28^post)) (= y_33^0 y_33^post)))
    (cfg_trans2 pc^0 l2 pc^post l4 (and (and (and (and (and (and (and (and (and (and (and (and (= x_32^post x_32^post) (= y_33^post y_33^post)) (<= 1 (+ 0 y_16^0))) (= x_13^post (+ -1 x_13^0))) (= y_16^post (+ -1 y_16^0))) (<= (+ 0 x_13^post) (+ -1 x_32^post))) (<= (+ -1 x_32^post) (+ 0 x_13^post))) (<= (+ 0 y_16^post) (+ -1 y_33^post))) (<= (+ -1 y_33^post) (+ 0 y_16^post))) (<= 1 (+ 0 y_33^post))) (= __const_5000^0 __const_5000^post)) (= x_27^0 x_27^post)) (= y_28^0 y_28^post)))
    (cfg_trans2 pc^0 l4 pc^post l2 (and (and (and (and (and (and (= __const_5000^0 __const_5000^post) (= x_13^0 x_13^post)) (= x_27^0 x_27^post)) (= x_32^0 x_32^post)) (= y_16^0 y_16^post)) (= y_28^0 y_28^post)) (= y_33^0 y_33^post)))
    (cfg_trans2 pc^0 l5 pc^post l0 (and (and (and (and (and (and (= __const_5000^0 __const_5000^post) (= x_13^0 x_13^post)) (= x_27^0 x_27^post)) (= x_32^0 x_32^post)) (= y_16^0 y_16^post)) (= y_28^0 y_28^post)) (= y_33^0 y_33^post)))
  )
)
