# Cuadro Resumen 



load("./munge/pov.RData")

head(pov)

pov[,c("iso3c","year","hcind")]

pov.resumen <- pov[complete.cases(pov[,c("hcind","gini","yn")]),]

resumen <- data.frame(table(pov.resumen$iso3c))
names(resumen) <- c("iso3c","Obs")

iso3c <- unique(pov.resumen$iso3c)
# country <- unique(pove.resumen$country)


for(i in 1:length(iso3c)){resumen$minyear[i] <- min(pov.resumen$year[pov.resumen$iso3c==iso3c[i]])}
for(i in 1:length(iso3c)){resumen$maxyear[i] <- max(pov.resumen$year[pov.resumen$iso3c==iso3c[i]])}

for(i in 1:length(iso3c)){resumen$hcindin[i] <- pov.resumen$hcind[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$minyear[i]]}
for(i in 1:length(iso3c)){resumen$hcindfin[i] <- pov.resumen$hcind[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$maxyear[i]]}

for(i in 1:length(iso3c)){resumen$hcpobin[i] <- pov.resumen$hcpob[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$minyear[i]]}
for(i in 1:length(iso3c)){resumen$hcpobfin[i] <- pov.resumen$hcpob[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$maxyear[i]]}

for(i in 1:length(iso3c)){resumen$giniin[i] <- pov.resumen$gini[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$minyear[i]]}
for(i in 1:length(iso3c)){resumen$ginifin[i] <- pov.resumen$gini[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$maxyear[i]]}

for(i in 1:length(iso3c)){resumen$pgindin[i] <- pov.resumen$pgind[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$minyear[i]]}
for(i in 1:length(iso3c)){resumen$pgindfin[i] <- pov.resumen$pgind[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$maxyear[i]]}

for(i in 1:length(iso3c)){resumen$pgpobin[i] <- pov.resumen$pgpob[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$minyear[i]]}
for(i in 1:length(iso3c)){resumen$pgpobfin[i] <- pov.resumen$pgpob[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$maxyear[i]]}

for(i in 1:length(iso3c)){resumen$pgsindin[i] <- pov.resumen$pgsind[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$minyear[i]]}
for(i in 1:length(iso3c)){resumen$pgsindfin[i] <- pov.resumen$pgsind[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$maxyear[i]]}
 
for(i in 1:length(iso3c)){resumen$pgspobin[i] <- pov.resumen$pgspob[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$minyear[i]]}
for(i in 1:length(iso3c)){resumen$pgspobfin[i] <- pov.resumen$pgspob[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$maxyear[i]]}

for(i in 1:length(iso3c)){resumen$pobin[i] <- pov.resumen$pob[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$minyear[i]]}
for(i in 1:length(iso3c)){resumen$pobfin[i] <- pov.resumen$pob[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$maxyear[i]]}

for(i in 1:length(iso3c)){resumen$ynin[i] <- pov.resumen$yn[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$minyear[i]]}
for(i in 1:length(iso3c)){resumen$ynfin[i] <- pov.resumen$yn[pov.resumen$iso3c==iso3c[i]&pov.resumen$year==resumen$maxyear[i]]}


write.table(resumen,"clipboard")

resumen
