format_title <- function(x, width) {
  needs_ticks <- !is_syntactic(x)
  x[needs_ticks] <- tick(x[needs_ticks])
  str_trunc(x, width)
}

is_syntactic <- function(x) {
  ret <- make.names(x) == x
  ret[is.na(x)] <- FALSE
  ret
}

tick <- function(x) {
  x[is.na(x)] <- "NA"
  encodeString(x, quote = "`")
}