
library(gapminder)
data("gapminder")
summary(gapminder)
mean(gapminder$lifeExp)

hist(gapminder$pop) ## skewed
hist(log(gapminder$pop)) ## log transformation converts to normal distribution
hist(gapminder$lifeExp)


library(tidyverse)
ggplot(gapminder, aes(x=lifeExp))+geom_histogram()+
  facet_grid(continent~.)

ggplot(gapminder, aes(x=continent, y=lifeExp))+geom_boxplot()

plot(gapminder$lifeExp ~ gapminder$gdpPercap) ## not linear
plot(gapminder$lifeExp ~ log(gapminder$gdpPercap)) ## more linear

## using dplyr
gapminder %>% select(country, lifeExp) %>%
  filter(country=="South Africa"|country=="Ireland") %>%
  group_by(country) %>%
  summarise(avg_life=mean(lifeExp))

## testing for statistical significance
## based on sample
df1 <- gapminder %>% select(country, lifeExp) %>%
  filter(country=="South Africa"|country=="Ireland")

t.test(data=df1, lifeExp ~ country)
## test shows average for each country
## low p-value means we can reject null hypothesis -> highly likely there is a real diff
## confidence interval shows the 95% of the range that the average is within

gapminder %>% filter(gdpPercap<50000) %>% 
  ggplot(aes(x=log(gdpPercap), y=lifeExp, col=continent))+
  geom_point(alpha=0.3)+
  geom_smooth(method=lm)

gapminder %>% filter(gdpPercap<50000) %>% 
  ggplot(aes(x=log(gdpPercap), y=lifeExp, col=year))+
  geom_point(alpha=0.3)+
  geom_smooth(method=lm)+facet_wrap(~continent)

## linear regression
## single variable
summary(lm(gapminder$lifeExp ~ gapminder$gdpPercap))
## multiple regression
summary(lm(gapminder$lifeExp ~gapminder$gdpPercap+gapminder$pop))

## with log transformation - much better R squared
summary(lm(gapminder$lifeExp ~ log(gapminder$gdpPercap)))
## multiple regression - slightly better R squared
summary(lm(gapminder$lifeExp ~ log(gapminder$gdpPercap)+gapminder$pop))

## using for prediction
## generate linear model
lm1 <- lm(data=gapminder, lifeExp~log(gdpPercap))
lm1
summary(lm1)

## prediction variable has to have same name as variable in model
## log transformation causes havoc with this
## so create new variable that is log of gdpPercap and use that for model
gapminder$lgdpPercap <- log(gapminder$gdpPercap)
ggplot(gapminder, aes(x=lgdpPercap, y=lifeExp))+geom_point()+geom_smooth(method=lm)

lm2 <- lm(data=gapminder, lifeExp~lgdpPercap)
lm2 ## same result as applying log transformation in lm formula above
summary(lm2)

## need value(s) in a data frame -> predictor variable has to have same name as in lm
g <- data.frame(lgdpPercap=c(5,8,9,11,12))
predict(lm2, g) ## creates prediction for each item
## add predicted values to data frame
g$lifeExp <- predict(lm2, g)
g$type <- "prediction"

## get variables from original data
gm <- gapminder %>% select(lifeExp, lgdpPercap) %>% 
  mutate(type="actual")
## combine actuals with prediction
gm <- bind_rows(gm, g)

## visualize
ggplot(gm, aes(x=lgdpPercap, y=lifeExp, col=type))+geom_point()

## LINEAR REGRESSION ASSUMPTIONS
## going back to check if required assumptions for linear regression are present
## Assumptions:
## 1. Y-values (or errors 'e') are independent
## 2. Y-values can be expressed as a linear function of the X variable
## 3. Variation of observations around the regression line (residual standard error)
##    is constant (homoscedasticity)
## 4. For given value X, Y values (or the error) are Normally distributed
### 2-4 can be checked by examining residuals

## check assumptions with four plots
plot(lm2) ## in console, hit return
par(mfrow=c(2,2))
plot(lm2)

## plot 1: Residuals vs Fitted
## - ideal: flat red line near zero, with no pattern of variation in the dots
## - actual: wavering red line but not bad and indicates general linearity; dots appear to cluster together more as x 
##   increases, indicating that residuals tend to be smaller at higher X; 
##   there are also some outliers at high X; not great but not sure how bad
## plot 2: Q-Q
## - ideal: dots fall along the line
## - actual: for the most part close, although lower x values are well below line and
##   a couple of upper dots are below line; so fairly normally distributed residuals but
##   certainly not ideal
## plot 3: Scale-Location
## - ideal: red line should be flat for linearity; random distribution of dots
## - actual: red line rises slightly and then droops off at higher X values; 
##   dots are pretty random, although more tightly clustered at higher X values and some
##   outliers at very high X; not clear how significant
## plot 4: Residuals vs Leverage
## - ideal: ?
## - actual: red line fairly flat but some concerning pattern in the dots

## BOTTOM LINE:
## - concerns about the validity of the model over the population
## - may be misleading
## - still probably good enough to use with caution (?)

