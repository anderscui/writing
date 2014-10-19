file <- 'nc.RData'
load(file)

summary(nc)

head(nc)

hist(nc$gained)

## clean_up data
gained_clean = na.omit(nc$gained)
n = length(gained_clean)

## bootstrap
boot_means = rep(NA, 100)
for (i in 1:100) {
  boot_sample = sample(gained_clean, n, replace = T)
  boot_means[i] = mean(boot_sample)
}

hist(boot_means)

## CI
# quantile method
quantile(boot_means, c(0.025, 0.975))

# normal dist
m = mean(boot_means)
se = sd(boot_means)

ci = m + c(-1, 1) * qnorm(0.975) * se


# inference function
#source('inference.R')

inference(nc$gained, type = "ci", method = "simulation", conflevel = 0.95,
          est = "mean", boot_method = "perc")

inference(nc$gained, type = "ci", method = "simulation", conflevel = 0.95,
          est = "median", boot_method = "se")


# relationships
boxplot(nc$weight ~ nc$habit)

# observed diff
by(nc$weight, nc$habit, mean)

# HT and CI
inference(y = nc$weight, x = nc$habit, est= "mean", type = "ht",
          null = 0, alternative = "twosided", method = "theoretical",
          order = c("smoker", "nonsmoker"))


inference(y = nc$weight, x = nc$habit, est= "mean", type = "ci",
          null = 0, alternative = "twosided", method = "theoretical",
          order = c("smoker", "nonsmoker"))

## cufoff
min(nc[which(nc$mature == 'mature mom'),]$mage)
max(nc[which(nc$mature == 'younger mom'),]$mage)
