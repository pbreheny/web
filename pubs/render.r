render <- function(infile, outfile, DT) {
  content <- readLines(infile)
  if (content[length(content)]!="") {
    writeLines(paste(infile, "must end with blank line"), con="/dev/tty")
    stop()
  }
  repeat {
    needsReplaced <- grep("^_", content)
    if (length(needsReplaced)==0) break
    i <- needsReplaced[1]
    ID <- gsub("_", "", content[i])
    pre <- content[1:(i-1)]
    post <- content[(i+1):length(content)]
    if (!(ID %in% DT$Identifier)) stop(paste0('ID not found: ', ID), call.=FALSE)
    content <- c(pre, htmlExport(DT[ID]), post)
  }
  writeLines(content, con=outfile)
}
