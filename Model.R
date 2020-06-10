
# Censored data model ###########################

sink("model.txt")
cat("
model {

# Likelihood: 
for (i in 1:n){
   isNotCensored[i] ~ dinterval(y[i] , censorLimitVec[i] )
   y[i] ~ dnorm(mu[i], tau)
   mu[i] <- alpha[site[i],type[i]]                  
}


# Level-2 of the model
for(i in 1:3){ # loop over sites
  for(j in 1:2){ # loop over water sample types
    alpha[i, j] ~ dnorm(mu.alpha,tau.alpha)
  }
}

mu.alpha ~ dnorm(0, 0.0001)
sigma.alpha ~ dunif(0,10)
sigma ~ dunif(0, 10)

# Derived quantities
tau.alpha <- pow(sigma.alpha,-2) # precision
tau <- pow(sigma,-2) # precision



} # end model
",fill = TRUE)
sink()

