import scipy as sp

from scipy.optimize import fsolve

p2 = sp.array([1, -5, 6])
p2f = sp.poly1d(p2)
x = fsolve(p2f, sp.array([0, 5]))
print(x)