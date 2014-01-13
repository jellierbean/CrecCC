#### Primeras estimaciones

rm(list = ls(all = TRUE)) 

library(plm)
library(lmtest)

load("./munge/pov.RData")


pov.p <- plm.data(x=pov,index=c("iso3c","year"))

str(pov.p)

#### Especificación  ----

### Línea de indigencia ====

hcind.fe <- plm(dlhcind~dlyn+dlg,data=pov.p,model="within")
hcind.ols <-plm(dlhcind~dlyn+dlg,data=pov.p,model="pooling")
hcind.re <- plm(dlhcind~dlyn+dlg,data=pov.p,model="random")

pFtest(hcind.fe, hcind.ols)
pooltest(hcind.ols,hcind.fe)
plmtest(hcind.ols, type=c("bp"))
pcdtest(hcind.fe, test = c("lm"))
phtest(hcind.fe,hcind.re) ##Hausman

coeftest(hcind.fe,vcov.=vcovHC)
coeftest(hcind.ols,vcov.=vcovHC)

pgind.fe <- plm(dlpgind~dlyn+dlg,data=pov.p,model="within")
pgind.ols <-plm(dlpgind~dlyn+dlg,data=pov.p,model="pooling")
pgind.re <- plm(dlpgind~dlyn+dlg,data=pov.p,model="random")

pFtest(pgind.fe, pgind.ols)
pooltest(pgind.ols,pgind.fe)
plmtest(pgind.ols, type=c("bp"))
phtest(pgind.fe,pgind.re) ##Hausman

#### Línea de pobreza =====

hcpob.fe <- plm(dlhcpob~dlyn+dlg,data=pov.p,model="within")
hcpob.ols <-plm(dlhcpob~dlyn+dlg,data=pov.p,model="pooling")
hcpob.re <- plm(dlhcpob~dlyn+dlg,data=pov.p,model="random")

pFtest(hcpob.fe, hcpob.ols)
pooltest(hcpob.ols,hcpob.fe)
plmtest(hcpob.ols, type=c("bp"))
phtest(hcpob.fe,hcpob.re) ##Hausman


pgpob.fe <- plm(dlpgpob~dlyn+dlg,data=pov.p,model="within")
pgpob.ols <-plm(dlpgpob~dlyn+dlg,data=pov.p,model="pooling")
pgpob.re <- plm(dlpgpob~dlyn+dlg,data=pov.p,model="random")

pFtest(pgpob.fe, pgpob.ols)
pooltest(pgpob.ols,pgpob.fe)
plmtest(pgpob.ols, type=c("bp"))
phtest(pgpob.fe,pgpob.re) ##Hausman

summary(fixef(pgpob.fe))

## Estimaciones Finales OLS ---- 

dep <- c("dlhcind","dlhcpob","dlpgind","dlpgpob")

expl <- "~dlyn+dlg"

lm(formula(paste0(dep[1],expl)),data=pov)
lm(formula(paste0(dep[2],expl)),data=pov)
plm(formula(paste0(dep[2],expl)),data=pov.p,model="pooling")

# curve(1.8*x/1000,0,6300,xlim=c(0,6000),ylim=c(0,10.8),
#       col="darkblue",lwd=5,xaxs="i", yaxs="i")
# grid()
# 