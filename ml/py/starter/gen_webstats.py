# This script generates web traffic data for our hypothetical
# web startup "MLASS" in chapter 01

import os
import scipy as sp
from scipy.stats import gamma
import matplotlib.pyplot as plt

sp.random.seed(3)  # to reproduce the data later on

x = sp.arange(1, 31 * 24)
y = sp.array(200 * (sp.sin(2 * sp.pi * x / (7 * 24))), dtype=int)
y += gamma.rvs(15, loc=0, scale=100, size=len(x))
y += 2 * sp.exp(x / 100.0)
y = sp.ma.array(y, mask=[y < 0])
print(sum(y), sum(y < 0))

plt.scatter(x, y, s=2, color='b')
plt.title("Web traffic over the last month")
plt.xlabel("Time")
plt.ylabel("Hits/hour")
plt.xticks([w * 7 * 24 for w in [0, 1, 2, 3, 4]],
           ['week %i' % (w + 1) for w in [0, 1, 2, 3, 4]])

plt.autoscale(tight=True)
plt.grid()
plt.savefig("1400_01_01.png")

data_dir = '.'
print(data_dir)

sp.savetxt(os.path.join(data_dir, "web_traffic.tsv"),
           list(zip(x, y)),
           delimiter="\t", fmt="%s")
