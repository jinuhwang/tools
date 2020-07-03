import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import os
import re

def parse_file(filepath):

    f = open(filepath)
    for line in f:
        if 'system.cpu.dtb.rdAccesses2' in line:
            rdAccesses2 = int(re.findall(r'\d\d+', line)[0])
        elif 'system.cpu.dtb.rdAccesses' in line:
            rdAccesses = int(re.findall(r'\d\d+', line)[0])
        elif 'system.cpu.dtb.rdMisses' in line:
            rdMisses = int(re.findall(r'\d\d+', line)[0])

        if 'system.cpu.dtb.wrAccesses2' in line:
            wrAccesses2 = int(re.findall(r'\d\d+', line)[0])
        elif 'system.cpu.dtb.wrAccesses' in line:
            wrAccesses = int(re.findall(r'\d\d+', line)[0])
        elif 'system.cpu.dtb.wrMisses' in line:
            wrMisses = int(re.findall(r'\d\d+', line)[0])

    rdL1 =  rdAccesses2 / rdAccesses
    wrL1 =  wrAccesses2 / wrAccesses

    rdL2 =  rdMisses / rdAccesses2
    wrL2 =  wrMisses / wrAccesses2

    return {'rdL1': rdL1, 'wrL1': wrL1, 'rdL2': rdL2, 'wrL2': wrL2}


d = {}
depth = 1
start = os.path.abspath(os.path.expanduser(os.path.expandvars('./m5out/part1')))
for root, dirs, files in os.walk(start):
    if root[len(start):].count(os.sep) < depth:
        for dirname in dirs:
            filepath = os.path.join(start, dirname, 'stats.txt')
            value = parse_file(filepath)
            d[dirname] = value

df = pd.DataFrame(d)

size = [128, 512, 1024]
assoc = [2, 4, 8]
benchmarks = ['lbm', 'hmmer', 'bzip2', 'mcf', 'sjeng', 'libquantum']

# Assoc fisrt
fig, ax = plt.subplots(3,2, figsize=(15, 20))
fig.suptitle('Performance of L2 TLB with 512 entries and different Associativity', fontsize=24)

for i, benchmark in enumerate(benchmarks):
    a = df.loc[:, df.columns.str.startswith(benchmark+'-512')]
    a = a.sort_index(axis=1)
    a.columns = a.columns.map(lambda x: x[len(benchmark)+1:])

    axes = ax[i//2][i%2]
    axes.set_title(benchmark)
    axes.set_xlabel('Set Associativity of L2 TLB')
    rdL1 = axes.plot(a.iloc[0])
    wrL1 = axes.plot(a.iloc[1])
    axes.set_ylabel('TLB Miss Rate')
    axes.legend(rdL1+wrL1, ('Read', 'Write'), loc=0)

fig.tight_layout(rect=[0, 0.00, 1, 0.90])
# plt.savefig('assoc.png', dpi=200)
plt.show()

# Then Size
# axes = plt.axes(figsize=(15, 20))
# fig.suptitle('Performance of L2 TLB of soplex', fontsize=24)
fig, axes = plt.subplots()

a = df.loc[:, df.columns.str.startswith('soplex')]
a = a.sort_index(axis=1)
a.columns = a.columns.map(lambda x: x[len('soplex')+1:])

axes.set_xlabel('Size-Associativity of L2 TLB')
rdL1 = axes.plot(a.iloc[0])
wrL1 = axes.plot(a.iloc[1])
rdL2 = axes.plot(a.iloc[2])
wrL2 = axes.plot(a.iloc[3])
axes.set_ylabel('TLB Miss Rate')
axes.legend(rdL1+wrL1+rdL2+wrL2, ('L1 Read', 'L1 Write', 'L2 Read', 'L2 Write'), loc=0)

plt.show()
