install.packages("fBasics")
library(fBasics)
library(forecast) 

# Set the folder (path) that contains this R file as the working directory
dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(dir)

# *** SESSION 8. Real Example ***
datos<-read.csv("coca_cola_earnings.csv",header=TRUE,sep=";",dec=",")
y<-datos[,2]
ts.plot(y)

# par(mar=c(5,5,5,5))

nlags=28   # play with this parameter..
par(mfrow=c(2,1))
acf(y,nlags)
pacf(y,nlags)  

s=4      # seasonal parameter FOR THIS DATA SET

ndiffs(y, alpha=0.05, test=c("adf")) # regular differences?

nsdiffs(y,m=s,test=c("ocsb"))  # seasonal differences?


# estimate the SAR and analyze the estimated parameters. Compare with the Seasonal Difference
#fit<-arima(y,order=c(2,1,0),seasonal=list(order=c(0,1,1),period=s)) 
#fit<-arima(y,order=c(0,,0),seasonal=list(order=c(0,0,0),period=s)) 
#fit<-arima(y,order=c(0,1,1),seasonal=list(order=c(0,1,1),period=s))
# fit<-arima(y,order=c(0,1,0),seasonal=list(order=c(1,1,0),period=s))
#fit<-arima(y,order=c(1,1,1),seasonal=list(order=c(1,1,0),period=s))
#fit<-arima(log(y),order=c(0,1,1),seasonal=list(order=c(0,1,1),period=s))
fit<-arima(log(y),order=c(0,1,1),seasonal=list(order=c(0,1,1),period=s))
#fit<-arima(log(y),order=c(2,1,0),seasonal=list(order=c(2,1,0),period=s))

fit
ts.plot(fit$residuals)
par(mfrow=c(2,1))
acf(fit$residuals,nlags)
pacf(fit$residuals,nlags)  



ndiffs(fit$residuals, alpha=0.05, test=c("adf")) # regular differences?
nsdiffs(fit$residuals,m=s,test=c("ocsb"))

Box.test(fit$residuals,lag=36) # white noise residuals?

Box.test(fit$residuals,lag=28)    # play with the number of lags

shapiro.test(fit$residuals)  # normality test


ts.plot(fit$residuals)
par(mfrow=c(2,1))
acf(fit$residuals^2,nlags)
pacf(fit$residuals^2,nlags)    

ndiffs(fit$residuals^2, alpha=0.05, test=c("adf")) # regular differences?
nsdiffs(fit$residuals^2,m=s,test=c("ocsb"))

Box.test(fit$residuals^2,lag=36) # white noise residuals?

Box.test(fit$residuals^2,lag=28)    # play with the number of lags

shapiro.test(fit$residuals^2)  # normality test

# normality test graphically
hist(fit$residuals,prob=T,ylim=c(0,2),xlim=c(mean(fit$residuals)-3*sd(fit$residuals),mean(fit$residuals)+3*sd(fit$residuals)),col="red")
lines(density(fit$residuals),lwd=2)
mu<-mean(fit$residuals)
sigma<-sd(fit$residuals)
x<-seq(mu-3*sigma,mu+3*sigma,length=100)
yy<-dnorm(x,mu,sigma)
lines(x,yy,lwd=2,col="blue")

# point predictions and standard errors

y.pred<-predict(fit,n.ahead=24)
y.pred$pred  # point predictions
#y.pred$pred  # point predictions
y.pred$se   # standard errors


  
exp(y.pred$pred)+-1.806302 *exp(y.pred$se) 
exp(y.pred$pred)+1.834527 *exp(y.pred$se) 

exp(y.pred$pred)   # point predictions

#lambda <- BoxCox.lambda(y)
#print(lambda)
#plot.ts(BoxCox(y, lambda = lambda))

newy <- exp(y.pred$pred) 

# 95% confidence interval (1.96)

std_residuals=(fit$residuals-mean(fit$residuals))/sd(fit$residuals)

quantile(std_residuals, probs=c(0.025,0.975)) 

# 80% confidence interval (1.28)

quantile(std_residuals, probs=c(0.1,0.9)) 

# 60% confidence interval (0.84)

quantile(std_residuals, probs=c(0.2,0.8)) 


quantile(fit$residuals)
quantile(fit$residuals, probs =c(0.025,0.975,0.5))
quantile(exp(y.pred$pred),probs =c(0.025,0.975,0.5))
naive(fit, bootstrap=TRUE)

predict(fit,type=c("percentile"),interval=c("confidence"),level=0.95)
# plotting real data with point predictions

#new <- c(y,y.pred$pred) # real data + predicted values
 new <- c(y,exp(y.pred$pred)) # real data + predicted values
plot.ts(new,main="Predictions",
        ylab="Dollars",col=3,lwd=2) # time series plot
lines(y,col=4,lwd=2) # for the second series
legend("topleft",legend=c("Predictions","Historical"),col=c(3,4),
       bty="n",lwd=2)



fc <- forecast(newy, h=30, level=95)
fc
qf <- matrix(0, nrow=99, ncol=20)
m <- fc$mean
s <- (fc$upper-fc$lower)/1.96/2
for(h in 1:20)
  qf[,h] <- qnorm((1:99)/100, m[h], s[h])

plot(fc)
matlines(101:120, t(qf), col=rainbow(120), lty=1)

#new %>% forecast(h=24) %>% autoplot(include=80)
#(new <- Arima(y, order=c(0,1,1), seasonal=c(0,1,1),lambda=lambda))

#fit %>% forecast(h=36) %>% autoplot()