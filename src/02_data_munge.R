### Sacar primeras diferencias

rm(list = ls(all = TRUE)) 

source("./functions/Functions_DIFF_LAG.R")

load("./data/pov.RData")


pov <- pov[complete.cases(pov[,c("hcind","yn","gini")]),]

pov$dlhcind <- s.diff(id=pov$iso3c,year=pov$year,pov$hcind)

pov$dlhcpob <- s.diff(id=pov$iso3c,year=pov$year,pov$hcpob)

pov$dlpgind <- s.diff(id=pov$iso3c,year=pov$year,pov$pgind)

pov$dlpgpob <- s.diff(id=pov$iso3c,year=pov$year,pov$pgpob)

pov$dlpgsind <- s.diff(id=pov$iso3c,year=pov$year,pov$pgsind)

pov$dlpgspob <- s.diff(id=pov$iso3c,year=pov$year,pov$pgspob)

pov$dlg <- s.diff(id=pov$iso3c,year=pov$year,pov$gini)

pov$dlyn <- s.diff(id=pov$iso3c,year=pov$year,pov$yn)

pov$gini.lag <- s.lag(id=pov$iso3c,year=pov$year,pov$gini)

# pov$dlyan <- s.diff(id=pov$iso3c,year=pov$year,pov$yan)
# 
# pov$dlynan <- s.diff(id=pov$iso3c,year=pov$year,pov$ynan)
# 
# pov$sagr_lag <- s.lag(id=pov$iso3c,year=pov$year,pov$sagr)
# 
# pov$snagr <- with(pov,100-sagr)
# 
# pov$snagr_lag <- s.lag(id=pov$iso3c,year=pov$year,pov$snagr)
# 
# pov$dlyanw <- with(pov,dlyan*sagr_lag)/100
# 
# pov$dlynanw <- with(pov,dlynan*snagr_lag)/100

# pov <- pov[complete.cases(pov),]

save(pov,file="./munge/pov.RData")


library(foreign)

write.dta(pov,file="./munge/pov.dta")
