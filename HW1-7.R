getwd()
setwd("C:/Users/ksy_pc/Desktop/»õ Æú´õ")

# Load the data and create subsamples
dat <- read.table("cps09mar.txt")
experience <- dat[,1]-dat[,4]-6
wmh <- (dat[,11]==1)&(dat[,2]==0)&(dat[,3]==1)
dat3 <- dat[wmh,]

# regression
y <- as.matrix(log(dat3[,5]/(dat3[,6]*dat3[,7])))
edu<-dat3[,4]
experience <- dat3[,1]-dat3[,4]-6
exp2 <- (experience^2)/100
x <- cbind(edu,experience,exp2,matrix(1,nrow(dat3),1))
xx <- t(x)%*%x
xy <- t(x)%*%y
beta <- solve(xx,xy)
print(beta)

# Create leverage and influence
e <- y-x%*%beta
xxi <- solve(xx)
leverage <- rowSums(x*(x%*%xxi))
r <- e/(1-leverage)
d <- leverage*e/(1-leverage)
print(max(abs(d)))

# standard error
n <- nrow(y)
k <- ncol(x)
a <- n/(n-k)
sig2 <- (t(e)%*%e)/(n-k)
u1 <- x*(e%*%matrix(1,1,k))
u2 <- x*((e/sqrt(1-leverage))%*%matrix(1,1,k))
u3 <- x*((e/(1-leverage))%*%matrix(1,1,k))
xx <- solve(t(x)%*%x)
v0 <- xx*sig2[1,1] ##############Question
v1 <- xx%*%(t(u1)%*%u1)%*%xxi
v1a <- a*xx%*%(t(u1)%*%u1)%*%xxi
v2 <- xx%*%(t(u2)%*%u2)%*%xxi
v3 <- xx%*%(t(u3)%*%u3)%*%xxi
s0 <- sqrt(diag(v0)) # Homoskedastic formula
s1 <- sqrt(diag(v1)) # HC0
s1a <- sqrt(diag(v1a)) # HC1
s2 <- sqrt(diag(v2)) # HC2
s3 <- sqrt(diag(v3)) # HC3
se <- cbind(s0, s1, s1a, s2, s3)
print(t(se))

# Functions of parameters
R1 <- c(100,0,0,0)
theta1 <- t(R1)%*%beta
V1 <- t(R1)%*%v1a%*%R1
R2 <- c(0,100,20,0)
theta2 <- t(R2)%*%beta
V2 <- t(R2)%*%v1a%*%R2
R0 <- c(100*(theta2[1,1]^(-1)),0,0,0)
theta0 <- t(R0)%*%beta
V0 <- t(R0)%*%v1a%*%R0
sqrtV0 <- sqrt(V0)
print(theta0)
print(sqrtV0)

# 90% asymptotic CI for theta0
CI0_ub <- theta0+(1.645*sqrtV0)
CI0_lb <- theta0-(1.645*sqrtV0)
CI0 <- cbind(CI0_lb, CI0_ub)
print(CI0)

# Forcasting at (edu=16,exp=5)
R1605 <- c(16,5,(5^2)*(100^(-1)),1)
y1605 <- t(R1605)%*%beta
V1605 <- t(R1605)%*%v1a%*%R1605
sqrtV1605 <- sqrt(V1605)
print(y1605)
print(sqrtV1605)

CI2_ub <- y1605+(1.96*sqrtV1605)
CI2_lb <- y1605-(1.96*sqrtV1605)
CI2 <- cbind(CI2_lb, CI2_ub)
print(CI2)



