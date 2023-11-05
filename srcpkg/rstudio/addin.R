handle <- NULL

#' Bundle on Save
#'
#' Bundle file on save.
#'
#' @export
bundle_on_save <- \(){
  handle <<- rstudioapi::registerCommandCallback(
    "saveSourceDoc", 
    \() {
      doc <- rstudioapi::getActiveDocumentContext()

      if(doc$path == "")
        return()

      bundle_file(doc$path)
    })
}

.onUnload <- \(...) {
  if(is.null(handle))  
    return()

  rstudioapi::unregisterCommandCallback(handle)
}
