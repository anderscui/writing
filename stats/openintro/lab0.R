#source("http://www.openintro.org/stat/data/present.R")

# Q1
ncol(present)

present$year

# Q2
present$girls


# Q3
plot(x = present$year, y = present$girls, type = "l")

plot(present$year, present$boys + present$girls, type = "l")


# Q4
sum <- present$boys + present$girls
present[which.max(sum),]


# Q5
boy_prop <- present$boys / (present$boys + present$girls)
plot(present$year, boy_prop, type = "l")

# Q6
more_boys <- present$boys > present$girls
sum(more_boys)

# Q7
ratio <- present$boys / present$girls
plot(present$year, ratio, type = "l")

# Q8
diff <- present$boys - present$girls
present[which.max(diff),]
