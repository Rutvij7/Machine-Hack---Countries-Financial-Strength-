## Countries' Financial Strength Study 

Based on Country's trade with each other - Predict particular country's financial strength based on balance.  


Approach taken to Predict Country's Financial Strength Model :

- Removed missing data from the dataset
- Check the correlation 
- Exploratory Data Analysis
- Check on Outliers and Skewness 
- NOrmilization of Data 

- Applied Linear Regression Model [Model gives very low R-squared 0.02 - due to low correaltion]
- Applied Regression Tree Model - R-squared around 0.80 
- Applied model on test dataset and poredicted 'Balance' variable
- Also, applied model on train dataset - plot graph for actual Balance and predicted Balance variable. 

<dr>
  
### Learning 

- Data cleaning was important part - we used quartile technique to check outliers. 
- We checked correlation for predicted variables. Due to high multicolinearity we decided not to use Linear Regression technique, and hence, we used CART. 
- While checking, Root Mean Squared Log Error (RMSLE) to evaluate model score - we identified - applying log() function to negative values gives NAs. So, we first applied abs() - absolute - and converted -ve into +ve and after that checked Squared Log Error. 

### Acknowledge: 

Machine Hack - https://www.machinehack.com/ 
