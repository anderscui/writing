data_url <- "http://www.openintro.org/stat/data/mlb11.RData"
file <- "mlb11.RData"

#download.file(data_url, file)

load(file)

plot(mlb11$runs, mlb11$at_bats)
plot(mlb11$at_bats, mlb11$runs)

# correlation coefficient
cor(mlb11$runs, mlb11$at_bats)

# visualize residuals
plot_ss(x = mlb11$at_bats, y = mlb11$runs)
plot_ss(x = mlb11$at_bats, y = mlb11$runs, showSquares = T)


# linear model
ml <- lm(runs ~ at_bats, data = mlb11)
summary(ml)

#(Intercept)      at_bats  
#-2789.2429       0.6305

# homeruns
ml2 <- lm(runs ~ homeruns, data = mlb11)
summary(ml2)


# draw the fit line
plot(mlb11$runs ~ mlb11$at_bats)
abline(ml)

-2789 + 0.6305 * 5579


## Model diagnostics
# 1. linearity
plot(ml$residuals ~ mlb11$at_bats)
abline(h = 0, lty = 3)

# 2. nearly normal residuals
hist(ml$residuals)

# or 
qqnorm(ml$residuals)
qqline(ml$residuals)

# 3. constant variability


# correlation
cor(mlb11$runs, mlb11$at_bats)
cor(mlb11$runs, mlb11$hits)
cor(mlb11$runs, mlb11$wins)
cor(mlb11$runs, mlb11$bat_avg)


cor(mlb11$runs, mlb11$new_obs)
cor(mlb11$runs, mlb11$new_slug)
cor(mlb11$runs, mlb11$new_onbase)



# predict
