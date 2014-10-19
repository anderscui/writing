load('gss_u4.RData')

summary(gss)

boxplot(gss$wordsum ~ gss$class)

#source('inference.R')

inference(y = gss$wordsum, x = gss$class, est = 'mean', type = 'ht',
          alternative = 'greater', method = 'theoretical')


inference(y = gss$wordsum, x = gss$class, est = "mean", type = "ht",
          alternative = "greater", method = "theoretical")
