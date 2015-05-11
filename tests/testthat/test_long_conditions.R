context("Testing if ifelser works with long conditions")

test_that("test_if , if_yes, if_no works with long conditions", {
  library(dplyr)

  m12 <- mtcars
  cyl_txt <- test_if(m12$cyl == 123456 & m12$cyl == 9 & m12$cyl == 8 & m12$cyl == 7) %>%
    if_true("hi") %>%
    if_false("hello")

  cyl_txt2 <- ifelse(m12$cyl == 123456 & m12$cyl == 9 & m12$cyl == 8 & m12$cyl == 7, "hi", "hello")

  expect_equal(cyl_txt, cyl_txt2)

})
