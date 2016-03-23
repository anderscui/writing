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

If stemming and lemmatization are a kind of lingustic compression, then word replacement can be thought of as error correction or text normalization.

```python
import re

replacement_patterns = [
    (r"won't", "will not"),
    (r"can't", "cannot"),
    (r"i'm", "i am"),
    (r"isn't", "is not"),
    (r"(\w+)'ll", "\g<1> will"),
    (r"(\w+)n't", "\g<1> not"),
    (r"(\w+)'ve", "\g<1> have"),
    (r"(\w+)'s", "\g<1> is"),
    (r"(\w+)'re", "\g<1> are"),
    (r"(\w+)'d", "\g<1> would")
]


class RegexpReplacer(object):
    def __init__(self, patterns=replacement_patterns):
        self.patterns = [(re.compile(regex), repl) for (regex, repl) in patterns]

    def replace(self, text):
        s = text
        for (pattern, repl) in self.patterns:
            s = re.sub(pattern, repl, s)
        return s
```

## Removing repeating characters

```python
class RepeatReplacer(object):
    def __init__(self):
        self.repeat_regexp = re.compile(r'(\w*)(\w)\2(\w*)')
        self.repl = r'\1\2\3'

    def replace(self, word):

        if wordnet.synsets(word):
            return word

        repl_word = self.repeat_regexp.sub(self.repl, word)

        if repl_word != word:
            return self.replace(repl_word)
        else:
            return repl_word
```

## Spelling correction with Enchant

Replacing repeating characters is actually an extreme form of spelling correction. Now we take on the less extreme case of correcting minor spelling issues using **Enchant**.

Enchant is an offshoot of the AbiWord open source word processor, and more info on it can be found at [AbiWord](http://www.abisource.com/projects/enchant/) or [github](https://github.com/AbiWord/enchant).

For dictionaries, **Aspell** is a good open source spellchecker and dict that can be found at [aspell.net](aspell.net).

Finally, we will need the [**PyEnchant**](http://pythonhosted.org/pyenchant/) library.


TODO: also TextBlob (which is bad:))

## Replacing synomyms

It's often useful to reduce the vocabulary of a text by replacing words with common synonyms. See more details at [Frequency Analysis](https://en.wikipedia.org/wiki/Frequency_analysis) and [Full Text Search](https://en.wikipedia.org/wiki/Full_text_search)

## Replacing negations with antonyms

The opposite of synonym replacement is **antonym replacement**. We can use WordNet to replace words with unambiguous antonyms.

We will try to convert a sentence like "let's not uglify our code" to "let's beautify our code".

