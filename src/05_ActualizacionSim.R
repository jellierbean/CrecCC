### Simulaciones

rm(list = ls(all = TRUE))

source("./src/03_estimaciones_clean.R")
source("./src/04_Cuadro_Resumen_Estats.R")

load("./munge/yn.RData")
load("./munge/pob.RData")


str(yn)

pob <- reshape(pob,v.names="pob",timevar="year",
        idvar=c("Countries","iso3c"),direction="wide")

tail(pob)

pob <- subset(pob, iso3c %in% unique(as.character(pov$iso3c)))

pobtot <- apply(X=pob[,3:46],MARGIN=2,FUN=sum)

yn.2012 <- yn[yn$year==2012,c("iso3c","yn")]
yn.1990 <- yn[yn$year==1990,c("iso3c","yn")]

pob.2012 <- pob[,c("iso3c","pob.2012")]


crec.yn9012 <- as.data.frame(yn.2012[,"iso3c"])
names(crec.yn9012) <- "iso3c"

crec.yn9012$crec <- (((yn.2012$yn/yn.1990$yn)^(1/(2012-1990)))-1)


crec.yn9012

pov.2012 <- resumen[,c("iso3c","maxyear","hcindfin","hcpobfin",
                       "pgindfin","pgpobfin","ginifin","ynfin","pobfin","giniin","minyear")]

names(yn.2012) <- c("iso3c","yn.2012")


### Actualización a 2012

pov.2012 <- merge(pov.2012,pob.2012,by=c("iso3c")) 
pov.2012 <- merge(pov.2012,yn.2012,by=c("iso3c")) 

pov.2012$crecyn.fin2012 <- with(pov.2012,(((yn.2012/ynfin)^(1/(2012-maxyear)))-1))
pov.2012$crecgini <- with(pov.2012,(((ginifin/giniin)^(1/(maxyear-minyear)))-1))

## Elasticidades ----

elast <- list()
for(i in 1:length(dep)){elast[[i]] <-  estim[[i]]$coef}
elast


pov.2012$hcind_2012 <- with(pov.2012,hcindfin*((1+(elast[[1]][2]*crecyn.fin2012+
                                                     elast[[1]][3]*crecgini))^(2012-maxyear)))

pov.2012$pgind_2012 <- with(pov.2012,pgindfin*((1+(elast[[2]][2]*crecyn.fin2012+
                                                             elast[[2]][3]*crecgini))^(2012-maxyear)))

pov.2012$hcpob_2012 <- with(pov.2012,hcpobfin*((1+(elast[[4]][2]*crecyn.fin2012+
                                                     elast[[4]][3]*crecgini))^(2012-maxyear)))

pov.2012$pgpob_2012 <- with(pov.2012,pgpobfin*((1+(elast[[5]][2]*crecyn.fin2012+
                                                     elast[[5]][3]*crecgini))^(2012-maxyear)))

#### Falta PGS ----

#### Población por debajo de 
####la Línea de la pobreza e indigencia 2012 ----

pov.2012$nhcpob.2012 <- with(pov.2012,pob.2012*hcpob_2012/100)

pov.2012$nhcind.2012 <- with(pov.2012,pob.2012*hcind_2012/100)


pov.2012[,c("iso3c","nhcind.2012","nhcpob.2012")]

sum(pov.2012$nhcind.2012)
sum(pov.2012$nhcpob.2012)


### Simulación 2025, 2050 ----

## Crecimiento de PIB con impacto del 1%, 5% y 10% ====

# BAU ----


sim <- merge(pov.2012[,c("iso3c","hcind_2012","hcpob_2012")],
             crec.yn9012,by="iso3c")


sim$hcind_2025 <- with(sim,hcind_2012*((1+(elast[[1]][2]*crec))^(2025-2012)))
sim$hcind_2050 <- with(sim,hcind_2012*((1+(elast[[1]][2]*crec))^(2050-2012)))

sim$hcpob_2025 <- with(sim,hcpob_2012*((1+(elast[[2]][2]*crec))^(2025-2012)))
sim$hcpob_2050 <- with(sim,hcpob_2012*((1+(elast[[2]][2]*crec))^(2050-2012)))

sim$yn_2025 <- with(sim,100*(1+crec)^(2025-2012))
sim$yn_2050 <- with(sim,100*(1+crec)^(2050-2012))

