#!/usr/bin/env python

import os
import sys
import datetime
import argparse
from copy import deepcopy
import functools

_ops = {"pe_times":"pe_times",
        "different_template":"different_template",
        "invariants":"invariants",
        "lib":"lib",
        "pe":"pe_times",
        "dt":"different_template",
        "inv":"invariants"
}
_kops = ["pe_times", "different_template","invariants","lib","termination"]
_possibles ={"pe_times":[0,1,2,3,4,5,6,7],
             "different_template":["never", "iffail", "always"],
             "invariants":["none", "interval", "polyhedra", "octagon"],
             "lib":["ppl", "z3"],
             "termination": ["lrf_pr", "qnlrfv1_1_1", "qnlrfv1_2_2", "qnlrfv1_3_3"]
}

def equivalent(opt):
    if opt in _ops:
        return _ops[opt]
    raise Exception("Option ({}) not available".format(opt))

def setArgumentParser():
    pets = _possibles["pe_times"]
    als = _possibles["termination"]
    libs = _possibles["lib"]
    invs = _possibles["invariants"]
    dts = _possibles["different_template"]
    desc = "Compare Table"
    argParser = argparse.ArgumentParser(description=desc)
    ropts = [k for k in _ops]
    # Program Parameters
    argParser.add_argument("-v", "--verbosity", type=int, choices=range(0, 5),
                           help="increase output verbosity", default=0)
    # IMPORTANT PARAMETERS
    argParser.add_argument("-c", "--cache", required=True,
                           help="Folder cache.")
    argParser.add_argument("-p", "--prefix", required=False, default="",
                           help="Prefix of the files path")
    argParser.add_argument("-r", "--rows", required=False, choices=ropts, default="invariants",
                           help="Criteria to compare by row")
    argParser.add_argument("-dts", "--different_template", required=False, choices=dts, default=["iffail"],
                           nargs='*', help="different template")
    argParser.add_argument("-als", "--termination", required=False, choices=als, default=als,
                           nargs='*', help="algorithms")
    argParser.add_argument("-libs", "--lib",  required=False, choices=libs, default=["ppl"],
                           nargs='*', help="libs")
    argParser.add_argument("-invs", "--invariants", required=False, choices=invs, default=["none", "interval", "polyhedra"],
                           nargs='*', help="invariants")
    argParser.add_argument("-pets", "--pe_times", required=False, choices=pets, default=[0,1],
                           type=int, nargs='*', help="pe times")

        
    return argParser


def getfiles(relevant_path, prefix):
    included_extensions = ['json']
    return [os.path.join(relevant_path,fn) for fn in os.listdir(relevant_path)
            if (fn.startswith(prefix) and
                any(fn.endswith(ext) for ext in included_extensions))]


def get_info(filename):
    o = filename
    info = None
    if os.path.isfile(o):
        import json
        with open(o) as f:
            info = json.load(f)
    else:
        print("Imposible")
        print(filename)
        raise Exception("Como has llegado aqui?")
    if not "analysis" in info:
        info["analysis"] = []
    for a in info["analysis"]:
        ter = []
        for alg in a["config"]["termination"]:
            ter.append(alg)
        a["config"]["termination"] = ter
        a["status"] = str(a["status"])
        a["date"] = datetime.datetime.strptime(a["date"], "%Y-%m-%dT%H:%M:%S.%f")
    return info

def orderalgs(a, b):
    if a == b:
        return 0
    aes = a.split("_")
    bes = b.split("_")
    types = ["lrf", "qlrf", "qnlrf", "qnlrfv1", "qnlrfv2"]
    if aes[0] not in types:
        raise Exception(",,,,1")
    if bes[0] not in types:
        raise Exception("....2")
    if types.index(aes[0]) < types.index(bes[0]):
        return 1
    if aes[0] != bes[0]:
        return -1
    if aes[0] == "lrf" or aes[0] == "qlrf":
        return 0
    am = 1
    aM = 5
    bm = 1
    bM = 5
    if len(aes) == 3:
        am = int(aes[1])
        aM = int(aes[2])
    elif len(aes) == 2:
        aM = int(aes[1])
    if len(bes) == 3:
        bm = int(bes[1])
        bM = int(bes[2])
    elif len(bes) == 2:
        bM = int(bes[1])
    if am < bm:
        return 1
    if aM < bM:
        return 1
    if am == bm and aM == bM:
        return 0
    return -1


def order(item1, item2):
    a = item2["config"]
    b = item1["config"]
    ia = int(a["pe_times"])
    ib = int(b["pe_times"])
    if ia < ib:
        return 1
    if ia > ib:
        return -1
    ta = a["termination"]
    tb = b["termination"]
    if len(ta) < len(tb):
        return 1
    elif len(ta) > len(tb):
        return -1
    else:
        als = orderalgs(ta[0],tb[0])
        if als != 0:
            return als
    ks = ["lib", "invariants", "different_template", "simplify_constraints"]
    for k in ks:
        if _possibles[k].index(a[k]) < _possibles[k].index(b[k]):
            return 1
        if _possibles[k].index(a[k]) > _possibles[k].index(b[k]):
            return -1
    return 0

