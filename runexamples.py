import argparse
from multiprocessing import Manager
from multiprocessing import Process
import os
import sys
import termination.algorithm
from genericparser import GenericParser
import rankfinder
from termination.result import TerminationResult


def setArgumentParser():
    desc = "Generator"
    argParser = argparse.ArgumentParser(description=desc)
    # SANDBOX Parameters
    argParser.add_argument("-mo", "--memoryout", type=int, default=None,
                           help="")
    argParser.add_argument("-to", "--timeout", type=int, default=None,
                           help="")
    # Program Parameters
    argParser.add_argument("-v", "--verbosity", type=int, choices=range(0, 5),
                           help="increase output verbosity", default=0)
    argParser.add_argument("--dotDestination", required=False,
                           help="Folder to save dot graphs.")
    # Algorithm Parameters
    argParser.add_argument("-sccd", "--scc_depth", type=int,
                           choices=range(0, 10), default=5,
                           help="Strategy based on SCC to go through the CFG.")
    argParser.add_argument("-sc", "--simplify_constraints", required=False,
                           action='store_true', help="Simplify constraints")
    # IMPORTANT PARAMETERS
    argParser.add_argument("-pe", "--pe_modes", type=int, required=False, nargs='+',
                           choices=range(0,5), default=[4],
                           help="List of levels of Partial evaluation in the order that you want to apply them.")
    argParser.add_argument("-pmt", "--pe_max_times", type=int, required=False,
                           choices=range(0,5), default=0,
                           help="")
    argParser.add_argument("-f", "--files", nargs='+', required=True,
                           help="File to be analysed.")
    argParser.add_argument("-c", "--cache", required=True,
                           help="Folder cache.")
    argParser.add_argument("-p", "--prefix", required=True, default="",
                           help="Prefix of the files path")
    return argParser


def sandbox(task, args=(), kwargs={}, time_segs=60, memory_mb=None):
    manager = Manager()
    r_dict = manager.dict()

    def worker(task, r_dict, *args, **kwargs):
        try:
            r_dict[0] = task(*args, **kwargs)
            r_dict["status"] = "ok"
        except MemoryError as e:
            r_dict["status"] = TerminationResult.MEMORYLIMIT
        except Exception as e:
            r_dict["status"] = TerminationResult.ERROR
            r_dict["output"] = "Error " + type(e).__name__
            raise Exception() from e

    def returnHandler(exitcode, r_dict, usage=None, usage_old=[0, 0, 0]):
        ret ={}
        try:
            if exitcode == -24:
                ret["status"] = TerminationResult.TIMELIMIT
            elif exitcode < 0:
                ret["status"] = TerminationResult.ERROR
            elif not("status" in r_dict):
                ret["status"] = TerminationResult.TIMELIMIT
            elif r_dict["status"] == "ok":
                ret["status"] = r_dict[0].get_status()
                ret["output"] = r_dict[0]
            else:
                ret["status"] = r_dict["status"]
        except Exception as e:
            ret["status"] = TerminationResult.ERROR
            ret["output"] = "ERROR while processing output " + type(e).__name__
        finally:
            if usage:
                ret["cputime"] = usage[0] + usage[1] - usage_old[0] - usage_old[1]
                ret["memory"] = usage[2] - usage_old[2]
            return ret

    import resource
    if memory_mb:
        bML = 1024 * 1024 * memory_mb
    else:
        bML = resource.RLIM_INFINITY
    if time_segs:
        sTL = time_segs
    else:
        sTL = resource.RLIM_INFINITY
    softM, hardM = resource.getrlimit(resource.RLIMIT_DATA)
    softT, hardT = resource.getrlimit(resource.RLIMIT_CPU)
    usage_old = resource.getrusage(resource.RUSAGE_CHILDREN)
    arguments=(task,r_dict)+args
    p = Process(target=worker, args=arguments, kwargs=kwargs)
    try:
        from resource import prlimit
        p.start()
        prlimit(p.pid, resource.RLIMIT_CPU, (sTL, hardT))
        prlimit(p.pid, resource.RLIMIT_DATA, (bML, hardM))
    except ImportError:
        resource.setrlimit(resource.RLIMIT_CPU, (sTL, hardT))
        resource.setrlimit(resource.RLIMIT_DATA, (bML, hardM))
        p.start()
    finally:
        p.join()
        usage = resource.getrusage(resource.RUSAGE_CHILDREN)
        resource.setrlimit(resource.RLIMIT_CPU, (softT, hardT))
        resource.setrlimit(resource.RLIMIT_DATA, (softM, hardM))
        return returnHandler(p.exitcode, r_dict, usage, usage_old)

def config2Tag(config):
    tag = ""
    tag += str(config["termination"][0])
    tag += "_sccd:"+str(config["scc_depth"])
    tag += "_invariant:"+str(config["invariats"])
    tag += "_dt:"+str(config["different_template"])
    tag += "_simplify:"+str(config["simplify_constraints"])
    tag += "_PE:"+str(config["pe_times"])
    return tag

def file2ID(file):
    pass

def get_info(cache, file):
    name = file2ID(file)
    o = os.path.join(cache, name+".json")
    info = None
    if os.path.isfile(o):
        import json
        with open(o) as f:
            info = json.load(f)
    else:
        info = {"id":name,"file":file}
    if not "anaylis" in info:
        info["analysis"] = []
    return info

def save_info(info, cache, file):
    name = file2ID(file)
    o = os.path.join(cache, name+".json")
    if os.path.isfile(o):
        os.remove(o)
    import json
    with open(o, "w") as f:
        json.dump(info, f)

if __name__ == "__main__":
    argParser = setArgumentParser()
    args = argParser.parse_args(sys.argv[1:])
    ar = vars(args)
    cachedir = os.path.join(os.path.dirname(
            os.path.realpath(__file__)), ar["cache"])
    files = ar["files"]
    sccd = ar["scc_depth"]
    dotF = ar["dotDestination"]
    verb = ar["verbosity"]
    pe_modes = ar["pe_modes"]
    lib = ["ppl"]
    inv = ["none", "interval", "polyhedra"]
    dt = ["iffail"]
    if "timeout" in ar and ar["timeout"]:
        tout = int(ar["timeout"])
    else:
        tout = None
    if "memoryout" in ar and ar["memoryout"]:
        mout = int(ar["memoryout"])
    else:
        mout = None
    algs = []
    algs.append([termination.algorithm.lrf.PR()])
    for i in range(1, 3):
        algs.append([termination.algorithm.qnlrf.QNLRF({"max_depth": i, "min_depth": i,
                                                        "version": 1})])
    # algs.append([{"name": "qlrf_bg"}])
    numm = len(files)
    status = {}
    info = {}
    for f in files:
        ite = 0
        info = get_info(cachedir, f)
        for l in lib:
            for a in algs:
                a[0].set_prop("lib", l)
                for d in dt:
                    name = os.path.basename(f)  # .replace("/","_")
                    config = {
                        "scc_depth": sccd,
                        "verbosity": verb,
                        "ei_out": False,
                        "termination": a,
                        "invariants": i,
                        "different_template": d,
                        "simplify_constraints": True,
                        "pe_modes": pe_modes,
                        "pe_times": 0,
                        "files": [f],
                        "lib": "ppl"
                    }
                    print("Trying with : " + config2Tag(config))

                    response = sandbox(rankfinder.launch_file, args=(config, f),
                                        time_segs=tout, memory_mb=mout)
                    response["date"] = "HOY"
                    response["config"] = config
                    info["analysis"].append(response)
        save_info(info, cachedir, f)
                
