If you ever had to make ifelse statements one inside of each other, this package will be usefull for you.

Think about the following code:

``` r
x <- 1:10
ifelse(x<=5, 1, ifelse(x<=7.5, 2, ifelse(x<=9.2, 3, 4)))
#>  [1] 1 1 1 1 1 2 2 3 3 4
```

It's hard to know what's being done. If x \< 5 then x = 1 else if x \<= 7.5 then x = 2 else if 9.2 then x = 3 else x = 4.

The problem can be worse if variable names are longer and the statement does not fit one line.

``` r
variable <- 1:10
ifelse(variable<=5, variable + log(variable), ifelse(variable<=7.5, variable + 2*log(variable), ifelse(variable<=9.2, variable + 3*log(variable), variable + 4*log(variable))))
#>  [1]  1.000000  2.693147  4.098612  5.386294  6.609438  9.583519 10.891820
#>  [8] 14.238325 15.591674 19.210340
```

Even if you think it's easy to understand the code, you won't find it easy to find if there are brackets missing.

Now take a look at `ifelser` code. It makes use of `magrittr` pipes to create more readable and mantainable code.

``` r
library(ifelser)
#> Loading required package: magrittr
test_if(variable <= 5) %>% 
  if_true(variable + log(variable)) %>% if_false() %>%
  test_if(variable <= 7.5) %>% 
  if_true(variable + 2*log(variable)) %>% if_false() %>%
  test_if(variable <= 9.2) %>% 
  if_true(variable + 3*log(variable)) %>% if_false(variable + 4*log(variable))
#>  [1]  1.000000  2.693147  4.098612  5.386294  6.609438  9.583519 10.891820
#>  [8] 14.238325 15.591674 19.210340
```

Don't think it's more readable?
