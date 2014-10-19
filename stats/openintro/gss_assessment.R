#url <- "http://d396qusza40orc.cloudfront.net/statistics/project/gss.Rdata"
url <- "gss.Rdata"
load(url)

names(gss)

hist(gss$year)

summary(gss$satfin)

summary(gss$natpark)

summary(gss$educ)

summary(gss$degree)

#gss1972 <- 


levels(gss$degree)

levels(gss$satfin)


plot(gss$degree, gss$satfin,
     xlab = "Highest degree",
     ylab = "Satisfaction with financial situation")


mytable <- xtabs(~ degree+satfin, data=gss)
pt <- prop.table(mytable, 1)

# part of data
head(gss[c("caseid", "degree", "satfin")], 25)
