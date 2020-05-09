#!/usr/bin/env python
import sys
output = {}
for input_line in sys.stdin:
    input_line = input_line.strip()
    l = input_line.split("\t")
    try:
        if len(l) > 0 :
            keystring = l[0]+"\t"+l[1]
            if keystring not in output.keys():
                output[keystring] = int(l[2])
            else:
                output[keystring] += int(l[2])
    except:
         output["1995-1\t0\t0"] = 0

for key in output:
    print("%s\t%s" % (key, output[key]))