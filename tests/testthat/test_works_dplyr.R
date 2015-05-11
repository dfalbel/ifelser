context("Testing if ifelser works with dplyr")

test_that("test_if , if_yes, if_no works inside dplyr", {
  library(dplyr)

  x <- mtcars %>%
    mutate(cyl_txt = test_if(cyl == 4) %>%
                    if_true('Four') %>%
                    if_false('Not Four'))

  y <- mtcars
  y$cyl_txt <- test_if(y$cyl == 4) %>%
    if_true('Four') %>%
    if_false('Not Four')

  expect_identical(
    x$cyl_text,
    y$cyl_text
  )

})
