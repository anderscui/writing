file <- "ames.RData"
#url <- "http://www.openintro.org/stat/data/ames.RData"
#download.file(url, file)

load(file)

population <- ames$Gr.Liv.Area
samp <- sample(population, 60)

summary(samp)

samp_mean <- mean(samp)
se <- sd(samp) / sqrt(60)
me <- 1.96 * se
lower <- samp_mean - me
upper <- samp_mean + me
c(lower, upper)

# true parameter
mean(population)


# simulating sampling
samp_mean <- rep(NA, 100)
samp_sd <- rep(NA, 100)
n <- 60

for (i in 1:100) {
  samp <- sample(population, n)
  samp_mean[i] <- mean(samp)
  samp_sd[i] <- sd(samp)
}

lower <- samp_mean - 1.96 * samp_sd / sqrt(n)
upper <- samp_mean + 1.96 * samp_sd / sqrt(n)

c(lower[1], upper[1])

plot_ci(lower, upper, mean(population))