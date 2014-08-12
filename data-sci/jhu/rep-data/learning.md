---
title: "Learning R Markdown"
author: "andersc"
date: "Tuesday, August 12, 2014"
output: html_document
---

## What is Markdown?

Complete info: <http://daringfireball.net/projects/markdown>

Background info: <http://daringfireball.net/2004/03/dive_into_markdown>

## What is R Markdown?

* R markdown is the integration of R with Markdown
* Allows one to create documents containing "live" R code
* A core tool in literate statistical programming

* RM can be converted to standard markdown using the knitr package
* RM -> markdown -> HTML work flow can be managed by RStudio
* RM can be converted to slides using [slidify](http://slidify.org/) package.


```r
v <- vector()
v <- append(v, c(3, 2, 1))
print(v)
```

```
## [1] 3 2 1
```


```r
summary(cars)
```

```
##      speed           dist    
##  Min.   : 4.0   Min.   :  2  
##  1st Qu.:12.0   1st Qu.: 26  
##  Median :15.0   Median : 36  
##  Mean   :15.4   Mean   : 43  
##  3rd Qu.:19.0   3rd Qu.: 56  
##  Max.   :25.0   Max.   :120
```

You can also embed plots, for example:

<img src="./using_knitr_files/figure-html/unnamed-chunk-5.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" width="672" />

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
