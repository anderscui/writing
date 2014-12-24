import scipy as sp


def euclidean(v1, v2):
    delta = v1 - v2
    return sp.linalg.norm(delta.toarray())


def normalized(v1, v2):
    v1_normalized = v1 / sp.linalg.norm(v1.toarray())
    v2_normalized = v2 / sp.linalg.norm(v2.toarray())
    delta = v1_normalized - v2_normalized
    return sp.linalg.norm(delta.toarray())

