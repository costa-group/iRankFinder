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
(declare-const l13 Loc)
(declare-const l14 Loc)
(declare-const l15 Loc)
(assert (distinct l0 l1 l2 l3 l4 l5 l6 l7 l8 l9 l10 l11 l12 l13 l14 l15))

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

(define-fun init_main ( (pc^0 Loc) (loop_count^0 Int) (loop_max^0 Int) (nPacketsOld^0 Int) (nPackets^0 Int) (tmp^0 Int) (tmp___0^0 Int) ) Bool
  (cfg_init pc^0 l15 true))

(define-fun next_main (
                 (pc^0 Loc) (loop_count^0 Int) (loop_max^0 Int) (nPacketsOld^0 Int) (nPackets^0 Int) (tmp^0 Int) (tmp___0^0 Int)
                 (pc^post Loc) (loop_count^post Int) (loop_max^post Int) (nPacketsOld^post Int) (nPackets^post Int) (tmp^post Int) (tmp___0^post Int)
             ) Bool
  (or
    (cfg_trans2 pc^0 l0 pc^post l1 (and (and (and (and (and (= loop_count^0 loop_count^post) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l2 pc^post l0 (and (and (and (and (and (= loop_count^0 loop_count^post) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l2 pc^post l0 (and (and (and (and (and (= loop_count^0 loop_count^post) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l2 pc^post l3 (and (and (and (and (and (= loop_count^0 loop_count^post) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l4 pc^post l2 (and (and (and (and (and (= loop_count^0 loop_count^post) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l4 pc^post l2 (and (and (and (and (and (= loop_count^0 loop_count^post) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l4 pc^post l3 (and (and (and (and (and (= loop_count^0 loop_count^post) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l5 pc^post l4 (and (and (and (and (and (and (<= (+ 1 loop_count^0) (+ 0 loop_max^0)) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l5 pc^post l6 (and (and (and (and (and (and (<= (+ 0 loop_max^0) (+ 0 loop_count^0)) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l6 pc^post l7 (and (and (and (and (and (= loop_count^0 loop_count^post) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l3 pc^post l8 (and (and (and (and (and (and (<= (+ 1 nPacketsOld^0) (+ 0 nPackets^0)) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l3 pc^post l8 (and (and (and (and (and (and (<= (+ 1 nPackets^0) (+ 0 nPacketsOld^0)) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l3 pc^post l6 (and (and (and (and (and (and (and (<= (+ 0 nPackets^0) (+ 0 nPacketsOld^0)) (<= (+ 0 nPacketsOld^0) (+ 0 nPackets^0))) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l9 pc^post l3 (and (and (and (and (and (= loop_count^post (+ 1 loop_count^0)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l10 pc^post l3 (and (and (and (and (and (and (and (<= (+ 0 tmp___0^0) 0) (<= 0 (+ 0 tmp___0^0))) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l10 pc^post l9 (and (and (and (and (and (and (<= 1 (+ 0 tmp___0^0)) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l10 pc^post l9 (and (and (and (and (and (and (<= (+ 1 tmp___0^0) 0) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l11 pc^post l10 (and (and (and (and (and (= tmp___0^post tmp___0^post) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)))
    (cfg_trans2 pc^0 l12 pc^post l11 (and (and (and (and (and (= nPackets^post (+ 1 nPackets^0)) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l13 pc^post l11 (and (and (and (and (and (and (and (<= (+ 0 tmp^0) 0) (<= 0 (+ 0 tmp^0))) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l13 pc^post l12 (and (and (and (and (and (and (<= 1 (+ 0 tmp^0)) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l13 pc^post l12 (and (and (and (and (and (and (<= (+ 1 tmp^0) 0) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l14 pc^post l13 (and (and (and (and (and (= tmp^post tmp^post) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l1 pc^post l14 (and (and (and (and (and (= loop_count^0 loop_count^post) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l8 pc^post l5 (and (and (and (and (and (= nPacketsOld^post (+ 0 nPackets^0)) (= loop_count^0 loop_count^post)) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
    (cfg_trans2 pc^0 l15 pc^post l8 (and (and (and (and (and (= loop_count^0 loop_count^post) (= loop_max^0 loop_max^post)) (= nPackets^0 nPackets^post)) (= nPacketsOld^0 nPacketsOld^post)) (= tmp^0 tmp^post)) (= tmp___0^0 tmp___0^post)))
  )
)
