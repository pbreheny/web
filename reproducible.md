---
layout: default
title: Minimal reproducible examples
---

### Minimal reproducible examples

When contacting someone (this applies to anyone: a professor, colleague, the author of a package, etc.) about a coding question/error/problem, it is important to provide a minimal reproducible example of the problem.  This means that the person reading your question can reproduce what you are seeing.  Without the ability to reproduce the context in which the error arises, it is typically impossible to identify what is causing the problem.

In fact, I'll go so far as to posit the following (not quite a "law", but in my experience true roughly 90% of the time):

> **Breheny's Law:** When someone sends you an isolated bit of code that produces an error and asks what's wrong, you can be certain that the mistake lies in code they didn't send you.

A minimal reproducible example consists of two basic components:

* **Data:** A dataset for which the error/problem arises.  This may be actual data or simulated data.  If simulated, you may need to set the seed via set.seed() if the error appears only intermittently.
* **Code:** Run-able lines of code.  Someone should be able to start up a fresh instance of R/SAS with nothing loaded or defined yet, run your code exactly as it is supplied with no changes, and get the exact same error that you are seeing.  You can (and definitely should) test this before asking your question.  Note that if the code requires certain packages to be loaded, variables to be defined, etc., all of that should be included in the code.

To check whether your R example is reproducible, as well as easily share it on GitHub, check out the wonderful [reprex](https://github.com/tidyverse/reprex) package.
