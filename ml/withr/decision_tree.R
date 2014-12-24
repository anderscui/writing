credit <- read.csv("withr/credit.csv")
str(credit)

# possible features
table(credit$checking_balance)
table(credit$savings_balance)

summary(credit$months_loan_duration)
summary(credit$amount)

# classes
table(credit$default)

# create a better Y
credit$Y = 'no'
credit$Y[credit$default == 2] = 'yes'
credit$Y = as.factor(credit$Y)
table(credit$Y)

# prepare train and test data sets
set.seed(12345)
credit_rand <- credit[order(runif(1000)), ]
credit_train <- credit_rand[1:900, ]
credit_test <- credit_rand[901:1000, ]

prop.table(table(credit_train$default))
prop.table(table(credit_test$default))

# use C50 lib
#install.packages("C50")

library(C50)

credit_model <- C5.0(credit_train[c(-21, -22)], credit_train$Y)

summary(credit_model)


# predict
credit_pred <- predict(credit_model, credit_test)

# validate
#install.packages("gmodels")

library(gmodels)
CrossTable(credit_test$Y, credit_pred,
           prop.chisq = F, prop.c = F, prop.r = F,
           dnn = c('actual default', 'predicted default'))


## Use boosting trials
credit_boost10 <- C5.0(credit_train[c(-21, -22)], credit_train$Y,
                       trials = 10)
credit_boost10
summary(credit_boost10)


# predict
credit_boost_pred10 <- predict(credit_boost10, credit_test)

# validate
CrossTable(credit_test$Y, credit_boost_pred10,
           prop.chisq = F, prop.c = F, prop.r = F,
           dnn = c('actual default', 'predicted default'))


## Use cost matrix
error_cost <- matrix(c(0, 1, 4, 0), nrow = 2)

credit_cost <- C5.0(credit_train[c(-21, -22)], credit_train$Y,
                       costs = error_cost)
# credit_boost10
# summary(credit_boost10)

credit_cost_pred <- predict(credit_cost, credit_test)

# validate
CrossTable(credit_test$Y, credit_cost_pred,
           prop.chisq = F, prop.c = F, prop.r = F,
           dnn = c('actual default', 'predicted default'))


## Use both boosting and cost matrix, (NOT REALLY GOOD)
credit_both <- C5.0(credit_train[c(-21, -22)], credit_train$Y,
                    trials = 10, costs = error_cost)
# credit_boost10
# summary(credit_boost10)

credit_both_pred <- predict(credit_both, credit_test)

# validate
CrossTable(credit_test$Y, credit_both_pred,
           prop.chisq = F, prop.c = F, prop.r = F,
           dnn = c('actual default', 'predicted default'))