states <- read.csv('states.csv')

# fit model
pov_slr <- lm(poverty ~ female_house, data = states)
anova(pov_slr)

# R square is 0.28

# fit by female householder and white
pov_mlr <- lm(poverty ~ female_house + white, data = states)
summary(pov_mlr)

anova(pov_mlr)

