from glob import glob

rule all:
    input:
        "_site/index.html"

rule site:
    input:
        "research.md",
        "teaching.md",
        "students.md",
        "_config.yml",
        "publications.md",
        "_layouts/default.html",
        "js/switcher.js",
        "assets/BrehenyCV.pdf",
        "_includes/header.html",
        "_includes/head.html",
        "_includes/menu.html",
        sass_files = sorted(glob("_sass/*.scss"))
    output:
        "_site/index.html"
    shell:
        "jekyll build"

rule publications:
    input:
        "pubs/x.r",
        "pubs/pubs.md",
        "pubs/res.md",
        "pubs/cv.csv",
        "pubs/cv-extra.txt",
        "pubs/md-export.r"
    output:
        "publications.md",
        "research.md"
    shell:
        "Rscript pubs/x.r"
