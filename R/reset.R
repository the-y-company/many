#' Reset
#' 
#' Deletes `,many`, forces copying of files with subsequent `bundle` run.
#' 
#' @export
reset <- \() {
  remove_file(".many")
}
