mcp <- function(theta,l,a=3.7) {
  theta <- abs(theta)
  return((theta < a*l)*(l*theta - theta^2/(2*a)) + (theta >= a*l)*(1/2)*a*l^2)
}
gLasso <- function(beta,lambda) {
  return(lambda*sqrt(sum(beta^2)))
}
gBridge <- function(beta,lambda) {
  return(lambda*sqrt(sum(abs(beta))))
}
gMCP <- function(beta,l,a=3) {
  K <- length(beta)
  return(mcp(sum(mcp(beta,l,a)),l,K*a*l/2))
}

res <- 31
beta1 <- beta2 <- seq(-4,4,len=res)
z <- matrix(NA,ncol=res,nrow=res)
lambda <- 1
for (i in 1:res) {
  for (j in 1:res) {
    beta <- c(beta1[i], beta2[j])
    z[i,j] <- gMCP(beta, lambda)
  }
}

png('../img/grpreg.png')
par(mai = c(0, 0, 0, 0), fig = c(0, 1, 0, 1), bg='transparent')
persp(z, theta=5, shade=.4, ltheta=0, lphi=0, phi=22, col="lightblue", box=F, zlim=c(0.25, 1.5))
dev.off()
system('mogrify -resize 200x ../img/grpreg.png')
