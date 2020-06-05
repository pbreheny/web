# Note: Must have D1, D2 in global env
render <- function(infile, outfile) {
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
    content <- c(pre, htmlExport(ID), post)
  }
  writeLines(content, con=outfile)
}
