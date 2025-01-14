library(data.table)
library(stringr)
source("html-export.r")
source("md-export.r")
source("render.r")

dat <- merge(fread("cv.csv"), fread("cv-extra.txt"), by='Identifier', all.x=TRUE)
render("pubs.md", "../publications.md", dat)
render("res.md", "../research.md", dat)
