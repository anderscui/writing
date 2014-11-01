
cognitive <- read.csv('cognitive.csv')

# full model
cog_full <- lm(kid_score ~ mom_hs + mom_iq + mom_work + mom_age, 
               data = cognitive)

