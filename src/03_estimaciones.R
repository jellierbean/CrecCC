#### Primeras estimaciones


library(plm)

load("./munge/pov.RData")

pov.p <- pdata.frame(x=pov,index=c("iso3c","year"))

pov.p

summary(plm(dlpov~dlyn+dlg,data=pov.p,model="pooling"))

summary(plm(dlind~dlyn+dlg,data=pov.p,model="within"))

fixed.effects((plm(dlind~dlyn+dlg,data=pov.p,model="within")))


### Poolability test 

x.fe <- plm(dlind~dlyn+dlg,data=pov.p,model="within")
x.ols <- plm(dlind~dlyn+dlg,data=pov.p,model="pooling")

pooltest(x.fe,x.ols)


