#' Bundle then document
#' 
#' Bundles then documents.
#' 
#' @param ... Arguments passed to [devtools::document()].
#' @param bundle_opts List of arguments passed to [bundle()].
#' 
#' @export
document <- \(..., bundle_opts = list()){
  do.call(bundle, as.list(bundle_opts))
  devtools::document(...)
}
