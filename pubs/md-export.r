md_export <- function(x) {
  if (x$BibliographyType==13) {
    info <- str_glue("Technical report {numberMod(x$Number)}, {journalMod(x$Institution)}. ")
  } else if (x$Journal=="") {
    info <- "In submission. "
  } else {
    if (!is.na(x$Volume)) {
      vol <- str_glue(', **{x$Volume}**: {pagesMod(x$Pages)}. ')
    } else {
      vol <- ', to appear. '
    }
    info <- str_glue('*{journalMod(x$Journal)}*, {vol}')
  }

  if (x$URL!="") info <- info + str_glue('<a href="{x$URL}"> <span class="journal">Journal</span></a>')
  if (!is.na(x$pdf) & x$pdf!="") info <- info + str_glue('<a href="{x$pdf}"> <span class="pdf">PDF</span></a>')
  if (!is.na(x$R) & x$R!="") info <- info + str_glue('<a href="{x$R}"> <span class="R">R</span></a>')
  if (!is.na(x$Website) & x$Website!="") info <- info + str_glue('<a href="{x$Website}"> <span class="website">Website</span></a>')
  if (!is.na(x$Reproduce) & x$Reproduce!="") info <- info + str_glue('<a href="{x$Reproduce}"> <span class="reproduce">Reproduce</span></a>')
  if (!is.na(x$App) & x$App!="") info <- info + str_glue('<a href="{x$App}"> <span class="app">App</span></a>')

  if (!is.na(x$featText) & x$featText!="") info <- info + str_glue('\n{x$featText} ')
  if (!is.na(x$featLink) & x$featLink!="") info <- info + str_glue('<a href="{x$URL}"> <span class="journal">Link</span></a>')

  str_glue('
* ##### {titleMod(x$Title)}
  ###### {authorMod(x$Author)}
  ###### {info}')
}
htmlExport2 <- function(x) {
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
  if (!is.na(x$pdf) & x$pdf!="") val <- paste0(val, "[<a href=\"", x$pdf, "\">pdf</a>] ")
  if (!is.na(x$R) & x$R!="") val <- paste0(val, "[<a href=\"", x$R, "\">R package</a>] ")
  if (!is.na(x$Website) & x$Website!="") val <- paste0(val, "[<a href=\"", x$Website, "\">Homepage</a>] ")
  if (!is.na(x$Reproduce) & x$Reproduce!="") val <- paste0(val, "[<a href=\"", x$Reproduce, "\">Reproduce</a>] ")
  if (!is.na(x$App) & x$App!="") val <- paste0(val, "[<a href=\"", x$App, "\">App</a>] ")
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
