
leads <- read.csv("web_leads_may_2014.csv")
leads_test <- read.csv("web_leads_june_2014.csv")

#str(leads)
leads$MktPlace_id = paste(as.character(leads$MktPlace_id), 'MKT')
leads$MktPlace_id[leads$MktPlace_id == 'NULL'] = '0'
leads$MktPlace_id = as.factor(leads$MktPlace_id)
leads$Age = 2014 - leads$YearOfBirth
leads$C = 'No'
leads$C[leads$StatusCode == 'STD'] = 'Yes'
leads$C[leads$StatusCode == 'EXSTD'] = 'Yes'
leads = leads[c(-1, -2, -5, -7, -9)]
leads$C = as.factor(leads$C)


leads_test$MktPlace_id = paste(as.character(leads_test$MktPlace_id), 'MKT')
leads_test$MktPlace_id[leads_test$MktPlace_id == 'NULL'] = '0'
leads_test$MktPlace_id = as.factor(leads_test$MktPlace_id)
leads_test$Age = 2014 - leads_test$YearOfBirth
leads_test$C = 'No'
leads_test$C[leads_test$StatusCode == 'STD'] = 'Yes'
leads_test$C[leads_test$StatusCode == 'EXSTD'] = 'Yes'
leads_test = leads_test[c(-1, -2, -5, -7, -9)]
leads_test$C = as.factor(leads_test$C)

#visited <- leads$Visited == 'Yes'
#sum(visited)


# train
library(C50)

data_col <- ncol(leads)
leads_model <- C5.0(leads[c(-data_col)], leads$C)
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

leads_cost_model <- C5.0(leads[c(-data_col)], leads$C, costs = error_cost)
leads_cost_pred <- predict(leads_cost_model, leads_test)

# validate
CrossTable(leads_test$C, leads_cost_pred,
           prop.chisq = F, prop.c = F, prop.r = F,
           dnn = c('actual student', 'predicted student'))
