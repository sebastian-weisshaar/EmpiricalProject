myts <- ts(new_variables$observation_date, start=c(1985, 2), end=c(2021, 1), frequency=12)
myts2=ts(new_variables, start=c(1985, 2), end=c(2021, 1), frequency=12)

## Estimate the confidence interval by looping through possible values of the NAIRU
CI=c()
for(x in seq(5,30,0.1)){
  mod.4=dynlm(inflation ~ L(inflation, c(1,6,12,18,24))+ L(hur - x, c(4,8,12)) +energy2 + working_population2 +jpn_usa +jp_china +jpn_australia, data = myts2)
  if(summary(mod.4)$coef[1,4]>0.05){
    CI=append(CI,x)
  }
}
cat(CI)
