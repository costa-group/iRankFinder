

def check(tool, args, f, expected):
    from subprocess import PIPE
    from subprocess import Popen
    import os
    call = args.split()
    call = [tool] + call
    call.append("-f")
    call.append(f)
    if tool[-3:] == ".py":
        call = ["python3"] + call
    pipe = Popen(call, stdout=PIPE, stderr=PIPE)
    out, err = pipe.communicate()
    if err is not None and err:
        print(" ".join(call))
        cads = err.decode("utf-8").splitlines()
        for c in cads:
            print(c)
        return False
    cads = out.decode("utf-8").splitlines()
    if len(cads) == 0 or cads[0] != expected:
        for c in cads:
            print(c)
        return False
    return True


def set_test(args, f, expected, feedback):
    return { "params": args,
             "file" : f,
             "expected": expected,
             "onfail":feedback}

def run_test(tool, base, test):
    import os
    f = os.path.join(base, test["file"])
    if check(tool, test["params"], f, test["expected"]):
        print("Ok")
        return True
    print(test["onfail"])
    return False

def run_all(tool, base, tests):
    count = 0
    total = len(tests.keys())
    for k in sorted(tests.keys()):
        print("Tests {}".format(k))
        if not run_test(tool, base, tests[k]):
            count += 1
    print("{}/{} test(s) passed.".format(total-count, total))
    if count > 0:
        print("{} test(s) failed!!".format(count))
             

def def_tests():
    f1 = "TPDB/From_AProVE_2014/a/Ackermann.jar-obl-8.smt2"
    f2 = "TPDB/C_Integer/Stroeder_15/aaron2_true-termination.c"
    f3 = "fc/misc/loop1.fc"
    f4 = "TPDB/From_AProVE_2014/a/AlternatingGrowReduce.jar-obl-9.smt2"
    f5 = "TPDB/From_AProVE_2014/a/AlternatingGrowReduceRec2.jar-obl-9.smt2"
    f6 = "TPDB/From_AProVE_2014/a/alternDivWidening_rec.jar-obl-8.smt2"
    args1= "-t qnlrf_2"
    args2= args1 + " -i polyhedra"
    args_cfr = args2 + " -cfr-st-scc -cfr-call -cfr-call-var -cfr-it 1"
    args_nt_q = args2 + " -nt monotonicrecset --domain Q -nt-reach"
    args_nt_z = args2 + " -nt monotonicrecset --domain Z -nt-reach"
    test = {}
    test["01_basic"] = set_test("-v 0", f1, "MAYBE", "Is iRankFinder installed?")
    test["02_basic1"] = set_test(args1, f1, "YES", "does LD_LIBRARY_PATH have ppl path?")
    test["03_c"] = set_test(args1, f2, "MAYBE", "does llvm fail?")
    test["04_c_yes"] = set_test(args2, f2, "YES", "")
    test["05_fc"] = set_test(args2, f3, "YES", "")
    test["06_no_cfr_maybe"] = set_test(args2, f4, "MAYBE", "")
    test["07_cfr_yes"] = set_test(args_cfr, f4, "YES", "")
    test["08_nt_maybe"] = set_test(args2, f5, "MAYBE", "")
    test["09_nt_no_q"] = set_test(args_nt_q, f5, "NO", "")
    test["10_nt_maybe_z"] = set_test(args_nt_z, f5, "MAYBE", "")
    test["11_nt_no_z"] = set_test(args_nt_z, f6, "NO", "")
    return test


if __name__ == "__main__":
    import sys, os

    base = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', 'examples')
    if len(sys.argv) > 1:
        argv = sys.argv[1:]
        tool = argv[0]
    else:
        tool= "/opt/tools/pyRankFinder/irankfinder.sh"
    run_all(tool, base, def_tests())
