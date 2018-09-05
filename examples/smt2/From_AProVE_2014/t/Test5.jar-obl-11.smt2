(declare-sort Loc 0)
(declare-const f83_0_mk_Return Loc)
(declare-const f140_0_main_InvokeMethod Loc)
(declare-const f1_0_main_Load Loc)
(declare-const f183_0_main_InvokeMethod Loc)
(declare-const f232_0_length_Return Loc)
(declare-const f268_0_main_LE Loc)
(declare-const f268_0_main_LE' Loc)
(declare-const f336_0_main_NE Loc)
(declare-const f378_0_main_InvokeMethod Loc)
(declare-const f519_0_main_InvokeMethod Loc)
(declare-const f161_0_mk_LE Loc)
(declare-const f283_0_length_NULL Loc)
(declare-const f632_0_test_NULL Loc)
(declare-const __init Loc)
(assert (distinct f83_0_mk_Return f140_0_main_InvokeMethod f1_0_main_Load f183_0_main_InvokeMethod f232_0_length_Return f268_0_main_LE f268_0_main_LE' f336_0_main_NE f378_0_main_InvokeMethod f519_0_main_InvokeMethod f161_0_mk_LE f283_0_length_NULL f632_0_test_NULL __init ))

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

(define-fun init_main ( (pc Loc) (arg1 Int) (arg2 Int) (arg3 Int) (arg4 Int) ) Bool
  (cfg_init pc __init true))

(define-fun next_main (
                 (pc Loc) (arg1 Int) (arg2 Int) (arg3 Int) (arg4 Int)
                 (pc1 Loc) (arg1P Int) (arg2P Int) (arg3P Int) (arg4P Int)
             ) Bool
  (or
    (cfg_trans2 pc f83_0_mk_Return pc1 f140_0_main_InvokeMethod (and (and (and (and (and (and (and (and (and (<= arg1P arg1) (> arg3 (- 1))) (<= (- arg1P 1) arg2)) (<= arg2P arg2)) (> arg1 0)) (> arg2 (- 1))) (> arg1P 0)) (> arg2P (- 1))) (= (+ arg3 3) arg3P)) (= arg3 arg4P)))
    (cfg_trans2 pc f1_0_main_Load pc1 f140_0_main_InvokeMethod (and (and (and (and (and (and (<= arg1P arg1) (> arg2 (- 1))) (> arg1 0)) (> arg1P 0)) (> arg2P (- 1))) (= (+ arg2 3) arg3P)) (= arg2 arg4P)))
    (cfg_trans2 pc f140_0_main_InvokeMethod pc1 f183_0_main_InvokeMethod (and (and (and (and (and (and (and (and (and (> (+ arg4 5) arg4) (> arg4 (- 1))) (> arg3 1)) (< arg4 arg3)) (<= arg3P arg2)) (> arg1 0)) (> arg2 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))) (> arg3P (- 1))))
    (cfg_trans2 pc f232_0_length_Return pc1 f268_0_main_LE (and (and (and (and (and (and (and (and (and (<= arg1P arg1) (<= arg2P arg2)) (<= arg3P arg3)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))) (> arg3P (- 1))) (= arg4 arg4P)))
    (cfg_trans2 pc f183_0_main_InvokeMethod pc1 f268_0_main_LE (and (and (and (and (and (and (and (and (<= arg1P arg3) (<= arg2P arg1)) (<= arg3P arg2)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))) (> arg3P (- 1))))
    (cfg_trans2 pc f268_0_main_LE pc1 f268_0_main_LE' (exists ((x171 Int) (x172 Int) (x173 Int) (x174 Int) (x175 Int)) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (> arg4 0) (> (- x171 (* 3 x172)) 0)) (<= x173 arg2)) (<= x174 arg3)) (<= x175 arg1)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> x173 (- 1))) (> x174 (- 1))) (> x175 (- 1))) (= arg1 arg1P)) (= arg2 arg2P)) (= arg3 arg3P)) (= arg4 arg4P))))
    (cfg_trans2 pc f268_0_main_LE' pc1 f336_0_main_NE (exists ((x185 Int) (x186 Int) (x183 Int) (x184 Int)) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (> (- x185 (* 3 x186)) 0) (> arg4 0)) (<= arg1P arg2)) (<= arg2P arg3)) (<= arg3P arg1)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))) (> arg3P (- 1))) (< (- x185 (* 3 x186)) 3)) (< (- x183 (* 5 x184)) 5)) (>= (- x183 (* 5 x184)) 0)) (= (- x183 (* 5 x184)) arg4P))))
    (cfg_trans2 pc f336_0_main_NE pc1 f378_0_main_InvokeMethod (and (and (and (and (and (and (and (and (and (<= arg1P arg2) (> arg4 0)) (<= arg2P arg3)) (<= arg3P arg1)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))) (> arg3P (- 1))))
    (cfg_trans2 pc f268_0_main_LE pc1 f268_0_main_LE' (exists ((x191 Int) (x192 Int) (x193 Int) (x194 Int) (x195 Int)) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (> arg4 0) (= (- x191 (* 3 x192)) 0)) (<= x193 arg2)) (<= x194 arg3)) (<= x195 arg1)) (> arg1 0)) (> arg2 (- 1))) (> arg3 (- 1))) (> x193 (- 1))) (> x194 (- 1))) (> x195 0)) (= arg1 arg1P)) (= arg2 arg2P)) (= arg3 arg3P)) (= arg4 arg4P))))
    (cfg_trans2 pc f268_0_main_LE' pc1 f336_0_main_NE (exists ((x205 Int) (x206 Int) (x203 Int) (x204 Int)) (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (> arg4 0) (= (- x205 (* 3 x206)) 0)) (<= arg1P arg2)) (<= arg2P arg3)) (<= arg3P arg1)) (> arg1 0)) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))) (> arg3P 0)) (>= (- x205 (* 3 x206)) 0)) (< (- x205 (* 3 x206)) 3)) (< (- x203 (* 5 x204)) 5)) (>= (- x203 (* 5 x204)) 0)) (= (- x203 (* 5 x204)) arg4P))))
    (cfg_trans2 pc f336_0_main_NE pc1 f378_0_main_InvokeMethod (and (and (and (and (and (and (and (and (and (<= arg1P arg2) (<= (+ arg2P 1) arg3)) (<= arg3P arg1)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 0)) (> arg1P (- 1))) (> arg2P (- 1))) (> arg3P (- 1))) (= 0 arg4)))
    (cfg_trans2 pc f378_0_main_InvokeMethod pc1 f519_0_main_InvokeMethod (exists ((x68 Int) (x67 Int)) (and (and (and (and (and (and (and (and (and (<= (+ arg1P 1) arg3) (> x68 x67)) (<= arg2P arg1)) (<= arg3P arg2)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 0)) (> arg1P (- 1))) (> arg2P (- 1))) (> arg3P (- 1)))))
    (cfg_trans2 pc f378_0_main_InvokeMethod pc1 f519_0_main_InvokeMethod (exists ((x78 Int) (x77 Int) (x76 Int) (x75 Int)) (and (and (and (and (and (and (and (and (and (and (> x78 x77) (<= x76 x75)) (<= arg1P arg3)) (<= arg2P arg1)) (<= (+ arg3P 1) arg2)) (> arg1 (- 1))) (> arg2 0)) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))) (> arg3P (- 1)))))
    (cfg_trans2 pc f378_0_main_InvokeMethod pc1 f519_0_main_InvokeMethod (exists ((x213 Int) (x214 Int) (x215 Int) (x216 Int)) (and (and (and (and (and (and (and (and (and (and (< x213 x214) (<= x215 x216)) (<= arg1P arg3)) (<= arg2P arg1)) (<= (+ arg3P 1) arg2)) (> arg1 (- 1))) (> arg2 0)) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))) (> arg3P (- 1)))))
    (cfg_trans2 pc f378_0_main_InvokeMethod pc1 f519_0_main_InvokeMethod (exists ((x86 Int) (x85 Int)) (and (and (and (and (and (and (and (and (and (<= arg1P arg3) (<= x86 x85)) (<= (+ arg2P 1) arg1)) (<= arg3P arg2)) (> arg1 0)) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))) (> arg3P (- 1)))))
    (cfg_trans2 pc f519_0_main_InvokeMethod pc1 f183_0_main_InvokeMethod (and (and (and (and (and (and (and (and (<= arg1P arg2) (<= arg2P arg3)) (<= arg3P arg1)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))) (> arg3P (- 1))))
    (cfg_trans2 pc f1_0_main_Load pc1 f161_0_mk_LE (and (and (and (> arg1 0) (> arg2 (- 1))) (= (- arg2 1) arg1P)) (= arg2 arg2P)))
    (cfg_trans2 pc f140_0_main_InvokeMethod pc1 f161_0_mk_LE (and (and (and (and (and (< arg4 arg3) (> arg3 1)) (> arg1 0)) (> arg2 (- 1))) (= (- arg3 1) arg1P)) (= arg3 arg2P)))
    (cfg_trans2 pc f140_0_main_InvokeMethod pc1 f161_0_mk_LE (and (and (and (and (and (and (and (> (+ arg4 5) arg4) (> arg4 (- 1))) (> arg3 1)) (< arg4 arg3)) (> arg1 0)) (> arg2 (- 1))) (= (+ arg4 4) arg1P)) (= (+ arg4 5) arg2P)))
    (cfg_trans2 pc f161_0_mk_LE pc1 f161_0_mk_LE (and (and (> arg2 0) (= (- arg1 1) arg1P)) (= arg1 arg2P)))
    (cfg_trans2 pc f183_0_main_InvokeMethod pc1 f283_0_length_NULL (and (and (and (and (and (and (<= arg1P arg3) (<= arg2P arg3)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))))
    (cfg_trans2 pc f268_0_main_LE pc1 f283_0_length_NULL (and (and (and (and (and (and (and (<= arg1P arg3) (> arg4 0)) (<= arg2P arg3)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))))
    (cfg_trans2 pc f268_0_main_LE pc1 f268_0_main_LE' (exists ((x221 Int) (x222 Int) (x223 Int) (x224 Int)) (and (and (and (and (and (and (and (and (and (and (and (and (> arg4 0) (> (- x221 (* 3 x222)) 0)) (<= x223 arg1)) (<= x224 arg1)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> x223 (- 1))) (> x224 (- 1))) (= arg1 arg1P)) (= arg2 arg2P)) (= arg3 arg3P)) (= arg4 arg4P))))
    (cfg_trans2 pc f268_0_main_LE' pc1 f283_0_length_NULL (exists ((x231 Int) (x232 Int)) (and (and (and (and (and (and (and (and (and (> (- x231 (* 3 x232)) 0) (> arg4 0)) (<= arg1P arg1)) (<= arg2P arg1)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))) (< (- x231 (* 3 x232)) 3))))
    (cfg_trans2 pc f268_0_main_LE pc1 f268_0_main_LE' (exists ((x237 Int) (x238 Int) (x239 Int) (x240 Int)) (and (and (and (and (and (and (and (and (and (and (and (and (> arg4 0) (= (- x237 (* 3 x238)) 0)) (<= x239 arg1)) (<= x240 arg1)) (> arg1 0)) (> arg2 (- 1))) (> arg3 (- 1))) (> x239 0)) (> x240 0)) (= arg1 arg1P)) (= arg2 arg2P)) (= arg3 arg3P)) (= arg4 arg4P))))
    (cfg_trans2 pc f268_0_main_LE' pc1 f283_0_length_NULL (exists ((x247 Int) (x248 Int)) (and (and (and (and (and (and (and (and (and (and (> arg4 0) (= (- x247 (* 3 x248)) 0)) (<= arg1P arg1)) (<= arg2P arg1)) (> arg1 0)) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P 0)) (> arg2P 0)) (< (- x247 (* 3 x248)) 3)) (>= (- x247 (* 3 x248)) 0))))
    (cfg_trans2 pc f378_0_main_InvokeMethod pc1 f283_0_length_NULL (and (and (and (and (and (and (<= arg1P arg3) (<= arg2P arg3)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))))
    (cfg_trans2 pc f378_0_main_InvokeMethod pc1 f283_0_length_NULL (and (and (and (and (and (and (<= arg1P arg1) (<= arg2P arg1)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))))
    (cfg_trans2 pc f378_0_main_InvokeMethod pc1 f283_0_length_NULL (exists ((x146 Int) (x145 Int)) (and (and (and (and (and (and (and (<= arg1P arg3) (<= x146 x145)) (<= arg2P arg3)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1)))))
    (cfg_trans2 pc f378_0_main_InvokeMethod pc1 f283_0_length_NULL (exists ((x153 Int) (x152 Int)) (and (and (and (and (and (and (and (<= arg1P arg1) (<= x153 x152)) (<= arg2P arg1)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1)))))
    (cfg_trans2 pc f283_0_length_NULL pc1 f283_0_length_NULL (and (and (and (and (and (and (and (<= (+ arg1P 1) arg1) (<= (+ arg1P 1) arg2)) (<= (+ arg2P 1) arg1)) (<= (+ arg2P 1) arg2)) (> arg1 0)) (> arg2 0)) (> arg1P (- 1))) (> arg2P (- 1))))
    (cfg_trans2 pc f519_0_main_InvokeMethod pc1 f632_0_test_NULL (and (and (and (and (and (and (<= arg1P arg1) (<= arg2P arg1)) (> arg1 (- 1))) (> arg2 (- 1))) (> arg3 (- 1))) (> arg1P (- 1))) (> arg2P (- 1))))
    (cfg_trans2 pc f632_0_test_NULL pc1 f632_0_test_NULL (and (and (and (and (and (and (and (<= (+ arg1P 1) arg1) (<= (+ arg1P 1) arg2)) (<= (+ arg2P 1) arg1)) (<= (+ arg2P 1) arg2)) (> arg1 0)) (> arg2 0)) (> arg1P (- 1))) (> arg2P (- 1))))
    (cfg_trans2 pc __init pc1 f1_0_main_Load true)
  )
)
