import os
from random import randint
from math import comb


def gen_tc():
    out = []
    tc = ''
    x = randint(1, 10)
    for _ in range(x):
        n = randint(1, 20)
        r = randint(0, n)
        tc += f'{n}\n{r}\nY\n'
        out.append(comb(n, r))

    tc += '5\n3\nN'
    f = open('tmp.txt', 'w')
    f.write(tc)
    f.close()

    return out + [10]


def run():
    out = []
    exp = []
    lines = os.popen('spim -f q1.s < tmp.txt').read().splitlines()
    for line in lines:
        if 'Enter n' in line:
            d = line.split(' ')[-1]
            if d.isdigit():
                exp.append(line.split(' ')[-2])
                out.append(int(d))

    return out, exp


n = 100

for i in range(n):
    out = gen_tc()
    o, exp = run()
    for j in range(len(out)):
        if o[j] != out[j]:
            print(f'failed for {exp[j]} got {o[j]} expected{out[j]}\n')
            exit(1)

    print(f'Testcase {i + 1}/{n} passed', end='\r')

print("woohoo! your code is correct (or the testcases are wrong xD)")
os.system("rm -rf tmp.txt")
