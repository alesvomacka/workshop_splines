library(ggeffects)
library(lspline)
library(splines)

un = readRDS(url("https://github.com/alesvomacka/workshop_splines/blob/master/data/un_clean.rds?raw=true"))

#1) Vytvorte si model predikujici HDP na hlavu v tisicich $ (GDPperCapita_10k)
#   pomoci podilu negramotnych zen (illiteracyFemale) a zkuste si ho interpertovat (napr. summary nebo ggpredict+plot)
mod1 = lm(GDPperCapita_10k ~ illiteracyFemale, data = un)
plot(ggpredict(mod1), add.data = T)

#2) Pridejte do predchozio modelu linearni spline s uzly v hodnotach 20 a 40 (funkce lspline)
#   a interpretujte pomoci regresnich koeficientu i grafu marginalnich efektu
mod2 = lm(GDPperCapita_10k ~ lspline(illiteracyFemale, knots = c(20, 40)), data = un)
summary(mod2)
plot(ggpredict(mod2), add.data = T)

#3) Vytvorte si dva modely, ktere budou mit prirozeny spline pro illiteracyFemale (funkce ns).
#   Prvni model bude mit 1 vnirtni uzel (df = 2) a druhy model 2 vnitrni uzly (df = 3).

mod3 = lm(GDPperCapita_10k ~ ns(illiteracyFemale, df = 2), data = un)
mod4 = lm(GDPperCapita_10k ~ ns(illiteracyFemale, df = 3), data = un)

#4) Pomoci Akaikiho informacniho kriteria zjistite, ktery model sedi lepe (funkce AIC)
AIC(mod3, mod4)

#5) Lepe sedici model interpretujte pomoci grafu marginalnich efektu
plot(ggpredict(mod4), add.data = T)