### Crecimiento con impactos ----

sim$crec_1_2025 <- with(sim,((yn_2025*0.99/100)^(1/(2025-2012)))-1)
sim$crec_2_2025 <- with(sim,((yn_2025*0.98/100)^(1/(2025-2012)))-1)
sim$crec_5_2025 <- with(sim,((yn_2025*0.95/100)^(1/(2025-2012)))-1)
sim$crec_10_2025 <- with(sim,((yn_2025*0.90/100)^(1/(2025-2012)))-1)

sim$crec_1_2050 <- with(sim,((yn_2050*0.99/100)^(1/(2050-2012)))-1)
sim$crec_2_2050 <- with(sim,((yn_2050*0.98/100)^(1/(2050-2012)))-1)
sim$crec_5_2050 <- with(sim,((yn_2050*0.95/100)^(1/(2050-2012)))-1)
sim$crec_10_2050 <- with(sim,((yn_2050*0.90/100)^(1/(2050-2012)))-1)

var.sim_hcind_2025 <- c("hcind_1_2025","hcind_2_2025","hcind_5_2025","hcind_10_2025")
             
var.sim_hcpob_2025 <- c("hcpob_1_2025","hcpob_2_2025","hcpob_5_2025","hcpob_10_2025")

var.sim_hcind_2050 <- c("hcind_1_2050","hcind_2_2050","hcind_5_2050","hcind_10_2050")

var.sim_hcpob_2050 <- c("hcpob_1_2050","hcpob_2_2050","hcpob_5_2050","hcpob_10_2050")

crec.sim_2025 <- c("crec_1_2025","crec_2_2025","crec_5_2025","crec_10_2025")
   
crec.sim_2050 <- c("crec_1_2050","crec_2_2050","crec_5_2050","crec_10_2050")

for(i in 1:length(var.sim_hcind_2050)){
  
  
  sim[,var.sim_hcind_2025[i]]<- 

                              with(sim,hcind_2012*((1+(elast[[1]][2]*sim[,crec.sim_2025[i]]))^(2025-2012)))

  sim[,var.sim_hcind_2050[i]]<-
                              
                              with(sim,hcind_2012*((1+(elast[[1]][2]*sim[,crec.sim_2050[i]]))^(2050-2012)))
  
  sim[,var.sim_hcpob_2025[i]]<- 
    
    with(sim,hcpob_2012*((1+(elast[[4]][2]*sim[,crec.sim_2025[i]]))^(2025-2012)))
  
  sim[,var.sim_hcpob_2050[i]]<-
    
    with(sim,hcpob_2012*((1+(elast[[4]][2]*sim[,crec.sim_2050[i]]))^(2050-2012)))

}

pob_sim <- sim$iso3c

pob.var.sim <- c("ind_bau_2025","ind_1_2025","ind_2_2025","ind_5_2025","ind_10_2025",
                 "ind_bau_2050","ind_1_2050","ind_2_2050","ind_5_2050","ind_10_2050",
                 "pobr_bau_2025","pobr_1_2025","pobr_2_2025","pobr_5_2025","pobr_10_2025",
                 "pobr_bau_2050","pobr_1_2050","pobr_2_2050","pobr_5_2050","pobr_10_2050")

pob_sim <- merge(pob_sim,length(grep("hc|2025",names(sim))))

pat_2025 <- intersect(grep(c("hc"),names(sim)),grep(c("2025"),names(sim)))
pat_2050 <- intersect(grep(c("hc"),names(sim)),grep(c("2050"),names(sim)))

for(i in 1:length())


#### Resultados -----

res <- sim[,grep("h|3",names(sim))]

res <- merge(res,pob[,c("iso3c","pob.2012","pob.2025","pob.2050")])

n_hc_2025 <- c("nind_1_2025","nind_2_2025","nind_5_2025","nind_10_2025",
               "npob_1_2025","npob_2_2025","npob_5_2025","npob_10_2025")

n_2025 <- pov.2012[,c("iso3c","pob.2012","nhcpob.2012","nhcind.2012")]

for(i in 1:8){n_2025[,n_hc_2025[i]]<-with(res, res[,c(var.sim_hcind_2025,var.sim_hcpob_2025)[i]]*pob.2025/100)} 


