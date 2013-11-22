# Funciones

s.diff <- function(id,year,var){ 
  
  y <- rep(NA,length(var))
  for(i in 2:length(var)){ifelse(id[i]==id[i-1],
                                 
                                 ifelse(var[i-1]==0,
                                        y[i] <-(((var[i]/0.1)^(1/(year[i]-year[i-1])))-1)*100,
                                        y[i] <-(((var[i]/var[i-1])^(1/(year[i]-year[i-1])))-1)*100),
                                 y[i] <- NA)}
  return(y)
}


# Diferencias v2 -----

s.diffv2 <- function(id,year,var){ 
  
  y <- rep(NA,length(var))
  for(i in 2:length(var)){ifelse(id[i]==id[i-1],
                                 y[i] <-    ((1/(year[i]-year[i-1]))*((var[i]-var[i-1])/((var[i]+var[i-1])/2)))*100,
                                 y[i] <- NA)}
  return(y)
}

#Rezago ----

s.lag <- function(id,year,var){ 
  
  y <- rep(NA,length(var))
  for(i in 2:length(var)){ifelse(id[i]==id[i-1],
                                 y[i] <-var[i-1],
                                 y[i] <- NA)}
  return(y)
}
