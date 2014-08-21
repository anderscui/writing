v <- c(3, 9, 5, 2, 6)

mean(v)
# var
vars <- v - mean(v)
sum(vars * vars) / length(v)
sum(vars * vars) / (length(v) - 1)
sd(v)
sd(v) * sd(v)

# sd == sum(vars * vars) / (length(v) - 1)