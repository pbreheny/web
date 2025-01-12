library(data.table)
source("html-export.r")
source("render.r")

dat <- merge(fread("cv.csv"), fread("cv-extra.txt"), by='Identifier', all.x=TRUE)
render("pubs.html", "../publications.html", dat)
render("res.md", "../research.md", dat)
