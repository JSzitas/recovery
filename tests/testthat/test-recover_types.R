test_that("Type recovery works", {

    dummy_fun <- function( x = 2, y = "death", z = 5 )
      {
      x <- x + 5
      z <- 12
      x <- y + 5
          return(x)
    }

  test_res <- recover_types(dummy_fun)

    expect_equal(names(test_res), c("Failing line", "Types"))
    expect_equal(as.character(test_res$'Failing line'), "x <- y + 5")
    expect_equal(test_res$Types$x, "numeric")
    expect_equal(test_res$Types$y, "character")
    expect_equal(test_res$Types$z, "numeric")

  test_res <- recover_types(dummy_fun, args = list(x=2,y=2,z=2))

  expect_equal(test_res, "The function ran succesfully!")
})

test_that( "This works even in parallel",{

  skip_on_cran()
  skip_on_travis()
  suppressWarnings( library(doFuture) )
  registerDoFuture()
  plan(multisession)

  parallel_fun <- function(x,y,z, length.out ){

    magical <- function(x,y,z){
      x <- x + 5
      z <- 12
      x <- y + z
      return(x)
    }
   res <-  foreach(i = 1:length.out ) %dopar%
      {
        weirdness <- magical(x,y,z)
      }
    return(res)
  }

test_res <- recover_types( parallel_fun,
                           args = list( x = 5,
                                        y ="fly",
                                        z = 2,
                                        length.out = 10 ))

  expect_equal(names(test_res), c("Failing line", "Types"))

  # returns the wrong line, ie
  expect_equal(as.character(test_res$'Failing line'),
               "res <- foreach(i = 1:length.out) %dopar% {\n    weirdness <- magical(x, y, z)\n}")
  # it would be nice if we could recurse on this...

  expect_equal(test_res$Types$x, "numeric")
  expect_equal(test_res$Types$y, "character")
  expect_equal(test_res$Types$z, "numeric")
  expect_equal(test_res$Types$length.out, "numeric")
})
