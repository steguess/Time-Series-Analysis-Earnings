![Coca Cola Banner](dashboard.png)


# Quarterly Earnings per Share Analysis

Quarterly earnings per share of Coca Cola Company from the first quarter of 1983 to the third quarter of 2009.

## <span style="color:darkred">📈 Box - Jenkins Methodology</span>

**Coca Cola Earnings from 1983 - 2009**

![image](https://github.com/steguess/Time-Series-Analysis-Earnings/assets/86976901/0daf6e69-182b-4ce5-b48c-341cd081e1a3)





Since 1983, the quarterly earnings per share grew strongly over time. It started from 0.0375 earnings per share and reached its highest peak at 1.01 earnings per share in July 2008. The variance/volatility was smaller from 1983 to 1990 compared to 1990 to 1997, and it increased even further in volatility/variance from 2000 to 2009. Additionally, you can also see a break in the trend, and earnings per share declined from the year 1999 to 2000.

## 📊 Analysis on the Original Data

<img width="568" alt="image" src="https://github.com/steguess/Time-Series-Analysis-Earnings/assets/86976901/b1975c3b-965e-4e56-a076-858a09f1805b">





The time series plot shows that the level is not constant over time.
- The series (Yt) is not stationary in the mean.
- Data is also not stationary in the variance; the variance is increasing over time, considering taking log(Yt).
- ADF test = 1.05 (p-value > 0.05, we fail to reject the null that the data is not stationary in the mean → we have to take at least one unit root.
- In ACF plot, decaying close to zero, and all lags until lags 25 are out of bound, → take the difference.
- PACF plot lag 1 is out of bound → clear need to take difference.
- Test shows regular and seasonal difference, but we start with regular difference, we have two ways either taking unit roots or AR(1).

## 🔄 Using Regular Difference

<img width="664" alt="image" src="https://github.com/steguess/Time-Series-Analysis-Earnings/assets/86976901/295552e6-d773-4dff-8ca2-438e30acf548">



ACF plot:
- S=4 Quarterly Data
- Seasonal Difference: 0
- Regular Difference: 1
- Seasonal lags, slow decay to zero
- Seasonal Difference

Doing the following Transformation: 

S=4 Quarterly Data | Seasonal Difference: 1 | Regular Difference: 1


When we take AR(1), the coefficient becomes close to 1 (0.9308), and when we take SAR(1) with Regular Difference 1, the coefficient is also becoming close to 1 (0.9184). Hence, we want to predict two parameters less and will take differences instead of AR(1) and SAR(1). After taking the differences (d,D), you can see the plots below. The ACF and PACF plot show that we don't have White Noise → look for a linear model.

<img width="1092" alt="image" src="https://github.com/steguess/Time-Series-Analysis-Earnings/assets/86976901/82f845c9-f80b-4d8d-a0af-a8a30f9e0563">



## 📝 Selected Models

We looked for possible models with significant parameters and also checked if the residuals are white noise. We selected the three models below, which capture the seasonal trend with the minimum number of parameters used based on the ACF and PACF plot. In addition, we ran a grid search, which looked for all possible combinations with the lowest AIC score. The lowest AIC score is the model: (1,1,1)(1,1,0), which is used as well. We did not consider (2,1,0)*(0,1,1) or other higher combinations, even though the box test showed it is a valid model, since we want to use the minimum of parameters, and the models with lower parameters already had significant coefficient parameters, and the Box Test p-value was above 0.05.

#### SARIMA(p,d,q)*(P,D,Q) Models Summary

| Parameters      | Significant | Box Test df=28 | WN  | GWN                  | SWN  | Non-Linear Model |
| --------------- | ----------- | -------------- | ---- | -------------------- | ----- | ---------------- |
| (0,1,0)*(1,1,0) | Yes         | 0.59           | Yes  | No, Shapiro test is <0.05 | No SWN | Yes              |
| (0,1,1)*(0,1,1) | Yes         | 0.66           | Yes  | No, Shapiro test is <0.05 | No SWN | Yes              |
| (1,1,0)*(1,1,0) | Yes         | 0.644          | Yes  | No, Shapiro test is <0.05 | No SWN | Yes              |
| (1,1,1)*(1,1,0) | Yes         | 0.804          | Yes  | No, Shapiro test is <0.05 | No SWN | Yes              |


*Legend
WH = White Noise,
GWN = Gaussian White Noise,
SWN = Strict White Noise


## 📈Log(Yt) Transformation


After using log transformation in the original dataset, you can see in the first plot that the mean is not stationary. Also the ACF plot is slowly decaying to zero 
→ Taking the difference 
- PACF plot lag 1 is out of bound → difference → also ndiff test for regular and seasonal indicates we need to apply the difference d= 1 and D=1 - After taking only d=1, the seasonal lags decay to zero over time in the ACF plot → Seasonal Difference and also the seasonal difference test is also indicating to take the difference

<img width="969" alt="image" src="https://github.com/steguess/Time-Series-Analysis-Coca-Cola-Earnings/assets/86976901/6cd39756-4345-4968-8ef2-0eccf7fe6756">

S=4 Quarterly Data | Seasonal Difference : 1 | Regular Difference: 1 | log transformation
- After taking the differences(d = 1,D =1 ) you can see the plots below show there are no trends 
- ADF Test p-value is below 0.05 → the mean is stationary 
- Box Test is below 0.05 → not White Noise and data is uncorrelated 
- ACF plot, lag 1,3,4,5,9,18 are out of bound → need to take regular and seasonal lags 
- PACF plot are 1,2,4,8 are out of bound → regular and seasonal lags → liner models needed

<img width="1242" alt="image" src="https://github.com/steguess/Time-Series-Analysis-Coca-Cola-Earnings/assets/86976901/ae951137-8558-43ba-9998-32b8bce14431">


## 🎯 Selected Models with Log Transformation :SARIMA(p,d,q)*(P,D,Q) Analysis

| SARIMA(p,d,q)*(P,D,Q) | Transformation | Parameters sign.| Box Test df=28 | WN | GWN | SWN |
|-----------------------|----------------|------------|----------|----|-----|-----|
| (0,1,1)*(0,1,1)       | log            | Yes        | 0.64     | Yes| No  | No  |
| (1,1,0)*(0,1,1)       | log            | Yes        | 0.23     | Yes| No  | No  |
| (1,0,1)*(1,0,1)       | log            | Yes        | 0.74     | Yes| No  | No  |


Using the ACF and PACF to find the best possible combination, and also employing Grid Search to find the best model with the lowest AIC score, the following models were selected:


 ## 📊 Model Comparison

We use 83 time series points for training and 24 values for the testing set. The performance of the models is compared using MAPE / MSFE for 4 horizons.

### 🔁Recursive Tests:

SARIMA(p,d,q)(P,D,Q) | Transformation | MSFE(n=1) | MSFE(n=2) | MSFE(n=3) | MSFE(n=4) | MAPE(n=1) | MAPE(n=2) | MAPE(n=3) | MAPE(n=4)
--- | --- | --- | --- | --- | --- | --- | --- | --- | ---
(0,1,0)*(1,1,0) | d=1, D=1, No log | 0.0022 | 0.0045 | 0.0055 | 0.0054 | 6.3740 | 8.9894 | 8.9848 | 9.0286
(0,1,1)*(0,1,1) | d=1, D=1, No log | 0.0024 | 0.0041 | 0.0049 | 0.0049 | 5.7943 | 7.8291 | 8.7941 | 8.5248
(1,1,0)*(1,1,0) | d=1, D=1, No log | 0.0024 | 0.0043 | 0.0052 | 0.0052 | 6.2328 | 8.0166 | 8.9991 | 8.7178
(1,1,1)*(1,1,0) | d=1, D=1, No log | 0.0020 | 0.0037 | 0.0046 | 0.0048 | 5.4503 | 7.5961 | 8.6684 | 8.6020
(0,1,1)*(0,1,1) | d=1, D=1, log | 0.0016 | 0.0031 | 0.0036 | 0.0036 | 5.2245 | 6.7830 | 7.2021 | 6.8361
(1,1,0)*(0,1,1) | d=1, D=1, log | 0.0018 | 0.0033 | 0.0039 | 0.0039 | 5.6678 | 7.0792 | 7.5103 | 7.1381
(1,0,1)*(1,0,1) | log | 0.0017 | 0.0031 | 0.0035 | 0.0035 | 5.2534 | 6.8415 | 7.2229 | 6.8383

### 🔀Rolling Tests:

SARIMA(p,d,q)(P,D,Q) | Transformation | MSFE(n=1) | MSFE(n=2) | MSFE(n=3) | MSFE(n=4) | MAPE(n=1) | MAPE(n=2) | MAPE(n=3) | MAPE(n=4)
--- | --- | --- | --- | --- | --- | --- | --- | --- | ---
(0,1,0)*(1,1,0) | d=1, D=1, No log | 0.0022 | 0.0045 | 0.0055 | 0.0054 | 6.3700 | 8.6115 | 8.9848 | 9.0217
(0,1,1)*(0,1,1) | d=1, D=1, No log | 0.0024 | 0.0042 | 0.0049 | 0.0049 | 5.7909 | 7.8253 | 8.7896 | 8.5229
(1,1,0)*(1,1,0) | d=1, D=1, No log | 0.0024 | 0.0043 | 0.0052 | 0.0052 | 6.2291 | 8.0123 | 8.9952 | 8.7143
(1,1,1)*(1,1,0) | d=1, D=1, No log | 0.0019 | 0.0036 | 0.0046 | 0.0049 | 5.4033 | 7.5656 | 8.6336 | 8.5998
(0,1,1)*(0,1,1) | d=1, D=1, log | 0.0016 | 0.0030 | 0.0036 | 0.0036 | 5.2268 | 6.7914 | 7.1990 | 6.8271
(1,1,0)*(0,1,1) | d=1, D=1, log | 0.0018 | 0.0033 | 0.0038 | 0.0039 | 5.6913 | 7.1160 | 7.5413 | 7.1232
(1,0,1)*(1,0,1) | log | 0.0017 | 0.0031 | 0.0035 | 0.0035 | 5.2534 | 6.8415 | 7.2229 | 6.838



## 🏆 Winner Model

The winning model is Log(Yt), SARIMA(0,1,1)(0,1,1,4).

- The two estimated parameters MA(1) and SMA(1) parameters are statistically significant (p-value < 0).
- ADF Test p-value is below 0.05 → the mean is stationary.
- The ACF plot shows that the lags are in bounds (some are close to the threshold value like lag 5 and 18) → Test Box Test.
- Box Test p-value = 0.649 → data is uncorrelated, and ACF close to zero → LB states White Noise residuals → no linear model needed.
- Shapiro Test p-value is below zero → no normal distribution → Non-Gaussian White Noise.

Squared residuals Box Test p-value is below 0.05, squared residuals lags are out of bound → data is correlated → No Strict White Noise → Nonlinear model for the variance can be used.

Since the tails of the distribution are not close to the normal distribution, we cannot use the assumption of normality for the tails, we need to use the quantiles of the distribution for the CI prediction.

## 📈 Prediction

Next 24 quarters point prediction already with the undone transformation (6 years):

For the Confidence Interval, we use the first transformation scale and, in the end, undo the transformation and bring it back on the scale of Y(t) for the 95% confidence interval.

95% confidence interval Assuming Quantile distribution on the tails:
- Lower CI: exp(Point prediction - 1.806302 * SE)
- Upper CI: exp(Point prediction + 1.834527 * SE)


## Authors 📚

 :tada:


<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/bmanzuoli"><img src="https://avatars.githubusercontent.com/u/108944195?v=4" width="100px;" alt="Barbara Manzueli"/><br /><sub><b>Barbara Manzueli</b></sub></a><br /><a href="https://github.com/codesandbox/codesandbox-client/commits?author=itayyoung" title="Data Analyst">✍️</a></td>
    <td align="center"><a href="https://github.com/juanhorrillo"><img src="https://avatars.githubusercontent.com/u/108974910?v=4" width="100px;" alt="Juan Horrillo"/><br /><sub><b>Juan Horrillo</b></sub></a><br /><a href="https://github.com/codesandbox/codesandbox-client/commits?author=juanhorrillo" title="Backend Developer">💻</a></td>
    <td align="center"><a href="https://github.com/steguess"><img src="https://avatars.githubusercontent.com/u/86976901?v=4" width="100px;" alt="Stephanie Gessler"/><br /><sub><b>Stephanie Gessler</b></sub></a><br /><a href="https://github.com/codesandbox/codesandbox-client/commits?author=steguess" title="Frontend Developer">💻</a></td>
    <td align="center"><a href="https://github.com/aousalmegrin"><img src="https://avatars.githubusercontent.com/u/89685456?v=4" width="100px;" alt="Aous Almegrin"/><br /><sub><b>Aous Almegrin</b></sub></a><br /><a href="https://github.com/codesandbox/codesandbox-client/commits?author=Aous Almegrin" title="UI/UX Designer">💻</a></td>
    <td align="center"><a href="https://github.com/Nirmalavino"><img src="https://avatars.githubusercontent.com/u/108956176?v=4" width="100px;" alt="Nirmala Vinothbabu"/><br /><sub><b>Nirmala Vinothbabu</b></sub></a><br /><a href="https://github.com/codesandbox/codesandbox-client/commits?author=Nirmalavino" title="Technical Writer">💻</a></td>
    <td align="center"><a href="https://github.com/JSS1602"><img src="https://avatars.githubusercontent.com/u/108944247?v=4" width="100px;" alt="Jorge Sanz"/><br /><sub><b>Jorge Sanz</b></sub></a><br /><a href="https://github.com/codesandbox/codesandbox-client/commits?author=JSS1602" title="Backend Developer">💻</a></td>
        <td align="center"><a href="https://github.com/ProdromosA"><img src="https://avatars.githubusercontent.com/u/108944247?v=4" width="100px;" alt="Prodromos Alampritis"/><br /><sub><b>Prodromos Alampritis</b></sub></a><br /><a href="https://github.com/codesandbox/codesandbox-client/commits?author=Prodromos Alampritis" title="Backend Developer">🎨</a></td>
    

  </tr>
</table>


