# read the data set
data <- read.csv("./StormData.csv", stringsAsFactors = FALSE)

# get the data we are interested in
vars <- c("BGN_DATE", "EVTYPE", "FATALITIES", "INJURIES", "PROPDMG",
          "PROPDMGEXP", "CROPDMG", "CROPDMGEXP")
tidy <- data[vars]

tidy$date <- as.Date(tidy$BGN_DATE, "%m/%d/%Y %H:%M:%S")
tidy$population_health <- tidy$FATALITIES + tidy$INJURIES

#sum(is.na(tidy$PROPDMG))
#sum(is.na(tidy$CROPDMG))

unique(tidy$PROPDMGEXP)
unique(tidy$CROPDMGEXP)

# convert damage exponents to a uniform numberical representation
# properties damage
tidy$PROPDMGEXP[(tidy$PROPDMGEXP == "") |
                    (tidy$PROPDMGEXP == "+") |
                    (tidy$PROPDMGEXP == "-") | 
                    (tidy$PROPDMGEXP == "?")] <- 0

tidy$PROPDMGEXP[(tidy$PROPDMGEXP == "h") | 
                    (tidy$PROPDMGEXP == "H")] <- 2

tidy$PROPDMGEXP[(tidy$PROPDMGEXP == "k") | 
                    (tidy$PROPDMGEXP == "K")] <- 3

tidy$PROPDMGEXP[(tidy$PROPDMGEXP == "m") | 
                    (tidy$PROPDMGEXP == "M")] <- 6

tidy$PROPDMGEXP[(tidy$PROPDMGEXP == "B")] <- 9

# crop damages
tidy$CROPDMGEXP[(tidy$CROPDMGEXP == "") |
                    (tidy$CROPDMGEXP == "?")] <- 0

tidy$CROPDMGEXP[(tidy$CROPDMGEXP == "k") | 
                    (tidy$CROPDMGEXP == "K")] <- 3

tidy$CROPDMGEXP[(tidy$CROPDMGEXP == "m") | 
                    (tidy$CROPDMGEXP == "M")] <- 6

tidy$CROPDMGEXP[(tidy$CROPDMGEXP == "B")] <- 9

# convert to numbers
tidy$PROPDMGEXP <- as.integer(tidy$PROPDMGEXP)
tidy$CROPDMGEXP <- as.integer(tidy$CROPDMGEXP)

tidy$eco_dmg <- tidy$PROPDMG * 10^tidy$PROPDMGEXP + 
    tidy$CROPDMG * 10^tidy$CROPDMGEXP

health <- sort(tapply(tidy$population_health, tidy$EVTYPE, sum), decreasing = T)
eco_dmg <- sort(tapply(tidy$eco_dmg, tidy$EVTYPE, sum), decreasing = T)

#head(health, n = 5)
#head(eco_dmg, n = 5)

library(ggplot2)

# population health
health_top5 <- health[1:5]

types <- as.vector(names(head(health_top5)))
values <- as.vector(health_top5)
df <- data.frame(types, values)
ggplot(data = df, aes(x = df$types, y = df$values)) + 
    geom_bar(stat = "identity") + 
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
    xlab("Event Type") + ylab("# of Harms to Population Health") + 
    ggtitle("Top 5 Most Harmful Event Types, 1950-2011")


# economic consequences
eco_top5 <- eco_dmg[1:5]

types <- as.vector(names(head(eco_top5)))
values <- as.vector(eco_top5)
df <- data.frame(types, values)
ggplot(data = df, aes(x = df$types, y = df$values)) + 
    geom_bar(stat = "identity") + 
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
    xlab("Event Type") + ylab("Economic Damages ($)") + 
    ggtitle("Top 5 Highest Economic Damages, 1950-2011")