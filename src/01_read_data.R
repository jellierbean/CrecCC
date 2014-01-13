#### Leer datos

library(xlsx)

# povd <- read.xlsx("./data/DatosCEPALSTAT20Oct.xlsx",sheetName="pov",endRow=157)
# gini <- read.xlsx("./data/DatosCEPALSTAT20Oct.xlsx",sheetName="g")
# sagr <- read.xlsx("./data/DatosAgr25Oct.xlsx",sheetName="sagr",)
# yan <- read.xlsx("./data/DatosAgr25Oct.xlsx",sheetName="yan2")
# 

hcpob <- read.xlsx("./data/datos_pobreza_2013.xlsx",sheetName="HCPOB",header=T)
hcind <- read.xlsx("./data/datos_pobreza_2013.xlsx",sheetName="HCIND",header=T)
pgpob <- read.xlsx("./data/datos_pobreza_2013.xlsx",sheetName="PGPOB",header=T)
pgind <- read.xlsx("./data/datos_pobreza_2013.xlsx",sheetName="PGIND",header=T)
pgspob <- read.xlsx("./data/datos_pobreza_2013.xlsx",sheetName="PGPOBS",header=T)
pgsind <- read.xlsx("./data/datos_pobreza_2013.xlsx",sheetName="PGINDS",header=T)
gini2 <- read.xlsx("./data/datos_pobreza_2013.xlsx",sheetName="Gini2",header=T)
yn <- read.xlsx("./data/PIB90_12.xlsx",sheetName="YN")
y <- read.xlsx("./data/PIB90_12.xlsx",sheetName="Y")
pob <- read.xlsx("./data/datos_pobreza_2013.xlsx",sheetName="POB",header=T)

# reshape ----
  
  
library(reshape)

hcpob <- melt(hcpob,varnames="hc",id.vars="iso3c",variable_name="year")
names(hcpob)[3] <- "hcpob"
hcind <- melt(hcind,varnames="hc",id.vars="iso3c",variable_name="year")
names(hcind)[3] <- "hcind"
pgpob <- melt(pgpob,varnames="pg",id.vars="iso3c",variable_name="year")
names(pgpob)[3] <- "pgpob"
pgind <- melt(pgind,varnames="pg",id.vars="iso3c",variable_name="year")
names(pgind)[3] <- "pgind"
pgspob <- melt(pgspob,varnames="pgs",id.vars="iso3c",variable_name="year")
names(pgspob)[3] <- "pgspob"
pgsind <- melt(pgsind,varnames="pgs",id.vars="iso3c",variable_name="year")
names(pgsind)[3] <- "pgsind"
gini <- melt(gini2,varnames="gini",id.vars="iso3c",variable_name="year")
names(gini)[3] <- "gini"
yn <- melt(yn,varnames="yn",id.vars="iso3c",variable_name="year")
names(yn)[3] <- "yn"
y <- melt(y,varnames="y",id.vars="iso3c",variable_name="year")
names(y)[3] <- "y"


### POBLACIÓN
library(countrycode)

pob$iso3c <- countrycode(sourcevar=pob$Countries,origin="country.name",destination="iso3c",warn=T)
pob <- melt(pob,varnames="yn",id.vars=c("Countries","iso3c"),variable_name="year")
names(pob)[4] <- "pob"


hcpob[,"year"] <- as.character(hcpob[,"year"])
hcpob[,"year"] <- as.numeric(gsub("X",x=hcpob[,"year"],replacement=""))

hcind[,"year"] <- as.character(hcind[,"year"])
hcind[,"year"] <- as.numeric(gsub("X",x=hcind[,"year"],replacement=""))

pgpob[,"year"] <- as.character(pgpob[,"year"])
pgpob[,"year"] <- as.numeric(gsub("X",x=pgpob[,"year"],replacement=""))

pgind[,"year"] <- as.character(pgind[,"year"])
pgind[,"year"] <- as.numeric(gsub("X",x=pgind[,"year"],replacement=""))

pgspob[,"year"] <- as.character(pgspob[,"year"])
pgspob[,"year"] <- as.numeric(gsub("X",x=pgspob[,"year"],replacement=""))

pgsind[,"year"] <- as.character(pgsind[,"year"])
pgsind[,"year"] <- as.numeric(gsub("X",x=pgsind[,"year"],replacement=""))

yn[,"year"] <- as.character(yn[,"year"])
yn[,"year"] <- as.numeric(gsub("X",x=yn[,"year"],replacement=""))

y[,"year"] <- as.character(y[,"year"])
y[,"year"] <- as.numeric(gsub("X",x=y[,"year"],replacement=""))

gini[,"year"] <- as.character(gini[,"year"])
gini[,"year"] <- as.numeric(gsub("X",x=gini[,"year"],replacement=""))

pob[,"year"] <- as.character(pob[,"year"])
pob[,"year"] <- as.numeric(gsub("X",x=pob[,"year"],replacement=""))


# sagr <- melt(sagr,varnames="sagr",id.vars="country",variable_name="year")
# 
# names(sagr)[3] <- "sagr"
# 
# sagr$year <- as.character(sagr$year)
# 
# sagr$year <- as.numeric(gsub("X",x=sagr$year,replacement=""))
# 
# sagr$year
# 
# yan <- melt(yan,varnames="yan",id.vars="country",variable_name="year")
# 
# names(yan)[3] <- "yan"
# 
# yan$year <- as.character(yan$year)
# 
# yan$year <- as.numeric(gsub("X",x=yan$year,replacement=""))
# 
# yan$year
# 
# yan <- merge(sagr,yan,by=c("country","year"))
# 
# library(countrycode)
# 
# yan$iso3c <- countrycode(yan$country,"country.name","iso3c")

### hacer el merge y guardarlo en el munge

pov <- Reduce(function(...) merge(..., by=c("iso3c","year"), all.x=T), list(hcind,hcpob,pgind,pgpob,pgsind,pgspob,gini,yn,pob[,2:4]))

str(pov)

pov$iso3c <- as.character(pov$iso3c)
pob$iso3c <- as.character(pob$iso3c)
yn$iso3c <- as.character(yn$iso3c)
y$iso3c <- as.character(y$iso3c)

# pov <- subset(pov,select=-c(country))

# pov$ynan <- with(pov,yn - yan)

save(pov, file="./data/pov.RData") # guardar datos originales en R
save(pob, file="./munge/pob.RData")
save(yn, file="./munge/yn.RData")
save(y, file="./munge/y.RData")
