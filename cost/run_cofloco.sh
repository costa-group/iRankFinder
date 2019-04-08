#!/bin/bash

export LD_LIBRARY_PATH=/root/.opam/4.04.0/lib/z3
/usr/bin/time -f "\n-- stats\nrealtime %E\nusertime %U\nsystime %S\n" timeout 300s /opt/tools/cofloco/cofloco_static -i $1 -compute_ubs -competition >& $2
