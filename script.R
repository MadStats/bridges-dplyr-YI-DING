library(plyr)
library(choroplethr)
library(dplyr)
library(readr)
library(data.table)
library(ggplot2)
library(choroplethrMaps)
library(GGally)
data("state.regions")
state.regions

states= read_csv("http://pages.stat.wisc.edu/~karlrohe/classes/data/stateAbv.txt")
states=states[-(1:12),]
states[51,] = c("WashDC", "DC")
states[52,] = c("Puerto Rico", "PR")

dest= rep("", 52)
for(i in 1:52) dest[i]=paste("https://www.fhwa.dot.gov/bridge/nbi/2016/delimited/", states[i,2],"16.txt", sep = "") 
x16 = ldply(dest,read_csv) 

save(x16,file="allstates16.RData")

attach(x16)

#cbind(TOTAL_IMP_COST_096,ADT_029,YEAR_BUILT_027,OPERATING_RATING_064,INVENTORY_RATING_066)%>%
#  as.data.frame()%>%ggpairs()

ggplot(x16)+geom_density(aes(OPERATING_RATING_064))+ggtitle("Operating Rating Density Plot")
ggplot(x16)+geom_density(aes(INVENTORY_RATING_066))+ggtitle("Inventory Rating Density Plot")
ggplot(x16)+geom_point(aes(x=OPERATING_RATING_064,y=INVENTORY_RATING_066))
