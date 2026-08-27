render <- function(infile, outfile, dat) {
  content <- c(readLines(infile), "")
  repeat {
    needsReplaced <- grep("^(\\* )?_", content)
    if (length(needsReplaced) == 0) {
      break
    }
    i <- needsReplaced[1]
    id <- gsub("\\* _", "", content[i])
    id <- gsub("_", "", id)
    pre <- content[1:(i - 1)]
    post <- content[(i + 1):length(content)]
    if (!(id %in% dat$Identifier)) {
      stop(paste0("ID not found: ", id), call. = FALSE)
    }
    content <- c(pre, md_export(dat[id]), post)
  }
  writeLines(content, con = outfile)
}
