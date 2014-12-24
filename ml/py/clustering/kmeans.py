from scipy.linalg import norm
from news_group import train
from vectorizers import StemmedTfidfVectorizer

vectorizer = StemmedTfidfVectorizer(min_df=10,
                                    stop_words='english', decode_error='ignore')

groups = ['comp.graphics', 'comp.os.ms-windows.misc',
              'comp.sys.ibm.pc.hardware', 'comp.sys.ma c.hardware',
              'comp.windows.x', 'sci.space']
dataset = train(groups)
assert len(dataset.filenames) == 3414
vectorized = vectorizer.fit_transform(dataset.data)
num_samples, num_features = vectorized.shape
print('#samples: {0}, #features: {1}'.format(num_samples, num_features))

# train
num_clusters = 50
from sklearn.cluster import KMeans
km = KMeans(n_clusters=num_clusters, init='random', n_init=1, verbose=1)
km.fit(vectorized)

print(km.labels_)
print(km.labels_.shape)
print(km.cluster_centers_)

# predict
new_post = \
    """Disk drive problems. Hi, I have a problem with my hard disk.
After 1 year it is working only sporadically now.
I tried to format it, but now it doesn't boot any more.
Any ideas? Thanks.
"""
new_post_vec = vectorizer.transform([new_post])
new_post_label = km.predict(new_post_vec)[0]

# read clustering info
similar_indices = (km.labels_ == new_post_label).nonzero()[0]
print(similar_indices)

similar = []
for i in similar_indices:
    dist = norm((new_post_vec - vectorized[i]).toarray())
    similar.append((dist, dataset.data[i]))
similar = sorted(similar)
print(len(similar))

show_at_1 = similar[0]
show_at_2 = similar[len(similar) / 2]
show_at_3 = similar[-1]

print(show_at_1)
print(show_at_2)
print(show_at_3)