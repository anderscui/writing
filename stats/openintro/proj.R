#url <- 'http://d396qusza40orc.cloudfront.net/statistics/project/dasi_project_template.Rmd'
#file <- 'dasi_project_template.Rmd'

#download.file(url = url, destfile = file)

load(url('http://d396qusza40orc.cloudfront.net/statistics/project/gss.Rdata'))

datatable <- xtabs(~ degree + satfin, data = gss)
pt <- prop.table(datatable, 1)