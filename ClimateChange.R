setwd("~/Developer/Climate Change")
#load climate data
climate <- read.csv("climate_change.csv")
# view structure
str(climate)
# separate training & test data - upto 2006
training <- subset(climate, Year <= 2006)
testing <- subset(climate, Year > 2006)

# Linear Regression to Model to predict temperature with all reasonable independent variables
TempReg <- lm(Temp ~ MEI + CO2 + CH4 + N2O + CFC.11 + CFC.12 + TSI + Aerosols, data = training)
summary(TempReg)
# Acc to this model CH4, N2O are insiginifant
# Regression coefficients of both the N2O and CFC-11 are -ve - Multicollinearity suspected

# Checking correlations among all variables
cor(training)
# Clear that:
#             N2O highly correlated with: CO2, CH4, CFC.12
#             CFC.11 highly correlated with: CH4, CFC.12