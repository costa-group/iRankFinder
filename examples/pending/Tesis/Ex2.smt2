(declare-sort Loc 0)
(declare-const evalEx2bb1in Loc)
(declare-const evalEx2bb2in Loc)
(declare-const evalEx2bb3in Loc)
(declare-const evalEx2bbin Loc)
(declare-const evalEx2entryin Loc)
(declare-const evalEx2returnin Loc)
(declare-const evalEx2start Loc)
(declare-const evalEx2stop Loc)
(assert (distinct evalEx2bb1in evalEx2bb2in evalEx2bb3in evalEx2bbin evalEx2entryin evalEx2returnin evalEx2start evalEx2stop))
(define-fun cfg_init ( (pc Loc) (src Loc) (rel Bool) ) Bool (and (= pc src) rel))
(define-fun cfg_trans2 ( (pc Loc) (src Loc) (pc1 Loc) (dst Loc) (rel Bool) ) Bool
                       (and (= pc src) (= pc1 dst) rel))
(define-fun cfg_trans3 ( (pc Loc) (exit Loc) (pc1 Loc) (call Loc) (pc2 Loc) (return Loc)
                         (rel Bool) ) Bool (and (= pc exit) (= pc1 call) (= pc2 return) rel))
(define-fun init_main ( (pc Loc) (A Int) (B Int) (C Int) (D Int) ) Bool (cfg_init pc evalEx2start true))
(define-fun next_main ( (pc Loc) (A Int) (B Int) (C Int) (D Int) (pc1 Loc) (A' Int) (B' Int) (C' Int) (D' Int)) Bool (or
    (cfg_trans2 pc evalEx2bb1in pc1 evalEx2bb2in (and (and (and (= (+ A (* -1 A')) 0) (= (+ B (* -1 B')) 0)) (= (+ (+ C 1) (* -1 C')) 0)) (= (+ (+ D -1) (* -1 D')) 0)))
    (cfg_trans2 pc evalEx2bb2in pc1 evalEx2bb1in (and (and (and (= (+ D (* -1 D')) 0) (= (+ A (* -1 A')) 0)) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)))
    (cfg_trans2 pc evalEx2start pc1 evalEx2entryin (and (and (and (= (+ A (* -1 A')) 0) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)) (= (+ D (* -1 D')) 0)))
    (cfg_trans2 pc evalEx2bb2in pc1 evalEx2bb1in (and (and (and (= (+ D (* -1 D')) 0) (= (+ A (* -1 A')) 0)) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)))
    (cfg_trans2 pc evalEx2bb2in pc1 evalEx2bb3in (and (and (and (= (+ C (* -1 A')) 0) (= (+ D (* -1 B')) 0)) (= (+ C (* -1 C')) 0)) (= (+ D (* -1 D')) 0)))
    (cfg_trans2 pc evalEx2bb3in pc1 evalEx2bbin (and (and (and (and (and (>= (+ B -1) 0) (>= (+ A -1) 0)) (= (+ A (* -1 A')) 0)) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)) (= (+ D (* -1 D')) 0)))
    (cfg_trans2 pc evalEx2bb3in pc1 evalEx2returnin (and (and (and (and (>= (* -1 B) 0) (= (+ A (* -1 A')) 0)) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)) (= (+ D (* -1 D')) 0)))
    (cfg_trans2 pc evalEx2bb3in pc1 evalEx2returnin (and (and (and (and (>= (* -1 A) 0) (= (+ A (* -1 A')) 0)) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)) (= (+ D (* -1 D')) 0)))
    (cfg_trans2 pc evalEx2bbin pc1 evalEx2bb2in (and (and (and (= (+ A (* -1 A')) 0) (= (+ B (* -1 B')) 0)) (= (+ (+ A -1) (* -1 C')) 0)) (= (+ (+ B -1) (* -1 D')) 0)))
    (cfg_trans2 pc evalEx2entryin pc1 evalEx2bb3in (and (and (and (= (+ B (* -1 A')) 0) (= (+ A (* -1 B')) 0)) (= (+ C (* -1 C')) 0)) (= (+ D (* -1 D')) 0)))
    (cfg_trans2 pc evalEx2returnin pc1 evalEx2stop (and (and (and (= (+ A (* -1 A')) 0) (= (+ B (* -1 B')) 0)) (= (+ C (* -1 C')) 0)) (= (+ D (* -1 D')) 0)))
  )
)
