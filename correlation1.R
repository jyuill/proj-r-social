## Initial correlation analysis

library(Hmisc)

F.fbcor <- read_csv('data-input/F-fb.csv')
F.fbcor <- F.fbcor[,c(2:26)]
F.fbcorsub1 <- F.fbcor[,c(1,3,4,5,6,7,8)]
F.fbcorm <- rcorr(as.matrix(F.fbcorsub1))
F.fbcorm

F.fbcorsub2 <- F.fbcor[,c(3,7,8,9)]
F.fbcorm2 <- rcorr(as.matrix(F.fbcorsub2))
F.fbcorm2
