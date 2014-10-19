#source('inference.R')

# url <- 'http://www.openintro.org/stat/data/atheism.RData'
# download.file(url, 'atheism.RData')

#load('atheism.RData')

us12 <- subset(atheism, atheism$nationality == 'United States'
                        & atheism$year == '2012')

head(us12)
summary(us12$response)
print(50 / 1002)

inference(us12$response, est = 'proportion', type = 'ci', method = 'theoretical',
          success = 'atheist')


# margin of error vs. prob
n <- 1000
p <- seq(0, 1, 0.01)
me <- 2 * sqrt(p * (1 - p) / n)
plot(me ~ p)


# Spain Change
sp05 <- subset(atheism, atheism$nationality == 'Spain'
                & atheism$year == '2005')
table(sp05$response) # 115, 1031, 1146

sp12 <- subset(atheism, atheism$nationality == 'Spain'
                & atheism$year == '2012')
table(sp12$response) # 103, 1042, 1145

n1 <- length(sp05$response)
p1 <- 115/n1

n2 <- length(sp12$response)
p2 <- 103/n2

se <- sqrt(p1 * (1-p1) / n1 + p2 * (1-p2) / n2)

p_delta <- p1-p2

ci <- p_delta + c(-1, 1) * 1.96 * se


# US Change
us05 <- subset(atheism, atheism$nationality == 'United States'
               & atheism$year == '2005')
table(us05$response) # 10, 992, 1002

us12 <- subset(atheism, atheism$nationality == 'United States'
               & atheism$year == '2012')
table(us12$response) # 50, 952, 1002

n1 <- length(us05$response)
p1 <- 10/n1

n2 <- length(us12$response)
p2 <- 50/n2

se <- sqrt(p1 * (1-p1) / n1 + p2 * (1-p2) / n2)

p_delta <- p1-p2

ci <- p_delta + c(-1, 1) * 1.96 * se