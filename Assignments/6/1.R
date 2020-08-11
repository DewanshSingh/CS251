setwd("/Users/dewansh/COURSE/cs251/6")
q=read.csv("result1.csv")
library(ggplot2)
d <- data.frame(q)
p = ggplot(data = d, aes(fill=branchline,x = branchline, y = bias)) + geom_bar(stat='identity')+ facet_grid(~testcase, scale='free_x') +theme_minimal()
p
