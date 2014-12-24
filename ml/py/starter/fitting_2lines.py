__author__ = 'anders.cui'

import scipy as sp

data = sp.genfromtxt('web_traffic.tsv', delimiter='\t')

x = data[:,0]
y = data[:,1]

x = x[~sp.isnan(y)]
y = y[~sp.isnan(y)]


def error(f, x, y):
    return sp.sum((f(x) - y) ** 2)

inflection = 3.5 * 7 * 24
xa = x[:inflection]
ya = y[:inflection]

xb = x[inflection:]
yb = y[inflection:]

fa = sp.poly1d(sp.polyfit(xa, ya, 1))
fb = sp.poly1d(sp.polyfit(xb, yb, 1))

fa_error = error(fa, xa, ya)
fb_error = error(fb, xb, yb)
print('Error inflection: %f' % (fa_error + fb_error))

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

plt.plot(xa, fa(xa), linewidth=2)
plt.legend(['d=%i' % fa.order], loc='upper left')
plt.plot(xb, fb(xb), linewidth=2)
plt.legend(['d=%i' % fb.order], loc='upper left')

# plt.show()

