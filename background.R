m <- 100
x <- rexp(m^2, 1)

X1 <- matrix(x, m, m)
X2 <- X1[,m:1]
X3 <- X1[m:1,]
X4 <- X1[m:1,m:1]
Y <- rbind(cbind(X2, X1), cbind(X4, X3))

png("css/bg.png", m, m)
par(mar=c(0,0,0,0))
image(Y, col=gray.colors(100, 0, 0.25), bty="n")
dev.off()
