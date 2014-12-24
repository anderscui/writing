__author__ = 'anders.cui'

import scipy as sp
import numpy as np
print(sp.version.full_version)

a = sp.array([1, 2, 3, 4, 5])
print(np.dot(a, a))
print(sp.dot(a, a))

print(np.dot is sp.dot)