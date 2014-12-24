import nltk.stem
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer

english_stemmer = nltk.stem.SnowballStemmer('english')


def basic():
    return CountVectorizer(min_df=1)


def stop_words():
    return CountVectorizer(min_df=1, stop_words='english')


class StemmedCountVectorizer(CountVectorizer):
    def build_analyzer(self):
        analyzer = super(StemmedCountVectorizer, self).build_analyzer()
        return lambda doc: (english_stemmer.stem(w) for w in analyzer(doc))


def stemmed():
    return StemmedCountVectorizer(min_df=1, stop_words='english')


class StemmedTfidfVectorizer(TfidfVectorizer):
    def build_analyzer(self):
        analyzer = super(TfidfVectorizer, self).build_analyzer()
        return lambda doc: (english_stemmer.stem(w) for w in analyzer(doc))


def stemmed_tfidf():
    # The resulting document vectors will not contain counts.
    return StemmedTfidfVectorizer(min_df=1, stop_words='english', decode_error='ignore')


if __name__ == '__main__':
    vectorizer = stemmed()
    print(vectorizer)

    vectorizer = stemmed_tfidf()
    print(vectorizer)