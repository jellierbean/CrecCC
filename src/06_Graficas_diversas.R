rm(list = ls(all = TRUE))

load("./munge/y.RData")
load("./munge/pob.RData")

str(y)

y <- merge(y,pob[,c("iso3c","year","pob")],by=c("iso3c","year"))

y.la <- aggregate.data.frame(y[,c("y","pob")],list(y$year),sum)

names(y.la) <- c("year","y","pob")

y.la$yn <- with(y.la,y*1000/pob)

yn.proy <- data.frame(year=2013:2050)

yn.proy.names <- c("Base","CC_2","CC_5","CC_10")

for(i in 2014:2050){yn.proy[yn.proy$year==2013,"Base"]<-tail(y.la$yn,1)*1.026
                    
                    yn.proy[yn.proy$year==i,"Base"] <- yn.proy[yn.proy$year==i-1,"Base"]*1.026}

impactos <- c(0.98,0.95,0.9)


for(i in 1:3){ 
    yn.proy[,yn.proy.names[i+1]]<-yn.proy$Base*impactos[i]}



plot(c(y.la$year,yn.proy$year),c(y.la$yn,rep(NA,2050-2012)),type="l",
     lwd=3,col="darkblue",ylim=c(min(y.la$yn),max(yn.proy$Base)))
lines(yn.proy$year,yn.proy$Base,lty = 1, col = 2)
lines(yn.proy$year,yn.proy[,"CC_2"], col= 3)
lines(yn.proy$year,yn.proy[,"CC_5"], col= 4)
lines(yn.proy$year,yn.proy[,"CC_10"], col= 5)
grid()

write.table(y.la,"clipboard")
