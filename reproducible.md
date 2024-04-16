---
layout: default
title: Minimal reproducible examples
---

### Minimal reproducible examples

When contacting someone (this applies to anyone: a professor, colleague, the author of a package, etc.) about a coding question/error/problem, it is important to provide a minimal reproducible example of the problem. This means that the person reading your question can reproduce what you are seeing. Without the ability to reproduce the context in which the error arises, it is typically impossible to identify what is causing the problem. You may be sending code that is perfectly fine -- the problem is introduced by an earlier line -- and it is impossible for anyone to debug this (this, in fact, happens *constantly* in my experience).

A minimal reproducible example consists of two basic components:

* **Data:** A dataset for which the error/problem arises.  This may be actual data or simulated data.  If simulated, you may need to set the seed via set.seed() if the error appears only intermittently.
* **Code:** Executable lines of code.  Someone should be able to start up a fresh instance of R (or Python or whatever) with nothing loaded or defined yet, run your code exactly as it is supplied with no changes, and get the exact same error that you are seeing.  You can (and should!) test this before asking your question. Note that if the code requires certain packages to be loaded, variables to be defined, etc., all of that should be included in the code.

To check whether your R example is reproducible, as well as easily share it on GitHub, check out the wonderful [reprex](https://github.com/tidyverse/reprex) package.
