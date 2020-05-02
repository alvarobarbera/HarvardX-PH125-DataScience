# Two by two matrix

tab <- matrix(c(3,1,1,3),2,2)
rownames(tab) <- c("Poured before","Poured after")
colnames(tab) <- c("Guessed before","Guessed after")
tab

fisher.test(tab,alternative = "greater")$p.value
