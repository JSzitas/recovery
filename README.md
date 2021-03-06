
<!-- README.md is generated from README.Rmd. Please edit that file -->

# recovery

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-green.svg)](https://www.tidyverse.org/lifecycle/#stable)
[![Travis build
status](https://travis-ci.org/JSzitas/recovery.svg?branch=master)](https://travis-ci.org/JSzitas/recovery)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/JSzitas/recovery?branch=master&svg=true)](https://ci.appveyor.com/project/JSzitas/recovery)
[![Codecov test
coverage](https://codecov.io/gh/JSzitas/recovery/branch/master/graph/badge.svg)](https://codecov.io/gh/JSzitas/recovery?branch=master)
[![CRAN
status](https://www.r-pkg.org/badges/version/recovery)](https://CRAN.R-project.org/package=recovery)
[![R build
status](https://github.com/JSzitas/recovery/workflows/R-CMD-check/badge.svg)](https://github.com/JSzitas/recovery/actions)
<!-- badges: end -->

## About

**recovery** is the simplest debugging tool you could wish for. It
supports debugging the **dumb** way - running functions line by line,
collecting objects, and returning the line which finally fails. This is
somewhat inefficient, and is not advised for debugging computationally
intensive functions. Nonetheless, for computationally unintensive tasks
(or tasks whose computational requirements can be made reasonably small)
it tends to return better messages than most other debugging tools. It
will return, particularly, the line which caused the code to crash, the
objects which were in scope at **that** time, and their values.

**recovery** is dependency free and written entirely in **R**. What few
other packages are used are used exclusively for testing and package
coverage - you do not need these to make use of the package.

## Examples

To start of, imagine we have a simple toy example. We are given the
following function, which sometimes crashes:

``` r
some_function <- function( x = 2, y = 3, z = 2 )
{
  x <- x+y
  y <- y-z 
  z <- y+x+y
  return(z)
}
```

Now, this function seems readily simple. Now, if you supply the correct
numeric arguments, the function will work. However, in absence of type
checking, we can easily run into trouble. We might sometimes come across
situations where things are not as they seem. Consider the following
simple case:

``` r

what_am_i <- factor(c(1,2,3,4,5))
# this looks like an integer, right? 
what_am_i[5]
#> [1] 5
#> Levels: 1 2 3 4 5

# so what happens when a user manages to call our function? 
some_function( x = 2, y = 3, z = what_am_i[5])
#> Warning in Ops.factor(y, z): '-' not meaningful for factors
#> [1] NA
# that seems a bit unclear
```

We get a message about factors… but we might not notice that we are
passing in a factor. Indeed, typically this is entirely unintentional,
and happens due to type coercion, somewhere within a different function.
Sometimes this leads to errors, which is usually better.

**recovery** to the rescue. Instead of writing your own return
statements (or print statements) as is customary during debugging,
**recovery** will allow you to do approach this problem in a manner more
befitting a programmer - lazily\!

**recovery** supports the following functions debugging functions:
*recover - recover everything that lived inside a function environment
when it crashed, and approximately the line **WHERE** it crashed. This
still has trouble going inside certain scope blocks, but thanks to a
return of the environment allows one to replicate the error, or
repeatedly call recover. *trace\_failures \*recover\_types

We further intend to eventually support nested recovery - if a function
within a function failed, figuring out **why** this happened should just
be another call to **recover**.

Document further (**TODO**)( in the meantime see documented examples
within the package).

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("JSzitas/recovery")
```
