import numpy as np


def learn_model(features, labels):
    global best_acc, fi, thresh, t, pred, acc, best_fi, best_t
    best_acc = -1.0
    # iterate features
    for fi in xrange(features.shape[1]):
        # get copy of a feature
        thresh = features[:, fi].copy()
        thresh.sort()

        # test all thresholds
        for t in thresh:
            pred = (features[:, fi] > t)
            # calculate accuracy
            acc = (pred == labels).mean()
            if acc > best_acc:
                best_acc = acc
                best_fi = fi
                best_t = t

    return best_t, best_fi


def apply_model(features, model):
    t, fi = model
    return features[:, fi] > t


def accuracy(features, labels, model):
    preds = apply_model(features, model)
    return np.mean(preds == labels)