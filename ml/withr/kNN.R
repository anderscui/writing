## kNN classification
# data_url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data"
# local_file <- "wdbc.data"
# download.file(data_url, local_file)
# 
# data <- read.table(local_file, sep = ",")
# str(data)

# use the changed data file instead
wbcd <- read.csv("withr/wisc_bc_data.csv", stringsAsFactors = F)
#str(wbcd)

# exclude the id var
wbcd <- wbcd[-1]

# take a glance at diagnosis var
table(wbcd$diagnosis)

# change the var to factors
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B", "M"),
                         labels = c("Benign", "Malignant"))

round(prop.table(table(wbcd$diagnosis)) * 100, digits = 1)

# the remaining 30 vars are all numeric, and consist of 3 diff 
# measurements of 10 characteristics.

summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])

# rescale measurements
normalize <- function(x) {
    return ((x - min(x)) / (max(x) - min(x)))
}

#normalize(c(1, 2, 3, 4, 5))
wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

# or z-score
wbcd_z <- as.data.frame(scale(wbcd[-1]))
#summary(wbcd_z$area_mean)

## training and test datasets
# wbcd_train <- wbcd_n[1:469,]
# wbcd_test <- wbcd_n[470:569,]

# or z-score
wbcd_train <- wbcd_z[1:469,]
wbcd_test <- wbcd_z[470:569,]

# normally, random sampling methods would be needed.
wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]

## training a model on the data - class package
#install.packages("class")

#library(class)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                 cl = wbcd_train_labels, k = 11)

## evaluating model performance
#library(gmodels)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq = F)

# 1: 2,4; 5: 0,4; 11: 1,1; 15: 2,0; 2,0; 2,0