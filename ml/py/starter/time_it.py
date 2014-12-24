__author__ = 'anders.cui'

import timeit
normal_py_sec = timeit.timeit('sum(x*x for x in xrange(1000))', number=10000)
naive_np_sec = timeit.timeit('sum(na*na)',
                             setup='import numpy as np; na=np.arange(1000)', number=10000)
good_np_sec = timeit.timeit('na.dot(na)',
                            setup='import numpy as np; na=np.arange(1000)', number=10000)

print("Normal Python: {0:f} sec".format(normal_py_sec))
print("Naive NumPy: {0:f} sec".format(naive_np_sec))
print("Good NumPy: {0:f} sec".format(good_np_sec))

# Normal Python: 0.723123 sec
# Naive NumPy: 1.539209 sec
# Good NumPy: 0.020509 sec

# Naive NumPy: 1.539209 sec
# the access of individual elements from Python itself is rather costly.

# so, we should always look at how we can move loops over individual elements from Python to
# some of the highly optimized NumPy or SciPy extension methods.
# on the other hand, we lost the flexibility of Python lists.

import numpy as np
a = np.array([1, 2, 3])
print(a.dtype)