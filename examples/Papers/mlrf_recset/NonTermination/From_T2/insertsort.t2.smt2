(declare-sort Loc 0)
(declare-const l0 Loc)
(declare-const l1 Loc)
(declare-const l2 Loc)
(declare-const l3 Loc)
(declare-const l4 Loc)
(declare-const l5 Loc)
(declare-const l6 Loc)
(assert (distinct l0 l1 l2 l3 l4 l5 l6))

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

(define-fun init_main ( (pc^0 Loc) (__const_10^0 Int) (i^0 Int) (j^0 Int) (temp^0 Int) ) Bool
  (cfg_init pc^0 l6 true))

(define-fun next_main (
                 (pc^0 Loc) (__const_10^0 Int) (i^0 Int) (j^0 Int) (temp^0 Int)
                 (pc^post Loc) (__const_10^post Int) (i^post Int) (j^post Int) (temp^post Int)
             ) Bool
  (or
    (cfg_trans2 pc^0 l0 pc^post l1 (and (and (and (= __const_10^0 __const_10^post) (= i^0 i^post)) (= j^0 j^post)) (= temp^0 temp^post)))
    (cfg_trans2 pc^0 l2 pc^post l3 (and (and (and (= __const_10^0 __const_10^post) (= i^0 i^post)) (= j^0 j^post)) (= temp^0 temp^post)))
    (cfg_trans2 pc^0 l3 pc^post l2 (and (and (and (= temp^post temp^post) (= j^post (+ -1 j^0))) (= __const_10^0 __const_10^post)) (= i^0 i^post)))
    (cfg_trans2 pc^0 l3 pc^post l0 (and (and (and (= i^post (+ 1 i^0)) (= __const_10^0 __const_10^post)) (= j^0 j^post)) (= temp^0 temp^post)))
    (cfg_trans2 pc^0 l1 pc^post l4 (and (and (and (and (<= (+ 1 __const_10^0) (+ 0 i^0)) (= __const_10^0 __const_10^post)) (= i^0 i^post)) (= j^0 j^post)) (= temp^0 temp^post)))
    (cfg_trans2 pc^0 l1 pc^post l2 (and (and (and (and (<= (+ 0 i^0) (+ 0 __const_10^0)) (= j^post (+ 0 i^0))) (= __const_10^0 __const_10^post)) (= i^0 i^post)) (= temp^0 temp^post)))
    (cfg_trans2 pc^0 l5 pc^post l0 (and (and (and (= i^post 2) (= __const_10^0 __const_10^post)) (= j^0 j^post)) (= temp^0 temp^post)))
    (cfg_trans2 pc^0 l6 pc^post l5 (and (and (and (= __const_10^0 __const_10^post) (= i^0 i^post)) (= j^0 j^post)) (= temp^0 temp^post)))
  )
)
