
#The Titanic dataset in the datasets package is a 4-dimensional
#table with summarized information on the fate of passengers
#on the Titanic according to social class, sex, age and survival

load("titanic.raw.rdata")
titanic_r <- titanic.raw # read dataset 
titanic_r

table(titanic_r$Age,titanic_r$Survived)

##        
##           No  Yes
##   Adult 1438  654
##   Child   52   57

summary(titanic_r)

## Class Sex Age Survived
## 1st :325 Female: 470 Adult:2092 No :1490
## 2nd :285 Male :1731 Child: 109 Yes: 711
## 3rd :706
## Crew:885

#----------------------
#Function apriori()

#Mine frequent itemsets, association rules or association hyperedges
#using the Apriori algorithm. The Apriori algorithm employs
#level-wise search for frequent itemsets

#Default settings:
#I minimum support: supp=0.1
#I minimum confidence: conf=0.8
#I maximum length of rules: maxlen=10

#------------------------

install.packages("arules") # install packages
install.packages("ggplot2")
install.packages("plyr")
install.packages("ROCR")
install.packages("arulesViz")



library(arules)
rules.all <- apriori(titanic.raw)


inspect(rules.all)
## lhs rhs support confidence ...
## 1 {} => {Age=Adult} 0.9504771 0.9504771 1.0...
## 2 {Class=2nd} => {Age=Adult} 0.1185825 0.9157895 0.9...
## 3 {Class=1st} => {Age=Adult} 0.1449341 0.9815385 1.0...
## 4 {Sex=Female} => {Age=Adult} 0.1930940 0.9042553 0.9...
## 5 {Class=3rd} => {Age=Adult} 0.2848705 0.8881020 0.9...
## 6 {Survived=Yes} => {Age=Adult} 0.2971377 0.9198312 0.9...
## 7 {Class=Crew} => {Sex=Male} 0.3916402 0.9740113 1.2...
## 8 {Class=Crew} => {Age=Adult} 0.4020900 1.0000000 1.0...
## 9 {Survived=No} => {Sex=Male} 0.6197183 0.9154362 1.1...
## 10 {Survived=No} => {Age=Adult} 0.6533394 0.9651007 1.0...
## 11 {Sex=Male} => {Age=Adult} 0.7573830 0.9630272 1.0...
## 12 {Sex=Female, ...
## Survived=Yes} => {Age=Adult} 0.1435711 0.9186047 0.9...
## 13 {Class=3rd, ...
## Sex=Male} => {Survived=No} 0.1917310 0.8274510 1.2...
## 14 {Class=3rd, ...
## Survived=No} => {Age=Adult} 0.2162653 0.9015152 0.9...
## 15 {Class=3rd, ...
## Sex=Male} => {Age=Adult} 0.2099046 0.9058824 0.9...
## 16 {Sex=Male, ...
## Survived=Yes} => {Age=Adult} 0.1535666 0.9209809 0.9..



# rules with rhs containing "Survived" only
rules <- apriori(titanic.raw,
                 control = list(verbose=F),
                 parameter = list(minlen=3, supp=0.005, conf=0.9),
                 appearance = list(rhs=c("Survived=No",
                                         "Survived=Yes"),
                                   default="lhs"))
## keep three decimal places
quality(rules) <- round(quality(rules), digits=6)
rules.sorted <- sort(rules, by="lift")
inspect(rules.sorted)

## lhs rhs support confidence lift


#--------------------------------------


library(arulesViz)
plot(rules.sorted)

plot(rules.sorted, method = "grouped")


plot(rules.sorted, method = "graph")

plot(rules.sorted, method = "paracoord", control = list(reorder = TRUE))




plot(rules.sorted, method = "graph", control = list(type = "items"))



#ref : Association Rule Mining with R∗ 
#https://www.webpages.uidaho.edu/~stevel/517/RDM-slides-association-rule-mining-with-r.pdf