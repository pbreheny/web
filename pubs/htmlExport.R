htmlExport <- function(id, style=1) {
  if (style==2) {
    val <- htmlExport2(id)
    return(val)
  }
  x <- subset(D1, Identifier==id)
  if (!nrow(x)) {
    writeLines(paste("ID not found:", id), con="/dev/tty")
    stop()
  }
  y <- subset(D2, Identifier==id)
  if (nrow(y)==0) y[1,] <- NA
  val <- character(4)
  val[1] <- paste0("<h3>", titleMod(x$Title), "</h3>")
  val[2] <- paste0("<h5>", authorMod(x$Author), "</h5>")
  if (x$BibliographyType==13) {
    val[3] <- paste0("<h6>Technical report ", numberMod(x$Number), ", ", journalMod(x$Institution), ".  ")
  } else if (x$Journal=="") {
    val[3] <- paste0("<h6>In submission.  ")
  } else {
    val[3] <- paste0("<h6><i>", journalMod(x$Journal), "</i>")
    if (!is.na(x$Volume)) {
      val[3] <- paste0(val[3], ", <b>", x$Volume, "</b>: ", pagesMod(x$Pages), ".  ")
    } else {
      val[3] <- paste0(val[3], ", to appear.  ")
    }
  }

  if (x$URL!="") val[3] <- paste0(val[3], "[<a href=\"", x$URL, "\">link</a>] ")
  if (!is.na(y$pdf) & y$pdf!="") val[3] <- paste0(val[3], "[<a href=\"", y$pdf, "\">pdf</a>] ")
  if (!is.na(y$R) & y$R!="") val[3] <- paste0(val[3], "[<a href=\"", y$R, "\">R package</a>] ")
  if (!is.na(y$Website) & y$Website!="") val[3] <- paste0(val[3], "[<a href=\"", y$Website, "\">Homepage</a>] ")
  if (!is.na(y$Reproduce) & y$Reproduce!="") val[3] <- paste0(val[3], "[<a href=\"", y$Reproduce, "\">Reproduce</a>] ")
  if (!is.na(y$App) & y$App!="") val[3] <- paste0(val[3], "[<a href=\"", y$App, "\">App</a>] ")
  
  if (!is.na(y$featText) & y$featText!="") {
    val[3] <- paste0(val[3], "<br>", y$featText)
  }
  if (!is.na(y$featLink) & y$featLink!="") {
    val[3] <- paste0(val[3], "[<a href=\"", y$featLink, "\">link</a>] ")
  }

  val[3] <- paste0(val[3], "</h6>")
  val
}
htmlExport2 <- function(id) {
  x <- subset(D1, Identifier==id)
  if (!nrow(x)) {
    writeLines(paste("ID not found:", id), con="/dev/tty")
    stop()
  }
  y <- subset(D2, Identifier==id)
  if (nrow(y)==0) y[1,] <- NA

  val <- paste0("<li>", authorMod(x$Author), " (", x$Year, ").  ", titleMod(x$Title))
  z <- titleMod(x$Title)
  if (substr(z, nchar(z), nchar(z))!="?") val <- paste0(val, ".")
  val <- paste0(val, "  <i>", journalMod(x$Journal), "</i>")
  if (!is.na(x$Volume)) {
    val <- paste0(val, ", <b>", x$Volume, "</b>: ", pagesMod(x$Pages), ".  ")
  } else if (x$Journal!="") {
    val <- paste0(val, ".  ")
  }
  if (x$URL!="") val <- paste0(val, "[<a href=\"", x$URL, "\">link</a>] ")
  if (!is.na(y$pdf) & y$pdf!="") val <- paste0(val, "[<a href=\"", y$pdf, "\">pdf</a>] ")
  if (!is.na(y$R) & y$R!="") val <- paste0(val, "[<a href=\"", y$R, "\">R package</a>] ")
  if (!is.na(y$Website) & y$Website!="") val <- paste0(val, "[<a href=\"", y$Website, "\">Homepage</a>] ")
  if (!is.na(y$Reproduce) & y$Reproduce!="") val <- paste0(val, "[<a href=\"", y$Reproduce, "\">Reproduce</a>] ")
  if (!is.na(y$App) & y$App!="") val <- paste0(val, "[<a href=\"", y$App, "\">App</a>] ")
  val <- paste0(val, "</li>")
  val
}
authorMod <- function(x) {
  x <- gsub(" &", ";", x)
  x <- strsplit(x, "; ")[[1]]
  s <- stringr::str_split(x, ', ', simplify=TRUE)
  Last <- s[,1]
  First <- s[,2]
  FirstList <- strsplit(First, " ")
  for (i in 1:length(First)) {
    if (length(FirstList[[i]]) >= 1) {
      for (j in 1:length(FirstList[[i]])) {
        FirstList[[i]][j] <- gsub("\\b(.).*", "\\1", FirstList[[i]][j])
      }
      First[i] <- paste(FirstList[[i]], collapse="")
    } else {
      First[i] <- ""
    }
  }
  n <- length(Last)
  if (n > 1) {
    a <- paste(paste(Last[-n], First[-n]), collapse=", ")
    b <- paste(Last[n], First[n])
    val <- paste(a, b, sep=" and ")
  } else {
    val <- paste0(Last, " ", First, ".")
  }
  gsub(' ,', ',', val)  # To correct for rare occurrences such as missing first names
}
titleMod <- function(x) {
  val <- gsub("\\\\emph([^,]*),", "<i>\\1</i>,", x)
  val <- gsub("\\\\textit([^,]*)$", "<i>\\1</i>", val)
  val <- gsub("\\\\emphIn Vivo", "<i>In Vivo</i>", val)
  val <- gsub("\\\\texttt([A-Za-z_0-9]*)", "<tt>\\1</tt>", val)
  val <- gsub("\\$([^_]*)_([^\\$]*)\\$", "\\1<sub>\\2</sub>", val)
  val <- gsub("\\$([^\\$]*)\\$", "<i>\\1</i>", val)
  val <- gsub("---", "&mdash;", val)
  val <- gsub("--", "&ndash;", val)
  val
}
pagesMod <- function(x) {
  gsub("--", "&ndash;", x)
}
journalMod <- function(x) {
  val <- gsub("\\\\&", "&amp;", x)
  val <- gsub("\\{R\\}", "R", val)
  val
}
numberMod <- function(x) {
  gsub("\\\\#", "#", x)
}
