
leads <- read.csv("web_leads_may_2014.csv")
leads_test <- read.csv("web_leads_june_2014.csv")

#str(leads)

#leads = leads[1:10,]
leads$Age = 2014 - leads$YearOfBirth
leads$C = 'No'
leads$C[leads$StatusCode == 'STD'] = 'Yes'
leads$C[leads$StatusCode == 'EXSTD'] = 'Yes'
leads = leads[c(-5, -6, -10)]
leads = leads[c(-2)]
leads$C = as.factor(leads$C)

names(leads_test)[1] = 'CustomerId'
leads_test$Age = 2014 - leads_test$YearOfBirth
leads_test$C = 'No'
leads_test$C[leads_test$StatusCode == 'STD'] = 'Yes'
leads_test$C[leads_test$StatusCode == 'EXSTD'] = 'Yes'
leads_test = leads_test[c(-5, -6, -10)]
leads_test = leads_test[c(-2)]
leads_test$C = as.factor(leads_test$C)

visited <- leads$Visited == 'Yes'
sum(visited)


# train
library(C50)

leads_model <- C5.0(leads[c(-8)], leads$C)
summary(leads_model)

# predict
leads_pred <- predict(leads_model, leads_test)

# validate
library(gmodels)
CrossTable(leads_test$C, leads_pred,
           prop.chisq = F, prop.c = F, prop.r = F,
           dnn = c('actual student', 'predicted student'))



## Use cost matrix
error_cost <- matrix(c(0, 1, 4, 0), nrow = 2)

leads_cost_model <- C5.0(leads[c(-8)], leads$C, costs = error_cost)
leads_cost_pred <- predict(leads_cost_model, leads_test)

# validate
CrossTable(leads_test$C, leads_cost_pred,
           prop.chisq = F, prop.c = F, prop.r = F,
           dnn = c('actual student', 'predicted student'))


