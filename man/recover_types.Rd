% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/recover_types.R
\name{recover_types}
\alias{recover_types}
\title{Recover the types of objects in scope when a function that dies.}
\usage{
recover_types(fun, args)
}
\arguments{
\item{fun}{A function to test. Please supply as either an unquoted name, or
as a character string.}

\item{args}{A list of optional function arguments to evaluate the function with.}
}
\value{
A list with the line caused the function to crash, and the list of types of
objects in scope when the crash happened. Alternatively a success message if the function ran successfully.
}
\description{
Allows error recovery with specific lines and functions.
}
\details{
This function exists due to difficulties in dealing with composed functions.
A composed function routinely returns an error message without listing the function
within that caused the error, leading to uninformative error messages. Rather
than try to rewrite everything that already exists (and works rather well), this
function allows you to evaluate everything that happened until the function crashed
and recover the types of objects in the environment when it crashed. This is a
less verbose and heavy version of recovery
}
\examples{

 dummy_fun <- function( x = 2,
                        y = "this_crashes",
                        z = 2 )
 {
 # these will run
 x = x + 2
 z = x + 3
 # this will crash due to y being type character
 x = y + z
 return(x)
 }

 recover_types(fun = dummy_fun, args = list(x = 5))
 # this also works with arguments unspecified
 recover_types(fun = dummy_fun)

}
