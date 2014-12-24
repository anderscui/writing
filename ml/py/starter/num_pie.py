import numpy as np

# version
print(np.version.full_version)

# create an array
a = np.array([0, 1, 2, 3, 4, 5])
print(a.ndim)
print(a.shape)

# reshape
b = a.reshape(3, 2)
print(b)
print(b.ndim)
print(b.shape)

# shadow copy
b[1][0] = 10
print(a)

# deep copy, c and are independent
c = a.reshape(3, 2).copy()
c[1][0] = 100
print(c)
print(a)

# element-wise operation
print(a * 2)

# boolean array
print(a > 3)
print(a[a > 3])

# trim outliers
#a[a > 3] = 3
print(a)
# or clip it
print(a.clip(0, 3))

