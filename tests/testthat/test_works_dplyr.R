context("Testing if ifelser works with dplyr")

test_that("test_if , if_yes, if_no works inside dplyr", {
  suppressPackageStartupMessages(library(dplyr))

  x <- mtcars %>%
    mutate(cyl_txt = test_if(cyl == 4) %>%
             if_true('Four') %>%
             if_false('Not Four'))

  y <- mtcars
  y$cyl_txt <- test_if(y$cyl == 4) %>%
    if_true('Four') %>%
    if_false('Not Four')

  z <- mtcars
  z$cyl_txt <- ifelse(z$cyl == 4, "Four", "Not Four")


  expect_identical(
    x$cyl_txt,
    y$cyl_txt
  )

  expect_identical(
    x$cyl_txt,
    z$cyl_txt
  )


})
