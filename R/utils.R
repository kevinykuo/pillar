cat_line <- function(...) {
  cat(..., "\n", sep = "")
}

str_trunc <- function(x, width) {
  if (is.infinite(width)) return(x)

  str_width <- utf8::utf8_width(crayon::strip_style(x), encode = FALSE)

  too_wide <- which(!is.na(x) & str_width > width)
  x[too_wide] <- paste0(crayon::col_substr(x[too_wide], 1, width - 1), get_ellipsis())

  x
}

check_sigfig <- function(x) {
  stopifnot(is.numeric(x), length(x) == 1)
  x <- as.integer(x)
  if (x < 1L) {
    stop("Must show at least one significant figure", call. = FALSE)
  }

  x
}

ruler <- function(width = getOption("width")) {
  x <- seq_len(width)
  y <- rep("-", length(x))

  y[x %% 10 == 0] <- as.character((x[x %% 10 == 0] %/% 10) %% 10)
  y[x %% 5 == 0] <- "+"

  cat(y, "\n", sep = "")
  cat(x %% 10, "\n", sep = "")
}

slice <- function(df, index) {
  df[index, , drop = FALSE]
}

get_ellipsis <- function() {
  cli::symbol$continue
}

is_latex_output <- function() {
  if (!("knitr" %in% loadedNamespaces())) return(FALSE)
  get("is_latex_output", asNamespace("knitr"))()
}

remove_as_is_class <- function(x) {
  if (all(class(x) == "AsIs")) return(unclass(x))
  class(x) <- setdiff(class(x), "AsIs")
  x
}
