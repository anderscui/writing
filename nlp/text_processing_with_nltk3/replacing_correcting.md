# Replacing and Correcting Words

We will go over various word replacement and correction techniques which cover the gamut of lingustic compression, spelling correction, and text normalization.

## Stemming words

**Stemming** is a technique to remove affixes from a word, ending up with the stem. e.g. the stem of cooking is cook. Stemming is most commonly used by **search engines** for indexing words. Instead of storing all forms of a word, a search engine can store only the stems, greatly reducing the size of index while increasing retrieval accuracy.

One of the most common stemming algorithms is the **Porter stemming algorithm** by Marting Porter. The resulting stem is not always a valid word.

## Lemmatizing words with WordNet

**Lemmatization** is very similar to stemming, but is more akin to synonym replacement. A lemma is a root word, as opposed to the root stem. So unlike stemming, you are always left with a valid word that means the same thing.

```WordNetLemmatizer``` class is a thin wrapper around the ```wordnet``` corpus and uses the ```morphy``` function of the WordNetCorpusReader class to find a lemma.

```python
from nltk.stem import WordNetLemmatizer

lemmatizer = WordNetLemmatizer()
print(lemmatizer.lemmatize('cooking'))
print(lemmatizer.lemmatize('cooking', pos='v'))
print(lemmatizer.lemmatize('cooking', pos='n'))
print(lemmatizer.lemmatize('cookbooks'))

# vs. stemming
from nltk.stem import PorterStemmer

stemmer = PorterStemmer()
print(stemmer.stem('beleives'))
print(lemmatizer.lemmatize('believes'))
```

While a stemmer only looks at the **form** of the word, the lemmatizer looks at the **meaning** of the word.

## Replacing words matching regular exp

## Removing repeating characters

## Spelling correction with Enchant

TODO: also TextBlob (which is bad:))

## Replacing synomyms

## Replacing negations with antonyms

