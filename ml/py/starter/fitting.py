import math

__author__ = 'anders.cui'

import scipy as sp

data = sp.genfromtxt('web_traffic.tsv', delimiter='\t')

# print(type(data), type(data[1][1]), data[1][1])
# print(data[:10])
# print(data.shape)

x = data[:,0]
y = data[:,1]

# print(sp.sum(sp.isnan(y)))

x = x[~sp.isnan(y)]
y = y[~sp.isnan(y)]

# now we've got the cleaned data

def error(f, x, y):
    return sp.sum((f(x) - y) ** 2)


# try to fit a simple straight line
# fp1, residuals, rank, sv, rcond = sp.polyfit(x, y, 1, full=True)
# print(fp1, residuals, rank, sv, rcond)

# print(math.sqrt(residuals / len(y)))
# 657.132264242

f1p = sp.polyfit(x, y, 1)
f1 = sp.poly1d(f1p)
print(error(f1, x, y))
# 317389767.34

# although it's not that good, we use it as our baseline.

# try to fit a more complex model
f2p = sp.polyfit(x, y, 2)
f2 = sp.poly1d(f2p)
f3p = sp.polyfit(x, y, 3)
f3 = sp.poly1d(f3p)
f10p = sp.polyfit(x, y, 10)
f10 = sp.poly1d(f10p)
f100p = sp.polyfit(x, y, 100)
f100 = sp.poly1d(f100p)

print(error(f1, x, y))
print(error(f2, x, y))
print(error(f3, x, y))
print(error(f10, x, y))
print(error(f100, x, y))


# draw it
import matplotlib.pyplot as plt

plt.scatter(x, y, color='blue', s=2)  # size is 2
plt.title('Web traffic over the last month')
plt.xlabel('Time')
plt.ylabel('Hits/hour')
plt.xticks([w*7*24 for w in range(10)], ['week %i' % (w+1) for w in range(10)])
plt.autoscale(tight=True)
plt.grid()
# plt.show()

fx = sp.linspace(1, x[-1], 1000)


# plt.plot(fx, f1(fx), linewidth=2, color='green')
plt.plot(fx, f1(fx), linewidth=2)
plt.legend(['d=%i' % f1.order], loc='upper left')
plt.plot(fx, f2(fx), linewidth=2)
plt.legend(['d=%i' % f2.order], loc='upper left')
plt.plot(fx, f3(fx), linewidth=2)
plt.legend(['d=%i' % f3.order], loc='upper left')
plt.plot(fx, f10(fx), linewidth=2)
plt.legend(['d=%i' % f10.order], loc='upper left')
plt.plot(fx, f100(fx), linewidth=2)
plt.legend(['d=%i' % f100.order], loc='upper left')

plt.show()

