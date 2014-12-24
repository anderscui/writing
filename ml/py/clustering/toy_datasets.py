import os
import sys

from distances import normalized, euclidean
from vectorizers import basic, stop_words, stemmed, stemmed_tfidf

# print(__file__)
# print(os.path.dirname(os.path.realpath(__file__)))
# print(os.path.join(os.path.dirname(os.path.realpath(__file__)), r'data\toy'))


def toy_data(vectorizer, func_dist, new_post):
    folder = os.path.join(os.path.dirname(os.path.realpath(__file__)), r'data\toy')
    posts = [open(os.path.join(folder, f)).read() for f in os.listdir(folder)]
    # for p in posts:
    #     print(p)

    X_train = vectorizer.fit_transform(posts)
    num_samples, num_features = X_train.shape
    print('#samples: {0}, #features: {1}'.format(num_samples, num_features))
    # print(vectorizer.get_feature_names())

    # transform function returns sparse vectors.
    new_post_vec = vectorizer.transform([new_post])
    # print(new_post_vec)
    # print(new_post_vec.toarray())

    best_doc = None
    best_dist = sys.maxint
    best_i = None
    for i in xrange(num_samples):
        post = posts[i]
        if post == new_post:
            continue
        post_vec = X_train.getrow(i)
        # print(post_vec)
        dist = func_dist(post_vec, new_post_vec)
        print('=== post {0} with dist = {1:.2f}: {2}'.format(i, dist, post))
        if dist < best_dist:
            best_dist = dist
            best_i = i
            best_doc = post

    print('new post: ' + new_post)
    print('best post is {0} with dist = {1:.2f}'.format(best_i, best_dist))
    print(best_doc)
    print('')


if __name__ == '__main__':

    new_post = 'imaging databases'

    print('using euclidean distance')
    toy_data(basic(), euclidean, new_post)
    print('using normalized distance')
    toy_data(basic(), normalized, new_post)

    print('using stop words')
    sw_vect = stop_words()
    toy_data(sw_vect, normalized, new_post)
    print(sorted(sw_vect.get_stop_words())[60:80])

    print('using stemmed vectorizer')
    stem_vect = stemmed()
    toy_data(stem_vect, normalized, new_post)
    print(stem_vect.get_feature_names())

    print('using stemmed tfidf vectroizer')
    toy_data(stemmed_tfidf(), normalized, new_post)