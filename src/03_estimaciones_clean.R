## Estimaciones Final ----

### A partir de 03_ vemos que las estimaciones se parecen todas
### Se usará OLS para las simulaciones


rm(list = ls(all = TRUE)) 

library(plm)
library(lmtest)

load("./munge/pov.RData")

pov.p <- plm.data(x=pov,index=c("iso3c","year"))

## Formula ----
dep <- c("dlhcind","dlhcpob","dlpgind","dlpgpob","dlpgsind","dlpgspob")

expl <- "~dlyn+dlg"

## Estimaciones ----

estim <- list()

for(i in 1:length(dep)){

#   if(i %in% grep(pattern="pob",dep))
#     {
#   estim[[i]] <- plm(formula(paste0(dep[i],expl)),data=pov.p,model="within") 
#   }
#   
#   else 
    estim[[i]] <- plm(formula(paste0(dep[i],expl)),data=pov.p,model="pooling") 
}


robu <- list()

for(i in 1:length(dep)){

  robu[[i]] <- coeftest(estim[[i]],vcov=function(x) vcovHC(x, method="arellano", type="HC3"))
  
}

estim
robu

## Cuadro Texreg ----
library(texreg)

screenreg(list(estim[[1]],estim[[3]],estim[[5]], estim[[2]],estim[[4]],estim[[6]]),
          custom.model.names=c("hcind","pgind","pgsind","hcpob","pgpob","pgspob"),
          override.se   =list(robu[[1]][,2],robu[[3]][,2],robu[[5]][,2],robu[[2]][,2],robu[[4]][,2],robu[[6]][,2]),
          override.pval =list(robu[[1]][,4],robu[[3]][,4],robu[[5]][,4],robu[[2]][,4],robu[[4]][,4],robu[[6]][,4]),
          stars=c(0.01,0.05,0.1))

htmlreg(list(estim[[1]],estim[[3]],estim[[5]], estim[[2]],estim[[4]],estim[[6]]),
        custom.model.names=c("hcind","pgind","pgsind","hcpob","pgpob","pgspob"),
        override.se   =list(robu[[1]][,2],robu[[3]][,2],robu[[5]][,2],robu[[2]][,2],robu[[4]][,2],robu[[6]][,2]),
        override.pval =list(robu[[1]][,4],robu[[3]][,4],robu[[5]][,4],robu[[2]][,4],robu[[4]][,4],robu[[6]][,4]),
        stars=c(0.01,0.05,0.1), file = "./reports/cuadro1.doc", inline.css = FALSE,
        doctype = TRUE, html.tag = TRUE, head.tag = TRUE, body.tag = TRUE)

