import nltk.stem
s = nltk.stem.SnowballStemmer('english')
print(s.stem('graphics'))
print(s.stem('imaging'))
print(s.stem('image'))
print(s.stem('imagination'))
print(s.stem('imagine'))