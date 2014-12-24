from scipy.stats import norm

v = norm(loc=0.3, scale=.15).rvs(20)
print(v)