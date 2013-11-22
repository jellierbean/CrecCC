#### Leer datos

library(xlsx)

povd <- read.xlsx("./data/DatosCEPALSTAT20Oct.xlsx",sheetName="pov",endRow=157)
gini <- read.xlsx("./data/DatosCEPALSTAT20Oct.xlsx",sheetName="g")
yn <- read.xlsx("./data/DatosCEPALSTAT20Oct.xlsx",sheetName="pcap")
# sagr <- read.xlsx("./data/DatosAgr25Oct.xlsx",sheetName="sagr",)
# yan <- read.xlsx("./data/DatosAgr25Oct.xlsx",sheetName="yan2")
# 


# reshape ----
  
  
library(reshape)

yn <- melt(yn,varnames="yn",id.vars="iso3c",variable_name="year")

names(yn)[3] <- "yn"

yn$year <- as.character(yn$year)

yn$year <- as.numeric(gsub("X",x=yn$year,replacement=""))

yn$year


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

pov <- Reduce(function(...) merge(..., by=c("iso3c","year"), all=F), list(povd,gini,yn))

str(pov)

# pov <- subset(pov,select=-c(country))

# pov$ynan <- with(pov,yn - yan)

save(pov, file="./data/pov.RData") # guardar datos originales en R
