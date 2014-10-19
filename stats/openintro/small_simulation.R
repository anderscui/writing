source('inference.R')

# paul the predictor:)
paul = factor(c(rep('yes', 8), rep('no', 0)), levels = c('yes', 'no'))

inference(paul, est = 'proportion', type = 'ht', method = 'simulation',
          success = 'yes', null = 0.5, alternative = 'greater')


# saying: to know something like the back of your hand.
back = factor(c(rep('correct', 11), rep('incorrect', 1)))

inference(back, est = 'proportion', type = 'ht', method = 'simulation',
          success = 'correct', null = 0.1, alternative = 'greater', nsim = 100)


