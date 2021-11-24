
#The Titanic dataset in the datasets package is a 4-dimensional
#table with summarized information on the fate of passengers
#on the Titanic according to social class, sex, age and survival

install.packages("arulesViz")



library(ggplot2)
library(plyr)
library(ROCR)
library(arules)


data <- read.csv("basket.csv")
summary(data)
dim(data)

library(arules)
rules.all <- apriori(data)

rules.all## number of rules discovered

inspect(rules.all) ## %>% inspect() ## print all rules


rules <- apriori(data,
                 parameter=list(minlen=2, supp=0.04, conf=0.06),  
                 appearance = list(default = "lhs", rhs=c("Item=coffee","Item=bread","Item=tea","Item=cake","Item=pastry")))
rules
inspect(rules)

rules.sorted <- sort(rules, by="lift")

inspect(rules.all)

require(arulesViz)



plot(rules.sorted, method="graph", control=list(nodeCol="red", edgeCol="blue"))

plot(rules.sorted)
plot(rules.sorted, method="grouped")
plot(rules.sorted, method = "paracoord", control = list(reorder = TRUE))
plot(rules.sorted, method = "graph", control = list(type = "items"))