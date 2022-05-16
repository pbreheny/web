library(data.table)
source("htmlExport.R")
source("render.R")

DT <- merge(fread("cv.csv"), fread("cv-extra.txt"), by='Identifier', all.x=TRUE)
render("pubs.html", "../publications.html", DT)
render("res.html", "../research.html", DT)
