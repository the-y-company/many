#' Use many
#' 
#' @inheritParams bundle
#' 
#' @param
use_many <- \(src = "srcpkg"){
  create_dir_if_not_exists(src)
  use_build_ignore(src)
}
