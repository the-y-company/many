#' Use many
#'
#' @inheritParams bundle
#'
#' @importFrom usethis use_build_ignore use_package use_build_ignore
#'
#' @export
use_many <- \(src = "srcpkg"){
  create_dir_if_not_exists(src)

  if(is_many()){
    error("this is already a \"many\" project\n")
    return(invisible())
  }

  # if src empty
  # if not it is likely that 
  # use_many was already run
  if(length(list.files(src))) {
    error(src, " already contains files\n")
    return(invisible())
  }

  use_build_ignore(src)

  existing <- list.files("R", full.names = TRUE)

  # copy existing R files in srcpkg
  if (length(existing)) {
    info("copying files from R to ", src, "\n")
    file.copy(existing, src)
  }

  # add dependencies
  use_package("many", type = "Suggests")
  use_build_ignore(".many")

  # create .many
  list() |>
    jsonlite::write_json(".many", auto_unbox = TRUE, pretty = TRUE)

  # add DO_NOT_EDIT.R
  fl <- system.file("templates/no-edit.R")
  file.copy(fl, file.path("R", "00_DO_NOT_EDIT.R"))

  invisible(TRUE)
}
