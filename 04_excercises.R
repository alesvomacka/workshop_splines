library(ggeffects)
library(lspline)
library(splines)

un = readRDS(url("https://github.com/alesvomacka/workshop_splines/blob/master/data/un_clean.rds?raw=true"))
ess = 