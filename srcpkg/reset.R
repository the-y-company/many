#' Reset
#'
#' Deletes `,many`, forces copying of files with subsequent `bundle` run.
#'
#' @export
reset <- \() {
  list() |>
    jsonlite::write_json(".many", auto_unbox = TRUE, pretty = TRUE)
}
