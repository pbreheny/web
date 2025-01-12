render <- function(infile, outfile, DT) {
  content <- readLines(infile)
  if (content[length(content)] != "") {
    writeLines(paste(infile, "must end with blank line"), con="/dev/tty")
    stop()
  }
  repeat {
    needsReplaced <- grep("^(\\* )?_", content)
    if (length(needsReplaced)==0) break
    i <- needsReplaced[1]
    id <- gsub("\\* _", "", content[i])
    id <- gsub("_", "", id)
    pre <- content[1:(i-1)]
    post <- content[(i+1):length(content)]
    if (!(id %in% DT$Identifier)) stop(paste0('ID not found: ', id), call.=FALSE)
    # content <- c(pre, htmlExport(DT[id]), post)
    browser()
    content <- c(pre, md_export(DT[id]), post)
  }
  writeLines(content, con=outfile)
}
