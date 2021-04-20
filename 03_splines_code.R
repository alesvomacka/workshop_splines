# Data and packages -------------------------------------------------------
library(tidyverse)
library(ggeffects)
library(lspline)
library(splines)

un = read_rds("data/un_clean.rds")
ess = read_rds("data/ess_cleaned.rds")

# Linear Splines ----------------------------------------------------------

mod1 = lm(infantMortality ~ lspline(GDPperCapita_10k, knots = c(10,20)), data = un)
summary(mod1)
plot(ggpredict(mod1))

# qlspline() dosazuje spliny podle kvantilu, ale moc si nerozumi s ggeffects -> lepsi dopocitat si kvantily rucne

# Natural splines ---------------------------------------------------------

mod2 = lm(infantMortality ~ ns(GDPperCapita, df = 2), data = un) #pocet vnitrnich uzly je df - 1
mod3 = lm(infantMortality ~ ns(GDPperCapita, df = 3), data = un) # model s 4 uzly (2 vnejsi a 2 vnitrni)

AIC(mod2, mod3) #mod3 sedi lepe

summary(mod3)
plot(ggpredict(mod3))

# Spliny v logisticke regresi ---------------------------------------------

mod4 = glm(vote ~ ns(age, df = 2) * education, family = "binomial", data = ess) #priklad ze seminare marginalnich efektu

plot(ggpredict(mod5, terms = c("age", "education")))
