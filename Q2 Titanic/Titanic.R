
#The Titanic dataset in the datasets package is a 4-dimensional
#table with summarized information on the fate of passengers
#on the Titanic according to social class, sex, age and survival

install.packages("arules")



library(ggplot2)
library(plyr)
library(ROCR)
library(arules)

load("titanic.raw.rdata")


summary(titanic.raw)


library(arules)

rules.all## number of rules discovered

inspect(rules.all) ## %>% inspect() ## print all rules

rules.all <- apriori(titanic.raw)

dim(titanic.raw)

rules.all <- apriori(titanic.raw) ## rules.all <- titanic.raw %>% apriori() ## run the APRIORI algorithm

inspect(rules.all) ## rules.all %>% inspect() ## print all rules

rules <- apriori(titanic.raw,
                parameter=list(minlen=2, supp=0.005, conf=0.8),  
                appearance = list(default = "lhs", rhs=c("Survived=Yes","Survived=No")))

inspect(rules.all)

rules.sorted <- sort(rules, by="lift")


inspect(rules.all)

require(arulesViz)



plot(rules.sorted, method="graph", control=list(nodeCol="red", edgeCol="blue"))

plot(rules.sorted)
plot(rules.sorted, method="grouped")
plot(rules.sorted, method = "paracoord", control = list(reorder = TRUE))
plot(rules.sorted, method = "graph", control = list(type = "items"))
