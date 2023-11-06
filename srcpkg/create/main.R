#' Use many
#'
#' @inheritParams bundle
#'
#' @importFrom usethis use_build_ignore use_package use_build_ignore
#'
#' @export
use_many <- \(src = "srcpkg"){
  create_dir_if_not_exists(src)
  use_build_ignore(src)

  # copy existing R files in srcpkg
  existing <- list.files("R", full.names = TRUE)
  if (!length(existing)) {
    return(invisible())
  }

  file.copy(existing, src)
  use_package("many", type = "Suggests")
  use_build_ignore(".many")

  invisible(TRUE)
}
