__author__ = 'anders.cui'

import numpy as np
a = np.array([0, 1, 2, 3, 4, 5])
print(a)
# [0 1 2 3 4 5]

print(a.ndim, a.shape)

# transform this array in to a 2D matrix
b = a.reshape((3, 2))
print(b)
print(b.ndim, b.shape)
# (2, (3L, 2L))


# avoids copies wherever possible
b[1][0] = 77
print(b)
print(a)
print(b.ndim, b.shape)


# a true copy
# Function 'copy' doesn't return anything. (Inferred type error)
c = a.reshape((3, 2)).copy()
c[0][0] = 99
print(c)
print(a)


# operations propagated to the individual elements
a = np.array([0, 1, 2, 3, 4, 5])
print(a * 2)
print(a ** 2)


# indexing
print(a[np.array([2, 3, 4])])  # [2 3 4]
print(a > 2)  # [False False False False  True  True]
print(a[a > 2])

# clip
print(a.clip(1, 3))


# NAN
c = np.array([1, 2, np.NaN, 3, 4])
print(c)
print(np.isnan(c))
print(c[~np.isnan(c)])
print(np.mean(c[~np.isnan(c)]))

