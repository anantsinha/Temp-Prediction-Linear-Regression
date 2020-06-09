setwd("~/Developer/Climate Change")
#load climate data
climate <- read.csv("climate_change.csv")
# view structure
str(climate)
# separate training & test data - upto 2006
training <- subset(climate, Year <= 2006)
testing <- subset(climate, Year > 2006)