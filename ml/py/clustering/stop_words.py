from sklearn.feature_extraction.text import CountVectorizer


# 'english' is currently the only supported string value.
vectorizer = CountVectorizer(min_df=1, stop_words='english')
for w in sorted(vectorizer.get_stop_words()):
    print(w)