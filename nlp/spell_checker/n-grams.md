
## Overview

语言模型是NLP中最重要的主题之一，其目标是为一个句子(或一般的词序列)指定一个概率。为何要为句子指定概率值？要知道，语言模型有很多应用：

* 机器翻译：区分好的和不好的翻译，如P(high winds tonight) > P(large winds tonight)
* 拼写检查：P(about fifteen minutes from) >> P(about fifteen minuets from)
* 语音识别：P(I saw a van) > P(eyes awe of an)

语言模型的目标是计算一个句子(或一般的词序列)的概率，即P(W) = P(w1,w2,...,wn)；
另一个相关任务是计算下一个词的概率：P(w5|w1,w2,w3,w4)

那么能够计算两种概率中任一个的模型就被称为**语言模型（language model）**。由于语言模型用于判断词序列的有效性，故部分地类似于grammar，但一般仍习惯称之为语言模型。

## 计算

如何计算如下联合概率：P(its, water, is, so, transparent, that)？

一个intuition是，通过概率的链式法则。即P(its, water, is, so, transparent, that) = P(its) P(water | its) P(is | its water) P(so | its water is) P(transparent | its water is so)

然后，使用计数计算单个条件概率如P(the | its water is so transparent that) = Count(its water is so transparent that the) / Count(its water is so transparent that)，但在这里这方法并不可行。当词序列稍长，我们需要计算的序列数目将变得极大，以至于不可能收集到如此数量的训练数据。

### 马尔可夫假设（Andrei Markov Assumption）

直接计数不可行，那我们就考虑将其简化，这就会用到马尔可夫假设。这时我们假设P(the | its water is so transparent that) = P(the | that) 或 P(the | transparent that)，即一个词的条件概率仅与它前面的若干个（甚至是0个）词有关。如此得到unigram、bigram、trigram等模型，并且可以继续扩展下去，我们得到的就是所谓N-gram模型。

按直觉理解，这样的模型似乎不足以描述一种语言，因为: language has long-distance dependencies。但实际应用中，trigram和4-gram大部分时候已经足够好了。




## Introduction to N-grams

