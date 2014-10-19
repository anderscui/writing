# url <- "http://www.openintro.org/stat/data/cdc.R"
# file <- "cdc.R"
# download.file(url, file)

source("cdc.R")

names(cdc)

# Q1
dim(cdc)

# Q2
str(cdc$genhlth)

# Q3
str(cdc$weight)

# Q4
str(cdc$smoke100)

#
table(cdc$smoke100)

table(cdc$smoke100) / nrow(cdc)

# bar plot
barplot(table(cdc$smoke100))


# Q5
table(cdc$gender)

# Q6
table(cdc$genhlth)
table(cdc$genhlth) / nrow(cdc)

# Q7
gender_smokers <- table(cdc$gender, cdc$smoke100)

mosaicplot(gender_smokers)

# Q8
under23_smoke = subset(cdc, cdc$age < 23
                            & cdc$smoke100 == 1)

#
boxplot(cdc$height)
summary(cdc$height)

#
boxplot(cdc$height ~ cdc$gender)

# Q9
bmi <- (cdc$weight / cdc$height^2) * 703
boxplot(bmi ~ cdc$genhlth)

# hist
hist(bmi)
hist(bmi, breaks = 50)


# Q10
plot(cdc$weight, cdc$wtdesire, type = "l")

