#' Collapse message for CLI
#' 
#' Collapse a message to pass to `cli` functions.
#' 
#' @param ... Any number of strings.
#' 
#' @keywords internal
collapse_msg <- \(...) {
  c(...) |>
    (\(.) paste0(., collapse = ""))()
}

#' Message
#' 
#' Info message
#' 
#' @inheritParams collapse_msg
#' 
#' @keywords internal
#' @importFrom cli cli_alert_info
info <- \(...){
  run_if_verbose(
    \() {
      collapse_msg(...) |>
        cli_alert_info()
    }
  )
}

#' @keywords internal
#' @importFrom cli cli_alert_danger
error <- \(...){
  run_if_verbose(
    \() {
      collapse_msg(...) |>
        cli_alert_danger()
    }
  )
}

#' @keywords internal
#' @importFrom cli cli_alert_success
success <- \(...){
  run_if_verbose(
    \() {
      collapse_msg(...) |>
        cli_alert_success()
    }
  )
}

#' @keywords internal
#' @importFrom cli cli_alert_warning
warn <- \(...){
  run_if_verbose(
    \() {
      collapse_msg(...) |>
        cli_alert_warning()
    }
  )
}

run_if_verbose <- \(fn) {
  if(!is_verbose())
    return()

  fn()
}

MANY_VERBOSE <- TRUE # nolint

is_verbose <- \(){
  Sys.getenv(MANY_VERBOSE, unset = TRUE) |>
    as.logical()
}
