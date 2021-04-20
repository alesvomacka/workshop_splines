# data and packages -------------------------------------------------------

library(tidyverse)

un = read.table("data/UnitedNations.txt")

# Data preparation --------------------------------------------------------

un = un %>% mutate(GDPperCapita_10k = GDPperCapita / 1000,
                   GDPperCapita_cat = case_when(GDPperCapita_10k <= 10 ~ "10k or less",
                                                GDPperCapita_10k <= 20 ~ "20k or less",
                                                GDPperCapita_10k >  20 ~ "More than 20k"),
                   GDPperCapita_cat = fct_relevel(GDPperCapita_cat,
                                                  "More than 20k",
                                                  after = Inf))

# Data export -------------------------------------------------------------

write_rds(x = un, file = "data/un_clean.rds")
write_csv(x = un, file = "data/un_clean.csv")