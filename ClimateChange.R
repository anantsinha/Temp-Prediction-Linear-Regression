setwd("~/Developer/Week2 - Linear Regression/Climate Change")
# Linear Regression to predict Temperature using cocentration of pollutants
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

# lm Model with MEI, TSI, Aerosols and N2O only
TempReg2 <- lm(Temp ~ N2O + MEI + TSI + Aerosols, data = training)
summary(TempReg2)
# Adjusted R Squared of this model - 0.7261, Adjusted R squared of prev model 0.7436
# It makes more sense to use the second model, since difference in R squared is very small

# produce model by AIC
# Only CH4 was not included
# Adjusted R squared 
AicTempModel <- step(TempReg)
predictedTemp <- predict(AicTempModel, newdata = testing)
SSE <- sum((testing$Temp - predictedTemp)^2)
SST <- sum ((mean(training$Temp) - testing$Temp)^2)
R2 <- 1-SSE/SST
# test R squared achieved  0.6286051