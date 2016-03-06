# How to Write a Spelling Corrector

注：本文译自Peter Norvig的[一篇文章](http://norvig.com/spell-correct.html)的翻译。

TODO：
- Spelling Corrector如何翻译？

在过去的一周，有两个朋友（Dean和Bill）不约而同地提到Google的拼写校正器效果很好，而且极快，为此深感惊奇。在Google的搜索框中输入speling，Google只需0.1秒左右就给出建议：您要搜索的是：spelling？（Yahoo和Microsoft的搜索引擎亦有类似功能）我所奇怪的是，Dean和Bill作为颇有造诣的工程师和数学家，应该对拼写校正器这一类统计语言处理问题有至少是直觉上的认识。但他们并没有，仔细想想，错不在他们，错在我对他们有不合理的期望。

我想到，如果对此实现给出一个解释，会对他们及其他感兴趣的人有所帮助。工业级拼写校正器的完整细节是相当复杂的（你可以读读[这篇](http://static.googleusercontent.com/external_content/untrusted_dlcp/research.google.com/en/us/pubs/archive/36180.pdf)和[这篇](http://citeseerx.ist.psu.edu/viewdoc/download;jsessionid=52A3B869596656C9DA285DCE83A0339F?doi=10.1.1.146.4390&rep=rep1&type=pdf)）。所以我这里只是开发一个代码量不超过一页的“玩具”校正器，同时它的准确率能达到80-90%，每秒钟能处理至少十个词。

于是，下面的21行Python代码就是这样一个实现：

```python
import re, collections

def words(text): return re.findall('[a-z]+', text.lower()) 

def train(features):
    model = collections.defaultdict(lambda: 1)
    for f in features:
        model[f] += 1
    return model

NWORDS = train(words(file('big.txt').read()))

alphabet = 'abcdefghijklmnopqrstuvwxyz'

def edits1(word):
   splits     = [(word[:i], word[i:]) for i in range(len(word) + 1)]
   deletes    = [a + b[1:] for a, b in splits if b]
   transposes = [a + b[1] + b[0] + b[2:] for a, b in splits if len(b)>1]
   replaces   = [a + c + b[1:] for a, b in splits for c in alphabet if b]
   inserts    = [a + c + b     for a, b in splits for c in alphabet]
   return set(deletes + transposes + replaces + inserts)

def known_edits2(word):
    return set(e2 for e1 in edits1(word) for e2 in edits1(e1) if e2 in NWORDS)

def known(words): return set(w for w in words if w in NWORDS)

def correct(word):
    candidates = known([word]) or known(edits1(word)) or known_edits2(word) or [word]
    return max(candidates, key=NWORDS.get)
```




