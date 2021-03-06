(declare-sort Loc 0)
(declare-const evalEx3bb1in Loc)
(declare-const evalEx3bb2in Loc)
(declare-const evalEx3bb3in Loc)
(declare-const evalEx3bb4in Loc)
(declare-const evalEx3bbin Loc)
(declare-const evalEx3entryin Loc)
(declare-const evalEx3returnin Loc)
(declare-const evalEx3start Loc)
(declare-const evalEx3stop Loc)
(assert (distinct evalEx3bb1in evalEx3bb2in evalEx3bb3in evalEx3bb4in evalEx3bbin evalEx3entryin evalEx3returnin evalEx3start evalEx3stop))
(define-fun cfg_init ( (pc Loc) (src Loc) (rel Bool) ) Bool (and (= pc src) rel))
(define-fun cfg_trans2 ( (pc Loc) (src Loc) (pc1 Loc) (dst Loc) (rel Bool) ) Bool
                       (and (= pc src) (= pc1 dst) rel))
(define-fun cfg_trans3 ( (pc Loc) (exit Loc) (pc1 Loc) (call Loc) (pc2 Loc) (return Loc)
                         (rel Bool) ) Bool (and (= pc exit) (= pc1 call) (= pc2 return) rel))
(define-fun init_main ( (pc Loc) (A Int) (B Int) (C Int) ) Bool (cfg_init pc evalEx3start true))
(define-fun next_main ( (pc Loc) (A Int) (B Int) (C Int) (pc1 Loc) (A' Int) (B' Int) (C' Int)) Bool (or
    (cfg_trans2 pc evalEx3bb1in pc1 evalEx3bb2in (and (and (= (+ A (* -1 A')) 0) (= (+ B (* -1 B')) 0)) (= (+ (+ C -1) (* -1 C')) 0)))
    (cfg_trans2 pc evalEx3bb2in pc1 evalEx3bb3in (and (and (and (>= (+ C -1) 0) (= (+ A (* -1 A')) 0)) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)))
    (cfg_trans2 pc evalEx3returnin pc1 evalEx3stop (and (and (= (+ A (* -1 A')) 0) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)))
    (cfg_trans2 pc evalEx3start pc1 evalEx3entryin (and (and (= (+ A (* -1 A')) 0) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)))
    (cfg_trans2 pc evalEx3bb2in pc1 evalEx3bb4in (and (and (and (>= (* -1 C) 0) (= (+ C (* -1 A')) 0)) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)))
    (cfg_trans2 pc evalEx3bb3in pc1 evalEx3bb1in (and (and (= (+ A (* -1 A')) 0) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)))
    (cfg_trans2 pc evalEx3bb3in pc1 evalEx3bb4in (and (and (= (+ C (* -1 C')) 0) (= (+ C (* -1 A')) 0)) (= (+ B (* -1 B')) 0)))
    (cfg_trans2 pc evalEx3bb3in pc1 evalEx3bb4in (and (and (= (+ C (* -1 C')) 0) (= (+ C (* -1 A')) 0)) (= (+ B (* -1 B')) 0)))
    (cfg_trans2 pc evalEx3bb4in pc1 evalEx3bbin (and (and (and (>= (+ A -1) 0) (= (+ A (* -1 A')) 0)) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)))
    (cfg_trans2 pc evalEx3bb4in pc1 evalEx3returnin (and (and (and (>= (* -1 A) 0) (= (+ A (* -1 A')) 0)) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)))
    (cfg_trans2 pc evalEx3bbin pc1 evalEx3bb2in (and (= (+ A (* -1 A')) 0) (= (+ A (* -1 C')) 0)))
    (cfg_trans2 pc evalEx3entryin pc1 evalEx3bb4in (and (and (= (+ A (* -1 A')) 0) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)))
  )
)
