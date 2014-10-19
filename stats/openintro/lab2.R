url <- "http://www.openintro.org/stat/data/kobe.RData"
file <- "kobe.RData"

download.file(url, file)
load(file)

head(kobe)

# Q3
kobe_streak <- calc_streak(kobe$basket)
barplot(table(kobe_streak))
summary(kobe_streak)

# Q7
outcomes <- c("H", "M")
sim_basket <- sample(outcomes, size = nrow(kobe), replace = T, prob = c(0.45, 0.55))

sim_streak <- calc_streak(sim_basket)
barplot(table(sim_streak))
#summary(kobe_streak)