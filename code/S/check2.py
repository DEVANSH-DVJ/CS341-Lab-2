import os
from random import randint
from math import gcd


def gen_amx():
    def eucl(a, m):
        if a == 0:
            return 0, 1
        x1, y1 = eucl(m % a, a)
        x = y1 - (m // a) * x1
        y = x1
        return x, y

    a = m = 2
    r = 1000000000
    while gcd(a, m) != 1:
        a = randint(1, r)
        m = randint(2, r)

    x, _ = eucl(a, m)

    return a, m, (x + m) % m


def gen_tc():
    out = []
    tc = ''
    n = randint(1, 20)
    for _ in range(n):
        a, m, x = gen_amx()
        tc += f'{a}\n{m}\nY\n'
        out.append(f'{a}*{x} = 1 (mod {m})')

    tc += '5\n26\nN'
    f = open('tmp.txt', 'w')
    f.write(tc)
    f.close()

    return out + ['5*21 = 1 (mod 26)']


def run():
    lines = os.popen('spim -file q2.s < tmp.txt').read().splitlines()
    return filter(lambda line: 'mod' in line, lines)


n = 1000

for i in range(n):
    out = gen_tc()
    o = list(run())
    for j in range(len(out)):
        if out[j] not in o[j]:
            print(f'got {o[j]} expected{out[j]}\n')
            exit(1)

    print(f'Testcase {i + 1}/{n} passed', end='\r')

print('woohoo! your code is correct (or the testcases are wrong xD)')
os.system('rm -rf tmp.txt')
