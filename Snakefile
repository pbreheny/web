from glob import glob

rule all:
    input:
        "_site/index.html"
    shell:
        """
        aws-auto-login
        deploy -r
        """

rule site:
    input:
        "research.md",
        "teaching.md",
        "people.html",
        "publications.md",
        "research.md",
        "assets/BrehenyCV.pdf",
        "_config.yml",
        "_data/people.yml",
        "_layouts/default.html",
        "_layouts/img-left.html",
        "_includes/header.html",
        "_includes/head.html",
        "_includes/menu.html",
        "_includes/person-card.html",
        sass_files = sorted(glob("_sass/*.scss"))
    output:
        "_site/index.html"
    shell:
        "jekyll build"

rule publications:
    input:
        "_publications/x.r",
        "_publications/pubs.md",
        "_publications/res.md",
        "_publications/cv.csv",
        "_publications/cv-extra.txt",
        "_publications/md-export.r"
    output:
        "publications.md",
        "research.md"
    shell:
        "Rscript _publications/x.r"
