# Exercise 2: working with data frames

# Create a vector of 100 employees ("Employee 1", "Employee 2", ... "Employee 100")
# Hint: use the `paste()` function and vector recycling to add a number to the word
# "Employee"

employees <- paste("Employee", 1:100)


# Create a vector of 100 random salaries for the year 2017
# Use the `runif()` function to pick random numbers between 40000 and 50000

salaries <- runif(100, min = 40000, max = 50000)

# Create a vector of 100 annual salary adjustments between -5000 and 10000.
# (A negative number represents a salary decrease due to corporate greed)
# Again use the `runif()` function to pick 100 random numbers in that range.

annual_salary_adjustments <- runif(100, min = -5000, max = 10000)

# Create a data frame `salaries` by combining the 3 vectors you just made
# Remember to set `stringsAsFactors=FALSE`!

salaries_df <- data.frame(employees, salaries, annual_salary_adjustments, 
                          stringsAsFactors=FALSE)

# Add a column to the `salaries` data frame that represents each person's
# salary in 2018 (e.g., with the salary adjustment added in).

salary_in_2018 <- c(salaries + annual_salary_adjustments)

salaries_df_2018 <- data.frame(salaries_df, salary_in_2018, stringsAsFactors = FALSE)

# Add a column to the `salaries` data frame that has a value of `TRUE` if the 
# person got a raise (their salary went up)

pay_raise <- c(annual_salary_adjustments > 0)


salaries_df_2018_increase <- data.frame(salaries_df_2018, pay_raise, stringsAsFactors = FALSE)

### Retrieve values from your data frame to answer the following questions
### Note that you should get the value as specific as possible (e.g., a single
### cell rather than the whole row!)

# What was the 2018 salary of Employee 57

salary_57 <- salaries_df_2018[salaries_df_2018$employees == "Employee 57",]$salaries

# How many employees got a raise?

nrow(salaries_df_2018_increase[salaries_df_2018_increase$pay_raise == TRUE,])

# What was the dollar value of the highest raise?

highest_raise <- max(salaries_df_2018_increase$annual_salary_adjustments)

# What was the "name" of the employee who received the highest raise?

employee_high_raise <- salaries_df_2018_increase[salaries_df_2018_increase$annual_salary_adjustments == highest_raise, "employees"]

# What was the largest decrease in salaries between the two years?

largest_pay_cut <- min(salaries_df_2018_increase$annual_salary_adjustments)

# What was the name of the employee who recieved largest decrease in salary?

employee_pay_cut <- salaries_df_2018_increase[salaries_df_2018_increase$annual_salary_adjustments == largest_pay_cut,"employees"]

# What was the average salary change?

avg_change <- mean(salaries_df_2018_increase$annual_salary_adjustments)

# For people who did not get a raise, how much money did they lose on average?

avg_loss <- mean(salaries_df_2018_increase$annual_salary_adjustments[salaries_df_2018_increase$pay_raise == FALSE])

## Consider: do the above averages match what you expected them to be based on 
## how you generated the salaries?

#I mean it was random there would be variation in this manner anyways

# Write a .csv file of your salary data to your working directory

write.csv(salaries_df_2018_increase, "salaries_2018.csv")