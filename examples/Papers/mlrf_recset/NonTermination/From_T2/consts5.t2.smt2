(declare-sort Loc 0)
(declare-const l0 Loc)
(declare-const l1 Loc)
(declare-const l2 Loc)
(declare-const l3 Loc)
(assert (distinct l0 l1 l2 l3))

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

(define-fun init_main ( (pc^0 Loc) (__const_1000^0 Int) (__const_110^0 Int) (__const_2000^0 Int) (__const_3000^0 Int) (x^0 Int) (y^0 Int) ) Bool
  (cfg_init pc^0 l3 true))

(define-fun next_main (
                 (pc^0 Loc) (__const_1000^0 Int) (__const_110^0 Int) (__const_2000^0 Int) (__const_3000^0 Int) (x^0 Int) (y^0 Int)
                 (pc^post Loc) (__const_1000^post Int) (__const_110^post Int) (__const_2000^post Int) (__const_3000^post Int) (x^post Int) (y^post Int)
             ) Bool
  (or
    (cfg_trans2 pc^0 l0 pc^post l1 (and (and (and (and (and (and (and (<= (+ 1 y^0) (+ 0 __const_2000^0)) (= x^post (+ (+ 0 __const_1000^0) x^0))) (<= (+ 1 __const_110^0) (+ 0 x^post))) (= __const_1000^0 __const_1000^post)) (= __const_110^0 __const_110^post)) (= __const_2000^0 __const_2000^post)) (= __const_3000^0 __const_3000^post)) (= y^0 y^post)))
    (cfg_trans2 pc^0 l1 pc^post l0 (and (and (and (and (and (= __const_1000^0 __const_1000^post) (= __const_110^0 __const_110^post)) (= __const_2000^0 __const_2000^post)) (= __const_3000^0 __const_3000^post)) (= x^0 x^post)) (= y^0 y^post)))
    (cfg_trans2 pc^0 l2 pc^post l0 (and (and (and (and (and (= y^post (+ 0 __const_3000^0)) (= __const_1000^0 __const_1000^post)) (= __const_110^0 __const_110^post)) (= __const_2000^0 __const_2000^post)) (= __const_3000^0 __const_3000^post)) (= x^0 x^post)))
    (cfg_trans2 pc^0 l3 pc^post l2 (and (and (and (and (and (= __const_1000^0 __const_1000^post) (= __const_110^0 __const_110^post)) (= __const_2000^0 __const_2000^post)) (= __const_3000^0 __const_3000^post)) (= x^0 x^post)) (= y^0 y^post)))
  )
)
