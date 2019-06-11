
## MACHINE HACK : World Countries : Predict Finncial Strength of Contries 

train = read.csv('final_train_data.csv')
train = train[, -1]

## Dataset Variables

summary(train)
str(train)

dim(train)

##  ~ ~ ~ DATA CLEANING ~ ~ ~  ## 

## Missing Values

colSums(is.na(train))

## Due to weak Coorelation between continuous variables, we decided to ommit -NA-

train = na.omit(train)

library(ggcorrplot)

ggcorrplot(cor(train[,-c(1,2,3)]), type = 'upper', method = 'circle')

cor(train[, -c(1,2,3)])

attach(train)

dim(train)  ## New Dataset contains 4217 observations : 289 observations removed as - NAs

## Pivot Table

library(rpivotTable)  ## Not Much insights from Pivot Table - due to continuous variables 

rpivotTable(train)

## DAta Visulisation

library(DataExplorer)

plot_str(train)

plot_missing(train)

plot_histogram(train)

plot_density(train)

plot_correlation(train, type = 'continuous')


## Checking Outliers & Skewness

library(ggplot2)

par(mfrow =c(2,3))


hist(Year, main = 'Year',  col = 'darkseagreen')
hist(Balance, col = 'darkseagreen', main = 'Balance')
hist(Inflation, col = 'darkseagreen',  main = 'Inflation')
hist(GDP, col = 'darkseagreen',  main = 'GDP')
hist(Exports, col = 'darkseagreen',  main = 'Exports')
hist(Trade, col = 'darkseagreen', main = 'Trade')

## Inflationn

# quantile(train$Inflation, 0.95) ## Remove observation Inflation > 42%
# quantile(Inflation, 0.99999)


## Balance 

# quantile(Balance, 0.1)
# quantile(Balance, 0.015) ## Remove Obser. less than 1.5% quant.

# quantile(Balance, 0.99) ## Remove Obser. more than 99% quant.

## Trade

# quantile(Trade, 0.99) ## Remove Obser. more than 99% quant. 
# quantile(Trade, 0.999) 

## Export

# quantile(Exports, 0.98) ## Remove Obser. more than 99% quant.


# train = train[which(Balance > -48856314353 & Balance < 80614820110 & Inflation < 42 & 
#                      GDP >= -10.2 & GDP <= 16.23 & Trade <= 239.4683), ]

# train = train[which(Exports <= 2.4354e+11), ]

    
## NORMALIZATION OF DATA                  

library(moments)
library(forecast)

BoxCox.lambda(GDP)

BoxCox.lambda(train$Trade)
train$Trade = log(train$Trade)

BoxCox.lambda(Exports)
Exports = log(Exports)

BoxCox.lambda(train$Inflation)  
train$Inflation = sqrt(train$Inflation)
train$Inflation = log(train$Inflation)

attach(train)

## REMOVE NA'a Produced in Inflation variable

train = na.omit(train)



##  ~ ~ ~ LINEAR REGRESSION MODEL ~ ~ ~  ##

# plot(Year, Balance, col = 'maroon', abline(lm(Balance~Year)))
# plot(Inflation, Balance, col = 'maroon', abline(lm(Balance~Inflation)))
# plot(GDP, Balance, col = 'maroon', abline(lm(Balance~GDP)))
# plot(Exports, Balance, col = 'maroon', abline(lm(Balance~Exports)))
# plot(Trade, Balance, col = 'maroon', abline(lm(Balance~Trade)))

## Correlation Improved 

# attach(train)

# ggcorrplot(cor(train[,-c(1,2)]), type = 'upper', method = 'circle') 

# model = lm(Balance ~ Trade + Inflation)

# summary(model)


## ~ ~ REGRESSION TREE ~ ~ ##

library(rpart)
library(rpart.plot)
library(rattle)
library(RColorBrewer)

r.ctrl = rpart.control(minsplit = 25, minbucket = 5, cp = , xval =10)

model2 = rpart(formula = Balance ~. , data = train, method = 'anova', control = r.ctrl)

# fancyRpartPlot(model2)
printcp(model2)

model.prun = prune(model2, cp = 0.01, 'CP')

summary(model.prun)

par(mfrow = c(1,2))
rsq.rpart(model.prun)


test = read.csv('final_test_data.csv')


## Plot Graph on Train Dataset 

train$test_balance = predict(model.prun, train, method = 'anova', interval = 'confidence' )

actual_balance = train[, 4]
predicted_balance = train[,9]

backtrack = data.frame(actual_balance, predicted_balance)

par(mfrow = c(1,1))

plot(actual_balance, col = 'blue')
plot(predicted_balance, col = 'red')

lines(actual_balance, col ='blue')
lines(predicted_balance, col = 'red')












