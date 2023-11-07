#' Bundle then loads all
#'
#' Bundles then loads all. 
#'
#' @param ... Arguments passed to [devtools::load_all()].
#' @param bundle_opts List of arguments passed to [bundle()].
#'
#' @export
load_all <- \(..., bundle_opts = list()){
  do.call(bundle, as.list(bundle_opts))
  devtools::load_all(...)
}
