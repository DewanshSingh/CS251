setwd("/Users/dewansh/COURSE/cs251/6")
q=read.csv("result1.csv")
library(ggplot2)
d <- data.frame(q)
p = ggplot(data = d, aes(color=testcase,x = branchline, y = bias)) + geom_line() + theme_minimal()
p
