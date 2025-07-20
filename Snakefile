from glob import glob

rule all:
    input:
        "_site/index.html"

rule publications:
    input:
        "pubs/x.r",
        "pubs/pubs.md",
        "pubs/res.md",
        "pubs/cv.csv",
        "pubs/cv-extra.txt"
    output:
        "publications.md",
        "research.md"
    shell:
        """
        Rscript pubs/x.r
        """

rule site:
    input:
        "research.md",
        "publications.md",
        "_layouts/default.html",
        "js/switcher.js",
        "pdf/BrehenyCV.pdf",
        sass_files = sorted(glob("_sass/*.scss"))
    output:
        "_site/index.html"
    shell:
        """
        jekyll build
        """

