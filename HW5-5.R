#5(a)

getwd()
setwd("C:/Users/ksy_pc/Desktop")
getwd()

install.packages("readxl")
library(readxl)


FRED_QD<-as.data.frame(read_excel("FRED-QD.xlsx"))
attach(FRED_QD)
pnfix<-ts(pnfix,start=1959,frequency=4)


pnfix.g<-diff(log((pnfix))

pnfix
pnfix.g


#5(b)

install.packages("lmtest")
library(lmtest)
install.packages("sandwich")
library(sandwich)

pnfix.ols<-ar.ols(pnfix.g, order.max=4, demean=F, intercept =T)

armod4<-lm(pnfix.g~lag(pnfix.g)+lag(pnfix.g,2)+lag(pnfix.g,3)+lag(pnfix.g,4))

coeftest(armod4,vcov=vcovHAC)


#5(c)

coeftest(armod4,vcov=NeweyWest(armod4,lag=5))


#5(d)

pnfix.ar<-arima(pnfix.g,order=c(4,0,0),include.mean=TRUE)
names(pnfix.ar)
matrix<-c(0,0,0,0)
matrix<-coef(pnfix.ar)
matrix
matrix$ar1
response(t=1) = B

for t=4:10
response(t) = response(t-1) + response(t-2)
end
