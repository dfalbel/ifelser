#' Function to test if
#'
#' @export
#' @import magrittr
test_if <- function(...){
  UseMethod("test_if")
}

#' Método do test_if quiando o argumento é um teste.
#'
#' @param test an object which can be coerced to logical mode.
#'
#' @export
#' @import magrittr
test_if.logical <- function(test){
  list(
    test = substitute(test) %>% deparse,
    env = parent.frame()
  )
}

#' Método do test_if quando o argumento é uma lista
#'
#' @param lst a chained ifelse statement using ifelser structure
#' @param test an object which can be coerced to logical mode.
#'
#' @export
#' @import magrittr
test_if.default <- function(lst, test){
   list(
     lst = lst,
     test = substitute(test) %>% deparse
   )
}


#' Function that gets what to do if yes
#'
#' @param lst a chained ifelse statement using ifelser structure
#' @param yes return values for true elements of test
#'
#' @export
#' @import magrittr
if_true <- function(lst, yes = NULL){
  if(!is.null(yes)){
    lst$yes <- substitute(yes) %>% deparse()
    if(!is.null(lst$no)){
      call <- create_call(lst)
      return(eval(call$expr, envir = call$env)  )
    } else{
      return(lst)
    }
  } else{
    return(lst)
  }
}

#' Function that gets what to do if no
#'
#' @param lst a chained ifelse statement using ifelser structure
#' @param no return values for false elements of test
#'
#' @export
#' @import magrittr
if_false <- function(lst, no = NULL){
  if(!is.null(no)){
    lst$no = substitute(no) %>% deparse()
    if(!is.null(lst$yes)){
      call <- create_call(lst)
      return(eval(call$expr, envir = call$env) )
    } else {
      return(lst)
    }
  } else {
    return(lst)
  }
}

# test_if(list(x = "1"), 1)

#test_if(2>3) %>% if_true(2) %>% if_false() %>% test_if(2==2) %>% if_true(100) %>% if_false(101)


#' A more readable function to continue test_if statements
#'
#' @export
if_false_then <- function(...){
  if_false()
}

#' Create ifelse call
#'
#' @param lst a chained ifelse statement using ifelser structure
#'
#' This function needs to be rewritten
create_call <- function(lst){
  expr <- paste0("ifelse(", lst$test, ",", lst$yes, ",", lst$no, ")")
  if(!is.null(lst$lst)){
    lst <- lst$lst
    while(!is.null(lst)){
      if(!is.null(lst$yes)){
        expr <- paste0("ifelse(", lst$test, ",", lst$yes, ",", expr, ")")
      }
      if(!is.null(lst$no)){
        expr <- paste0("ifelse(", lst$test, ",", expr, ",", lst$no, ")")
      }
      if(!is.null(lst$env)){
        env <- lst$env
      }
      lst <- lst$lst
    }
  } else{
    env <- lst$env
  }
  return(
    list(
      expr = expr %>% parse(text = .),
      env = env
    )
  )
}








