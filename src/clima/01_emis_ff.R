###### Gráfica emisiones

library(xlsx)

ffe <- read.xlsx("./data/ClimaEmis/global.1751_2010.xlsx",1,startRow=3,header=F)


str(ffe)

names(ffe) <- c("year","total","gas","liquid","solid","cement","flaring")

lm(total~year,data=ffe)

plot(ffe$year,ffe$total,type="l",bty="L")
grid()
