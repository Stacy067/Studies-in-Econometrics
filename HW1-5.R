# Metrics 710 Problem Set 4
# Dennis McWeeny

getwd()
setwd("C:/Users/ksy_pc/Desktop")
library(foreign)
data <- read.table("cps09mar.txt")

# Restrict sample to white male hispanics
restriction <- (data[,11]==1)&(data[,2]==0)&(data[,3]==1)
sample <- data[restriction,]

# Generate variable of interest
experience <- sample[,1] - sample[,4] - 6
education <- sample[,4]
earnings <- sample[,5]
hours <- sample[,6]
week <- sample[,7]
wage <- earnings/(hours*week)
logwage <- log(wage)
experience_squared <- (experience^2)/100
constant <- rep(1, length(logwage))

# Generate binary variables

# Regions
northeast <- (sample[,10]==1)
south <- (sample[,10]==3)
west <- (sample[,10]==4)

# Marital Status
married <- (sample[,12]<=3)
widowed <- (sample[,12]==4)
divorced <- (sample[,12]==5)
separated <- (sample[,12]==6)


X <- cbind(education, experience, experience_squared, northeast, south, west, married, 
           widowed, divorced, separated, constant)
beta_hat <- solve(crossprod(X)) %*% crossprod(X,logwage)
beta_hat