context("General tests for ifelser")

test_that("test_if , if_yes, if_no works with simple vectors", {
  library(magrittr)

  expect_identical(
    test_if(1:10>5) %>% if_true(1) %>% if_false(2),
    ifelse(1:10>5,1,2)
  )

  expect_identical(
    test_if(1:10>5) %>% if_false(2) %>% if_true(1),
    ifelse(1:10>5,1,2)
  )

})

test_that("test_if , if_yes, if_no works inside function calls", {
  library(magrittr)
  # create testing function
  ifelse2 <- function(x){
    test_if(x>2) %>% if_true(1) %>% if_false(2)
  }
  # expectations
  expect_identical(ifelse2(1:10), ifelse(1:10>2,1,2))
})

test_that("tests works in sequences of ifelse(ifelse...", {
  library(magrittr)

  expect_identical(
    test_if(2>3) %>% if_true(2) %>% if_false() %>% test_if(2==2) %>% if_true(100) %>% if_false(101),
    ifelse(2>3, 2, ifelse(2==2, 100, 101))
  )

  x <- 1:10
  expect_identical(
    test_if(x>5L) %>% if_true(x) %>% if_false() %>% test_if(x==2) %>% if_true(100) %>% if_false(101),
    ifelse(x>5L, x, ifelse(x==2, 100, 101))
  )


  x <- 1:10
  expect_identical(
    test_if(x>5L) %>% if_true(x) %>% if_false() %>% test_if(x==2L) %>% if_false(101) %>% if_true(100),
    ifelse(x>5L, x, ifelse(x==2, 100, 101))
  )

  x <- 1:10
  expect_identical(
    test_if(x>5) %>% if_false(10) %>% if_true() %>% test_if(x==2) %>% if_false(101) %>% if_true(100),
    ifelse(x>5, ifelse(x==2, 100, 101), 10)
  )

})