def print_selector(ID, name, value):
    v = ""
    if isinstance(value, list):
        v = " ".join([str(vv) for vv in value])
    else:
        v = str(value)
    return '<span><b>'+name+':</b> <input type="text" name="'+ID+'" value="'+v+'" /></span><br/>\n'
def print_selectors(params):
    selector = "<h2>Filters</h2>\n"
    selector += "<form action='?' method='get' accept-charset='utf-8' id='filterform'>\n"
    selector += print_selector("prefix", "File Prefix", params["prefix"])
    for k in sorted(_possibles):
        selector += print_selector(k, k, params[k])
    selector += "<span>Rows: <select name='rows' form='filterform'>\n"
    selector += "<option value='None'>None</option>\n"
    for k in _possibles:   
        selector += "<option value='"+k+"'"
        if params["rows"] == k:
            selector += " selected "
        selector += ">"+k+"</option>\n"
    selector += "</select></span><br/>"
    selector += '<input type="submit" value="Filter">\n'
    selector += "</form>"
    return selector

        
def print_head(cfgs, rows):
    head = "<table>\n\t<col class='number'><col class='name'>"
    head += "<thead>\n\t\t<tr><th>#</th><th>Name</th>"
    if len(rows) > 0:
        head += "<th></th>"
    i = 0
    for c in cfgs:
        i += 1
        head += '<th alt="'+str(c)+'">.    c'+str(i)+"    .</th>"
    head += "</tr>\n\t</thead>\n\t<tbody>\n"
    return head

def print_bottom(cfgs, rows):
    bottom = "\n\t\t<tr><td></td><td></td>"
    if len(rows) > 0:
        bottom += "<td></td>"
    i = 0
    for c in cfgs:
        i += 1
        bottom += '<td>c '+str(i)+"</td>"
    bottom += "</tr>\n\t</tbody>\n</table>"
    return bottom

def get_i(config, info):
    aas = info["analysis"]
    valids = []
    
    for a in aas:
        c = a["config"]
        good = True
        for k in config:
            if k not in _kops:
                continue
            if c[k] == config[k]:
                continue
            good = False
            break
        if good:
            valids.append(a)
    if len(valids) == 0:
        return None
    valids.sort(key=lambda a: a["date"])
    return valids[0]
            

    
def print_info(i, cfgs, rows, rowsinfo, info):
    nr = max(1,len(rowsinfo))
    line = "\t\t<tr class='upper'><td rowspan='"+str(nr)+"'>"+str(i)+"</td>"
    line += "<td rowspan='"+str(nr)+"'>"+info["id"]+"</td>"
    for ith in range(nr):
        if ith != 0:
            line += "\t\t<tr>"
        if rows != "":
            line += "<td>"+str(rowsinfo[ith])+"</td>"
        terminate = False
        for c in cfgs:
            lc = deepcopy(c["config"])
            if rows != "None":
                lc[rows] = rowsinfo[ith]
            i = get_i(lc, info)
            line+= "<td"
            if not terminate and i is not None:
                line += " class='"+str(i["status"]).replace(" ", "")+"'>"
                line += str(i["status"])
                terminate = ("Terminate" == str(i["status"]))
            else:
                line += ">"
            line+= "</td>"
        line += "</tr>\n"
    return line
            
if __name__ == "__main__":
    argParser = setArgumentParser()
    args = argParser.parse_args(sys.argv[1:])
    ar = vars(args)
    dbdir = os.path.abspath(ar["cache"])
    if "rows" in ar:
        ar["rows"] = equivalent(ar["rows"])
    else:
        ar["rows"] = "None"
    ar["None"] = [""]
    configs = [{"config":{}}]

    for k in _kops:
        nconfs = []
        if k == ar["rows"]:
            continue
        for item in ar[k]:
            for c in configs:
                a = deepcopy(c)
                if k == "termination":
                    a["config"][k] = [item]
                else:
                    a["config"][k] = item
                nconfs.append(a)
        configs = [c for c in nconfs]

    fs = getfiles(dbdir, ar["prefix"])
    infos = sorted([get_info(f) for f in fs], key=lambda cf: cf["id"])
    print(print_selectors(ar))
    str_table = print_head(configs, ar["rows"])
    i = 0
    for info in infos:
        i+=1
        str_table += print_info(i, configs, ar["rows"], ar[ar["rows"]], info)
    str_table += print_bottom(configs, ar["rows"])
    print(str_table)
    




