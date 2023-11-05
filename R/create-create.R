#' Use many
#' 
#' @inheritParams bundle
#' 
#' @importFrom usethis use_build_ignore
#' 
#' @export
use_many <- \(src = "srcpkg"){
  create_dir_if_not_exists(src)
  use_build_ignore(src)

  # copy existing R files in srcpkg
  existing <- list.files("R")
  if(!length(existing))
    return(invisible())

  file.copy(existing, src)

  invisible(TRUE)
}
