source("htmlExport.R")
D1 <- read.csv("cv.csv", stringsAsFactors=FALSE)
D2 <- read.delim("cv-extra.txt", stringsAsFactors=FALSE)

pubs <- readLines("pubs.html")
if (pubs[length(pubs)]!="") {
  writeLines(paste("pubs.html must end with blank line"), con="/dev/tty")
  stop()
}
repeat {
  needsReplaced <- grep("^_", pubs)
  if (length(needsReplaced)==0) break
  i <- needsReplaced[1]
  ID <- gsub("_", "", pubs[i])
  pre <- pubs[1:(i-1)]
  post <- pubs[(i+1):length(pubs)]
  pubs <- c(pre, htmlExport(ID), post)
}
writeLines(pubs, con="../publications.html")

res <- readLines("res.html")
if (res[length(res)]!="") {
  writeLines(paste("res.html must end with blank line"), con="/dev/tty")
  stop()
}
repeat {
  needsReplaced <- grep("^_", res)
  if (length(needsReplaced)==0) break
  i <- needsReplaced[1]
  ID <- gsub("_", "", res[i])
  pre <- res[1:(i-1)]
  post <- res[(i+1):length(res)]
  res <- c(pre, htmlExport2(ID), post)
}
writeLines(res, con="../research.html")
