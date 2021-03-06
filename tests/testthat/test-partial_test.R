test_that("Partial function tests work", {

  dummy_fun <- function( x = 2, y = "death", z = 5 )
  {
    x <- x + 5
    z <- 12
    x <- y + 5
    x <- list("something")
    z <- "something_else"
    z <- "ensure_that_you_never_go_over_the_end"
    return(x)
  }

  object_comparison <- partial_test( dummy_fun,
                                     args = list(y = 2),
                                     eval_point = 8,
                                     compare_object = list("something") )
  expect_true(object_comparison)

  object_comparison_list <- partial_test( dummy_fun,
                                     args = list(y = 2),
                                     eval_point = 5,
                                     compare_object = list("something") )
  expect_true(object_comparison_list)

  object_comparison_string <- partial_test( dummy_fun,
                                     args = list(y = 2),
                                     eval_point = 6,
                                     compare_object = "something_else" )
  expect_true(object_comparison_string)

})

test_that( "Errors work as expected",{

  dummy_fun <- function( x = 2, y = "death", z = 5 )
  {
    x <- x + 5
    z <- 12
    x <- y + 5
    x <- list("something")
    z <- "something_else"
    z <- "ensure_that_you_never_go_over_the_end"
    return(x)
  }

  expect_error( partial_test( dummy_fun,
                              args = list(y = 2),
                              eval_point = 8 ),
                "Please supply a predicate function, or an object to compare to.",
                fixed = TRUE )
})

test_that( "Predicate functions work",{

  dummy_fun <- function( x = 2, y = "death", z = 5 )
  {
    x <- x + 5
    z <- 12
    x <- y + 5
    x <- list("something")
    z <- "something_else"
    z <- "ensure_that_you_never_go_over_the_end"
    return(x)
  }

  expect_true( partial_test( dummy_fun,
                             args = list(y = 2),
                             eval_point = 8,
                             compare_fun = is.list ))
})
