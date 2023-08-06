Certainly! Below is the updated version of the text with icons and the "CocaCola Banner.png" image at the top:

# Coca Cola Company - Quarterly Earnings per Share Analysis

![Coca Cola Banner](CocaCola_Banner.png)

## 💹 Quarterly Earnings per Share from 1983 to 2009

Quarterly earnings per share of Coca Cola Company from the first quarter of 1983 to the third quarter of 2009.

## 📈 Box - Jenkins Methodology

![Chart Icon](https://example.com/chart-icon.png)

**Coca Cola Earnings from 1983 - 2009**

Since 1983, the quarterly earnings per share grew strongly over time. It started from 0.0375 earnings per share and reached its highest peak at 1.01 earnings per share in July 2008. The variance/volatility was smaller from 1983 to 1990 compared to 1990 to 1997, and it increased even further in volatility/variance from 2000 to 2009. Additionally, you can also see a break in the trend, and earnings per share declined from the year 1999 to 2000.

## 📊 Analysis on the Original Data

![Analysis Icon](https://example.com/analysis-icon.png)

The time series plot shows that the level is not constant over time.
- The series (Yt) is not stationary in the mean.
- Data is also not stationary in the variance; the variance is increasing over time, considering taking log(Yt).
- ADF test = 1.05 (p-value > 0.05, we fail to reject the null that the data is not stationary in the mean → we have to take at least one unit root.
- In ACF plot, decaying close to zero, and all lags until lags 25 are out of bound, → take the difference.
- PACF plot lag 1 is out of bound → clear need to take difference.
- Test shows regular and seasonal difference, but we start with regular difference, we have two ways either taking unit roots or AR(1).

## 🔄 Using Regular Difference

![Difference Icon](https://example.com/difference-icon.png)

S=4 Quarterly Data | Seasonal Difference: 0 | Regular Difference: 1
ACF plot: Seasonal lags, slow decay to zero → Seasonal Difference.

=4 Quarterly Data | Seasonal Difference: 1 | Regular Difference: 1
When we take AR(1), the coefficient becomes close to 1 (0.9308), and when we take SAR(1) with Regular Difference 1, the coefficient is also becoming close to 1 (0.9184). Hence, we want to predict two parameters less and will take differences instead of AR(1) and SAR(1). After taking the differences (d,D), you can see the plots below. The ACF and PACF plot show that we don't have White Noise → look for a linear model.

## 📝 Selected Models

![Model Icon](https://example.com/model-icon.png)

We looked for possible models with significant parameters and also checked if the residuals are white noise. We selected the three models below, which capture the seasonal trend with the minimum number of parameters used based on the ACF and PACF plot. In addition, we ran a grid search, which looked for all possible combinations with the lowest AIC score. The lowest AIC score is the model: (1,1,1)(1,1,0), which is used as well. We did not consider (2,1,0)*(0,1,1) or other higher combinations, even though the box test showed it is a valid model, since we want to use the minimum of parameters, and the models with lower parameters already had significant coefficient parameters, and the Box Test p-value was above 0.05.

#### SARIMA(p,d,q)*(P,D,Q) Models Summary

| Parameters      | Significant | Box Test df=28 | WN   | GWN                  | SWN   | Non-Linear Model |
| --------------- | ----------- | -------------- | ---- | -------------------- | ----- | ---------------- |
| (0,1,0)*(1,1,0) | Yes         | 0.59           | Yes  | No, Shapiro test is <0.05 | No SWN | Yes              |
| (0,1,1)*(0,1,1) | Yes         | 0.66           | Yes  | No, Shapiro test is <0.05 | No SWN | Yes              |
| (1,1,0)*(1,1,0) | Yes         | 0.644          | Yes  | No, Shapiro test is <0.05 | No SWN | Yes              |
| (1,1,1)*(1,1,0) | Yes         | 0.804          | Yes  | No, Shapiro test is <0.05 | No SWN | Yes              |

Note: Replace the image URLs (e.g., `https://example.com/CocaCola_Banner.png`) with actual image URLs to display the "CocaCola Banner.png" image at the top. You can also modify the icons and formatting as per your preference.
