#!/usr/bin/env python
import sys
import datetime
first = 1
output = {}
for input_line in sys.stdin:
    if first == 0:
        try:
            input_line = input_line.strip()
            l = input_line.split(",")
            if l[9] == "2":
                dateMonth = datetime.datetime.strptime(l[2], '%Y-%m-%d %H:%M:%S')
                keystring = str(dateMonth.year)+"-"+str(dateMonth.month)+"\t"+str(l[7])
                if keystring not in output.keys():
                    output[keystring] = int(l[3])
                else:
                    output[keystring] += int(l[3])
        except:
            output["1995-1\t0\t0"] = 1
    else:
        first = 0

# Combined output for one node
for key in output:
    print("%s\t%s" % (key, output[key]))